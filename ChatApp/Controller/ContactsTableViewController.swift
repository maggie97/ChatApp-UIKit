//
//  ConatctsTableViewController.swift
//  ChatApp
//
//  Created by maggie mendez on 03/10/20.
//

import UIKit

class ContactsTableViewController: UITableViewController {

    var friends: [Friend]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: IdentifiersViews.ContactCell.rawValue, bundle: nil), forCellReuseIdentifier: IdentifiersViews.ContactCell.rawValue)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewDidAppear(_ animated: Bool) {
        do {
            try DatabaseManager.instance.getFriends(onSuccess: {[weak self] (friends) in
                self?.friends = friends
                self?.tableView.reloadData()
            })
        } catch let error{
            print(error)
        }
    }

    // MARK: - Table view data source

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return  1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friends?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IdentifiersViews.ContactCell.rawValue, for: indexPath) as? ContactItemViewCell else {
            let cell = UITableViewCell()
            return cell
        }
        cell.nameFriendLabel.text = friends?[indexPath.row].userId
        cell.lastMessageLabel.text = friends?[indexPath.row].lastMessageId
        cell.setup(idLastMessage: friends?[indexPath.row].lastMessageId)

        return cell
    }
    
    @IBAction func logOutClick(_ sender: Any) {
        do {
            try Authentication.instance.signOut()
            let storyboard = UIStoryboard(name: Storyboard.LoginFlow.rawValue, bundle: Bundle.main)
            if let contactList = storyboard.instantiateViewController(withIdentifier: IdentifiersViews.login.rawValue) as? LoginViewController{
                UIApplication.shared.windows[0].rootViewController = contactList
            }
        } catch let error {
            let alertAction = UIAlertController(title: "Error", message: error.localizedDescription , preferredStyle: .alert)
            alertAction.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertAction, animated: true, completion: nil)
        }
    }
    

}
