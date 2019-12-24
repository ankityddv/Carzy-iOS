//
//  HomeViewController.swift
//  Carzy
//
//  Created by ANKIT YADAV on 24/12/19.
//  Copyright © 2019 ANKIT YADAV. All rights reserved.
//

import UIKit
import FirebaseStorage

class HomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var imageArr1 = ["f1","f2"]
    var imageArr2 = ["s1","s2","s3","s4","s5","s6"]
    var intoArr = ["INTODUCING","INTODUCING"]
    var nameArr = ["Maybach","G Wagon"]
    var nameArr2 = ["Range Rover","Lamborghini","Mercedese GLE","Audi Q8","Mustang Mach-E","BMW M5"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nameArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:firstCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "firstCollectionViewCell", for: indexPath) as! firstCollectionViewCell
        cell.imageView.layer.cornerRadius = 26
        //cell.intoducingLabel.text = intoArr[indexPath.row]
        //cell.NameLabel.text = nameArr[indexPath.row]
        //cell.learnMoreBttn.layer.cornerRadius = 10
        // Image Retrive
        cell.imageView.image = UIImage(named: imageArr1[indexPath.row])
        let storageRef = Storage.storage().reference()
        let imageArr = ["1","2"]
        let imageRef = storageRef.child("Images/FirstCV/\(imageArr[indexPath.row]).png")
        imageRef.getData(maxSize: 1*1000*1000) { (data,error) in
            if error == nil{
                print(data ?? Data.self)
                DispatchQueue.global(qos: .default).async {
                    cell.imageView.image = UIImage(data: data!)
                }
            }
            else{
                print(error?.localizedDescription ?? error as Any)
            }
        }
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
