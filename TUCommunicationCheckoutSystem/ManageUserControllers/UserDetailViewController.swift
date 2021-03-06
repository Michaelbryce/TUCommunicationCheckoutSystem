//
//  UserDetailViewController.swift
//  TUCommunicationCheckoutSystem
//
//  Created by Michael Bryce on 3/24/19.
//  Copyright © 2019 CheckoutGurus. All rights reserved.
//

import UIKit
import Firebase

class UserDetailViewController: UIViewController {

    let ref = Database.database().reference(withPath: "users")
    
    
    @IBOutlet weak var UserNameLabel: UILabel!
    
    @IBOutlet weak var TrinityIDLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var CourseLabel: UILabel!
    @IBOutlet weak var AuthorizedLabel: UILabel!
    @IBOutlet weak var AdminLabel: UILabel!
    
    @IBOutlet weak var IDvalue: UILabel!
    @IBOutlet weak var EmailValue: UILabel!
    @IBOutlet weak var CourseValue: UILabel!
    @IBOutlet weak var AuthorizedSwitch: UISwitch!
    @IBOutlet weak var AdminSwitch: UISwitch!
   
    var userOfInterest: User? {
        didSet{
            refershUI()
        }
    }

    func refershUI(){
        loadViewIfNeeded()
        let name = userOfInterest?.name
        UserNameLabel.text = name!
        let ID = userOfInterest?.ID_number
        IDvalue.text = String(ID!)
        let email = userOfInterest?.email
        EmailValue.text = email!
        let course = userOfInterest?.classId
        CourseValue.text = course!
        let isAdmin = userOfInterest?.isAdmin
        AdminSwitch.setOn(isAdmin!,animated: false)
        let isAuthorized = userOfInterest?.authorized
        AuthorizedSwitch.setOn(isAuthorized!,animated:false)
    }

    @IBAction func AuthorizedChange(_ sender: UISwitch) {
        let switchState = AuthorizedSwitch.isOn
        ref.child((userOfInterest?.ID_number)!).updateChildValues(["authorized": switchState]) {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Authorized data could not be saved: \(error).")
            } else {
                print("Data saved successfully!")
            }
        }
    }
   
    @IBAction func AdminChange(_ sender: UISwitch) {
        let switchState = AdminSwitch.isOn
        ref.child((userOfInterest?.ID_number)!).updateChildValues(["isAdmin": switchState]) {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Authorized data could not be saved: \(error).")
            } else {
                print("Data saved successfully!")
            }
        }
    }
    //Functions to pass to Firbase.  Will update when it detectes a change in switch state.  Needs to comfirm that current user is an admin.  Stil needs command to pass value to firebase
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UserDetailViewController: UserSelectionDelegate{
    func UserSelected(_ newUser: User) {
        userOfInterest = newUser
    }
}
