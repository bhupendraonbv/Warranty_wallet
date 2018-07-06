//
//  SubApplianceCategListViewController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 01/02/18.
//  Copyright © 2018 ONBV-BHUPI. All rights reserved.
//

import UIKit

class SubApplianceCategListViewController: UIViewController,TopviewDelegate,UICollectionViewDelegate,UICollectionViewDataSource {
    var topview:TopViewController!
    var bottomView = BottomViewViewController()
    var postString = String()
    var userDefault = UserDefaults.standard
    var user_id = String()
    var UserToken = String()
    var dict = String()
    var allDictValue = NSDictionary()
    var mainArr = NSMutableArray()
    var strCatIDApplncList = String()
    var ArrCatName = NSMutableArray()
    var CommonstrMsg = String()
    var strRecvLocationTag = String()
    var strHDRTITLE = String()
    var ArrCatIMAGEName = NSMutableArray()
    
    @IBOutlet weak var btnFull: UIButton!
    @IBOutlet weak var thankVW: UIView!
    @IBOutlet weak var cnclPOP : UIButton!
    
    
  @IBOutlet var SubCollectnAppliance: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ArrCatName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubApplincCategryCustem", for: indexPath) as! SubApplincCategryCustem
       cell.lblSubCat!.text = ArrCatName .object(at: indexPath.row) as? String
        
        print(ArrCatName)
        
        
        if strCatIDApplncList == "Home Appliances"{
            print("flgwf")
            if let image = UIImage(named: "catImg.png") {
                cell.btnSubCat.setImage(image, for: UIControlState.normal)
            }
            
        }
        if strCatIDApplncList == "Phone"{
            print("phone")
            if let image = UIImage(named: "Phone.png") {
                cell.btnSubCat.setImage(image, for: UIControlState.normal)
            }
        }
        if strCatIDApplncList == "Furniture"{
            print("Furniture")
            if let image = UIImage(named: "furtinuture.png") {
                cell.btnSubCat.setImage(image, for: UIControlState.normal)
            }
        }
        if strCatIDApplncList == "Vehicles"{
            print("flgwf")
            print("Furniture")
            if let image = UIImage(named: "Vechicle.png") {
                cell.btnSubCat.setImage(image, for: UIControlState.normal)
            }
        }
        if strCatIDApplncList == "Sports and Fitness"{
            print("flgwf")
            if let image = UIImage(named: "catImg.png") {
                cell.btnSubCat.setImage(image, for: UIControlState.normal)
            }
        }
        else {
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 20, 0, 20)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        
        strCatIDApplncList = (ArrCatName .object(at: indexPath.item) as? String)!
        print("You selected cell #\(strCatIDApplncList)!")
        
        print("You locationcell #\(strRecvLocationTag)!")
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let newViewController = storyBoard.instantiateViewController(withIdentifier: "AppliancesViewController") as! AppliancesViewController
         newViewController.strCatIDApplncList = (ArrCatName .object(at: indexPath.item) as? String)!
         newViewController.strRecvCatLocationFromAp = strRecvLocationTag
        
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        print("Get IDNAme",strCatIDApplncList)
        print("Location",strRecvLocationTag)
        
        strHDRTITLE = strRecvLocationTag.uppercased() + " " + "-" + " " + strCatIDApplncList.uppercased()
        
         SubCollectnAppliance.register(UINib(nibName: "SubApplincCategryCustem", bundle: nil), forCellWithReuseIdentifier: "SubApplincCategryCustem")
        
        POST_SUB_CATEGORY_LIST_API()

        
    addTopView()
    addBottomView()
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
    }
    

    func addTopView(){
        topview = TopViewController(title: strHDRTITLE, menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        topview.delegate = nil
        
        topview.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 75)
        self.view.addSubview(topview.view)
        self.view.layoutIfNeeded()
        
    }
    
    func addBottomView(){
        // bottomView = BottomViewViewController()
        self.bottomView.view.frame = CGRect(x: 0, y: WINDOW_HEIGHT-56 , width: WINDOW_WIDTH, height: 56)
        self.bottomView.btnApplinc.isUserInteractionEnabled = false
        self.bottomView.btnApplinc.isSelected = true
        self.view.addSubview(bottomView.view)
    }
    
    //Api code here.
    func POST_SUB_CATEGORY_LIST_API()
    {
        user_id = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_SUB_Category_Appliance_API)! as URL)
        request.httpMethod = "POST"
        
        request.setValue(ServerAuthorization, forHTTPHeaderField: "authorization_token")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "access_token")
        
        postString = "userId=\(String(describing: user_id))&tokenId=\(String(describing: UserToken))&cat_location=\(String(describing: strRecvLocationTag))&category=\(String(describing: strCatIDApplncList))"
        
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
                        
                        for storedict in 0..<self.mainArr.count
                        {
                            self.allDictValue = self.mainArr[storedict] as! NSDictionary
                            print(self.allDictValue)
                            self.ArrCatName.addObjects(from: [self.allDictValue.value(forKey: "sub_category_name")!])
                        }
                        
                        print("sub_category_name",self.ArrCatName)
                    }
                        
                    else {
                        print (" status 0")
                        self.CommonstrMsg = (dictFromJSON["msg"] as? String)!
                        self.displayAlertMessagae(userMessage: self.CommonstrMsg)
                        
                    }
                    
                    DispatchQueue.main.async(execute: {
                        self.SubCollectnAppliance.delegate = self
                        self.SubCollectnAppliance.dataSource = self
                        self.SubCollectnAppliance .reloadData()
                    })
                    
                }
                
            }catch
            {
                print("error")
            }
            
        }
        
        task.resume()
        
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
