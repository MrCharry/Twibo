//
//  SNBaseController.swift
//  Twibos
//
//  Created by 彭韬 on 17/02/2017.
//  Copyright © 2017 Charry Peng. All rights reserved.
//

import UIKit


class SNBaseController: UIViewController {

    var tableView: UITableView?
    var refreshControl: UIRefreshControl?
    // Pull up refresh flag
    var isPullUp = false
    // User logon flag
    var userLogon = false
    
    var visitorInfomation: [String: String]?
    
    
    // Custome NavigationBar
    lazy var navBar = UINavigationBar( frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64) )

    lazy var navItem = UINavigationItem()
    
    // override title's set
    override var title: String?{
        
        didSet{
            navItem.title = title
        }
    }
    
    // load data
    func loadData() {
        // If the SubClasses don't implement it, end refreshing as default
        refreshControl?.endRefreshing()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
    }

  

}

// Setup the UIInterface
extension SNBaseController {
    
    func setupUI() {
        
        // Let the view not to adjust the scroll automatically
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavigationBar()
        
        userLogon ? setupTableView():setupVisitorView()
    }
    
    func setupVisitorView() {
        
        let visitorView = SNVisitorView(frame: view.bounds)
        
        visitorView.visitorInfo = visitorInfomation
        
        view.insertSubview(visitorView, belowSubview: navBar)
        
    }
    
    fileprivate func setupNavigationBar() {
        
        // Show Custome NavigationBar
        view.addSubview(navBar)
        // Add items to NavigationBar
        navBar.items = [navItem]
        
        // Setup the barTintColor of NavigationBar
        navBar.barTintColor = UIColor.cz_color(withHex: 0xf6f6f6)
        
        // Setup the ForegroundColor of navigationBar's title
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.darkGray]
    }
    
    fileprivate func setupTableView() {
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.insertSubview(tableView!, belowSubview: navBar)
        
        tableView?.delegate = self
        tableView?.dataSource = self
        
        // tabbar's default height is '49'
        tableView?.contentInset = UIEdgeInsets(top: navBar.bounds.height, left: 0, bottom: tabBarController?.tabBar.bounds.height ?? 49, right: 0)
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
        tableView?.addSubview(refreshControl!)

        
    }
    

}

// Isolate the DataSource and Delegate
extension SNBaseController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // get the current row
        let row = indexPath.row
        // get the second last section
        let section = tableView.numberOfSections - 1
        
        if row < 0 || section < 0 {
            return
        }
        // get the row of second last section
        let rowOfSection = tableView.numberOfRows(inSection: section)
        
        if row==rowOfSection-1 && !isPullUp {
            
            print("Pull Up Refresh!")
            isPullUp = true
            // load data
            loadData()
        }
        
        
    }

}
