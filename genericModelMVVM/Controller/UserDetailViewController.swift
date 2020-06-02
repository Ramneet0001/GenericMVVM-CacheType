//
//  UserDetailViewController.swift
//  genericModelMVVM
//
//  Created by Ramneet on 03/06/20.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    @IBOutlet weak var img_main: UIImageView!
    @IBOutlet weak var lbl_name, lbl_Fname, lbl_Lname, lbl_age, lbl_email, lbl_mobile,lbl_address, lbl_contact: UILabel!

    var personLists : List?
    var tempImg = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.img_main.image = tempImg
        self.lbl_name.text = personLists?.name
        self.lbl_Fname.text = personLists?.firstName
        self.lbl_Lname.text = personLists?.lastName
        self.lbl_age.text =  "\(HelperMethods().calculateAge(dob:personLists!.contact))"
        self.lbl_email.text = personLists?.email
        self.lbl_mobile.text = "\(personLists?.mobile ?? 0)"
        self.lbl_address.text = personLists?.address
        self.lbl_contact.text = personLists?.contact
    }
    

}

