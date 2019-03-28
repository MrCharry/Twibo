//
//  SNHomeController.swift
//  Twibos
//
//  Created by 彭韬 on 17/02/2017.
//  Copyright © 2017 Charry Peng. All rights reserved.
//


import UIKit

fileprivate let cellId = "cellId"

class SNHomeController: SNBaseController {

    fileprivate lazy var testList = [String]()
    
    override func loadData() {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) { 
            
            print("Load start!")
            
            for i in 0..<15 {
            
                if self.isPullUp {
                    self.testList.append("PullUp\(i)")
                }else {
                    self.testList.insert(i.description, at: 0)
                }
            }
            
            print("Refresh data")
            // Stop freshing
            self.refreshControl?.endRefreshing()
            
            // Reset the flag of Pullup
            self.isPullUp = false
            // Refresh start
            self.tableView?.reloadData()
        }
        
    }
    
    @objc fileprivate func showFriends() {
        
        let demoVC = SNDemoController()
      //  demoVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(demoVC, animated: true)

        
    }

}

extension SNHomeController {
    
    override func setupUI() {
        super.setupUI()
        
       // navigationItem.leftBarButtonItem = UIBarButtonItem( title: "Friends", style: .plain, target: self, action: #selector(showFriends) )
        navItem.leftBarButtonItem = UIBarButtonItem( title: "Friends", target: self, action: #selector(showFriends) )
        
        // Register the prototype cell
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
}

// Implement dataSource and delegate
extension SNHomeController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // setup cell
        let cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        
        // bind the data with cell
        cell.textLabel?.text = testList[indexPath.row]
        
        // return cell
        return cell
        
    }
}
