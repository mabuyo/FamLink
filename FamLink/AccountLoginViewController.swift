//
//  AccountLoginViewController.swift
//  FamLink
//
//  Created by Michelle Mabuyo on 2017-05-16.
//  Copyright © 2017 Michelle Mabuyo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseGoogleAuthUI


class AccountLoginViewController: UIViewController, FUIAuthDelegate {
    @IBOutlet weak var signInButton: UIButton!
    
    fileprivate(set) var auth: FIRAuth? = FIRAuth.auth()
    fileprivate(set) var authUI: FUIAuth? = FUIAuth.defaultAuthUI()
    
    let providers: [FUIAuthProvider] = [
        FUIGoogleAuth(),
//        FUIFacebookAuth(),
//        FUITwitterAuth(),
        ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func signIn(_ sender: Any) {
        if (self.auth?.currentUser) != nil {
            do {
                try FUIAuth.defaultAuthUI()?.signOut()
            } catch let error {
                // Again, fatalError is not a graceful way to handle errors.
                // This error is most likely a network error, so retrying here
                // makes sense.
                fatalError("Could not sign out: \(error)")
            }
        } else {
            // You need to adopt a FUIAuthDelegate protocol to receive callback
            self.authUI = FUIAuth.defaultAuthUI()
            self.authUI?.providers = providers

            self.authUI?.delegate = self
            let authViewController = self.authUI!.authViewController()
            present(authViewController, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
        print("IDK")
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication = options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String?
        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
            return true
        }
        // other URL handling goes here.
        return false
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
