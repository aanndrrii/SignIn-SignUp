//
//  ViewController.swift
//  SignIn & SignUp
//
//  Created by Andrii on 3/12/20.
//  Copyright © 2020 Andrii. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        signUpButton.layer.cornerRadius = 5
    }

    @IBAction func signUpDidClick(_ sender: UIButton) {
        
        let message = Validation.shared.validateSignUp(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "", confirmPassword: confirmPasswordTextField.text ?? "")
        
        if message == Validation.Success.userSignedUpSuccessfully.rawValue {
            //presentAlertWithMessage(message: message)
            let viewController = self.storyBoard.instantiateViewController(withIdentifier: "signin") as! SignInViewController
            viewController.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(viewController, animated: true)
        } else {
            presentAlertWithMessage(message: message)
        }
        
    }
    
    @IBAction func SignInButtonDidClick(_ sender: Any) {
        let viewController = self.storyBoard.instantiateViewController(withIdentifier: "signin") as! SignInViewController
        viewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func presentAlertWithMessage(message: String){
        let alert = UIAlertController(title: "Alert!", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

