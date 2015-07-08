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



class LoginViewController: UIViewController, UITextFieldDelegate
{
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var passwort: UITextField!
    @IBOutlet weak var statusLabel: UILabel!

    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var content: UIView!
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        username.delegate = self
        passwort.delegate = self
        
        let recognizer = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        content.addGestureRecognizer(recognizer)
        
        if PFUser.currentUser() != nil{
            self.loginButton.hidden = true
            self.loginButton.enabled = false
            self.logoutButton.hidden = false
            self.logoutButton.enabled = true
            
            self.username.text = PFUser.currentUser()?.username
            self.passwort.text = PFUser.currentUser()?.password
        }
        else
        {
            self.loginButton.hidden = false
            self.loginButton.enabled = true
            self.logoutButton.hidden = true
            self.logoutButton.enabled = false
            
            self.username.text = ""
            self.passwort.text = ""
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 1/255, green: 200/255, blue: 171/255, alpha: 0.8)
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSFontAttributeName: UIFont(name: "HelveticaNeue-Thin", size: 20)!,
            NSForegroundColorAttributeName: UIColor.whiteColor()
        ]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    func handleTap(recognizer: UITapGestureRecognizer)
    {
        username.resignFirstResponder()
        passwort.resignFirstResponder()
    }
    
    @IBAction func loginButton(sender: AnyObject)
    {
        
        if username.text != "" && passwort.text != ""
        {
            PFUser.logInWithUsernameInBackground(username.text, password:passwort.text)
                {
                (user: PFUser?, error: NSError?) -> Void in
                if user != nil
                {
                    // Do stuff after successful login.
                    let user = PFUser.currentUser()
                    self.statusLabel.text = "Du bist eingeloggt."
                    self.username.enabled = false
                    self.passwort.enabled = false
                    
                    self.username.backgroundColor = UIColor.grayColor()
                    self.passwort.backgroundColor = UIColor.grayColor()
                    
                    self.loginButton.hidden = true
                    self.loginButton.enabled = false
                    self.logoutButton.hidden = false
                    self.logoutButton.enabled = true
                    
                    
                }
                else
                {
                    // The login failed. Check error to see why.
                    self.statusLabel.text = "Fehler beim Anmelden."
                }
            }
        }
        else
        {
            self.statusLabel.text = "Bitte Nutzernamen und Passwort eingeben."
        }
    }


     @IBAction func logoutButton(sender: AnyObject)
     {
        PFUser.logOut()
        
        self.statusLabel.text = ""
        
        self.loginButton.hidden = false
        self.loginButton.enabled = true
        self.logoutButton.hidden = true
        self.logoutButton.enabled = false
        
        self.username.enabled = true
        self.passwort.enabled = true
        
        self.username.backgroundColor = UIColor.whiteColor()
        self.passwort.backgroundColor = UIColor.whiteColor()
        
        
    }
    

    

    

}