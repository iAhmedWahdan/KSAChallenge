//
//  UsersViewController.swift
//  KSAChallenge
//
//  Created by Ahmed Wahdan on 21/01/2023.
//

import UIKit
import RxSwift
import RxCocoa

class UsersViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .appBackground
        tableView.separatorStyle = .none
        tableView.register(
            UINib(nibName: UserTableViewCell.className, bundle: nil),
            forCellReuseIdentifier: UserTableViewCell.className
        )
        return tableView
    }()
    
    
     var searchController = UISearchController(searchResultsController: nil)
    
    private var searchText: String {
        searchController.searchBar.text ?? ""
    }
    
     let viewModel = UsersViewModel()
    
    private var bag = DisposeBag()
            
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Users"
        setupTableView()
        setupSearchController()
        setupViewBindings()
        reloadUsers()
    }
    
    override func loadView() {
        view = tableView
    }
    
    func reloadUsers() {
        self.searchController.searchBar.text = ""
        self.viewModel.loadUsers(loadingMore: false)
    }
    
    private func setupViewBindings() {
        self.viewModel.isLoadingData.bind { [weak self] isLoading in
            guard let self = self else { return }
            if isLoading {
                self.view.showActivityIndicator(centerOffSet: .init(horizontal: 0, vertical: -150))
            } else {
                self.view.hideActivityIndicator()
            }
        }.disposed(by: bag)
    }
    
    private func setupSearchController() {
        searchController.searchBar.searchTextField.backgroundColor = .white
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by user name Ex: Alamofire"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchBar.rx.text.orEmpty.distinctUntilChanged().bind { [weak self] text in
            guard let self = self else { return }
            self.viewModel.searchUsers(searchText: text)
        }.disposed(by: bag)
    }
  
}

extension UsersViewController {
    
    private func setupTableView() {
        viewModel.users.bind(to: tableView.rx.items(
            cellIdentifier: UserTableViewCell.className,
            cellType: UserTableViewCell.self
        )) { (index, user, cell) in
            cell.setupCell(user: user)
        }.disposed(by: bag)
        
        tableView.rx.modelSelected(Users.self).bind { [weak self] user in
            guard let self = self else { return }
            self.show(UserDetailsViewController(user: user), sender: nil)
        }.disposed(by: bag)
        
        tableView.rx.willDisplayCell.map {
            $1
        }.withLatestFrom(viewModel.users) {
            ($0, $1)
        }.filter {
            $1.count > 99 && $1.count - 1 == $0.row
        }.bind { [weak self] users, indexPath in
            guard let self = self else { return }
            self.viewModel.loadUsers(loadingMore: true)
        }.disposed(by: bag)
        
        tableView.refreshControl = UIRefreshControl.init()
        tableView.refreshControl?.rx.controlEvent(.valueChanged).bind { [weak self] index in
            guard let self = self else { return }
            self.reloadUsers()
            self.tableView.refreshControl?.endRefreshing()
        }.disposed(by: bag)
    }
}

public extension NSObject {
    var className: String {
        String(describing: type(of: self))
    }
    
    class var className: String {
        String(describing: self)
    }
}

extension BehaviorRelay where Element: RangeReplaceableCollection {
    func acceptAppending(_ element: [Element.Element]) {
        accept(value + element)
    }
}
