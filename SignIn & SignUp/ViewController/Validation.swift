//
//  Validation.swift
//  SignIn & SignUp
//
//  Created by Andrii on 3/12/20.
//  Copyright © 2020 Andrii. All rights reserved.
//

import Foundation

class Validation {
    
    let numbers = "0123456789"
    let lower_case = "abcdefghijklmnopqrstuvwxyz"
    let upper_case = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    let special_characters = "!@#$%^&*()-+"
    
    let defaults = UserDefaults.standard
    
    enum Password : String {
        case passwordIsTooShort = "Password should contain at least 5 characters."
        case noLovercase = "Password should contain at least one lowercase English character."
        case noUppercase = "Password should contain at least one uppercase English character."
        case noDigit = "Password should contain at least one digit character."
        case noSpecialCharacter = "Password should contain at least one special character."
        case incorrectPassword = "The password is incorrect"
    }
    
    enum ConfirmPassword : String {
        case passwordsAreNotEqual = "Passwords are not equal."
    }
    
    enum Username : String {
        case userCurrentlyExists = "This user currently exists."
        case usernameIsEmpty = "Field username is empty."
        case userDoesNotExist = "This user is not registered yet."
    }
    
    public enum Success:String {
        case userSignedUpSuccessfully = "The user signed up successfully."
        case userSignedInSuccessfully = "The user signed in successfully."
    }
    
    func validatePassword(password:String) -> String {
        var result = ""
        if password.count < 5 {
            result += Password.passwordIsTooShort.rawValue
            return result
        }
        
        var digitExists:Bool = false
        var lowerCaseExists:Bool = false
        var upperCaseExists:Bool = false
        var specialCharacterExists:Bool = false
        
        for c in password {
            if numbers.contains(c){
                digitExists = true
                continue
            }
            if lower_case.contains(c){
                lowerCaseExists = true
                continue
            }
            if upper_case.contains(c){
                upperCaseExists = true
                continue
            }
            if special_characters.contains(c){
                specialCharacterExists = true
                continue
            }
        }
        
        if !digitExists {
             result += Password.noDigit.rawValue
             result += "\n"
         }
                
        if !lowerCaseExists {
            result += Password.noLovercase.rawValue
            result += "\n"
        }
        
        if !upperCaseExists {
            result += Password.noUppercase.rawValue
            result += "\n"
        }
        
        if !specialCharacterExists {
            result += Password.noSpecialCharacter.rawValue
            result += "\n"
        }
        result = String(result.dropLast(1))
    
        return result
    }
    
    func validateUsernameSignUp(user: User) -> String {
        if user.username == "" {
            return Username.usernameIsEmpty.rawValue
        }
        
        if user.isRegistered() {
            return Username.userCurrentlyExists.rawValue
        } else {
            return ""
        }
    }
    
    func validateConfirmPassword(password: String, confirmPassword: String) -> String {
        if password == confirmPassword {
            return ""
        } else {
            return ConfirmPassword.passwordsAreNotEqual.rawValue
        }
    }
    
    func validateSignUp(username: String, password: String, confirmPassword: String) -> String {
        var result = ""
        
        let user = User(username: username, password: password)
        let usernameNotification = validateUsernameSignUp(user: user)
        let passwordNotification = validatePassword(password: password)
        let confirmPasswordNotification = validateConfirmPassword(password: password, confirmPassword: confirmPassword)
        
        if usernameNotification != "" {
            result += usernameNotification
            result += "\n"
        }
        if passwordNotification != "" {
            result += passwordNotification
            result += "\n"
        }
        if confirmPasswordNotification != "" {
            result += confirmPasswordNotification
            result += "\n"
        }
        result = String(result.dropLast(1))
        
        if result == "" {
            result = Success.userSignedUpSuccessfully.rawValue
            user.register()
        }
        
        return result
    }
    
    func validateUsernameSignIn(user: User) -> String {
        if user.username == "" {
            return Username.usernameIsEmpty.rawValue
        }
        
        if user.isRegistered() {
            return ""
        } else {
            return Username.userDoesNotExist.rawValue
        }
    }
    
    func validatePasswordSignIn(user: User) -> String {
        if user.password == "" {
            return Password.passwordIsTooShort.rawValue
        }
        
        if user.validatePassword() {
            return ""
        } else {
            return Password.incorrectPassword.rawValue
        }
    }
    
    func validateSignIn(username: String, password: String) -> String {
        var result = ""
        
        let user = User(username: username, password: password)
        let usernameNotification = validateUsernameSignIn(user: user)
        let passwordNotification = validatePasswordSignIn(user: user)
        
        if usernameNotification != "" {
            result += usernameNotification
            result += "\n"
        }
        if passwordNotification != "" {
            result += passwordNotification
            result += "\n"
        }
        result = String(result.dropLast(1))
        
        if result == "" {
            result = Success.userSignedInSuccessfully.rawValue
        }
        
        return result
    }
    
}
