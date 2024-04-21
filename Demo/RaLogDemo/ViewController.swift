//
//  ViewController.swift
//  RaLogDemo
//
//  Created by Rakuyo on 2020/9/2.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import RaLog
import UIKit

// MARK: - ViewController

class ViewController: UITableViewController {
    /// ViewModel
    private lazy var viewModel = ViewModel()
    
    deinit {
        Log.deinit(self)
    }
}

// MARK: - The life cycle

extension ViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle { .default }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "RaLog demo"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        Log.debug("Note the output of the console")
    }
    
    override open func viewWillAppear(_ animated: Bool) {
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
}

// MARK: - UITableViewDelegate

extension ViewController {
    
    override open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    
    override open func tableView(_: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.dataSource[section].title
    }
    
    override open func numberOfSections(in _: UITableView) -> Int {
        viewModel.dataSource.count
    }
    
    override open func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.dataSource[section].dataSource.count
    }
    
    override open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        let dataSource = viewModel.dataSource[indexPath.section].dataSource
        
        cell.textLabel?.text = dataSource[indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}
