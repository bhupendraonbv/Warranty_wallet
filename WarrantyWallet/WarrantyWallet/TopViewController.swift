//
//  TopViewController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 16/10/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.
//

import UIKit

enum TopLeftBtnType : Int {
    case menuBtn
    case backBtn
}

@objc protocol TopviewDelegate{
    
}
class TopViewController: SliderBaseViewViewController {

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnMenu : UIButton!
    @IBOutlet weak var btnNotifiy : UIButton!
    var screen_Title: String?
    var parentController: UIViewController!
    weak var delegate:TopviewDelegate?
    var leftBtnType: TopLeftBtnType!
    @IBOutlet weak var topBGVW : UIView!
    @IBOutlet weak var leftBack : UIButton!
    
    @IBOutlet weak var btnBGMAinBack : UIButton!
    
    
    
    
    @IBAction func backclick(sender: AnyObject)
    {
       
       
        if self.presentingViewController != nil {
            self.dismiss(animated: false, completion: {
                self.navigationController!.popToRootViewController(animated: true)
            })
        }
        else {
            //AppDelegateInstance.rootNavigationController.popToRootViewController(animated: true) Temp Comment Test
            //self.navigationController?.popViewController(animated: true)
            AppDelegateInstance.rootNavigationController.popViewController(animated: true)
        
        }
    
    }

    //Back button Perform work fine
    @IBAction func backHidneMAin(sender: AnyObject)
    {
        
        if self.presentingViewController != nil {
            self.dismiss(animated: false, completion: {
                self.navigationController!.popToRootViewController(animated: true)
            })
        }
        else {
            //AppDelegateInstance.rootNavigationController.popToRootViewController(animated: true) Temp Comment Test
            //self.navigationController?.popViewController(animated: true)
            AppDelegateInstance.rootNavigationController.popViewController(animated: true)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
     lblTitle.text = screen_Title
    
    }
    
    
    init(title:String,menuBtnType:TopLeftBtnType , controller:UIViewController, isFilterBtnShow:Bool, channelPage:Bool){
        screen_Title = title
        parentController = controller
        leftBtnType = menuBtnType
        
        super.init(nibName: "TopViewController", bundle: nil)
    }
    
    //MARK:- IBActions
    @IBAction func clickToLeft(_ sender: AnyObject) {
        if(leftBtnType==TopLeftBtnType.menuBtn){
            AppDelegateInstance.drawerController.toggle(MMDrawerSide.left, animated:true, completion:nil)
            print("Menu btn Clicked")
        }
        else{
            
            _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(TopViewController.dismissView), userInfo: nil, repeats: false)
            parentController.navigationController?.popViewController(animated: true)
        
        }
        
        UIView.animate(withDuration: 0.6,
                       animations: {
                        self.btnMenu.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.6) {
                            self.btnMenu.transform = CGAffineTransform.identity
                        }
        })
        
}

    @IBAction func clickToNotify(_ sender: AnyObject)
    {
       let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "WTNotificationViewController") as! WTNotificationViewController
       // self.navigationController?.pushViewController(newViewController, animated: true)
        AppDelegateInstance.rootNavigationController.pushViewController(newViewController, animated: true)

        
        //UIApplication.shared.openURL(NSURL(string: "tel://9643296520")! as URL)

    }
    
    func dismissView() {
    
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
