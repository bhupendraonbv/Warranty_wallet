//
//  ApplianceEditDetailsViewController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 06/11/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.
//

import UIKit

class ApplianceEditDetailsViewController: UIViewController,UITextFieldDelegate,TopviewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource {

    var topview:TopViewController!
    var bottomView = BottomViewViewController()
    var webStrPassURL = String()
    var GetStrHdrTitle = String()
    var userDefault = UserDefaults.standard
    var user_id = String()
    var UserToken = String()
    var dict = String()
    var mainArr = NSMutableArray()
    var strRecvAplnc_ID = String()
    var TempDict = NSDictionary()
    var ArrImgDocumentAll = NSMutableArray()
    var DictDocumentUrl = NSDictionary()
    var ArrImgURL = NSMutableArray()
    var ArrDays = NSMutableArray()
    var strDaysCount = String()
    var ArrGetAppilncData = NSMutableArray()
    var ArrDocumentName = NSMutableArray()
   
    var wageFloat:Float = 10.0
    
    var arrOtherParts = NSMutableArray()
    
    
    //Edit Field Declare here all//
    @IBOutlet weak var TxtApplncName: UITextField!
    @IBOutlet weak var TxtPurcsDate: UITextField!
    @IBOutlet weak var TxtExpDate: UITextField!
    @IBOutlet weak var TxtModel: UITextField!
    @IBOutlet weak var TxtSerial: UITextField!
    @IBOutlet weak var TxtMenufacture: UITextField!
    @IBOutlet weak var TxtCapcty: UITextField!
    @IBOutlet weak var ImgBrndLogo: UIImageView!
    
    @IBOutlet weak var VWDocu_PopUp: UIView!
    @IBOutlet weak var ImgDocu_PopUp: UIImageView!
    
    @IBOutlet weak var btnExtendWrnt: UIButton!
    @IBOutlet weak var btnREQSTServc: UIButton!
    
    var imagePicker:UIImagePickerController?=UIImagePickerController()
    @IBOutlet weak var userPhotoImageView: UIImageView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var ImgDocmntBG: UIImageView!
    
    @IBOutlet var vwDocumentListPopUp: UIView!
    
    @IBOutlet weak var btnSELONOLX: UIButton!
    
    
    var pinchGesture = UIPinchGestureRecognizer()
    var strSendApplnvTagName  = String()
    var strSendModelApplnc = String()
    var strSendApplncIDtoRaise = String()
    
    
    @IBOutlet weak var tblSliderList: UITableView!
    @IBOutlet weak var tblDocumentList: UITableView!
    var spinnerActivity: MBProgressHUD = MBProgressHUD()
    
    //Dict Parts add Date
    var AlldictParts  = NSDictionary()
    var TempDictDays = String()
    var ArrallOtherPartsProduct = NSMutableArray()
    
    @IBOutlet var btnSaveAftrEdit: UIButton!
    

    @IBAction func backclick(sender: AnyObject)
    {
       self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var btnHMAplnc: UIButton!
    @IBOutlet weak var btnAirConcnr: UIButton!

    @IBOutlet var VWGradient: UIView!
    
    @IBOutlet weak var lblCatePrdcNwScrn: UILabel!
    @IBOutlet weak var lblnameprdctNwScrn: UILabel!
    
    /*Touch Method*/
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.vwDocumentListPopUp.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBottomView()
        setGradientBackground()
        addTopView()
        
        btnHMAplnc.layer.cornerRadius = 6.0
        btnAirConcnr.layer.cornerRadius = 6.0

        print("RecvApplinces_ID",strRecvAplnc_ID)
        btnExtendWrnt.layer.borderColor = UIColor(red:78/255.0, green:178/255.0, blue:175/255.0, alpha: 1.0).cgColor
        btnExtendWrnt.layer.borderWidth = 1.0
        btnExtendWrnt.layer.cornerRadius = 2.0
        
        btnSELONOLX.layer.borderColor =  UIColor(red:78/255.0, green:178/255.0, blue:175/255.0, alpha: 1.0).cgColor
        btnSELONOLX.layer.borderWidth = 2.0
        btnSELONOLX.layer.cornerRadius = 2.0
        
        self.tblSliderList.register(UINib(nibName: "CstmEditDaySlidrCell", bundle: nil), forCellReuseIdentifier: "CstmEditDaySlidrCell")
       print(ArrGetAppilncData)
        
        self.tblDocumentList.register(UINib(nibName: "CustemDocumentCell", bundle: nil), forCellReuseIdentifier: "CustemDocumentCell")
        
        //Api Call..Edit View details
        self.doPostServiceEditApplianceApi()
        
    }
    
    //TopView code
    func addTopView(){
        
        topview = TopViewController(title: "Device Detail", menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        topview.delegate = nil
        topview.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 70)
        topview.topBGVW.backgroundColor = UIColor .clear
        self.view.addSubview(topview.view)
        self.view.layoutIfNeeded()
    }
    
    //Gradient Method
    func setGradientBackground() {
        let colorTop =  UIColor(red: 19.0/255.0, green: 84.0/255.0, blue: 122.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 128.0/255.0, green: 209.0/255.0, blue: 199.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.VWGradient.bounds
        self.VWGradient.layer.addSublayer(gradientLayer)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ArrImgURL.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionVWCell", for: indexPath) as! collectionVWCell
        
        self.pinchGesture.delegate = self
        self.pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(ApplianceEditDetailsViewController.pinchRecognized(sender:)))
        cell.addGestureRecognizer(self.pinchGesture)
        
        let  imageNamedocument = self.ArrImgURL.object(at: indexPath.row)
        print(imageNamedocument)
        cell.DocumentImage.setImageFromURl(stringImageUrl: imageNamedocument as! String)
       
        return cell
    }
    
    func pinchRecognized(sender: UIPinchGestureRecognizer) {
        if pinchGesture.view != nil {
            
            sender.view?.transform = (sender.view?.transform)!.scaledBy(x: sender.scale, y: sender.scale)
            sender.scale = 1.0
        }

    }
    
    //Tabel view Delegate and data source....
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == tblSliderList
        {
             return ArrDays.count
        }
        
        else
        {
            return ArrImgURL.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if tableView == tblSliderList
        {
            return 63
        }
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        if tableView == tblSliderList
        {
            let identifier: String = "CstmEditDaySlidrCell"
            var customCellNew : CstmEditDaySlidrCell!
            
            customCellNew = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CstmEditDaySlidrCell
            customCellNew.selectionStyle = UITableViewCellSelectionStyle.none
            
            print(ArrDays)
            customCellNew.LblDays!.text =  ArrDays.object(at: indexPath.row) as? String
            //customCellNew.LblProductNm.text = self.TempDict.value(forKey: "appliance_manufacturer") as? String
            customCellNew.LblProductNm.text = ArrallOtherPartsProduct.object(at: indexPath.row)as? String
           
            //customCellNew.sliderTnt.setValue(1096, animated: true)
            customCellNew.sliderTnt.minimumValue = 0
            
            
            UIView.animate(withDuration: 0.9, delay: 0.5, options: .curveEaseOut, animations: {
                customCellNew.sliderTnt.setValue(Float(self.ArrDays.count), animated: true) },
                           completion: nil)
            
            return customCellNew
        }
        
        else
        {
            let identifier: String = "CustemDocumentCell"
            var customCellNew : CustemDocumentCell!
            
            customCellNew = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CustemDocumentCell
            customCellNew.selectionStyle = UITableViewCellSelectionStyle.none
            
          //  customCellNew.LblDocumentName.text = ArrDocumentName.objects(at: indexPath.row) as? String
           
            customCellNew.LblDocumentName.text = ArrDocumentName.object(at: indexPath.row) as? String
            
            return customCellNew
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      if tableView == tblDocumentList
      {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "WTListDocumentFile") as! WTListDocumentFile
        newViewController.arrrecvImg = ArrImgURL .object(at: indexPath.row) as! String
        self.navigationController?.pushViewController(newViewController, animated: true)
        
      }
        
    
    }

    
    @IBAction func clickusrMake_EditField(sender: AnyObject){
       // self.usrMake_EditField()
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ApplianceEditDetailsController") as! ApplianceEditDetailsController
        newViewController.ArrGetEditAppliance = mainArr
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    
    @IBAction func clicSaveEditDeatilsService(sender: AnyObject){
       //  self.doPostServiceUPDATEApplianceApi()
        
        UIApplication.shared.openURL(NSURL(string: "tel://9643296520")! as URL)


    }
    
    //Edit Field Api.
    func usrMake_EditField() {
        let Editalert = UIAlertController(title: "Title", message: "Are you sure you want to edit..", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            
            self.btnSaveAftrEdit.isHidden = false
            
            self.TxtApplncName.isUserInteractionEnabled = true
            self.TxtPurcsDate.isUserInteractionEnabled = true
            self.TxtExpDate.isUserInteractionEnabled = true
            self.TxtModel.isUserInteractionEnabled = true
            self.TxtSerial.isUserInteractionEnabled = true
            self.self.TxtMenufacture.isUserInteractionEnabled = true
            self.TxtCapcty.isUserInteractionEnabled = true
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
            

        }
        
        // Add the actions
        Editalert.addAction(okAction)
        Editalert.addAction(cancelAction)
        
        // Present the controller
        self.present(Editalert, animated: true, completion: nil)
        
    }
    
    // Code update Applinace Api
    func doPostServiceUPDATEApplianceApi(){
        
        var TempManufactr = String()
        TempManufactr = (TxtMenufacture.text)!
        
        
        var TempCapacity = String()
        TempCapacity = (TxtCapcty.text)!
        
         var TempApplncNameTAg = String()
        TempApplncNameTAg = (TxtApplncName.text)!
        
        
        var TempMODEL = String()
        TempMODEL = (TxtModel.text)!
        
         var TempSERIAL = String()
        TempSERIAL = (TxtSerial.text)!
        
        
        var TempPURCHASEdATE = String()
         TempPURCHASEdATE = (TxtPurcsDate.text)!

        var TempEXPIRYDATE = String()
        TempEXPIRYDATE = (TxtExpDate.text)!

        
        user_id = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_Update_Edit_Appliance_API)! as URL)
        request.httpMethod = "POST"
        request.setValue(ServerAuthorization, forHTTPHeaderField: "authorization_token")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "access_token")
        
        let postString = "userId=\(String(describing: user_id))&tokenId=\(String(describing: UserToken))&applianceId=\(String(describing: strRecvAplnc_ID))&manufacturer=\(String(describing: TempManufactr))&capacity=\(String(describing: TempCapacity))&name_tag=\(String(describing: TempApplncNameTAg))&model_no=\(String(describing: TempMODEL))&serial_no=\(String(describing: TempSERIAL))&date_of_parched=\(String(describing: TempPURCHASEdATE))&expiry_date=\(String(describing: TempEXPIRYDATE))"
        
        
        print("Userid&usertoken--->",postString)
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest){data, response, error in
            guard error == nil && data != nil else{
                print("error")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200{
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                
                if httpStatus.statusCode == 0
                {
                    print("user alredy regestiter")
                }
            }
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            
            do
            {
                guard let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary else{
                    return
                }
                
                if let dictFromJSON = json as? [String:AnyObject] {
                    
                    print(dictFromJSON)
                    
                    self.dict = (dictFromJSON["status"] as? String)!
                    print("hfuwfhwq",self.dict)
                    
                    if (self.dict == "1")
                    {
                        //arrCategoryList
                       
                    }
                    
                }
                
            }catch
            {
                print("error")
            }
            
        }
        
        task.resume()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
    
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    /*do postcategory list*/
    func doPostServiceEditApplianceApi()
    {
        user_id = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_VIEW_APPLIANCES_DETAILS)! as URL)
        request.httpMethod = "POST"
        
        request.setValue(ServerAuthorization, forHTTPHeaderField: "authorization_token")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "access_token")
       
        let postString = "userId=\(String(describing: user_id))&tokenId=\(String(describing: UserToken))&applianceId=\(String(describing: strRecvAplnc_ID))"
        
        print("Userid&usertoken--->",postString)
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest){data, response, error in
            guard error == nil && data != nil else{
                print("error")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200{
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                
                if httpStatus.statusCode == 0
                {
                    print("user alredy regestiter")
                }
            }
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            
            do
            {
                guard let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary else{
                    return
                }
                
                if let dictFromJSON = json as? [String:AnyObject] {
                    print(dictFromJSON)
                    
                    self.dict = (dictFromJSON["status"] as? String)!
                    print("hfuwfhwq",self.dict)
                    
                    if (self.dict == "1")
                    {
                        //arrCategoryList
                        self.mainArr = NSMutableArray()
                        self.mainArr = (dictFromJSON["data"] as? NSMutableArray)!
                        print(self.mainArr)
                        
                        self.TempDict = self.mainArr[0] as! NSDictionary
                        print("SelfDict",self.TempDict)
                        
                        
                        DispatchQueue.main.async(execute: {
                            self.TxtApplncName.text = self.TempDict.value(forKey: "appliance_name_tag") as? String
                            
                            self.strSendApplnvTagName = (self.TempDict.value(forKey: "appliance_name_tag") as? String)!
                            
                            print(self.strSendApplnvTagName)
                            
                            self.strSendModelApplnc = (self.TempDict.value(forKey: "appliances_model") as? String)!
                            
                            print(self.strSendModelApplnc)
                            self.strSendApplncIDtoRaise = (self.TempDict.value(forKey: "appliance_id") as? String)!
                            
                            self.TxtPurcsDate.text = self.TempDict.value(forKey: "appliance_date_of_parched") as? String
                            self.TxtExpDate.text = self.TempDict.value(forKey: "appliance_expiry_date") as? String
                            self.TxtModel.text = self.TempDict.value(forKey: "appliances_model") as? String
                            self.TxtSerial.text = self.TempDict.value(forKey: "appliances_serial") as? String
                            self.TxtMenufacture.text = self.TempDict.value(forKey: "appliance_manufacturer") as? String
                            self.TxtCapcty.text = self.TempDict.value(forKey: "appliance_capacity") as? String
                            self.btnHMAplnc.setTitle(self.TempDict.value(forKey: "appliance_manufacturer") as? String, for: .normal)
                            self.btnAirConcnr.setTitle(self.TempDict.value(forKey: "appliance_name_tag") as? String, for: .normal)
                            
                            let imageName = self.TempDict.value(forKey: "brand_logo") as? String
                            //let image = UIImage(named: imageName!)
                            
                            self.ImgBrndLogo.setImageFromURl(stringImageUrl: imageName!)
                            
                            self.ArrallOtherPartsProduct .addObjects(from: [self.TempDict.value(forKey: "appliance_manufacturer")!])
                            
                            //Tbl Reload and delege self.....
                            
                            let startDateProduct  = self.TempDict.value(forKey: "appliance_date_of_parched") as? String
                            let EndDateProduct = self.TempDict.value(forKey: "appliance_expiry_date") as? String
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "dd-MM-yyyy"
                            let start = dateFormatter.date(from: startDateProduct!)!
                            let end = dateFormatter.date(from: EndDateProduct!)!
                            
                            let diff = Date.daysBetween(start: start, end: end) // 365
                            
                            let xNSNumber = diff as NSNumber
                            self.strDaysCount = xNSNumber.stringValue
                            print(self.strDaysCount)
                            
                            // Document URL code ..
                                self.ArrImgDocumentAll = self.TempDict.value(forKey: "appliance_document") as! NSMutableArray
                                print(self.ArrImgDocumentAll)
                                
                                for storedict in 0..<self.ArrImgDocumentAll.count
                                {
                                    self.DictDocumentUrl = self.ArrImgDocumentAll[storedict] as! NSDictionary
                                    print(self.DictDocumentUrl)
                                    
                                    self.ArrImgURL.addObjects(from: [self.DictDocumentUrl.value(forKey: "document")!])
                                    print(self.ArrImgURL)
                                    self.ArrDocumentName.addObjects(from: [self.DictDocumentUrl.value(forKey: "document_name")!])
                                    print(self.ArrDocumentName)
                                    
                                }
                            
                            self.ArrDays .removeAllObjects()
                            self.ArrDays .add(self.strDaysCount)
                            print(self.ArrDays)
                            
                            self.arrOtherParts = self.TempDict.value(forKey: "other") as! NSMutableArray
                            print(self.arrOtherParts)
                            
                            if self.arrOtherParts.count > 0
                            {
                                for dictParts in 0..<self.arrOtherParts.count
                                {
                                    self.AlldictParts = self.arrOtherParts[dictParts] as! NSDictionary
                                    print(self.AlldictParts)
                                    
                                    let Temp_parchase_Date = self.AlldictParts.value(forKey: "other_date_of_parched")
                                    let Temp_Exp_Date = self.AlldictParts.value(forKey: "other_expiry_date")
                                    
                                    self.ArrallOtherPartsProduct.addObjects(from: [self.AlldictParts.value(forKey: "other_name_tag")!])
                                    print(self.ArrallOtherPartsProduct)
                                    
                                    
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "dd-MM-yyyy"
                                    let start = dateFormatter.date(from: Temp_parchase_Date! as! String)!
                                    let end = dateFormatter.date(from: Temp_Exp_Date! as! String )!
                                    
                                    let diff = Date.daysBetween(start: start, end: end) // 365
                                    
                                    let xNSNumber = diff as NSNumber
                                    self.TempDictDays = xNSNumber.stringValue
                                    print(self.TempDictDays)
                                    
                                    self.ArrDays .add(self.TempDictDays)
                                    print(self.ArrDays)
                                    
                                }
                                
                            }
                            
                            self.tblSliderList.delegate = self
                            self.tblSliderList.dataSource = self
                            self.tblSliderList.emptyCellsEnabledEditVWLog = false
                            self.tblSliderList .reloadData()
                            
                        })
                        
                    }
                }
                
            }catch
            {
                print("error")
            }
            
        }
        
        task.resume()
    }

    //Bottom View
    func addBottomView(){
        // bottomView = BottomViewViewController()
        self.bottomView.view.frame = CGRect(x: 0, y: WINDOW_HEIGHT-56 , width: WINDOW_WIDTH, height: 56)
        self.bottomView.btnApplinc.isSelected = true
        self.view.addSubview(bottomView.view)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Show Pop up View
    @IBAction func clickVwShowPopUp(sender: AnyObject){
        
        if ArrDocumentName.count > 0
        {
            vwDocumentListPopUp.isHidden = false
            vwDocumentListPopUp.isUserInteractionEnabled = false
            vwDocumentListPopUp.layer.cornerRadius = 8.0
            vwDocumentListPopUp.layer.borderWidth = 1.0
            //vwDocumentListPopUp.layer.borderColor = UIColor(red: 50/255, green: 60/255, blue: 70/255, alpha: 1.0) as! CGColor
            vwDocumentListPopUp.layer.shadowColor = UIColor .black.cgColor
            //vwDocumentListPopUp.backgroundColor = UIColor(red: 50/255, green: 60/255, blue: 70/255, alpha: 1.0)
            //vwDocumentListPopUp.backgroundColor = UIColor.white
            tblDocumentList.dataSource = self
            tblDocumentList.delegate = self
            self.tblDocumentList.emptyCellsEnabledEditVWLog = false
            tblDocumentList .reloadData()
        }
       
        else {
            let alert = UIAlertController(title: "Alert", message: "Please upload document", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
                    {
                        self.imagePicker?.delegate = self
                        self.imagePicker?.sourceType = UIImagePickerControllerSourceType.photoLibrary
                        self.imagePicker?.allowsEditing = true
                        self.present(self.imagePicker!, animated: true, completion: nil)
                    }
                    else
                    {
                        let alert:UIAlertController = UIAlertController(title: "Camera Unavailable", message: "Unable to find a camera on this device", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                        alert.view.tintColor = UIColor(red:0.37, green:0.66, blue:0.44, alpha:1.0)
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                }}))
            
            self.present(alert, animated: true, completion: nil)
        }
      
}
    
    //Picker Method
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            userPhotoImageView.contentMode = .scaleToFill
            
            userPhotoImageView.image = pickedImage
            
            self.spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
            self.spinnerActivity.label.text = "Uploading Please wait..."
            self.MyUploadDocumentRequest()
            
        }
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func clickCnclAlertDocumen(sender: AnyObject){
     VWDocu_PopUp.isHidden = true
    }
    
    // Comment this functionality
     @IBAction func clickOLX(sender: AnyObject)
     {
      /*  self.dismiss(animated: true, completion: nil)
        
        if sender.tag == 1001
        {
            webStrPassURL = "https://www.olx.in/"
            GetStrHdrTitle = "OLX SALE"
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "WTWebViewController") as! WTWebViewController
            newViewController.webStrUrlGet = webStrPassURL
            newViewController.RecvStrHdrTitle = GetStrHdrTitle
            self.present(newViewController, animated: true, completion: nil)
            
        }
        else
        {
            webStrPassURL = "https://www.policybazaar.com/"
            GetStrHdrTitle = "POLICY BAZAR"
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "WTWebViewController") as! WTWebViewController
            newViewController.RecvStrHdrTitle = GetStrHdrTitle
            newViewController.webStrUrlGet = webStrPassURL
            self.present(newViewController, animated: true, completion: nil)
        }*/
    }
    
    
    //Upload Document code here...
    func MyUploadDocumentRequest()
    {
        user_id = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
        
        let jpegCompressionQuality: CGFloat = 0.2 // Set this to whatever suits your purpose
        let strBase64 = UIImageJPEGRepresentation(userPhotoImageView.image!, jpegCompressionQuality)?.base64EncodedString()
        // print(strBase64 ?? 09)
        
        var myurl: URL!
        myurl = NSURL(string:POST_Upload_Appliances_Document_API)! as URL;
        let request = NSMutableURLRequest(url:myurl! as URL)
        request.httpMethod = "POST"
        
        request.setValue(ServerAuthorization, forHTTPHeaderField: "authorization_token")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "access_token")
        
        let imageData = UIImagePNGRepresentation(userPhotoImageView.image!) as NSData?
        
        let param = [
            "userId" : user_id,
            "tokenId" : UserToken,
            "upload_document" : strBase64!,
            "applianceId" : strRecvAplnc_ID,
            "image_extension" : ".png"
            ] as [String : AnyObject]
        
        // print(param)
        let boundary = generateBoundaryString()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        if(imageData==nil)  { return; }
        
        request.httpBody = createBodyWithParameters(param: param, filePathKey: "file", imageDataKey: imageData! as NSData, boundary: boundary) as Data
        
        let task =  URLSession.shared.dataTask(with: request as URLRequest,
                                               completionHandler: {
                                                (data, response, error) -> Void in
                                                if let data = data {
                                                    // You can print out response object
                                                    print("******* response = \(String(describing: response))")
                                                    print(data.count)
                                                    // you can use data here
                                                    // Print out reponse body
                                                    
                                                    let responseString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                                                    print("****** response data = \(responseString!)")
                                                    
                                                    let json = try!JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                                                    
                                                    print("json value \(String(describing: json))")
                                                    
                                                    DispatchQueue.main.async(execute: {
                                                        let snackbar = TTGSnackbar.init(message: "Image Upload Successfully", duration: .middle)
                                                        snackbar.show()
                                                        
                                                        MBProgressHUD.hide(for: self.view!, animated: true)
                                                        self.userPhotoImageView.image = nil;
                                                        
                                                      // DashBrdViewController.createHomeViewController()
                                                        self.doPostServiceEditApplianceApi()
                                                    });
                                                    
                                                } else if let error = error {
                                                    print(error)
                                                }
        })
        
        task.resume()
    }
    
    
    func createBodyWithParameters(param:[String:AnyObject], filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        var body = NSMutableData();
        
        let mimetype = "image/jpg"
        let filename = "user-profile.jpg"
        
        if param != nil {
            for (key, value) in param {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendString(string: "\r\n")
        
        body.appendString(string: "--\(boundary)--\r\n")
        body.appendString(string: "upload_document")
        
        return body
        
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    //Button Action Raise Service
    @IBAction func clickReqst_RaiseService(sender: AnyObject){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "WTRaiseVWController") as! WTRaiseVWController
        newViewController.arrRecvApplncData = ArrGetAppilncData
        newViewController.strRecvApplincName = strSendApplnvTagName
        newViewController.strRecvModelApplnc = strSendModelApplnc
        newViewController.strAplincID = strSendApplncIDtoRaise
       self.navigationController?.pushViewController(newViewController, animated: true)
    
    }
    
    //Button ExtendWarranty
    @IBAction func clicktoExtendWarrantybtn(sender: AnyObject){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "WTExtndWarntyViewController") as! WTExtndWarntyViewController
        newViewController.strRecvApplncNAmeTAgforExtend = strSendApplnvTagName
        newViewController.strExtnd_ApplncID = strSendApplncIDtoRaise
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    //Renew Service..
    @IBAction func clicRENEWSERVICE_AMC(sender: AnyObject){
        //  self.doPostServiceUPDATEApplianceApi()
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AMCAggrementController") as! AMCAggrementController
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    
}

extension UIImageView{
    
    func setImageFromURl(stringImageUrl url: String){
        
        if let url = NSURL(string: url) {
            if let data = NSData(contentsOf: url as URL) {
                self.image = UIImage(data: data as Data)
            }
        }
    }
}
extension Date {
    
    func daysBetween(date: Date) -> Int {
        return Date.daysBetween(start: self, end: date)
    }
    
    static func daysBetween(start: Date, end: Date) -> Int {
        let calendar = Calendar.current
        
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: start)
        let date2 = calendar.startOfDay(for: end)
        
        let a = calendar.dateComponents([.day], from: date1, to: date2)
        return a.value(for: .day)!
    }
}

extension UITableView {
    
    var emptyCellsEnabledEditVWLog: Bool {
        set(newValue) {
            if newValue {
                tableFooterView = nil
            } else {
                tableFooterView = UIView()
            }
            
        }
        get {
            if tableFooterView == nil {
                return true
            }
            return false
        }
    }
}

