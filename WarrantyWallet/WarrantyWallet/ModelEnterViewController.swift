//
//  ModelEnterViewController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 25/10/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.
//

import UIKit

class ModelEnterViewController: UIViewController,UIPickerViewDelegate,TopviewDelegate {

    @IBOutlet weak var datePicker  = UIDatePicker()
    @IBOutlet weak var txtDatefld : UITextField!
    @IBOutlet weak var txtModlNo : UITextField!
    @IBOutlet weak var txtSerialNo : UITextField!
     var topview:TopViewController!
    
     @IBOutlet weak var vwModelNM : UIView!
     @IBOutlet weak var vwSerialNM : UIView!
    @IBOutlet weak var  vwDate : UIView!
    
    var maivc = UIViewController()
    var bottomView:BottomViewViewController!
    
    //Dateicker Code here
    func createDatePicker(){
        
      let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let dnebtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ModelEnterViewController.doneClick))
        toolBar.setItems([dnebtn], animated: false)
        
        toolBar.frame = CGRect(x: 0, y: 105, width: view.frame.size.width, height: 40)

        txtDatefld?.inputAccessoryView = toolBar
        txtDatefld.inputView = datePicker
       
        //Feature date not select..
        self.datePicker?.maximumDate = Date()

        self.view.endEditing(true)
        
    }
    
    //DatePicker Click Done Button Action
    func  doneClick(){
        
        let dateformat = DateFormatter()
        dateformat.dateFormat = "dd-MM-yyyy"
        //txtDatefld.text = "\(String(describing: datePicker?.date))"
        txtDatefld.text = dateformat.string(from: (datePicker?.date)!)
        self.view.endEditing(true)
        
    }
    
    /*Touch Method*/
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
        // RegstrPickVW.isHidden = true
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
    txtDatefld.inputView = datePicker
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        vwModelNM.layer.cornerRadius = 10
        vwSerialNM.layer.cornerRadius = 10
        vwDate.layer.cornerRadius = 10
        
        
        datePicker?.isHidden = false
        createDatePicker()
        maivc.view .addSubview(datePicker!)
        
        addTopView()
        addBottomView()
    
    }
    
    func addTopView(){
        topview = TopViewController(title: "Register Product", menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        topview.delegate = nil
        topview.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 75)
        //topview.topBGVW.backgroundColor = UIColor (colorLiteralRed: 47/255, green: 57/255, blue: 66/255, alpha: 1.0)
        //topview.leftBack.isHidden = true
        
        self.view.addSubview(topview.view)
        self.view.layoutIfNeeded()
    }
    
    
    func addBottomView(){
        bottomView = BottomViewViewController()
        self.bottomView.view.frame = CGRect(x: 0, y: WINDOW_HEIGHT-75 , width: WINDOW_WIDTH, height: 75)
        self.bottomView.btnAddAplinc.isSelected = true
        self.view.addSubview(bottomView.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func clickLocationTagPushVW(sender: AnyObject)
    {
        if (txtModlNo.text?.isEmpty)! || (txtSerialNo.text?.isEmpty)! || (txtDatefld.text?.isEmpty)!
        {
             displayAlertMessagae(userMessage: "Please select all the fields.")
        }else{
           
            let defaults = UserDefaults.standard
            defaults.set(txtModlNo.text, forKey: "txtmodel")
            defaults.set(txtSerialNo.text, forKey: "txtSerialNM")
            defaults.set(txtDatefld.text, forKey: "txtDAte")
            defaults.synchronize()
            
            /*let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "LocationTagViewController") as! LocationTagViewController
            self.navigationController?.pushViewController(newViewController, animated: true)*/
        
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "InvoiceViewController") as! InvoiceViewController
            self.navigationController?.pushViewController(newViewController, animated: true)
            
        }
    
    }
    
    @IBAction func clickBackVW(sender: AnyObject)
    {
        self.navigationController?.popViewController(animated: true)
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
