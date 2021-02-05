//
//  TripAdressesViewController.swift
//  CleanArhitecture
//
//  Created by Pavel Kochenda on 22.12.2020.
//  Copyright © 2020 IA. All rights reserved.
//

import UIKit

class TripAdressesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var tableViewCellsModel = [AddressModel]()
//    (1...5)
//        .map { AddressModel(address: "Тернопольская 6, кв. \($0)", number: $0) } {
//        didSet {
//            self.tableView.reloadData()
//        }
//    }
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        
    }
    
    var tableViewHeight: CGFloat {
        get {
            CGFloat(tableViewCellsModel.count * 50)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
    }
    
    func setupViews() {
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        tableView.isScrollEnabled = false
    }
    
    deinit {
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.transitioningDelegate = nil
        super.viewDidDisappear(animated)
        
        
        
//        dismiss(animated: false, completion: nil)
    }
}

extension TripAdressesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewCellsModel.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let addressModel = tableViewCellsModel[indexPath.row]
        let cell = tableView.dequeueReusableCell(AddressCell.self, forIndexPath: indexPath)!

        cell.configure(model: addressModel, forIndexPath: indexPath) { [unowned self] in
            self.tableViewCellsModel.remove(at: indexPath.row)
            self.tableView.reloadData()
            UIView.animate(withDuration: 0.3) { [unowned self] in
                self.view.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.height - self.tableViewHeight, width: UIScreen.main.bounds.width, height: self.tableViewHeight)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = tableViewCellsModel.remove(at: sourceIndexPath.row)
        tableViewCellsModel.insert(item, at: destinationIndexPath.row)
    }
}

extension TripAdressesViewController: UITableViewDelegate {
    
}

extension TripAdressesViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
}

extension TripAdressesViewController: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {

      if session.localDragSession != nil {
        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
      }
      return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
    }
}

extension TripAdressesViewController: ExpandablePopoverViewController {
    var scrollViewObserver: PopoverViewControllerScrollViewObserver? {
        get {
            return nil
        }
        set {
        }
    }
    
    var frameObserver: PopoverViewControllerFrameObserver? {
        get {
            return nil
        }
        set {
        }
    }
    
    var expandingScrollView: UIScrollView {
        return tableView
    }
}
