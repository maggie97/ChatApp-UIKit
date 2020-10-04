//
//  ConatctsTableViewController.swift
//  ChatApp
//
//  Created by maggie mendez on 03/10/20.
//

import UIKit

class ContactsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: IdentifiersViews.ContactCell.rawValue, bundle: nil), forCellReuseIdentifier: IdentifiersViews.ContactCell.rawValue)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IdentifiersViews.ContactCell.rawValue, for: indexPath) as? ContactItemViewCell else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "Hi"
            cell.detailTextLabel?.text = "uno"
            return cell
        }

        // Configure the cell...

        return cell
    }
    
    @IBAction func logOutClick(_ sender: Any) {
        do {
            try Authentication.instance.signOut()
            let storyboard = UIStoryboard(name: Storyboard.LoginFlow.rawValue, bundle: Bundle.main)
            if let contactList = storyboard.instantiateViewController(withIdentifier: IdentifiersViews.login.rawValue) as? RegisterViewController{
                UIApplication.shared.windows[0].rootViewController = contactList
            }
        } catch let error {
            let alertAction = UIAlertController(title: "Error", message: error.localizedDescription , preferredStyle: .alert)
            alertAction.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertAction, animated: true, completion: nil)
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
