//
//  EmployeeListEmployeeListViewController.swift
//  CleanArhitecture
//
//  Created by MSI on 03/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

protocol PopoverViewControllerScrollViewObserver: class {
    func observe(scrollView: UIScrollView?)
}

protocol PopoverViewControllerFrameObserver: class {
    var onPopoverViewControllerChangeFrameHandler: ((CGRect) -> Void)? { get set }
}

protocol ExpandablePopoverViewController: UIViewController {
    var scrollViewObserver: PopoverViewControllerScrollViewObserver? { get set }
    var frameObserver: PopoverViewControllerFrameObserver? { get set }
    var expandingScrollView: UIScrollView { get }
}

class EmployeeListViewController: UITableViewController, EmployeeListViewInput, ExpandablePopoverViewController {
    var presenter: EmployeeListPresenter!
    var sections = [EmployeeSectionModel]()
    
    weak var frameObserver: PopoverViewControllerFrameObserver?
    private var viewFrameChangedObserver: NSKeyValueObservation?
    
    weak var scrollViewObserver: PopoverViewControllerScrollViewObserver?
    var expandingScrollView: UIScrollView {
        tableView
    }
    
    deinit {
        viewFrameChangedObserver?.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewIsReady()
        
        scrollViewObserver?.observe(scrollView: tableView)
        
        viewFrameChangedObserver?.invalidate()
        viewFrameChangedObserver = self.view.observe(\.frame, options: .old) { [weak self] (view, change) in
            guard let self = self else { return }
            self.frameObserver?.onPopoverViewControllerChangeFrameHandler?(self.view.frame)
        }
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


