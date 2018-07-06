//
//  Constant.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 05/10/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.
//

import Foundation

let MAIN_STORYBOARD = UIStoryboard(name: "Main", bundle: nil)
//let MAIN_STORYBOARD = UIStoryboard(name: "Main", bundle: nil)
//http://13.126.21.70/walletWebApi/users/SignIn.php
var BASE_URL : NSURL = NSURL(string: "http://13.126.157.205" as String)!

let WINDOW_HEIGHT = UIScreen.main.bounds.height
let WINDOW_WIDTH = UIScreen.main.bounds.width

let LOGIN_POSt_NEW_METHOD = "/walletWebApi/users/SignIn.php"
let SIGNUP_POSt_NEW_METHOD = "/walletWebApi/users/SignUp.php"

