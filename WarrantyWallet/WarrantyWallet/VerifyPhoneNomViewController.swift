//
//  VerifyPhoneNomViewController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 04/10/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.
//

import UIKit

class VerifyPhoneNomViewController: UIViewController,UITextFieldDelegate {

    /*Property declaration*/
    @IBOutlet weak var textfieldPhone: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
     @IBOutlet weak var vwMobNM: UIView!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    textfieldPhone.delegate = self
    textfieldPhone.keyboardType = .numberPad
        
     btnSignUp.layer.cornerRadius = 18
     vwMobNM.layer.cornerRadius = 10
        
         displayAlertMessagae(userMessage: "Please Enter 10 digit mobile number.")
        // Do any additional setup after loading the view.
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  /*Veryfy OTP Method*/
    @IBAction func gotoVerifyOTP(sender: AnyObject)
    {
        if (textfieldPhone.text?.characters.count)! < 10
        {
            displayAlertMessagae(userMessage: "Please fill Phone number 10  digit")
             return
        }
        else
        {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        
    }
    
    /*Textfield Delegate Method*/
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
     let usrPhNom = textfieldPhone.text!
        if (textField.text == usrPhNom)
        {
            guard let text = textField.text else { return true }
            
            let newLength = text.utf16.count + string.utf16.count - range.length
            return newLength <= 10 // Bool
        }
        
        return true
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
