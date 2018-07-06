//
//  WTMenuViewController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 07/11/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.
//

import UIKit

class WTMenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

   var cntrl: UIViewController?;
   @IBOutlet weak var tblMenu: UITableView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserEmail: UILabel!
    @IBOutlet weak var ImgUserProfile: UIImageView!
    
    var Arrmenulist : NSMutableArray!
    var ArrImglist : NSMutableArray!
    var selectedCellIndex = 0
    var userDefault = UserDefaults.standard
    var user_id = String()
    var UserToken = String()
    var dict = String()
    var mainArr = NSMutableArray()
    
    var arrUserName : NSMutableArray!
    var arrUserEmail : NSMutableArray!
    
    var strUserName = String()
    var strEmail = String()
     var strImageUrl = String()
     var MainDict = NSDictionary()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       tblMenu.delegate = self
       tblMenu.dataSource = self
        
       tblMenu.separatorColor = UIColor.clear
       tblMenu.isScrollEnabled = true
        
        self.tblMenu.register(UINib(nibName: "CusteomMenuCell", bundle: nil), forCellReuseIdentifier: "CusteomMenuCell")

        Arrmenulist = ["Profile","About Us","Help & Support","Settings","Sign Out"]
        
        ArrImglist = NSMutableArray(arrayLiteral: "ProfileIcon","AccountsIcon","HelpIcon","SettingsIcon","SignoutIcon")
    
        
        //ImgUserProfile.layer.borderWidth = 1
        ImgUserProfile.layer.masksToBounds = false
       // ImgUserProfile.layer.borderColor = UIColor .white .cgColor
        ImgUserProfile.layer.cornerRadius = ImgUserProfile.frame.height/2
        ImgUserProfile.clipsToBounds = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
       doPostPROFILEeApi()
    
    }
    
    /*do postcategory list*/
    func doPostPROFILEeApi()
    {
        user_id = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_PROFILE_API)! as URL)
        request.httpMethod = "POST"
        request.setValue(ServerAuthorization, forHTTPHeaderField: "authorization_token")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "access_token")
        
        let postString = "userId=\(String(describing: user_id))&tokenId=\(String(describing: UserToken))"
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
                    
                    if(self.dict == "1")
                    {
                        self.mainArr = NSMutableArray()
                        self.mainArr = (dictFromJSON["data"] as? NSMutableArray)!
                        print(self.mainArr)
                       
                        self.MainDict = (self.mainArr[0] as? NSDictionary)!
                        print(self.MainDict)
                        
                        self.strUserName = self.MainDict.value(forKey: "first_name") as! String
                        self.strEmail = self.MainDict.value(forKey: "user_email") as! String
                        self.strImageUrl = self.MainDict.value(forKey: "user_image") as! String
                    }
                    
                    DispatchQueue.main.async {
                        self.lblUserName?.text = self.strUserName
                        self.lblUserEmail?.text = self.strEmail
                        self.ImgUserProfile?.setImageProfileFromURl(stringImageUrl: self.strImageUrl)
                    
                    }
                }
                
            }catch
            {
                print("error")
            }
            
        }
        
        task.resume()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Arrmenulist.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return  60 //46
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let identifier: String = "CusteomMenuCell"
        var customCell : CusteomMenuCell!
        
        customCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CusteomMenuCell
        
        let image: String = ArrImglist[indexPath.row] as! String
        
        
        customCell.ImgMenu.image = UIImage(named: image )

        customCell.lblMenuName.text = Arrmenulist.object(at: indexPath.row) as? String
        
        customCell.selectionStyle = .none

        //customCell.setCollectionViewDataSourceDelegate(indexPath)
        return customCell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedCellIndex = indexPath.row
        tblMenu.reloadData()
        
        //Side Menu Cell Action
        switch(indexPath.row)
        {
        
        case 0:
            
            self.dismiss(animated: true, completion: {});
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "EditProfileView") as! EditProfileView
            newViewController.ReceiveMainDict = MainDict
            AppDelegateInstance.rootNavigationController.pushViewController(newViewController, animated: true)
            
        case 1:
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
            AppDelegateInstance.rootNavigationController.pushViewController(newViewController, animated: true)
            
        case 2:
            self.dismiss(animated: true, completion: {});
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "HelpSupportViewController") as! HelpSupportViewController
            AppDelegateInstance.rootNavigationController.pushViewController(newViewController, animated: true)
            
            case 3:
            
            self.dismiss(animated: true, completion: {});
            
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "WTSettingViewController") as! WTSettingViewController
            AppDelegateInstance.rootNavigationController.pushViewController(newViewController, animated: true)
            
            case 4:
                // create the alert
                // Create the alert controller
                let alertController = UIAlertController(title: "Alert!", message: "Are you sure you want to Sign Out.", preferredStyle: .alert)
                
                // Create the actions
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    NSLog("OK Pressed")
                    
                    //self.saveListIdArray()
                    let defaults = UserDefaults.standard
                    defaults.removeObject(forKey: "UserToken")
                    
                    /*AppDelegateInstance.drawerController.centerViewController = MAIN_STORYBOARD.instantiateViewController(withIdentifier: "ViewController")
                    AppDelegateInstance.drawerController.toggle(MMDrawerSide.left, animated: true, completion: nil)*/
                    
                    AppDelegateInstance.drawerController.centerViewController = MAIN_STORYBOARD.instantiateViewController(withIdentifier: "WarrantyOrganizerViewController")
                    AppDelegateInstance.drawerController.toggle(MMDrawerSide.left, animated: true, completion: nil)
                    
                }
                
                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
                    UIAlertAction in
                    NSLog("Cancel Pressed")
                
                }
                
                // Add the actions
                alertController.addAction(okAction)
                alertController.addAction(cancelAction)
                
                // Present the controller
                self.present(alertController, animated: true, completion: nil)
        
        default:
            print("Default")
        }
        
    }
    
    
    func saveListIdArray(_ params: NSMutableArray = []) {
        let data = NSKeyedArchiver.archivedData(withRootObject: params)
        
        UserDefaults.standard.set(data, forKey: "accessToken")
        UserDefaults.standard.synchronize()
    }

    
    func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int){
        switch buttonIndex{
        case 0:
            print("Yes")
            
        case 1:
            print("No")
           
        
        default:
          print("Default")
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension UIImageView{
    
    func setImageProfileFromURl(stringImageUrl url: String){
        
        if let url = NSURL(string: url) {
            if let data = NSData(contentsOf: url as URL) {
                self.image = UIImage(data: data as Data)
            }
        }
    }
}
