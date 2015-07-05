//
//  LoginViewController.swift
//  Giftkoeder
//
//  Created by Lisa Fischer on 05.07.15.
//  Copyright © 2015 TeamGK. All rights reserved.
//

import Foundation
import UIKit
import Parse


class LoginViewController: UIViewController
{
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var passwort: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad()
    {
        
    }
    
    @IBAction func loginButton(sender: AnyObject)
    {
        if username.text != "" && passwort.text != ""
        {
            PFUser.logInWithUsernameInBackground("myname", password:"mypass")
                {
                (user: PFUser?, error: NSError?) -> Void in
                if user != nil
                {
                    // Do stuff after successful login.
                    self.statusLabel.text = "Du bist eingeloggt."
                }
                else
                {
                    // The login failed. Check error to see why.
                    self.statusLabel.text = "Fehler beim Anmelden. Bitte Nutzernamen und Passwort überprüfen."
                }
            }
        }
        else
        {
            self.statusLabel.text = "Bitte Nutzernamen und Passwort eingeben."
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
    @IBAction func signUpButton(sender: AnyObject)
    {
        if username.text != "" && passwort.text != ""
        {
            var user = PFUser()
            user.username = self.username.text
            user.password = self.passwort.text
            user.email = "email@example.com"
            // other fields can be set just like with PFObject
            // user["phone"] = "415-392-0202"
            
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool, error: NSError?) -> Void in
                if let error = error {
                    let errorString = error.userInfo["error"] as? NSString
                    // Show the errorString somewhere and let the user try again.
                } else {
                    // Hooray! Let them use the app now.
                print("sign up")
                }
            }
        }
        else
        {
            print("empty - TODO")
        }
    }
    

}