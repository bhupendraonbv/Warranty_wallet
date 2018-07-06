//
//  LocationTagViewController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 25/10/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.
//

import UIKit

class LocationTagViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,TopviewDelegate {

    @IBOutlet weak var txtlocation : UITextField!
    @IBOutlet weak var txtCstmlocation : UITextField!
    @IBOutlet weak var txtNameTag : UITextField!
    var bottomView:BottomViewViewController!
    var maivc = UIViewController()
    var active_txtField = UITextField()
    var TempStr = String()
    
    var list = NSMutableArray()
    @IBOutlet weak var vwCSTMLocationHdn : UIView!
    var topview:TopViewController!
    
    
    @IBOutlet weak var locationTag: UIPickerView!
    
    @IBOutlet weak var vwApplincePrdct: UIView!
    @IBOutlet weak var vwlocatnTag: UIView!
    @IBOutlet weak var  VWTag: UIView!
    
    
    //Picker All Components.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return list.object(at: row) as! String
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
       return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //print("selected item is",current_arr[row])
        
        var temp = list.object(at: row) as! String
        
        if temp == "Custom"
        {
             vwCSTMLocationHdn.isHidden = false
        }
        else {
             vwCSTMLocationHdn.isHidden = true
        }
        
        txtlocation.text = list[row] as! String
        locationTag.reloadAllComponents();
    
    }

    
    /*Touch Method*/
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        // RegstrPickVW.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //list = ["Hall" , "Room" , "Compnay" , "Kitchen", "Custom"] comment code change
        
        vwApplincePrdct.layer.cornerRadius = 10
        vwlocatnTag.layer.cornerRadius = 10
        vwCSTMLocationHdn.layer.cornerRadius = 10
        
        list = ["Home" , "Office"]

        vwCSTMLocationHdn.isHidden = true
       // txtlocation.delegate = self
        locationTag.isHidden = false
        
        txtlocation.delegate = self
        
        locationTag.delegate = self
        locationTag.dataSource = self
        txtlocation.inputView = locationTag
        
        maivc.view .addSubview(locationTag)

        addTopView()
        addBottomView()
        // Do any additional setup after loading the view.
    }
    
    //Top View
    func addTopView(){
        topview = TopViewController(title: "Register Product", menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        topview.delegate = nil
        topview.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 75)
        //topview.topBGVW.backgroundColor = UIColor (colorLiteralRed: 47/255, green: 57/255, blue: 66/255, alpha: 1.0)
        //topview.leftBack.isHidden = true
        
        self.view.addSubview(topview.view)
        self.view.layoutIfNeeded()
    }
    
    //Bottom View
    func addBottomView(){
        bottomView = BottomViewViewController()
        self.bottomView.view.frame = CGRect(x: 0, y: WINDOW_HEIGHT-56 , width: WINDOW_WIDTH, height: 56)
        self.view.addSubview(bottomView.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func clickBackVW(sender: AnyObject)
    {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    //Select Invoice VW
    @IBAction func clickInvoiceVW(sender: AnyObject)
    {
        
        if (txtlocation.text?.isEmpty)! || (txtNameTag.text?.isEmpty)!
        {
            displayAlertMessagae(userMessage: "Please fill all the details.")
        }else{
            let defaults = UserDefaults.standard
            defaults.set(txtlocation.text, forKey: "txtlocation")
            defaults.set(txtCstmlocation.text, forKey: "txtcustomLocation")
            defaults.set(txtNameTag.text, forKey: "txtNameTAg")
            defaults.synchronize()
            
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "InvoiceViewController") as! InvoiceViewController
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        
    
    }
    
    /*Generic Alert Method*/
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
