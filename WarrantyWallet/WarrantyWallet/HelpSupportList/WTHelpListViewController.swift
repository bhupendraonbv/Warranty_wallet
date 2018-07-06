//
//  WTHelpListViewController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 23/12/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.
//

import UIKit

class WTHelpListViewController: UIViewController,TopviewDelegate,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    var topview:TopViewController!
    var userDefault = UserDefaults.standard
    var user_id = String()
    var UserToken = String()
    var dict = String()
    
    var ArrSubjectList = NSArray()
    var ArrMessageList = NSArray()
    
    var allDictValue = NSDictionary()
    var mainArr = NSMutableArray()
    @IBOutlet weak var tblfeedbaclList: UITableView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblfeedbaclList.register(UINib(nibName: "CustomFeedbackList", bundle: nil), forCellReuseIdentifier: "CustomFeedbackList")
        
        tblfeedbaclList.isHidden = true

        
        addTopView()
        // Do any additional setup after loading the view.
    }
    
    func addTopView(){
        topview = TopViewController(title: "Feedback List", menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        topview.delegate = nil
        
        topview.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 75)
        self.view.addSubview(topview.view)
        self.view.layoutIfNeeded()
        
    }

    override func viewWillAppear(_ animated: Bool)
    {
        doPostHelpFeedbackListApi()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*do postcategory list*/
    func doPostHelpFeedbackListApi()
    {
        user_id = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_HELP_Feedback_List_API)! as URL)
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
                    
                    if (self.dict == "1")
                    {
                        self.mainArr = NSMutableArray()
                        self.mainArr = (dictFromJSON["data"] as? NSMutableArray)!
                        print(self.mainArr)
                        
                        self.ArrSubjectList = self.mainArr.value(forKey: "support_subject") as! NSArray
                        self.ArrMessageList = self.mainArr.value(forKey: "support_message") as! NSArray
                       
                        print(self.ArrSubjectList)
                        print(self.ArrMessageList)

                        DispatchQueue.main.async(execute: {
                            self.tblfeedbaclList.delegate = self
                            self.tblfeedbaclList.dataSource = self
                            self.tblfeedbaclList.isHidden = false
                            self.tblfeedbaclList.tblfeedbaclListemptyCellsEnabledServiceLog = false
                            self.tblfeedbaclList.reloadData()
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

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ArrSubjectList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let identifier: String = "CustomFeedbackList"
        var customCell : CustomFeedbackList!
        
        customCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CustomFeedbackList
        customCell.selectionStyle = UITableViewCellSelectionStyle.none
        //customCell.lblSubject?.text = mainArr.value(forKey: "support_subject") as? String
        customCell.lblSubject?.text = ArrSubjectList .object(at: indexPath.row) as? String
        //customCell.lblTxt?.text = mainArr.value(forKey: "support_message") as? String
        customCell.lblTxt?.text = ArrMessageList .object(at: indexPath.row) as? String

       // customCell.setCollectionViewDataSourceDelegate(indexPath)
        return customCell
    
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

extension UITableView {
    
    var tblfeedbaclListemptyCellsEnabledServiceLog: Bool {
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

