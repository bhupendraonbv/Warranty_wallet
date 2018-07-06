//
//  WTCheckStatusViewController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 17/11/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.
//

import UIKit


class WTCheckStatusViewController:UIViewController,UIScrollViewDelegate,TopviewDelegate,iCarouselDataSource,iCarouselDelegate{
   
    @IBOutlet weak var ScrllvwBG: UIScrollView!
    @IBOutlet weak var imgVW: UIImageView!
    @IBOutlet weak var btnslide: UIButton!
    @IBOutlet weak var btnLogService: UIButton!
    
    var topview:TopViewController!
    
    @IBOutlet weak var _imagePager: KIImagePager!
    var imgAarry:NSMutableArray!
    var bottomView = BottomViewViewController()
    @IBOutlet var carousel: iCarousel!
     var items: [Int] = []
    var titleArrayName = Array<String>()
    
    @IBOutlet weak var btnDot1 : UIButton!
    @IBOutlet weak var btnDot2 : UIButton!
    @IBOutlet weak var btnDot3 : UIButton!
    
    var gradientLayer: CAGradientLayer!
    
    @IBOutlet weak var graView : UIView!
    
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        let currentIndex: Int = carousel.currentItemIndex
        print("currentValue =\(currentIndex)")
    
        if currentIndex == 0
        {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "WTRaiseVWController") as! WTRaiseVWController
            self.navigationController?.pushViewController(newViewController, animated: true)
        
        }
        else if currentIndex == 1
        {
            //WtRenewTicketController
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "WtRenewTicketController") as! WtRenewTicketController
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        
        else if currentIndex == 2
        {
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "WTExtndWarntyViewController") as! WTExtndWarntyViewController
            self.navigationController?.pushViewController(newViewController, animated: true)
            
        }
        else{
            print("iCraousel")
        }
        
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 3
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        var label: UILabel
        var itemView: UIImageView
        
        //reuse view if available, otherwise create a new view
        if let view = view as? UIImageView {
            itemView = view
            //get a reference to the label in the recycled view
            label = itemView.viewWithTag(1) as! UILabel
        } else {
            //don't do anything specific to the index within
            //this `if ... else` statement because the view will be
            //recycled and used with other index values later
            itemView = UIImageView(frame: CGRect(x: 0, y: 0, width: 226, height: 269))
           let strUrl = titleArrayName[index]
            
            itemView.image = UIImage(named: strUrl)
            itemView.contentMode = .center
            
            label = UILabel(frame: itemView.bounds)
            label.backgroundColor = .clear
            label.textAlignment = .center
            label.font = label.font.withSize(50)
            label.tag = 1
            itemView.addSubview(label)
        }
       
        
        return itemView
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 1.1
        }
        
        let Activeimage = UIImage(named:"DotNewSelected")
        let Inactiveimage = UIImage(named:"DotNewIcon")
        
        // let titleArrayName = NSMutableArray(array: ["a", "b", "c"])
        
        let currentIndex: Int = carousel.currentItemIndex
        print("currentValue =\(currentIndex)")
        
        
        if currentIndex == 0
        {
            print ("Index --0")
            btnDot1.setImage(UIImage(named: "DotNewSelected")!, for: UIControlState.normal)
            btnDot2.setImage(UIImage(named: "DotNewIcon")!, for: UIControlState.normal)
            btnDot3.setImage(UIImage(named: "DotNewIcon")!, for: UIControlState.normal)
            
        }
        else if currentIndex == 1
        {
            print ("Index --1")
            btnDot1.setImage(UIImage(named: "DotNewIcon")!, for: UIControlState.normal)
            btnDot2.setImage(UIImage(named: "DotNewSelected")!, for: UIControlState.normal)
            btnDot3.setImage(UIImage(named: "DotNewIcon")!, for: UIControlState.normal)
            
        }
            
        else if currentIndex == 2
        {
            print ("Index --2")
            btnDot1.setImage(UIImage(named: "DotNewIcon")!, for: UIControlState.normal)
            btnDot2.setImage(UIImage(named: "DotNewIcon")!, for: UIControlState.normal)
            btnDot3.setImage(UIImage(named: "DotNewSelected")!, for: UIControlState.normal)
        }
        else
        {
            
        }
        
        
        return value
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBottomView()
        
       
        setGradientBackground()
        
        btnLogService.layer.cornerRadius = 22
        
        self.titleArrayName = ["RequestServiceCard","RenewAMCCardWarenty","ExtentWarrantyCard"]

        for i in 0 ... 99 {
            items.append(i)
        }
        
        //.coverFlow2
        carousel.type = .linear
        carousel.delegate = self as! iCarouselDelegate
        carousel.dataSource = self as! iCarouselDataSource
     
    }
    
    //Gradient BackView
    func setGradientBackground() {
        let colorTop =  UIColor(red: 19.0/255.0, green: 84.0/255.0, blue: 122.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 128.0/255.0, green: 209.0/255.0, blue: 199.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.graView.bounds
        
        self.graView.layer.addSublayer(gradientLayer)
        
    }
    
    ///DshBrdTpBg
    
    override func viewWillAppear(_ animated: Bool){
     addTopView()
    
    }
    
    func addTopView(){
        topview = TopViewController(title: "Request Service", menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        topview.delegate = nil
        
        topview.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 70)
        topview.topBGVW.backgroundColor = UIColor (colorLiteralRed: 47/255, green: 57/255, blue: 66/255, alpha: 1.0)
        topview.topBGVW.backgroundColor = UIColor.clear
        topview.leftBack.isHidden = false
        self.view.addSubview(topview.view)
        self.view.layoutIfNeeded()
    }

    @IBAction func clickExtendWarrenty(sender: AnyObject){ //WTExtndWarntyViewController
    
       // let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
       // let newViewController = storyBoard.instantiateViewController(withIdentifier: "WTExtndWarntyViewController") as! WTExtndWarntyViewController
       // self.navigationController?.pushViewController(newViewController, animated: true)
   
    }
    
    func addBottomView(){
        // bottomView = BottomViewViewController()
        self.bottomView.view.frame = CGRect(x: 0, y: WINDOW_HEIGHT-56 , width: WINDOW_WIDTH, height: 56)
       self.bottomView.btnServc.isUserInteractionEnabled = false
        self.bottomView.btnServc.isSelected = true
        self.view.addSubview(bottomView.view)
    }

    /*Veryfy OTP Method*/
    @IBAction func clickRequestStatus(sender: AnyObject)
    {
        /*let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "WTRequestStatusViewController") as! WTRequestStatusViewController
        self.navigationController?.pushViewController(newViewController, animated: true)*/
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "StatusViewController") as! StatusViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
    
    }
    
    @IBAction func clickServiceLog(sender: AnyObject)
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "WTServiceLogViewController") as! WTServiceLogViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
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
