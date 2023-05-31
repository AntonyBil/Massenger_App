//
//  UsersViewController.swift
//  Messenger
//
//  Created by apple on 25.05.2023.
//

import UIKit

class UsersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let service = Service.shared
    var users = [CurentUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: UserTableViewCell.identifire)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
  
        getUsers()
    }
    
    func getUsers() {
        service.getAllUsers { users in
            self.users = users
            self.tableView.reloadData()
        }
    }
   
}

extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifire, for: indexPath) as! UserTableViewCell
        cell.selectionStyle = .none
        let cellName = users[indexPath.row]
        cell.configCell(cellName.email)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userId = users[indexPath.row].id
        
        let vc = ChatViewController()
        vc.otherID = userId
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
