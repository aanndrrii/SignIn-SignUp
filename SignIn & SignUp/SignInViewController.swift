//
//  SignInViewController.swift
//  SignIn & SignUp
//
//  Created by Andrii on 3/12/20.
//  Copyright © 2020 Andrii. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        signInButton.layer.cornerRadius = 5
    }

    @IBAction func signInButtonDidClick(_ sender: UIButton) {
        let message = Validation.shared.validateSignIn(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "")
        
        if message == Validation.Success.userSignedInSuccessfully.rawValue {
            //presentAlertWithMessage(message: message)
            let viewController = self.storyBoard.instantiateViewController(withIdentifier: "table") as! TableViewController
            viewController.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(viewController, animated: true)
        } else {
            presentAlertWithMessage(message: message)
        }        
    }
    
    @IBAction func signUpButtonDidClick(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func presentAlertWithMessage(message: String){
        let alert = UIAlertController(title: "Alert!", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
