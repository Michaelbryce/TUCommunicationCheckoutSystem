//
//  CheckinoutViewController.swift
//  TUCommunicationCheckoutSystem
//
//  Created by Suarez IPhone on 3/24/19.
//  Copyright © 2019 CheckoutGurus. All rights reserved.
//

import UIKit
import Firebase

protocol checkKitSelectionDelegate:class {
    func checkKitItems(_ checkKit: Kit)
}

class CheckinoutViewController: UIViewController {
    
    let ref = Database.database().reference(withPath: "kits")
    weak var passingDelegate:checkKitSelectionDelegate?
    var kits = [Kit]()
    var kitToCheck:Kit? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.observe(.value, with: { snapshot in
            var newKits: [Kit] = []
            for child in snapshot.children {
                print(child)
                if let snapshot2 = child as? DataSnapshot{
                    if let newKit = Kit(snapshot: snapshot2){
                        newKits.append(newKit)
                    }
                }
            }
            
            self.kits = newKits
            print("kits successfully initalized")
            
        })
        //ConnectUGrokit()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    //Button Functionality
    
    @IBAction func manualKitEntry(_ sender: Any) {
        let alert = UIAlertController(title: "Check Kit",
                                      message: "Please enter the kit identification number",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            // 1
            guard let textField = alert.textFields?.first,      
                let newkitNumber = textField.text else { return }
            //print(self.kits)
            //print("here part 2")
            //print(newkitNumber)
            for i in self.kits{
                //print(testKit, "compared with ", i.kitNumber)
                if newkitNumber == i.kitNumber{
                    self.passingDelegate?.checkKitItems(i)
                    //let checkItems = CheckItemsViewController()
                    //self.present(checkItems,animated: true, completion: nil)
                    
                }
            }
            self.ThrowError(reason: "That kit number does not exist")
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }

    @IBAction func Back(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    //Transition to Kit Item Check
    func transitToItemCheck(kitToCheck:Kit){
        
    }
    
    // U Grokit Functionality
    func ConnectUGrokit(){
        var inven: Array<String> = []
        let i: Int = 0
        Ugi.singleton().openConnection()
        
        //    let inventory = Ugi.singleton().startInventory(self as! UgiInventoryDelegate, with:UgiRfidConfiguration.config(withInventoryType: UgiInventoryTypes.UGI_INVENTORY_TYPE_LOCATE_DISTANCE))
        
        Ugi.singleton().activeInventory?.stop {
            // Code to run when inventory is stopped
        }
        
        Ugi.singleton().closeConnection()
        Ugi.singleton().activeInventory?.tags.forEach { (tag) in
            inven[i] = getkitnum(help: tag)
        }
        
        // Do any additional setup after loading the view.
    }
    
    func getkitnum(help:UgiTag) -> String{
        // var helped = String(help)
        var helped = help.hfName
        print(helped)
        var i = helped.count
        i=i-1
        while(i>6){
            helped.removeFirst()
            i=i-1
        }
        // helped = helped.replacingOccurrences(of: "0", with: "", options: NSString.CompareOptions.literal, range: nil)
        print(helped)
        return helped
    }
    
    // Extra Functions
    func checkForValidKitNumber(testKit:String) -> Bool{
        print("here")
        for i in self.kits{
            //print(testKit, "compared with ", i.kitNumber)
            if testKit == i.kitNumber{
                
                return true
            }
        }
        print("what the fuck is happening")
        ThrowError(reason: "That kit number does not exist")
        return false
    }
    
    func ThrowError(reason:String) {
        let alert = UIAlertController(title: "Invaild Kit",
                                      message: reason,
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

