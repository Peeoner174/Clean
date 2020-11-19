//
//  EmployeeListEmployeeListViewController.swift
//  CleanArhitecture
//
//  Created by MSI on 03/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

class EmployeeListViewController: UITableViewController, EmployeeListViewInput, ExpandablePopoverViewController {
    var presenter: EmployeeListPresenter!
    var sections = [EmployeeSectionModel]()
    weak var popoverDelegate: PopoverViewControllerDelegate?
    var expandingScrollView: UIScrollView {
        tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewIsReady()
        popoverDelegate?.observe(scrollView: tableView)
    }
    
    func updateForSections(_ sections: [EmployeeSectionModel]) {
        self.sections = sections

        tableView.reloadData()
    }
    
    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            sections[indexPath.section].rows.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            preferredContentSize = tableView.contentSize
        }
    }
}

protocol ExpandablePopoverViewController: UIViewController {
    var popoverDelegate: PopoverViewControllerDelegate? { get set }
    var expandingScrollView: UIScrollView { get }
}

protocol PopoverViewControllerDelegate: class {
    func observe(scrollView: UIScrollView?)
}

