//
//  TermsPolicyViewController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 20/06/18.
//  Copyright © 2018 ONBV-BHUPI. All rights reserved.
//

import UIKit

class TermsPolicyViewController: UIViewController,UIWebViewDelegate {

    //var webView: UIWebView!
    
    var userDefault = UserDefaults.standard
    var user_id = String()
    var UserToken = String()
    var dict = String()
    
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let url = URL (string: "http://warrantyandmore.com/walletWebApi/pages/terms-and-contiditions.html")
        let requestObj = URLRequest(url: url!)
        webView.loadRequest(requestObj)
        
        
    }

    func dopostAggreTerms()
    {
        user_id = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_TERMS_Accept_API)! as URL)
        let set = CharacterSet()
        request.httpMethod = "POST"
        
        request.setValue(ServerAuthorization, forHTTPHeaderField: "authorization_token")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "access_token")
        
        let postString = "userId=\(String(describing: user_id))&tokenId=\(String(describing: UserToken))&isAgree=\(String(describing:"1"))"
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
                    print("status",self.dict)
                    
                    if (self.dict == "1")
                    {
                          //  let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                          //  let newViewController = storyBoard.instantiateViewController(withIdentifier: "DashBrdViewController") as! DashBrdViewController
                          //  self.navigationController?.pushViewController(newViewController, animated: true)
                          // AppDelegateInstance.rootNavigationController.pushViewController(newViewController, animated: true)
                    }else
                    {
                        print ("status 0")
                    }
                    
                }
                
            }catch
            {
                print("error")
            }
            
        }
        
        task.resume()
    }
    
    
    /*Login IN Up button click */
    @IBAction func clicklAggreandcancel(sender: AnyObject)
    {
        // DispatchQueue.main.async(execute: {
        self.dopostAggreTerms()
      //  })
        
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DashBrdViewController") as! DashBrdViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
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
