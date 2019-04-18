//
//  CheckOutAgreementViewController.swift
//  TUCommunicationCheckoutSystem
//
//  Created by Michael Bryce on 4/18/19.
//  Copyright © 2019 CheckoutGurus. All rights reserved.
//

import UIKit
import Firebase

class CheckOutAgreementViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let kitsRef = Database.database().reference(withPath: "kits")
    let usersRef = Database.database().reference(withPath: "users")
    var actionKit:Kit? = nil
    var itemsFound = [Bool]()
    var fees = 0
    @IBOutlet weak var EquipmentList: UITableView!
    
    @IBOutlet weak var CheckoutDateLabel: UILabel!
    
    @IBOutlet weak var equipmentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EquipmentList.delegate = self
        EquipmentList.dataSource = self
        equipmentLabel.text = "Equipment: Kit " + (actionKit?.kitNumber ?? "0")
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfItems = actionKit?.items.count ?? 0
        return numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? CheckItemsTableViewCell else { fatalError("The dequeued cell is not an instance of InventoryTableViewCell")
        }
        let currentItem = actionKit?.items[indexPath.row] ?? "error"
        let present = itemsFound[indexPath.row]
        //if present == false{
        //    cell.
        //}
        cell.setLabels(found: present, Name: currentItem)
        return cell
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