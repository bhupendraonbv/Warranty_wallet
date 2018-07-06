//
//  WalkThroughViewController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 24/05/18.
//  Copyright © 2018 ONBV-BHUPI. All rights reserved.
//

import UIKit

class WalkThroughViewController: UIViewController,iCarouselDataSource,iCarouselDelegate {

    
    var bottomView = BottomViewViewController()
    @IBOutlet var carousel: iCarousel!
    var imgAarry:NSMutableArray!
    var titleArrayName = Array<String>()
    var items: [Int] = []
    var rootNavigationController: navViewController!

    
    
    @IBOutlet weak var btnDot1 : UIButton!
    @IBOutlet weak var btnDot2 : UIButton!
    @IBOutlet weak var btnDot3 : UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleArrayName = ["card_1","card_2","card_3"]
        
        for i in 0 ... 99 {
            items.append(i)
        }
        
        //.coverFlow2
        carousel.type = .linear
        carousel.delegate = self as! iCarouselDelegate
        carousel.dataSource = self as! iCarouselDataSource

        // Do any additional setup after loading the view.
    
        UIApplication.shared.statusBarStyle = .default
    
    }

    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        let currentIndex: Int = carousel.currentItemIndex
        print("currentValue =\(currentIndex)")
        
        if currentIndex == 0
        {
           
        }
        else if currentIndex == 1
        {
            //WtRenewTicketController
            
        }
            
        else if currentIndex == 2
        {
            
           
            
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
            return value * 1.3
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

    
    
    @IBAction func skipBtnAction(sender: AnyObject) {
        
        /*let homeScreenViewController = MAIN_STORYBOARD.instantiateViewController(withIdentifier: "ViewController")
        rootNavigationController = navViewController(rootViewController: homeScreenViewController)
        rootNavigationController.isNavigationBarHidden = true
        self.window?.rootViewController = rootNavigationController*/
    
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
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
