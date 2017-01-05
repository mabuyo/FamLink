//
//  FamLinkClock.swift
//  FamLink
//
//  Created by Michelle Mabuyo on 2017-01-04.
//  Copyright © 2017 Michelle Mabuyo. All rights reserved.
//

import Foundation

class FamLinkClock {
    var device: SparkDevice!
    var users: [String:String]

    static let sharedInstance: FamLinkClock = {
        let instance = FamLinkClock()
        
        // setup code
        return instance
    }()
    
    private init() {
        self.device = nil
        self.users = [:]
    }
    
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
                print("Event details: \(event!.data)")
            }
        })

        
        // initial-locs
        self.device.subscribeToEvents(withPrefix: "flink/initial-locs", handler: {
            (event: SparkEvent?, error: Error?) -> Void in
            if let e = error {
                print("error: \(e)")
                
            } else {
                print("Got event: \(event!.event)")
                print("Initial locations: \(event!.data)")
                
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
