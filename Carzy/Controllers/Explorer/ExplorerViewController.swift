//
//  ExplorerViewController.swift
//  Carzy
//
//  Created by ANKIT YADAV on 26/12/19.
//  Copyright © 2019 ANKIT YADAV. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class ExplorerViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    var imageArr1 = ["f1","f2"]
    var imageArr2 = ["s1","s2","s3","s4","s5","s6"]
    var intoArr = ["INTODUCING","INTODUCING"]
    var nameArr = ["Maybach","G Wagon"]
    var nameArr2 = ["Range Rover","Lamborghini","Mercedese GLE","Audi Q8","Mustang Mach-E","BMW M5"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nameArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:OneCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "OneCollectionViewCell", for: indexPath) as! OneCollectionViewCell
        cell.imageView.image = UIImage(named: imageArr1[indexPath.row])
        let storageRef = Storage.storage().reference()
        let imageArr = ["1","2"]
        let imageRef = storageRef.child("Images/FirstCV/\(imageArr[indexPath.row]).png")
        imageRef.getData(maxSize: 1*1000*1000) { (data,error) in
            if error == nil{
                print(data ?? Data.self)
                DispatchQueue.main.async {
                    cell.imageView.image = UIImage(data: data!)
                }
            }
            else{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
