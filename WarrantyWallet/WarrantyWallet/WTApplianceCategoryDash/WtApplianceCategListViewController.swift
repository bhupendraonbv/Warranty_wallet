//
//  WtApplianceCategListViewController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 20/01/18.
//  Copyright © 2018 ONBV-BHUPI. All rights reserved.
//

import UIKit

class WtApplianceCategListViewController: UIViewController,TopviewDelegate,UICollectionViewDelegate,UICollectionViewDataSource {

     var topview:TopViewController!
      @IBOutlet var CollectnAppliance: UICollectionView!
    
    var userDefault = UserDefaults.standard
    var user_id = String()
    var UserToken = String()
    var dict = String()
    var allDictValue = NSDictionary()
    var mainArr = NSMutableArray()
    var ArrCatName = NSMutableArray()
    var strCatIDApplncList = String()
    var bottomView = BottomViewViewController()
    var strCatNameSend = String()
    var CommonstrMsg = String()
    
    var postString = String()
    
    var isSelected = false
    var strSendLoctnTAG = String()
    
     var ArrExpCountSoonName = NSMutableArray()
     var arCatImGIcon = NSMutableArray()
    
    
     @IBOutlet var btnHome: UIButton!
     @IBOutlet var btnOfc: UIButton!
    
     @IBOutlet var lblOfcLine: UILabel!
     @IBOutlet var lblHomeLine: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        CollectnAppliance.register(UINib(nibName: "WTApplincCategryCustom", bundle: nil), forCellWithReuseIdentifier: "WTApplincCategryCustom")

      btnHome.isUserInteractionEnabled = false
        
      addTopView()
      addBottomView()
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        btnHome.backgroundColor = UIColor.white
        btnHome.setTitleColor(UIColor(red: 91/255, green: 202/255, blue: 203/255, alpha: 1.0), for: .normal)
        btnOfc.setTitleColor(UIColor.gray, for: .normal)

        strSendLoctnTAG = "Home"
 
        user_id = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
        
        postString = "userId=\(String(describing: user_id))&tokenId=\(String(describing: UserToken))&cat_location=\(String(describing: "Home"))"
        POST_CATEGORY_LIST_API()
    
    }
    
    //Top View
    func addTopView(){
        topview = TopViewController(title: "Registered Products", menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        topview.delegate = nil
        
        topview.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 75)
        topview.topBGVW.backgroundColor = UIColor .clear
        self.view.addSubview(topview.view)
        self.view.layoutIfNeeded()
        
    }
    
    //Bottom view
    func addBottomView(){
        // bottomView = BottomViewViewController()
        self.bottomView.view.frame = CGRect(x: 0, y: WINDOW_HEIGHT-56 , width: WINDOW_WIDTH, height: 56)
        self.bottomView.btnApplinc.isUserInteractionEnabled = false
         self.bottomView.btnApplinc.isSelected = true
        self.view.addSubview(bottomView.view)
    }
    
    //Hidden right now
    @IBAction func clickOfficeandHomeTAGbtn(sender: UIButton)
    {
        user_id = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
        
        if sender.tag == 501
        {
            btnHome.backgroundColor = UIColor.white
            btnHome.setTitleColor(UIColor(red: 91/255, green: 202/255, blue: 203/255, alpha: 1.0), for: .normal)
            
            btnOfc.backgroundColor = UIColor.white
            btnOfc.setTitleColor(UIColor.gray, for: .normal)
            lblHomeLine.isHidden = false
            lblOfcLine.isHidden = true
            
            strSendLoctnTAG = "Home"
            
            //cat_location","Home"
             postString = "userId=\(String(describing: user_id))&tokenId=\(String(describing: UserToken))&cat_location=\(String(describing: "Home"))"
           
        }
        else if sender.tag == 502
        {
            btnHome.isUserInteractionEnabled = true
            lblHomeLine.isHidden = true
            lblOfcLine.isHidden = false
            
            btnOfc.backgroundColor = UIColor.white
            btnOfc.setTitleColor(UIColor(red: 91/255, green: 202/255, blue: 203/255, alpha: 1.0), for: .normal)
            
            btnHome.backgroundColor = UIColor.white
            btnHome.setTitleColor(UIColor.gray, for: .normal)
            
            strSendLoctnTAG = "Office"
            
            //cat_location","Office"
            postString = "userId=\(String(describing: user_id))&tokenId=\(String(describing: UserToken))&cat_location=\(String(describing: "Office"))"
        }
        else{
            print("tag")
        }
        
      POST_CATEGORY_LIST_API()
    
    }
    
    // Api for category list
    func POST_CATEGORY_LIST_API()
    {
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_Appliance_Category_LIST_API)! as URL)
        request.httpMethod = "POST"
        
        request.setValue(ServerAuthorization, forHTTPHeaderField: "authorization_token")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "access_token")
        
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
                    
                    self.ArrCatName .removeAllObjects()
                    
                    if (self.dict == "1")
                    {
                        //arrCategoryList
                        self.mainArr = NSMutableArray()
                        self.mainArr = (dictFromJSON["data"] as? NSMutableArray)!
                        print(self.mainArr)
                        
                        for storedict in 0..<self.mainArr.count
                        {
                            self.allDictValue = self.mainArr[storedict] as! NSDictionary
                            print(self.allDictValue)
                             self.ArrCatName.addObjects(from: [self.allDictValue.value(forKey: "category_name")!])
                            print("nameApp",self.ArrCatName)
                            self.ArrExpCountSoonName.addObjects(from: [self.allDictValue.value(forKey: "exp_count")!])
                        
                            self.arCatImGIcon.addObjects(from:[self.allDictValue.value(forKey: "category_icon")!])
                             print("nameApp",self.arCatImGIcon)
                        
                        }
                        
                        print("CategoryList",self.ArrCatName)
                        print("arrList",self.ArrExpCountSoonName)
                        print("CategoryListIMG",self.arCatImGIcon)
                        
                    }
                        
                    else {
                        print (" status 0")
                        self.CommonstrMsg = (dictFromJSON["msg"] as? String)!
                        self.displayAlertMessagae(userMessage: self.CommonstrMsg)
                        
                    }
                    
                    DispatchQueue.main.async(execute: {
                        self.CollectnAppliance.delegate = self
                        self.CollectnAppliance.dataSource = self
                        self.CollectnAppliance .reloadData()
                    })
                
                }
                
            }catch
            {
                print("error")
            }
            
        }
        
        task.resume()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ArrCatName.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WTApplincCategryCustom", for: indexPath) as! WTApplincCategryCustom
        cell.lblCat!.text = ArrCatName .object(at: indexPath.row) as? String
        cell.expCount!.text = ArrExpCountSoonName.object(at: indexPath.row) as? String
        
        cell.expCount.isHidden = false
        cell.lblExpSn.isHidden = false
        
       cell.imgVWCat.downloadImageFrom(link: arCatImGIcon[indexPath.row] as! String , contentMode: UIViewContentMode.scaleAspectFit)
        
        /*let img : UIImage = UIImage(named: (arCatImGIcon[indexPath.row] as? String)!)!
        cell.btnCat.setImage(img,for:.normal)*/
        
        /*for var i in 0..<ArrExpCountSoonName.count {
            /*if (ArrExpCountSoonName[i] < 5) {
                ArrExpCountSoonName.removeAtIndex(i)
                i -= 1
            }*/
            
            let filteredStrings = ArrExpCountSoonName.filter(using: {(item: String) -> Bool in
                var stringMatch = item.lowercaseString.rangeOfString(searchToSearch.lowercaseString)
                return stringMatch != nil ? true : false
            
            })
      
        }*/
        
           /* for i in 0 ..< ArrExpCountSoonName.count
            {
                let elemant = ArrExpCountSoonName[i] as! String
                if (elemant as AnyObject).contains("0")
                {
                    cell.expCount.isHidden = true
                    cell.lblExpSn.isHidden = true
                }
                else {
                    
                    cell.expCount.isHidden = false
                    cell.lblExpSn.isHidden = false
                }
                
            }*/
        
        print(ArrCatName)
        print(ArrExpCountSoonName)
        
      /* if (ArrCatName.object(at: indexPath.row) as AnyObject).contains("Home Appliances")
        {
            print("flgwf")
            if let image = UIImage(named: "catImg.png") {
                cell.btnCat.setImage(image, for: UIControlState.normal)
            }
        }
        if (ArrCatName.object(at: indexPath.row) as AnyObject).contains("Phone")
        {
            print("phone")
            if let image = UIImage(named: "Phone.png") {
                cell.btnCat.setImage(image, for: UIControlState.normal)
            }
            
        }
        if (ArrCatName.object(at: indexPath.row) as AnyObject).contains("Furniture")
        {
            print("Furniture")
            if let image = UIImage(named: "furtinuture.png") {
                cell.btnCat.setImage(image, for: UIControlState.normal)
            }
            
        }
        if (ArrCatName.object(at: indexPath.row) as AnyObject).contains("Vehicles")
        {
            print("flgwf")
            print("Furniture")
            if let image = UIImage(named: "Vechicle.png") {
                cell.btnCat.setImage(image, for: UIControlState.normal)
            }
            
            
        }
        if (ArrCatName.object(at: indexPath.row) as AnyObject).contains("Sports")
        {
            print("flgwf")
            if let image = UIImage(named: "categorysprt.png") {
                cell.btnCat.setImage(image, for: UIControlState.normal)
            }   
            
        }
        else {
            
        }*/
        
        return cell
    
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
      
        //Inside tab comment ...............>>>>>>>
        /*print("You selected cell #\(indexPath.item)!")
         
        strCatNameSend = (ArrCatName .object(at: indexPath.item) as? String)!
        print("You selected cell #\(strCatNameSend)!")
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SubApplianceCategListViewController") as! SubApplianceCategListViewController
        newViewController.strCatIDApplncList = strCatNameSend
        newViewController.strRecvLocationTag = strSendLoctnTAG
        self.navigationController?.pushViewController(newViewController, animated: true)*/
        
        print("You selected cell #\(indexPath.item)!")
        strCatIDApplncList = (ArrCatName .object(at: indexPath.item) as? String)!
        print("You selected cell #\(strCatIDApplncList)!")
        
      //  print("You locationcell #\(strRecvLocationTag)!")
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AppliancesViewController") as! AppliancesViewController
        newViewController.strCatIDApplncList = (ArrCatName .object(at: indexPath.item) as? String)!
       // newViewController.strRecvCatLocationFromAp = strRecvLocationTag
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
      return UIEdgeInsetsMake(35, 0, 0, 0)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let numberOfSets = CGFloat(self.ArrCatName.count)
        
        let width = (collectionView.frame.size.width - (numberOfSets * view.frame.size.width / 15))/numberOfSets
        
        let height = collectionView.frame.size.height / 2
        
        return CGSize(width: width, height: height)
    
    }
    

    func doPostApplianceCAteoryListApi()
    {
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*Generic Alert view functionality */
    func displayAlertMessagae(userMessage:String)
    {
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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

extension UIImageView {
    func downloadImageFrom(link link:String, contentMode: UIViewContentMode) {
        URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async() {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}
