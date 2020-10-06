//
//  UsersTableViewController.swift
//  ChatApp
//
//  Created by maggie mendez on 05/10/20.
//

import UIKit

class UsersTableViewController: UITableViewController {
    var filteredData: [User] = []
    var selectUser: User?
    @IBOutlet weak var searchBaer: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.register(UINib(nibName: IdentifiersViews.UserEmailCell.rawValue, bundle: nil), forCellReuseIdentifier: IdentifiersViews.UserEmailCell.rawValue)
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: IdentifiersViews.UserEmailCell.rawValue)
        DatabaseManager.instance.getUsers {[weak self] (users) in
            self?.filteredData = users
            self?.tableView.reloadData()
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func doneClick(_ sender: UIBarButtonItem) {
        do{
            try DatabaseManager.instance.addFriend(Friend(selectUser?.email ?? "", "nil")) { (added) in
                print("Elemento \(added ? "si": "no") añadido")
                self.dismiss(animated: true, completion: nil)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    // MARK: - Table view data source

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return  1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredData.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectUser = filteredData[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IdentifiersViews.UserEmailCell.rawValue, for: indexPath)
        
        cell.textLabel?.text = filteredData[indexPath.row].email

        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}

extension UsersTableViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //filteredData = []
        //DatabaseManager.instance.getUsers()
    }
}
