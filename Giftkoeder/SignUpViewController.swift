//
//  SignUpViewController.swift
//  Giftkoeder
//
//  Created by Lisa Fischer on 08.07.15.
//  Copyright © 2015 TeamGK. All rights reserved.
//

import UIKit
import Foundation
import Parse

class SignUpViewController: UIViewController
{
    
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var passwort: UITextField!
    @IBOutlet weak var passRepeat: UITextField!
    @IBOutlet weak var mail: UITextField!
    
    
    override func viewDidLoad()
    {
        
    }
    
    @IBAction func signUpButton(sender: AnyObject)
    {
        if (self.username != "" && self.passwort != "" && self.passRepeat != "" && self.mail != "")
        {
            if self.passwort == self.passRepeat
            {
                var user = PFUser()
                user.username = self.username.text
                user.password = self.passwort.text
                user.email = self.mail.text
                // other fields can be set just like with PFObject
                // user["phone"] = "415-392-0202"
                
                user.signUpInBackgroundWithBlock
                    {
                        (succeeded: Bool, error: NSError?) -> Void in
                        if let error = error
                        {
                            let errorString = error.userInfo?["error"] as? NSString
                            // Show the errorString somewhere and let the user try again.
                        }
                        else
                        {
                            // Hooray! Let them use the app now.
                            print("user signed in")
                        }
                }
            }
        }
    }
 
    
}
