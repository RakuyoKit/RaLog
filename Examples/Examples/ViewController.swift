//
//  ViewController.swift
//  RaLogExamples
//
//  Created by Rakuyo on 2020/09/02.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import UIKit
import RaLog

class ViewController: UITableViewController {
    
    /// ViewModel
    private lazy var viewModel = ViewModel()
    
    deinit {
        Log.deinit(self)
    }
}

// MARK: - The life cycle

extension ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "RaLog demo"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        Log.debug("Note the output of the console")
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Log.appear(self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        Log.disappear(self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .default }
}

// MARK: - UITableViewDelegate

extension ViewController {
    
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dataSource = viewModel.dataSource[indexPath.section].dataSource
        
        let tuple = dataSource[indexPath.row].action(indexPath)
         
        guard let controller = tuple.0 else {
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        
        if tuple.1 {
            navigationController?.pushViewController(controller, animated: true)
        } else {
            present(controller, animated: true) {
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension ViewController {
    
    open override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.dataSource[section].title
    }
    
    open override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.dataSource.count
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource[section].dataSource.count
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        let dataSource = viewModel.dataSource[indexPath.section].dataSource
        
        cell.textLabel?.text = dataSource[indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}
