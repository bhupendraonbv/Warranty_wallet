//
//  DashBrdViewController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 03/11/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.
//

import UIKit

class DashBrdViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,TopviewDelegate {

    @IBOutlet weak var tblList = UITableView()
     @IBOutlet weak var ExtndWrrntTbl = UITableView()
    @IBOutlet weak var wrntyPopVw = UIView()
    
    @IBOutlet weak var lblrgstdDev = UILabel()
    @IBOutlet weak var lblrgstdInvc = UILabel()
    @IBOutlet weak var lblrgstdAMC = UILabel()
    
    @IBOutlet weak var btnTApExpiring = UIButton()
    
    @IBOutlet weak var vwPrdctdwn = UIView()
    @IBOutlet weak var vwWrntAdd = UIView()
    
    @IBOutlet weak var  vwBGGradient = UIView()
    
    
    var bottomView = BottomViewViewController()
    var user_id = String()
    var UserToken = String()
    var userDefault = UserDefaults.standard
    var dict = String()
    
    var lblEXPIRING = UILabel()
    
    var allExpiryListDict  = NSDictionary()
    
    var lblExpSn = UILabel()
    var arrExpirylst = NSMutableArray()
  // var arrExpirylst = [String]()
    
    var topview:TopViewController!
    
    var arrDefaultTagNme = NSMutableArray()
    
    var roundView = UIView()
    
     var allDictValue = NSDictionary()
    
     var arrTagName = NSMutableArray()
     var arrModelNum = NSMutableArray()
     var arrMnufactuer = NSMutableArray()
    var arrdatePurchased = NSMutableArray()
    var arrExpiryApplincID = NSMutableArray()
    
    /**/
    var arrJass = NSMutableArray()
    var mainArr = NSDictionary()
    var strExpiry = String()
    
    //Expirety Object..Declare
    var allDictExpiryList = NSDictionary()
    var arrExpiryListTagName = NSMutableArray()
    var arrExpiryListexpDate = NSMutableArray()


    var arrExpiryListParchsDate = NSMutableArray()
    var arrExpiryListmanufctr = NSMutableArray()
    var arrExpiryListmodlNm = NSMutableArray()
    
    var strExpiryExtendTag = String()
    var strExpiryApplncID = String()
    var strUserNameDashboard = String()
    
    var CommonstrMsg = String()
    var lblWarrany = UILabel()
    var strPassExpirtAplnc_ID = String()
    var dateStr = String()
    var arrCompareStrDate = [String]()

    
    @IBOutlet weak var lblVerificatnPndg = UILabel()
    
    @IBOutlet weak var  thmbUPVW = UIView()
    @IBOutlet weak var  VWCircleHaly = UIView()
    @IBOutlet weak var  VWHIBuddy = UIView()
    @IBOutlet weak var  btnAddPrdct = UIButton()
    
     @IBOutlet weak var lblPSST = UILabel()
    
    @IBOutlet weak var lblRecetAdded = UILabel()
    
    @IBOutlet weak var  VWVerifcnPanding = UIView()
    
    @IBOutlet weak var lblRecetActivity = UILabel()
    
    
    /*Generic Alert view functionality */
    func displayAlertMessagae(userMessage:String)
    {
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    
    func addTopView(){
        
        print("Top User Name",strUserNameDashboard)
        topview = TopViewController(title: strUserNameDashboard, menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        topview.delegate = nil
        topview.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 70)
        topview.btnMenu.isHidden = false
        topview.topBGVW.backgroundColor = UIColor .clear
        self.view.addSubview(topview.view)
        self.view.layoutIfNeeded()
    }
    
    @IBAction func clickToNotifyVW(_ sender: AnyObject)
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "WTNotificationViewController") as! WTNotificationViewController
       // self.navigationController?.pushViewController(newViewController, animated: true)
        self.present(newViewController, animated: true, completion: nil)
        // AppDelegateInstance.rootNavigationController.pushViewController(newViewController, animated: true)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        vwPrdctdwn?.layer.cornerRadius = 8.0
        vwWrntAdd?.layer.cornerRadius = 8.0
        
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd.MM.yyyy"
        
        let dateStr = formatter.string(from: date)
        
        print(dateStr)
        
        tblList?.backgroundColor = UIColor.clear
        tblList?.isHidden = true
        
         // round view
        // Do any additional setup after loading the view.
     self.tblList?.register(UINib(nibName: "DashboardCustomCell", bundle: nil), forCellReuseIdentifier: "DashboardCustomCell")
        
        
     self.ExtndWrrntTbl?.register(UINib(nibName: "ExtndWarrntCell", bundle: nil), forCellReuseIdentifier: "ExtndWarrntCell")
    
        print(strUserNameDashboard)
        
        if userDefault.string(forKey: "FullNameDashBoard")! == nil {
        print("dhw")
        }
        
        else {
            strUserNameDashboard = userDefault.string(forKey: "FullNameDashBoard")!
            print("savename",strUserNameDashboard)
        }
        
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        
        switch height {
        case 480.0:
            print("iPhone 3,4")
            
            
        case 568.0:
            print("iPhone 5")
            roundView = UIView(frame:CGRect(x: 85, y: 85, width: 150, height: 150))
            lblExpSn = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
            lblWarrany = UILabel(frame: CGRect(x: 33 , y: lblExpSn.frame.minY + lblExpSn.frame.size.height + 68, width: 85, height: 18))
            lblEXPIRING = UILabel(frame: CGRect(x: 33, y: lblExpSn.frame.minY + lblExpSn.frame.size.height + 60 + 25, width: 85, height: 18))
            
        case 667.0:
            print("iPhone 6")
            
            roundView = UIView(frame:CGRect(x: (self.view.frame.size.width/2)-90, y: 120, width: 183, height: 155))
            
            lblExpSn = UILabel(frame: CGRect(x: 0, y: 0, width: 34, height: 50))
            lblWarrany = UILabel(frame: CGRect(x: 33 , y: lblExpSn.frame.minY + lblExpSn.frame.size.height + 68, width: 85, height: 18))
            lblEXPIRING = UILabel(frame: CGRect(x: 26, y: lblExpSn.frame.minY + lblExpSn.frame.size.height + 60 + 25 , width: 100
                , height: 18))
            
        case 736.0:
            print("iPhone 6+")
        case 812:
            print("iPhone X")
            
            roundView = UIView(frame:CGRect(x: (self.view.frame.size.width/2)-75, y: 120 , width: 150, height: 150))
            lblExpSn = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
            lblWarrany = UILabel(frame: CGRect(x: 33 , y: lblExpSn.frame.minY + lblExpSn.frame.size.height + 68, width: 85, height: 18))
            lblEXPIRING = UILabel(frame: CGRect(x: 26, y: lblExpSn.frame.minY + lblExpSn.frame.size.height + 60 + 25 , width: 100
                , height: 18))
            
            
        default:
            print("not an iPhone")
            
        }
        
        // roundView.backgroundColor = UIColor.clear
        roundView.layer.cornerRadius = roundView.frame.size.width / 2
        roundView.isUserInteractionEnabled = true
        
        // bezier path
        let circlePath = UIBezierPath(arcCenter: CGPoint (x: roundView.frame.size.width / 2, y: roundView.frame.size.height / 2),
                                      radius: roundView.frame.size.width / 2,
                                      startAngle: CGFloat(0.7 * M_PI),
                                      endAngle: CGFloat(2.7 * M_PI),
                                      clockwise: true)
        // circle shape
        let circleShape = CAShapeLayer()
        circleShape.path = circlePath.cgPath
        //circleShape.strokeColor = UIColor.cyan.cgColor
        circleShape.strokeColor = UIColor (colorLiteralRed: 36/255, green: 103/255, blue: 134/255, alpha: 1.0).cgColor
        circleShape.fillColor = UIColor.clear.cgColor
        circleShape.lineWidth = 6.5
        // set start and end values
        circleShape.strokeStart = 0.0
        circleShape.strokeEnd = 0.8
        
        // add sublayer
        roundView.layer.addSublayer(circleShape)
        // add subview
        
        
        lblExpSn.center = CGPoint(x: roundView.frame.size.width/2, y: roundView.frame.size.height/2)
        lblExpSn.textAlignment = .center
        lblExpSn.text = "0"
        lblExpSn.backgroundColor = UIColor.clear
        lblExpSn.textColor = UIColor(red: 37/255, green: 105/255, blue: 135/255, alpha: 1.0)
        lblExpSn.font = UIFont(name: "TitilliumWeb-Thin", size: 60)
        roundView.addSubview(lblExpSn)
        
        lblWarrany.textAlignment = .center
        //lblWarrany.text = "WARRANTIES"
        lblWarrany.textColor = UIColor.gray
        lblWarrany.backgroundColor = UIColor.clear
        lblWarrany.font = lblEXPIRING.font.withSize(10)
        roundView.addSubview(lblWarrany)
    
        
        self.roundView.isHidden = true
        self.VWCircleHaly?.isHidden = true
        self.lblExpSn.isHidden = true
        
        self.view.addSubview(roundView)
        
        lblEXPIRING.textAlignment = .center
        //lblEXPIRING.text = "EXPIRING SOON"
        lblEXPIRING.backgroundColor = UIColor.clear
        lblEXPIRING.textColor = UIColor.white
        lblEXPIRING.font = lblEXPIRING.font.withSize(10)
        roundView.addSubview(lblEXPIRING)
        self.view.addSubview(roundView)
        
        addTopView()
        setGradientBackground()
        addBottomView()
        
        self.view .addSubview(btnTApExpiring!)

}
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 19.0/255.0, green: 84.0/255.0, blue: 122.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 128.0/255.0, green: 209.0/255.0, blue: 199.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = (self.vwBGGradient?.bounds)!
        
        self.vwBGGradient?.layer.addSublayer(gradientLayer)
        
    }
    
    
    @IBAction func clickToVerifyPendingPrdct(_ sender: AnyObject)
    {
        //WTVerifcnPandingVWViewController
        print ("EXPIRING VIEW")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "WTVerifcnPandingVWViewController") as! WTVerifcnPandingVWViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @IBAction func clicktoExpiringLIstVW(sender: AnyObject)
    {
        print ("EXPIRING VIEW")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ExpiringVWController") as! ExpiringVWController
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool){
        self.VWCircleHaly?.isHidden = true
        self.lblExpSn.isHidden = true
        self.roundView.isHidden = true
        
        topview.leftBack.isHidden = true
        
        DispatchQueue.main.async {
            self.dopostDashboardApi()
        }
    
    }
    
    func addBottomView(){
       // bottomView = BottomViewViewController()
        
        self.bottomView.view.frame = CGRect(x: 0, y: WINDOW_HEIGHT-56 , width: WINDOW_WIDTH, height: 56)
        self.bottomView.btnDash .isUserInteractionEnabled = false
        self.bottomView.btnDash.isSelected = true
        self.view.addSubview(bottomView.view)
    
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrExpirylst.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        if tableView == tblList
        {
          return 67
        }
        
        else {
            return 64
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        if tableView == tblList
        {
            let identifier: String = "DashboardCustomCell"
            var customCell : DashboardCustomCell!
            customCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! DashboardCustomCell
            
            customCell.selectionStyle = .none
       
            print(arrExpirylst.count)
            
            print(arrTagName)
            print(arrMnufactuer)
            print(arrdatePurchased)
            print(arrExpiryListexpDate)
            print(arrModelNum)
            
           // dates = arrExpiryListexpDate.object(at: indexPath.row) as! [String]
           // dates.append(arrExpiryListexpDate.object(at: indexPath.row) as! String)
           // print("AllDateStringExpire",dates)
            
           
            for dates in 0..<arrExpiryListexpDate.count
            {
                arrCompareStrDate.append(arrExpiryListexpDate[dates] as! String)
            }
            
            print("FinalStrExpDAte",arrCompareStrDate)

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            
            var greaterThanToday = arrCompareStrDate.filter({ dateFormatter.date(from: $0)! > Date() })
            print("FilterDateGreater",greaterThanToday) // ["23-09-2017"]
            
//            for dateTemp in arrCompareStrDate{
//                let dateObject = dateFormatter.date(from: dateTemp)
//
//            }
            
         //   let dateFormatter = NSDateFormatter()
        //  dateFormatter.dateFormat = "MM/dd/yyyy"
        // let someDate = dateFormatter.dateFromString("03/10/2015")
            
            //Get calendar
            let someDate = dateFormatter.date(from: "03/10/2015")

            let calendar = Calendar.current

            //Get just MM/dd/yyyy from current date
            let flags = Set<Calendar.Component>([.hour, .year, .minute])
            let components = calendar.dateComponents(flags, from: NSDate() as Date)
            let today = calendar.date(from: components)

            //Convert to NSDate
            if (someDate?.timeIntervalSince(today!).isSignalingNaN)! {
                //someDate is berofe than today
                print ("datejkhgjk")

            } else {
                //someDate is equal or after than today
               print ("date")
            }
            
            

            
            customCell.lblHdeExpirng?.text = arrExpiryListTagName.object(at: indexPath.row) as? String
            customCell.lblperchDt?.text = arrExpiryListexpDate.object(at: indexPath.row) as? String
            customCell.lblExpDT?.text = arrExpiryListParchsDate.object(at: indexPath.row) as? String
            customCell.lblGroupFamily?.text = arrExpiryListmodlNm.object(at: indexPath.row) as? String
            customCell.lblGroup?.text = arrExpiryListmanufctr.object(at: indexPath.row) as? String
            
            
            //Temp Comment//
            customCell.btnExpndWrnt?.tag = indexPath.row
            customCell.btnExpndWrnt?.addTarget(self, action: #selector(DashBrdViewController.PopViewWarrenty), for: .touchUpInside)
            return customCell
            
        }
        
        else{
        
            let identifier: String = "ExtndWarrntCell"
            var ExtendCustomCell : ExtndWarrntCell!
            ExtendCustomCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ExtndWarrntCell
            
            ExtendCustomCell.selectionStyle = .none
            return ExtendCustomCell
        }
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
       
        
         if tableView == tblList
         {
            strPassExpirtAplnc_ID = arrExpiryApplincID.object(at: indexPath.row) as! String
            print(strPassExpirtAplnc_ID)
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ApplianceEditDetailsViewController") as! ApplianceEditDetailsViewController
            newViewController.strRecvAplnc_ID = strPassExpirtAplnc_ID
            self.navigationController?.pushViewController(newViewController, animated: true)
         }
    
    }
    
    func PopViewWarrenty(sender : UIButton)
    {
        let btnTag = sender.tag
        print(btnTag)
        
        strExpiryExtendTag = arrExpiryListTagName.object(at: btnTag) as! String
        strExpiryApplncID = arrExpiryApplincID.object(at: btnTag) as! String
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "WTExtndWarntyViewController") as! WTExtndWarntyViewController
        
        newViewController.strExtnd_ApplncID = strExpiryApplncID
        newViewController.strRecvApplncNAmeTAgforExtend = strExpiryExtendTag
        
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    
    /*Touch Method*/
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        wrntyPopVw?.isHidden = true
        
    }

     @IBAction func clicktoRegisterDevice(sender: AnyObject)
     {
        //Taday comment ..
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AppliancesViewController") as! AppliancesViewController
        //AppliancesViewController.createHomeViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
        //AppDelegateInstance.rootNavigationController.pushViewController(newViewController, animated: true)
    
        /*let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "WtApplianceCategListViewController") as! WtApplianceCategListViewController
       // AppDelegateInstance.rootNavigationController.pushViewController(newViewController, animated: true)
      self.navigationController?.pushViewController(newViewController, animated: true)*/
    
    }
    
    //AMC NOW
    @IBAction func clicktoRegisterInvoice(sender: AnyObject)
    {
        /*let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let newViewController = storyBoard.instantiateViewController(withIdentifier: "RegisteredInvoicesViewController") as! RegisteredInvoicesViewController
        self.navigationController?.pushViewController(newViewController, animated: true)*/
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "WTRegisteredAMCViewController") as! WTRegisteredAMCViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    
    //EXOIRING NOW
    @IBAction func clicktoRegisteredAMC(sender: AnyObject)
    {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "WtExpiredListController") as! WtExpiredListController
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    
    //DashBoard Api Code Here...
    func dopostDashboardApi()
    {
        user_id = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_DASHBOARD_LIST_API)! as URL)  //POST_DASHBOARD_LIST_API
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
                    print("status",self.dict)
                    
                    if (self.dict == "1")
                    {
                        self.mainArr = (dictFromJSON["data"] as? NSDictionary)!
                        print("Data",self.mainArr)
                        
                        let isAggre = self.mainArr.value(forKey: "isAgree") as! String
                        print(isAggre)
                        
                        if isAggre == "0"
                        {
                            DispatchQueue.main.async {
                                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                let newViewController = storyBoard.instantiateViewController(withIdentifier: "TermsPolicyViewController") as! TermsPolicyViewController
                                self.navigationController?.pushViewController(newViewController, animated: true)
                                return
                            }
                      
                        }
                        else{
                            print("1")
                            
                        }
                        
                        let totl_Exp = self.mainArr.value(forKey: "total_expiry") as! String
                        print(totl_Exp)
                        
                       
                        let totl_ExpIred = self.mainArr.value(forKey: "total_expired")
                        print(totl_ExpIred ?? 11)
                        
                        
                        let totl_Registrd = self.mainArr.value(forKey: "total_registered") as! String
                        print(totl_Registrd)
                        
                        let totl_Invoice = self.mainArr.value(forKey: "total_invoice") as! String
                        print(totl_Invoice)

                        let total_appliance = self.mainArr.value(forKey: "total_amc") as! String
                        print(total_appliance)
                        
                        let VerificationPending = self.mainArr.value(forKey: "verification_pending") as! String
                        print(VerificationPending)
                        
                        let RecentActivity = self.mainArr.value(forKey: "recent_activity") as! String
                        print(RecentActivity)
                        
                         DispatchQueue.main.async {
                            self.lblrgstdDev?.text = totl_Registrd
                           // self.lblrgstdInvc?.text = totl_Invoice    // This Field Is AMC Now
                            
                            self.lblrgstdInvc?.text = total_appliance   // again chnage
                            
                          //self.lblrgstdAMC?.text = total_appliance as? String // This Field Is Expired Now
                            self.lblrgstdAMC?.text = totl_ExpIred as? String // again chnage
                            
                            self.lblVerificatnPndg?.text = VerificationPending as? String
                            self.lblRecetAdded?.text = RecentActivity as? String
                            
                            self.lblExpSn.text! = ""
                            self.lblExpSn.text = totl_Exp
                            
                            if self.self.lblExpSn.text == "0"
                            {
                                DispatchQueue.main.async {
                                print("fvhwfqwf")
                                self.VWCircleHaly?.isHidden = true
                                self.lblExpSn.isHidden = true
                                self.self.thmbUPVW?.isHidden = false
                                self.roundView.isHidden = true
                                self.btnTApExpiring?.isUserInteractionEnabled = false
                                }
                            }else
                            {
                                print("dfgwf")
                                self.VWCircleHaly?.isHidden = false
                                self.self.lblExpSn.isHidden = false
                                self.thmbUPVW?.isHidden = true
                                self.roundView.isHidden = false
                                self.btnTApExpiring?.isUserInteractionEnabled = true
                                
                            }
                            
                            //Animation
                            UIView.animate(withDuration: 0.6,
                                           animations: {
                                            self.lblrgstdDev!.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                                            self.lblrgstdInvc!.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                                            self.lblrgstdAMC!.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                                            self.lblExpSn.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                                            
                            },
                                           completion: { _ in
                                            UIView.animate(withDuration: 0.6) {
                                                self.lblrgstdDev?.transform = CGAffineTransform.identity
                                                self.lblrgstdInvc?.transform = CGAffineTransform.identity
                                                self.lblrgstdAMC?.transform = CGAffineTransform.identity
                                                self.lblExpSn.transform = CGAffineTransform.identity

                                                
                                            }
                            })
                            
                            
                        }
                        
                        
                        ///Here method for Expiry list show....
                        let _tempArr = self.mainArr.value(forKey: "expiry_list") as! NSMutableArray
                        
                        if(_tempArr.count > 0) {
                            self.arrExpirylst = self.mainArr.value(forKey: "expiry_list") as! NSMutableArray
                            print("arr",self.arrExpirylst)
                            
                            //Arr fatch
                            for switchint in 0..<self.arrExpirylst.count {
                                
                                self.allDictExpiryList = self.arrExpirylst[switchint] as! NSDictionary
                                print(self.allDictExpiryList)
                                
                                self.arrExpiryListTagName.addObjects(from: [self.allDictExpiryList.value(forKey: "appliance_name_tag")!])
                                print(self.arrExpiryListTagName)
                               
                                self.arrExpiryListexpDate.addObjects(from: [self.allDictExpiryList.value(forKey: "expiry_date")!])
                                print(self.arrExpiryListexpDate)
                                
                                self.arrExpiryListParchsDate.addObjects(from: [self.allDictExpiryList.value(forKey: "date_of_parched")!])
                                print(self.arrExpiryListParchsDate)
                               
                                self.arrExpiryListmanufctr.addObjects(from: [self.allDictExpiryList.value(forKey: "appliance_manufacturer")!])
                                self.arrExpiryListmodlNm.addObjects(from: [self.allDictExpiryList.value(forKey: "appliance_model_no")!])
                                self.arrExpiryApplincID.addObjects(from:[self.allDictExpiryList.value(forKey: "appliance_id")!])
                                
                                
                                let defaults = UserDefaults.standard
                                                                   defaults.set(self.arrExpiryListTagName, forKey: "SavedStringArray")
                                                                    defaults.synchronize()
                            }
                            
                            DispatchQueue.main.async {
                               // self.tblList?.isHidden = false
                                self.tblList?.emptyTblDashBrdCellsEnabled = false
                                self.tblList?.dataSource = self
                                self.tblList?.delegate = self
                                self.tblList?.reloadData()
                            }
                        }
                        
                        
                        self.POST_Hit_FCM_token_API()
                        
                    }else
                    {
                        print (" status 0")
                        self.CommonstrMsg = (dictFromJSON["msg"] as? String)!
                        
                        if self.CommonstrMsg == "Oops! Your session expired, you might have logged in other device. Pls login again"
                        {
                            let alertController = UIAlertController(title: "", message: self.CommonstrMsg, preferredStyle: .alert)
                            
                            // Create the actions
                            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                                UIAlertAction in
                                NSLog("OK Pressed")
                                
                                
                                /*let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                let newViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                                self.navigationController?.pushViewController(newViewController, animated: true)*/
                            
                                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                let newViewController = storyBoard.instantiateViewController(withIdentifier: "WarrantyOrganizerViewController") as! WarrantyOrganizerViewController
                                self.navigationController?.pushViewController(newViewController, animated: true)
                            
                            }
                            
                            // Add the actions
                            alertController.addAction(okAction)
                            // Present the controller
                            self.present(alertController, animated: true, completion: nil)
                        }
                        else {
                             DispatchQueue.main.async {
                             self.VWHIBuddy?.isHidden = false
                             self.btnAddPrdct?.isHidden = false
                              self.lblPSST?.isHidden = false
                             self.vwWrntAdd?.isHidden = true
                             self.vwPrdctdwn?.isHidden = true
                             self.VWVerifcnPanding?.isHidden = true
                             self.lblRecetActivity?.isHidden = true
                            }
                        }

                    }
                    
                }
                
            }catch
            {
                print("error")
                self.displayAlertMessagae(userMessage: "Error!")
            }
            
        }
        
        task.resume()
        
    }
    
    //FCM_Api Declare Here..
    func POST_Hit_FCM_token_API(){
        
        user_id = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_FCM_token_API)! as URL)
        request.httpMethod = "POST"
        request.setValue(ServerAuthorization, forHTTPHeaderField: "authorization_token")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "access_token")
        
        let postString = "userId=\(String(describing: user_id))&tokenId=\(String(describing: UserToken))&device_type=\(String(describing: "iOS"))&fcm_token=\(String(describing: "dfsdljfgdljfgsdlff"))"
        print("Userid&usertoken--->",postString)
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest){data, response, error in
            guard error == nil && data != nil else{
                print("error")
                DispatchQueue.main.async(execute: {() -> Void in                                                                           MBProgressHUD.hide(for: self.view!, animated: true)
                })
                self.displayAlertMessagae(userMessage: "No Internet connection.")
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
                    
                    if (self.dict == "1")
                    {
                        print("sucess")
                    }
                    else {
                        
                    }
                    
                }
                
            }catch
            {
                print("error")
                
            }
            
        }
        
        task.resume()
    }
    
    
    
    
    
    //EXOIRING NOW
    @IBAction func clicktoADDProductfirstTime(sender: AnyObject)
    {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterDeviceViewController") as! RegisterDeviceViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    
    //EXOIRING NOW
    @IBAction func clicktoNotificationTime(sender: AnyObject)
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "WTNotificationViewController") as! WTNotificationViewController
        // self.navigationController?.pushViewController(newViewController, animated: true)
        AppDelegateInstance.rootNavigationController.pushViewController(newViewController, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: LEFT MENU NAVIGATION CLASS
    class func createHomeViewController() {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let leftCntrl = storyBoard.instantiateViewController(withIdentifier: "WTMenuViewController") as! WTMenuViewController
        let rightCntrl = storyBoard.instantiateViewController(withIdentifier: "WTMenuViewController") as! WTMenuViewController
        let centerCntrl = storyBoard.instantiateViewController(withIdentifier: "DashBrdViewController")  as! DashBrdViewController
        AppDelegateInstance.drawerController.showsShadow = false
        AppDelegateInstance.drawerController.centerHiddenInteractionMode = .none
        AppDelegateInstance.drawerController.leftDrawerViewController = leftCntrl
        AppDelegateInstance.drawerController.centerViewController = centerCntrl
        AppDelegateInstance.drawerController.rightDrawerViewController = rightCntrl
        AppDelegateInstance.drawerController.closeDrawerGestureModeMask = .all
        let layer = UIView(frame: CGRect(x: 0, y: 0, width: WINDOW_WIDTH, height: WINDOW_HEIGHT))
        layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.35)
        layer.tag = -1
        
        AppDelegateInstance.drawerController.setDrawerVisualStateBlock { (controller: MMDrawerController!, drawerSide: MMDrawerSide, percentOpen: CGFloat) -> Void in
            if !controller.centerViewController.view.subviews.contains(layer) {
                controller.centerViewController.view.addSubview(layer)
            }
            if percentOpen == 0.0 {
                layer.removeFromSuperview()
            }
        }
        
        AppDelegateInstance.drawerController.setMaximumLeftDrawerWidth(320, animated: true, completion: nil)
        AppDelegateInstance.rootNavigationController.setViewControllers([AppDelegateInstance.drawerController], animated: true)
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
    
    var emptyTblDashBrdCellsEnabled: Bool {
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

extension UILabel {
    
    func startBlink() {
        UIView.animate(withDuration: 0.8,
                       delay:0.0,
                       options:[.allowUserInteraction, .curveEaseInOut, .autoreverse, .repeat],
                       animations: { self.alpha = 0 },
                       completion: nil)
    }
    
    func stopBlink() {
        layer.removeAllAnimations()
        alpha = 1
    }
}

class CustomDateFormatter {
    
    // MARK: - Properties
    private static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter
    }
    
    // MARK: - Public
    static func date(from string: String) -> Date? {
        return dateFormatter.date(from: string)
    }
    
    static func campare(_ string: String, with date: Date = Date()) -> Bool {
        guard let newDate = dateFormatter.date(from: string) else {
            return false
        }
        return newDate > date
    }
}
