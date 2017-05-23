//
//  AccountInfo.swift
//  FamLink
//
//  Created by Michelle Mabuyo on 2017-05-23.
//  Copyright © 2017 Michelle Mabuyo. All rights reserved.
//

import Foundation

class AccountInfo: NSObject, NSCoding {
    var famlink_code: String
    var username: String
    
    struct PropertyKey {
        static let famlink_codeKey = "famlink_code"
        static let usernameKey = "username"
    }
    
    init(famlink_code: String, username: String) {
        self.famlink_code = famlink_code
        self.username = username
    }
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    static let archiveURL = documentsDirectory.appendingPathComponent("account")
    
    func encode(with aCoder: NSCoder) {
         aCoder.encode(famlink_code, forKey: PropertyKey.famlink_codeKey)
         aCoder.encode(username, forKey: PropertyKey.usernameKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let famlink_code = aDecoder.decodeObject(forKey: PropertyKey.famlink_codeKey) as! String
        let username = aDecoder.decodeObject(forKey: PropertyKey.usernameKey) as! String
        
        self.init(famlink_code: famlink_code, username: username)
    }
    
}
