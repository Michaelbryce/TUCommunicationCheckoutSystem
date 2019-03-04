//
//  MasterManageInventoryViewController.swift
//  TUCommunicationCheckoutSystem
//
//  Created by Michael Bryce on 2/28/19.
//  Copyright © 2019 CheckoutGurus. All rights reserved.
//

import UIKit

class MasterManageInventoryViewController: UISplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self as? UISplitViewControllerDelegate
        self.preferredDisplayMode = .allVisible
        guard let leftNavController = splitViewController?.viewControllers.first as? UINavigationController,
            let InventoryTableView = leftNavController.topViewController as? InventoryTableViewController,
            let detailViewController = splitViewController?.viewControllers.last as? KitDetailsViewController
            else{
                fatalError()
        }
        let firstKit = InventoryTableView.kits.first
        detailViewController.kitOfInterest = firstKit ?? Kit(kitName: "Error", items: [0,0,0,0,0,0], checkIn: Date() as NSDate, checkOut: Date()as NSDate, lastUsers: [], available: false)!

        // Do any additional setup after loading the view.
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
