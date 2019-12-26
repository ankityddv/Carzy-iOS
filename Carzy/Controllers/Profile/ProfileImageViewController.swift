//
//  ProfileImageViewController.swift
//  Carzy
//
//  Created by ANKIT YADAV on 26/12/19.
//  Copyright © 2019 ANKIT YADAV. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class ProfileImageViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    func fetchName(){
        let userID = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        ref.child("USER").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let username = value?["Name"] as? String ?? ""
            self.nameLabel.text = username
        }) { (error) in
            let alert = UIAlertController(title: "Sorry!", message: "Error finding your details! Please log out and login again.", preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func fetchProfileImage(){
        //retrive image
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("user/profile_images")
        let imageRef = storageRef.child("\(uid).png")
        imageRef.getData(maxSize: 1*1000*1000) { (data,error) in
            if error == nil{
                print(data ?? Data.self)
                self.profileImageView.image = UIImage(data: data!)
            }
            else{
                let alert = UIAlertController(title: "Sorry!", message: "Error finding your profile image! Please login again.", preferredStyle: UIAlertController.Style.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchName()
        fetchProfileImage()
        profileImageView.layer.cornerRadius = 300
    }
}
