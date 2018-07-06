/////Login Class
//Bhupi


import UIKit
import  AVFoundation
//import Google
import GoogleSignIn
import Google


class ViewController: UIViewController,UIImagePickerControllerDelegate,UITextFieldDelegate,GIDSignInDelegate,GIDSignInUIDelegate {
    
    @IBOutlet weak var imagePicked: UIImageView!
    @IBOutlet weak var textfieldEmail: UITextField!
    @IBOutlet weak var textfieldPassword: UITextField!
    @IBOutlet weak var btnRemember: UIButton!
    
     @IBOutlet weak var redEmailImg: UIImageView!
     @IBOutlet weak var redCircle: UIImageView!
    
    @IBOutlet weak var redpassword: UIImageView!
    @IBOutlet weak var redCirclePass: UIImageView!
    
    var UserToken = String()
    var status : Int!
    var dict = String()
    
    var arrPrdctName: NSMutableArray = []
    var strFirstName = String()
    var strLastName = String()
    var strFullNAmeAppend = String()
    
    var AlertstrMsg = String()
    var spinnerActivity: MBProgressHUD = MBProgressHUD()
    
     var UserEmail = UserDefaults.standard
     var UserPass = UserDefaults.standard
     var btnStateDefault = UserDefaults.standard
    
    
    @IBOutlet weak var vwBG: UIView!
    @IBOutlet weak var vwEmail: UIView!
    @IBOutlet weak var vwPassword: UIView!
    @IBOutlet weak var btnlgn: UIButton!
    
    @IBOutlet weak var btnFull: UIButton!
    @IBOutlet weak var thankVW: UIView!
    
    @IBOutlet weak var cnclPOP : UIButton!
    
     @IBOutlet weak var lblOppsMsg : UILabel!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
   
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        vwEmail.layer.cornerRadius = 10
        vwPassword.layer.cornerRadius = 10
        btnlgn.layer.cornerRadius = 18
        
        
        btnRemember.setImage(UIImage(named: "CheckboxSelected"), for: .normal)
        textfieldEmail.text = UserEmail.value(forKey: "RememberName") as? String
        textfieldPassword.text = UserPass.value(forKey: "RemeberPass") as? String
        
        if UserDefaults.standard.object(forKey: "btnState") != nil {
            btnRemember.isSelected = true
        }
        else {
            btnRemember.isSelected = false
        }
        
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().clientID = "653639818409-kku4nl74t0gfnfu2pgo2rqnopl51d94v.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().scopes.append("https://www.googleapis.com/auth/plus.login")
        GIDSignIn.sharedInstance().scopes.append("https://www.googleapis.com/auth/plus.me")
        
        GIDSignIn.sharedInstance().signInSilently()
        
        
    }
    
    //Remember Button Action for save password
    @IBAction func clickrememberBtn(sender: AnyObject)
    {
        if let button = sender as? UIButton {
            if button.isSelected {
                // set deselected
                
                button.isSelected = false
                
                UserEmail.removeObject(forKey: "RememberName")
                UserPass.removeObject(forKey: "RemeberPass")
                btnStateDefault.removeObject(forKey: "btnState")
                
            } else {
                // set selected
                
                UserEmail.setValue(textfieldEmail.text, forKey: "RememberName")
                UserEmail.synchronize()//user_email
                
                UserPass.setValue(textfieldPassword.text, forKey: "RemeberPass")
                UserPass.synchronize()//user_pass
                
                btnStateDefault.setValue(true, forKey: "btnState")
                
                button.isSelected = true
            
            }
        }
    }
    
  
    /*Login IN Up button click */
     @IBAction func clickloginBtn(sender: AnyObject)
     {
        
         if ((textfieldEmail?.text!.isEmpty)!)
        {
           // displayAlertMessagae(userMessage: "Please enter Email/Mobile No.")
            
            redEmailImg.isHidden = false
            redCircle.isHidden = false
            
            btnFull.isHidden = false
            thankVW.isHidden = false
            
            return
        }
        
        else if ((textfieldPassword?.text!.isEmpty)!)
        {
           // displayAlertMessagae(userMessage: "Please enter password.")
            
            redpassword.isHidden = false
            redCirclePass.isHidden = false
            
            
            btnFull.isHidden = false
            thankVW.isHidden = false


            
            return
        }
        
       POST_Hit_LOGIN_API()

     }
    
    
    @IBAction func cnclPopUPcrosbtn(sender: AnyObject) {
        
        thankVW.isHidden = true
        btnFull.isHidden = true
        
    }
    
    //LoginApi Declare Here..
    func POST_Hit_LOGIN_API(){
        
        self.spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
        self.spinnerActivity.label.text = "Loading..."
        
        let userName = textfieldEmail.text!
        let pass = textfieldPassword.text!
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_SIGNIN_API)! as URL)
        request.httpMethod = "POST"
        request.setValue(ServerAuthorization, forHTTPHeaderField: "authorization_token")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "access_token")
        
        
        let postString = "username=\(String(describing: userName))&password=\(String(describing: pass))"
        print("printString",postString)
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest){data, response, error in
            guard error == nil && data != nil else{
                print("error")
                DispatchQueue.main.async(execute: {() -> Void in                                                                           MBProgressHUD.hide(for: self.view!, animated: true)
                })
                //self.displayAlertMessagae(userMessage: "No Internet connection.")
                
                self.btnFull.isHidden = false
                self.thankVW.isHidden = false
                self.lblOppsMsg.text = "No Internet connection."
                
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200{
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                
            }
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            
            do
            {
                guard let parsedData = try JSONSerialization.jsonObject(with: data!) as? [String:Any]else{
                    
                    //json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary else{
                    
                    return
                }
                
                if let dictFromJSON = parsedData as? [String:AnyObject] {
                    print(dictFromJSON)
                    
                    DispatchQueue.main.async(execute: {() -> Void in                                                                           MBProgressHUD.hide(for: self.view!, animated: true)
                    })
                    
                    self.dict = (dictFromJSON["status"] as? String)!
                    print("hfuwfhwq",self.dict)
                    
                    self.AlertstrMsg = (dictFromJSON["msg"] as? String)!
                    
                    if (self.dict == "1")
                    {
                        var mainArr = NSArray()
                        mainArr = (dictFromJSON["data"] as? NSArray)!
                        
                        let token = (mainArr[0] as? NSDictionary)!
                        print(token)
                        
                        var strToken = String()
                        strToken = token.value(forKey: "session_token") as! String
                        print(strToken)
                        
                        //let userId = mainArr.value(forKey: "user_id") as AnyObject
                        var userId  = String()
                        userId = token.value(forKey: "user_id") as! String
                        
                        print("userId",userId)
                        
                        let defaults = UserDefaults.standard
                        defaults.set(userId, forKey: "user_id")
                        print("userdefault",defaults.set(userId, forKey: "user_id"))
                        
                        defaults.synchronize()//user_email
                        
                        let UserToken = UserDefaults.standard
                        UserToken.set(strToken, forKey: "UserToken")
                        UserToken.synchronize()
                        print(UserToken)
                        
                        self.strFirstName = token.value(forKey: "first_name") as! String
                        
                        self.strLastName = token.value(forKey: "last_name") as! String
                        
                        self.strFullNAmeAppend = self.strFirstName + " " + self.strLastName
                        print("FullNAme",self.strFullNAmeAppend)
                        
                        let fullnameDefault = UserDefaults.standard
                        fullnameDefault.set(self.strFullNAmeAppend, forKey: "FullNameDashBoard")
                        fullnameDefault.synchronize()
                        
                        
                        var EmailiD = String()
                        EmailiD = token.value(forKey: "user_email") as! String
                        
                        let UserEmail = UserDefaults.standard
                        UserEmail.set(EmailiD, forKey: "LoginEmail")
                        UserEmail.synchronize()
                        
                        DispatchQueue.main.async(execute: {() -> Void in                                                      DashBrdViewController.createHomeViewController()
                        })
                        
                    }
                    else {
                        
                        DispatchQueue.main.async(execute: {
                           // self.displayAlertMessagae(userMessage: self.AlertstrMsg)
                       
                            self.btnFull.isHidden = false
                            self.thankVW.isHidden = false
                            self.lblOppsMsg.text = self.AlertstrMsg
                        
                        })
                        
                    }
                    
                }
                
            }catch
            {
                print("error")
                DispatchQueue.main.async(execute: {() -> Void in                                                                           MBProgressHUD.hide(for: self.view!, animated: true)
                })
                DispatchQueue.main.async(execute: {
                   // self.displayAlertMessagae(userMessage: self.AlertstrMsg)
                    self.btnFull.isHidden = false
                    self.thankVW.isHidden = false
                    self.lblOppsMsg.text = self.AlertstrMsg
                    
                })
                
            }
            
        }
        
        task.resume()
    }
    
    /*Sign Up button click */
    @IBAction func gotosignup(sender: AnyObject)
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "GroupSelectViewController") as! GroupSelectViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
     /*Camera button open functionality */
    @IBAction func openCameraButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        displayAlertMessagae(userMessage: "Please connect to the device ")
    }
    
     /*Device photo button open functionality */
    @IBAction func openPhotoLibraryButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    /*Generic Alert view functionality */
    func displayAlertMessagae(userMessage:String)
    {
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

     /*Under Development */
    @IBAction func MenuviewOPen(sender: AnyObject){
    displayAlertMessagae(userMessage: "Under Development ")
    
    }
    
    //SignUPButton Action Click.
    @IBAction func clicktosignUP(sender: AnyObject){
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SignUpPage") as! SignUpPage
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    
    //HelpButton Action Click.
     @IBAction func HelpSupport(sender: AnyObject) {
    
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "HelpSupportViewController") as! HelpSupportViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
    
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    //forgotpass Action Click.
     @IBAction func forgotpass(sender: AnyObject)
     {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "VerifyPhoneNomViewController") as! VerifyPhoneNomViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
     }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //G+ Sharing Functionality
    /*func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
                withError error: NSError!) {
        if (error == nil) {
            // Perform any operations on signed in user here.
            
            // ...
        } else {
            print("\(error.localizedDescription)")
            
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            
            //userToken = UserDefaults.standard.string(forKey: "UserToken")
            var UserDefault = UserDefaults.standard
            UserDefault.setValue(idToken, forKey: "UserToken")
            
            // UserEmail.setValue(textfieldEmail.text, forKey: "RememberName")
            UserDefault.synchronize()//user_email
            
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "DashBrdViewController") as! DashBrdViewController
            self.navigationController?.pushViewController(newViewController, animated: true)
            
        }
    }*/
    
    
   /* func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
                withError error: NSError!) {
        if (error == nil) {
            // Perform any operations on signed in user here.
            // ...
        } else {
            println("\(error.localizedDescription)")
        }
    }*/

    @IBAction func googleSignIn(sender: UIButton) {
        //GIDSignIn.sharedInstance().uiDelegate = self as! GIDSignInUIDelegate
        GIDSignIn.sharedInstance().delegate=self
        GIDSignIn.sharedInstance().uiDelegate=self
        GIDSignIn.sharedInstance().signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user?.profile.email
            
            //userToken = UserDefaults.standard.string(forKey: "UserToken")
            var UserDefault = UserDefaults.standard
            UserDefault.setValue(idToken, forKey: "UserToken")
            
            // UserEmail.setValue(textfieldEmail.text, forKey: "RememberName")
            UserDefault.synchronize()//user_email  user_id
            
            // Redirect to home page.

            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "DashBrdViewController") as! DashBrdViewController
            self.navigationController?.pushViewController(newViewController, animated: true)
            
        }
        
        print("Successfully logged into Google", user)
    }
    
    
    
    func signIn(signIn: GIDSignIn!,
                presentViewController viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
        
        print("Sign in presented")
        
    }
    
    // Dismiss the "Sign in with Google" view
    func signIn(signIn: GIDSignIn!,
                dismissViewController viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
        
        print("Sign in dismissed")
    }
    
    func application(application: UIApplication,
                     openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return GIDSignIn.sharedInstance().handle(url as URL!,
                                                 sourceApplication: sourceApplication,
                                                 annotation: annotation)
    }
    
}

extension ViewController : SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    func rightWillOpen() {
        print("SlideMenuControllerDelegate: rightWillOpen")
    }
    
    func rightDidOpen() {
        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        print("SlideMenuControllerDelegate: rightWillClose")
    }
    
    func rightDidClose() {
        print("SlideMenuControllerDelegate: rightDidClose")
    }
}

