//
//  FamLinkClock.swift
//  FamLink
//
//  Created by Michelle Mabuyo on 2017-01-04.
//  Copyright © 2017 Michelle Mabuyo. All rights reserved.
//

import Foundation
import Firebase

let userLocationsDidUpdateNotification = "userLocationsDidUpdate"

class FamLinkClock: NSObject, NSCoding {
    var device: SparkDevice!
    var users: [String:String] {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: userLocationsDidUpdateNotification), object: nil)
        }
    } // Username:Location
    var user_colors: [String:String]
    var famlink_code: String!
    var user_list: [String]
    var user: String
    
    var firebaseDB: FIRDatabaseReference!
    
    // MARK: types
    struct PropertyKey {
        static let codeKey = "code"
        static let userKey = "user"
    }
    

    static let sharedInstance: FamLinkClock = {
        let instance = FamLinkClock(user: nil, code: nil)
        
        // setup code
        return instance
    }()
    
    init(user: String?, code: String?) {
        self.device = nil
        self.users = [:]
        self.user_colors = [:]
        self.famlink_code = code == nil ? "" : code!
        self.user_list = []
        self.user = user == nil ? "" : user!
        self.firebaseDB = FIRDatabase.database().reference()
    }
    
    func setFamlinkUser(_ username: String) {
        self.user = username
    }
    
    func createUser(username: String) {
        self.user_list.append(username)
        self.firebaseDB.child(self.famlink_code).child("users").setValue(self.user_list, withCompletionBlock: {(error: Error?, dbref: FIRDatabaseReference) -> Void in
            if let e = error {
                print("error \(e)")
            } else {
                print("Successfully added user")
            }
        })
    }
    
    func loadLocations() {
        self.firebaseDB.child(self.famlink_code).child("user-locations").observe(.value, with: {(snapshot: FIRDataSnapshot) -> Void in
            let results = snapshot.value as? [String : AnyObject] ?? [:]
            self.users = results as! [String : String]
            print("users set from firebase")
        })
        
        self.firebaseDB.child(self.famlink_code).child("user-colors").observe(.value, with: {(snapshot: FIRDataSnapshot) -> Void in
            let results = snapshot.value as? [String : AnyObject] ?? [:]
            self.user_colors = results as! [String : String]
            print("user colors set from firebase")
        })
        
    }
    
    func updateLocation(_ newLocation: String) {
        print("Updating Location!!")
        users[user] = newLocation
        self.firebaseDB.child(self.famlink_code).child("user-locations/" + user).setValue(newLocation)
    }
    
    // MARK: archiving paths
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    static let archiveURL = documentsDirectory.appendingPathComponent("account")
    
    // MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(famlink_code, forKey: PropertyKey.codeKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let famlink_code = aDecoder.decodeObject(forKey: PropertyKey.codeKey) as! String
        let user = aDecoder.decodeObject(forKey: PropertyKey.userKey) as? String

        self.init(user: user, code: famlink_code)
    }

    
    
    // leftover Photon functions below
    func initLocations() {
        self.device.callFunction("init_locs", withArguments: [""], completion: nil)
    }
    
    func subscribeToEvents() {
        // update-users
        self.device.subscribeToEvents(withPrefix: "flink/update-users", handler: {
            (event: SparkEvent?, error: Error?) -> Void in
            if let e = error {
                print("error: \(e)")
            } else {
                print("Got event: \(event!.event)")
                print("Event details: \(String(describing: event!.data))")
            }
        })
        
        // get-users
        self.device.subscribeToEvents(withPrefix: "flink/get-user-colors") { (event: SparkEvent?, error: Error?) in
            if let e = error {
                print("error: \(e)")
            } else {
                var data = event!.data!
                
                // michelle=green,brad=blue
                let userArr = data.characters.split(separator: ",").map(String.init)
                for user in userArr {
                    let tempArr = user.characters.split(separator: "=").map(String.init)
                    self.user_colors[tempArr[0]] = tempArr[1]
                }
                print("user_colors: \(self.user_colors)")
            }
        }
        
        

        
        // initial-locs
        self.device.subscribeToEvents(withPrefix: "flink/initial-locs", handler: {
            (event: SparkEvent?, error: Error?) -> Void in
            if let e = error {
                print("error: \(e)")
                
            } else {
                print("Got event: \(event!.event)")
                print("Initial locations: \(String(describing: event!.data))")
                
                var data = event!.data!
                
                // parse data
                // format: user1=location1,user2=location2
                
                // split into [user1=location1,user2=location2], then split again using '=' and store in users dictionary.
                let userArr = data.characters.split(separator: ",").map(String.init)
                for pair in userArr {
                    let tempArr = pair.characters.split(separator: "=").map(String.init)
                    self.users[tempArr[0]] = tempArr[1]
                }
                print("users: \(self.users)")
            }
        })
    }
}
