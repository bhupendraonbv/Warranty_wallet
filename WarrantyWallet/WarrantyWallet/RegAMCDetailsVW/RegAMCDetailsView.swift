//
//  RegAMCDetailsView.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 15/02/18.
//  Copyright © 2018 ONBV-BHUPI. All rights reserved.
//

import UIKit

class RegAMCDetailsView: UIViewController,TopviewDelegate,UITableViewDelegate,UITableViewDataSource {

    
    var bottomView = BottomViewViewController()
    var topview:TopViewController!
    
    var userDefault = UserDefaults.standard
    var user_id = String()
    var UserToken = String()
    var dict = String()
    var mainArr = NSMutableArray()
    var strRecvAplnc_ID = String()
    var TempDict = NSDictionary()
    var ArrDays = NSMutableArray()
    var ArrDocumentName = NSMutableArray()
    var ArrImgURL = NSMutableArray()
    var ArrallOtherPartsProduct = NSMutableArray()
    var strDaysCount = String()
     var DictDocumentUrl = NSDictionary()
    
    
    
    @IBOutlet weak var TxtAMCName: UITextField!
    @IBOutlet weak var TxtPurcsDate: UITextField!
    @IBOutlet weak var TxtExpDate: UITextField!
    @IBOutlet weak var TxtProviderNam: UITextField!
    @IBOutlet weak var TxtProviderNumb: UITextField!
    @IBOutlet weak var TxtAMCTenure: UITextField!
    
    @IBOutlet weak var tblSliderList: UITableView!
    @IBOutlet weak var tblDocumentList: UITableView!
    
    var ArrImgDocumentAll = NSMutableArray()
    
    
     @IBOutlet weak var VWGradient: UIView!
    
    @IBOutlet weak var btnHMAplnc: UIButton!
    @IBOutlet weak var btnAirConcnr: UIButton!
    
    
    @IBAction func backclick(sender: AnyObject)
    {
        self.navigationController?.popViewController(animated: true)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tblSliderList.register(UINib(nibName: "CstmEditDaySlidrCell", bundle: nil), forCellReuseIdentifier: "CstmEditDaySlidrCell")
        
        doPostReGAMCDEtailsApi()
        
        
        btnHMAplnc.layer.cornerRadius = 6.0
        btnAirConcnr.layer.cornerRadius = 6.0
        
        
        addTopView()
        addBottomView()
        setGradientBackground()
        
    }

    //Gradient View code here..
    func setGradientBackground() {
        let colorTop =  UIColor(red: 19.0/255.0, green: 84.0/255.0, blue: 122.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 128.0/255.0, green: 209.0/255.0, blue: 199.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.VWGradient.bounds
        
        self.VWGradient.layer.addSublayer(gradientLayer)
        
    }
    
    //Top View here..
    func addTopView(){
        topview = TopViewController(title: "AMCs Edit Details", menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        topview.delegate = nil
        
        topview.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 75)
        topview.topBGVW.backgroundColor = UIColor .clear
        self.view.addSubview(topview.view)
        self.view.layoutIfNeeded()
    }
    
    //Bottom View here..
    func addBottomView(){
        // bottomView = BottomViewViewController()
        self.bottomView.view.frame = CGRect(x: 0, y: WINDOW_HEIGHT-56 , width: WINDOW_WIDTH, height: 56)
        self.view.addSubview(bottomView.view)
    }
    
    
    //Tabel delegate method here..
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
            return 55
        }
        return 70
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
            //customCellNew.LblProductNm.text = self.TempDict.value(forKey: "amc_tag_name") as? String
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

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //AMCEditDetails Api here..
    func doPostReGAMCDEtailsApi()
    {
        user_id = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_REGISTERED_AMCDETAILS_API)! as URL)
        request.httpMethod = "POST"
        
        request.setValue(ServerAuthorization, forHTTPHeaderField: "authorization_token")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "access_token")
        
        let postString = "userId=\(String(describing: user_id))&tokenId=\(String(describing: UserToken))&amcId=\(String(describing: strRecvAplnc_ID))"
        
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
                            self.TxtAMCName.text = self.TempDict.value(forKey: "amc_tag_name") as? String
                            
                            
                            self.TxtAMCTenure.text = self.TempDict.value(forKey: "amc_tenure") as? String
                            self.TxtPurcsDate.text = self.TempDict.value(forKey: "amc_date_of_parched") as? String
                            self.TxtExpDate.text = self.TempDict.value(forKey: "amc_expiry_date") as? String
                            self.TxtProviderNam.text = self.TempDict.value(forKey: "amc_provider_name") as? String
                            self.TxtProviderNumb.text = self.TempDict.value(forKey: "amc_provider_number") as? String
                           /* self.TxtMenufacture.text = self.TempDict.value(forKey: "appliance_manufacturer") as? String
                            self.TxtCapcty.text = self.TempDict.value(forKey: "appliance_capacity") as? String*/
                            
                            self.ArrallOtherPartsProduct .addObjects(from: [self.TempDict.value(forKey: "amc_tag_name")!])
                            
                            //Tbl Reload and delege self.....
                            
                            let startDateProduct  = self.TempDict.value(forKey: "amc_date_of_parched") as? String
                            let EndDateProduct = self.TempDict.value(forKey: "amc_expiry_date") as? String
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "dd-MM-yyyy"
                            let start = dateFormatter.date(from: startDateProduct!)!
                            let end = dateFormatter.date(from: EndDateProduct!)!
                            
                            let diff = Date.daysBetween(start: start, end: end) // 365
                            
                            let xNSNumber = diff as NSNumber
                            self.strDaysCount = xNSNumber.stringValue
                            print(self.strDaysCount)
                            
                            
                            self.ArrDays .removeAllObjects()
                            self.ArrDays .add(self.strDaysCount)
                            print(self.ArrDays)
                            
                          
                            
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
    
    
    //AMC Edit Fields.
    @IBAction func clickusrMake_AMCeditField(sender: AnyObject){
        // self.usrMake_EditField()
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AMCEditFieldView") as! AMCEditFieldView
        newViewController.ArrGetEditAMCDetails = mainArr
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    
    //RenewService button action ...
    @IBAction func clicRENEWSERVICE_AMC(sender: AnyObject){
        //  self.doPostServiceUPDATEApplianceApi()
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AMCAggrementController") as! AMCAggrementController
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    
    @IBAction func clicktoPhoneNymber(sender: AnyObject){
        
        UIApplication.shared.openURL(NSURL(string: "tel://9643296520")! as URL)
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
