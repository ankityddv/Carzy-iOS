//
//  signUpViewController.swift
//  Carzy
//
//  Created by ANKIT YADAV on 23/12/19.
//  Copyright © 2019 ANKIT YADAV. All rights reserved.
//

import UIKit
import FirebaseAuth

class signUpViewController: UIViewController {
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet weak var emailFiled: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signUpBttn: UIButton!
    @IBAction func signUpBttn(_ sender: Any) {
        createUser()
    }
    // update
    func createUser() {
        let email = emailFiled.text!
        let password = passwordField.text!
        if password.count < 6 && password.count >= 1 {
            let alertController = UIAlertController(title: "Password Invalid!", message: "Password must be greater than 6 characters!", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            Auth.auth().createUser(withEmail: email, password: password){ (user, error) in
                if error == nil {
                    self.performSegue(withIdentifier: "addInfo", sender: nil)
                }
                else{
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            startSpinning()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpBttn.layer.cornerRadius = 10
        //Hide Keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardwilchange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardwilchange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardwilchange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    // MARK: - Activity Indicator
    
    func startSpinning() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        //activityIndicator.style = UIActivityIndicatorView.Style.gray
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        //UIApplication.shared.beginIgnoringInteractionEvents()
    }
    func stopSpinning() {
        activityIndicator.stopAnimating()
        //UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    // MARK: - Code below this is for hiding keyboard

    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func hideKeyboard(){
        view.resignFirstResponder()
    }
    
    @objc func keyboardwilchange(notification: Notification){
        view.frame.origin.y = -268

    }
    
    //UITextFieldDeligate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
    
    //Hide when touch outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        view.frame.origin.y = 0
    }
    

}
