//
//  EmployeeListEmployeeListViewController.swift
//  CleanArhitecture
//
//  Created by MSI on 03/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

class EmployeeListViewController: UITableViewController, EmployeeListViewInput {
    
    var presenter: EmployeeListPresenter!
    var sections = [EmployeeSectionModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewIsReady()
    }
    
    func updateForSections(_ sections: [EmployeeSectionModel]) {
        self.sections = sections

        tableView.reloadData()
    }
}

extension EmployeeListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: model.cellIdentifier, for: indexPath) as! EmployeeBaseCell
        cell.model = model
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(sections[indexPath.section].rows[indexPath.row].cellHeight)
    }
}
