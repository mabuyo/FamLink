//
//  LoginViewController.swift
//  FamLink
//
//  Created by Michelle Mabuyo on 2016-12-10.
//  Copyright © 2016 Michelle Mabuyo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var deviceNameTextField: UITextField!
    @IBOutlet weak var enterNameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
   
    @IBAction func famLinkSetup(_ sender: UIButton) {
        // login with company credentials
        SparkCloud.sharedInstance().login(withUser: "michelle.mabuyo@gmail.com", password: "FAM!l!nk2017", completion: {(error: Error?) -> Void in
            if let e = error {
                print("Something went wrong! \(e)")
            } else {
                self.getDevice()
            }
        })
    }
    
    func getDevice() {
        let deviceName = self.deviceNameTextField.text!
        
        SparkCloud.sharedInstance().getDevices({(sparkDevices: [Any]?, error: Error?) -> Void in
            if let e = error {
                print("Something went wrong! \(e)")
            } else {
                if let devices = sparkDevices as? [SparkDevice] {
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
