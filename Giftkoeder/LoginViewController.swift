//
//  LoginViewController.swift
//  Giftkoeder
//
//  Created by Lisa Fischer on 05.07.15.
//  Copyright © 2015 TeamGK. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController
{
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var passwort: UITextField!
    override func viewDidLoad() {
        
    }
    
    @IBAction func loginButton(sender: AnyObject)
    {
        if username.text != "" && passwort.text != "" {
            // Not Empty, Do something.
        } else {
            print("empty - TODO")
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    

}