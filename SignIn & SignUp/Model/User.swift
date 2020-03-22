//
//  Models.swift
//  SignIn & SignUp
//
//  Created by Andrii on 3/18/20.
//  Copyright © 2020 Andrii. All rights reserved.
//

import Foundation

class User : Codable {
    
    var username:String
    var password:String
    
    public init(username: String, password: String){
        self.username = username
        self.password = password
    }
    
    required init(coder: NSCoder) {
        username = coder.value(forKey: "Username") as! String
        password = coder.value(forKey: "Password") as! String
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(username, forKey: "Username")
        coder.encode(password, forKey: "Password")
    }
    
    static var getUsersFromUserDefaults: [User] {
       if let objects = UserDefaults.standard.value(forKey: "Users") as? Data {
          let decoder = JSONDecoder()
          if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [User] {
             return objectsDecoded
          } else {
             return Array<User>()
          }
       } else {
          return Array<User>()
       }
    }
    
    public func register() {
        var savedArray = User.getUsersFromUserDefaults
        if !isRegistered() {
            savedArray.append(self)
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(savedArray){
               UserDefaults.standard.set((encoded), forKey: "Users")
            }
        }
    }
    
    public func isRegistered() -> Bool {
        let savedArray = User.getUsersFromUserDefaults
        for u in savedArray {
            if username == u.username {
                return true
            }
        }
        return false
    }
    
    public func validatePassword() -> Bool {
        let savedArray = User.getUsersFromUserDefaults
        for u in savedArray {
            if username == u.username {
                if password == u.password {
                    return true
                } else {
                    return false
                }
            }
        }
        return false
    }
    
}
