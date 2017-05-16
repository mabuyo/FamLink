//
//  UserSetupViewController.swift
//
//
//  Created by Michelle Mabuyo on 2017-02-04.
//
//

import UIKit
import Firebase

class UserSetupViewController: UIViewController, UITextFieldDelegate {
    var ref: FIRDatabaseReference!
    
    @IBOutlet weak var userListTextArea: UITextView!
    @IBOutlet weak var userNameTextInput: UITextField!
    @IBOutlet weak var userSetupButton: UIButton!
    
    @IBOutlet weak var userListTextLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameTextInput.delegate = self
        let famlinkClock = FamLinkClock.sharedInstance
        
        self.ref = FIRDatabase.database().reference()
        
        // list any users already in that family
        let famlinkCode = FamLinkClock.sharedInstance.famlink_code!
        ref.child(famlinkCode).observeSingleEvent(of: .value) { (snapshot: FIRDataSnapshot) in
            let usersList = snapshot.value as? NSDictionary
            print("FAMLINK_CODES VALUES \(String(describing: usersList))")
            let users = usersList?["users"] as! NSArray
            
            for user in users as! [String] {
                famlinkClock.user_list.append(user)
            }
            
            let usersString = users.componentsJoined(by: "\n")
            print("\(usersString)")
            self.userListTextLabel.text = usersString
            print("\(String(describing: self.userListTextLabel.text))")
        }
        self.userListTextLabel.text = "testing"
        
        // Do any additional setup after loading the view.
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
            self.userSetupButton.isEnabled = false //Enabling the button
        } else {
            self.userSetupButton.isEnabled = true //Disabling the button
        }
        
        return true
    }
    
    
    @IBAction func setupNewUser(_ sender: Any) {
        let userName = userNameTextInput.text!
        
        let famlinkClock = FamLinkClock.sharedInstance
        // if userName already exists, then log in as that userName
        if (!famlinkClock.user_list.contains(userName)) {
            famlinkClock.createUser(username: userName)
        } else {
            famlinkClock.setUser(userName)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "mainTabBarController")
        self.present(controller, animated: true, completion: nil)
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
