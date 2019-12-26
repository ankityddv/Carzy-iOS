//
//  ProfileViewController.swift
//  Carzy
//
//  Created by ANKIT YADAV on 24/12/19.
//  Copyright © 2019 ANKIT YADAV. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class ProfileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var labelArr = ["Personal information","Search"]
    var imgArr = ["usr","srch"]
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileUIView: UIView!
    @IBOutlet weak var logOutBttn: UIButton!
    @IBAction func logOutBttn(_ sender: Any) {
        try!Auth.auth().signOut()
        self.performSegue(withIdentifier: "loggedOut", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labelArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AccountsettingsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AccountsettingsTableViewCell", for: indexPath) as! AccountsettingsTableViewCell
        cell.accessoryView = UIImageView(image:UIImage(named: imgArr[indexPath.row]))
        cell.Label.text = labelArr[indexPath.row]
        cell.accessoryView!.frame = CGRect(x: 208, y: 21, width: 25, height: 25)
        let view = UIView()
        view.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = view
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileOptionsResultViewController") as! ProfileOptionsResultViewController
        //vc.labelTxt = labelArr[indexPath.row]
        //self.navigationController?.pushViewController(vc, animated: true)
    }
    
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
                self.imageView.image = UIImage(data: data!)
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
    func addShadow(){
        profileUIView.layer.shadowOffset = CGSize(width: 0,height: 5)
        profileUIView.layer.shadowRadius = 2
        profileUIView.layer.shadowOpacity = 0.05
        profileUIView.layer.masksToBounds = false
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        logOutBttn.layer.cornerRadius = 10
        imageView.layer.cornerRadius = imageView.bounds.height / 2
        imageView.clipsToBounds = true
        addShadow()
        fetchName()
        fetchProfileImage()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.isNavigationBarHidden = true
    }
}
