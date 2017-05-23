//
//  LoginViewController.swift
//  FamLink
//
//  Created by Michelle Mabuyo on 2016-12-10.
//  Copyright © 2016 Michelle Mabuyo. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

class LoginViewController: UIViewController, UITextFieldDelegate, UNUserNotificationCenterDelegate {
    var ref: FIRDatabaseReference!
    
    @IBOutlet weak var deviceNameTextField: UITextField!
    @IBOutlet weak var enterNameButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = FIRDatabase.database().reference()
        
        deviceNameTextField.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // We need to figure out how many characters would be in the string after the change happens
        let startingLength = textField.text?.characters.count ?? 0
        let lengthToAdd = string.characters.count
        let lengthToReplace = range.length
        
        let newLength = startingLength + lengthToAdd - lengthToReplace

        if newLength == 0 {//Checking if the input field is not empty
            self.enterNameButton.isEnabled = false //Enabling the button
        } else {
            self.enterNameButton.isEnabled = true //Disabling the button
        }
        
        return true
    }
    
   
    // Handler for when user clicks "Let's Famlink it up!"
    @IBAction func famLinkSetup(_ sender: UIButton) {
        print("Famlink it up")
        let famlinkName = self.deviceNameTextField.text!
        ref.child("famlink_codes").observeSingleEvent(of: .value) { (snapshot: FIRDataSnapshot) in
            let value = snapshot.value as? NSDictionary
            print("FAMLINK_CODES VALUES \(String(describing: value))")
            
            if let _ = value?[famlinkName] {
                self.setup()
            } else {
                print("Not found")
            }
        }
        
        
    }
    
    func setup() {
        print("FamLinkClock setup")
        // store this in device
        FamLinkClock.sharedInstance.famlink_code = self.deviceNameTextField.text!
        FamLinkClock.sharedInstance.user = self.usernameTextField.text!
        print("set famlink_code")
        
        let url = FamLinkClock.archiveURL.path
        let code = self.deviceNameTextField.text!
        let name = self.usernameTextField.text!
        let accountInfo = AccountInfo(famlink_code: code, username: name)
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(accountInfo, toFile: url)
        if (!isSuccessfulSave) {
            print("Was not able to save fclock code.")
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "mainTabBarController")
        self.present(controller, animated: true, completion: nil)
    }
    
    func getDevice() {
        let deviceName = self.deviceNameTextField.text!
        
        SparkCloud.sharedInstance().getDevices({(sparkDevices: [SparkDevice]?, error: Error?) -> Void in
            if let e = error {
                print("Something went wrong! \(e)")
            } else {
                if let devices = sparkDevices {
                    var deviceFound = false
                    for device in devices {
                        if device.name == deviceName {
                            FamLinkClock.sharedInstance.device = device
                            let famlinkDevice = FamLinkClock.sharedInstance.device!
                            deviceFound = true
                            
                            // set up wifi if needed
                            if famlinkDevice.connected {
                                FamLinkClock.sharedInstance.initLocations()
                                FamLinkClock.sharedInstance.subscribeToEvents()
                                
                                
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                let controller = storyboard.instantiateViewController(withIdentifier: "mainTabBarController")
                                self.present(controller, animated: true, completion: nil)
                            } else {
                                if let setupController = SparkSetupMainController(setupOnly: true)
                                {
                                    self.present(setupController, animated: true, completion: nil)
                                }
                            }
                        
                       }
                    }
                    if !deviceFound {
                        
                        let alert = UIAlertController(title: "Could not find device", message: "Please try again with a different device name.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                        
                        // TODO: remove this, this is just to demo location monitoring without having a user account. uncomment the above alert.
                        /*
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let controller = storyboard.instantiateViewController(withIdentifier: "mainTabBarController")
                        self.present(controller, animated: true, completion: nil)
                         */

                    }
                }
            }
        })
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
