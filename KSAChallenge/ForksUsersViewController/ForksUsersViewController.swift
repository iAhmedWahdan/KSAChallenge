//
//  ForksUsersViewController.swift
//  KSAChallenge
//
//  Created by Ahmed Wahdan on 22/01/2023.
//

import UIKit
import RxSwift
import RxCocoa

class ForksUsersViewController: UIViewController {
    
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
    
    var ownerRepo: String {
        return "\(repo.owner.login)/\(repo.name)"
    }

    let repo: Repositories
    init(repo: Repositories) {
        self.repo = repo
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let viewModel = ForksUsersViewModel()
    
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Forks"
        setupTableView()
        reloadUsers()
    }
    
    override func loadView() {
        view = tableView
    }
    
    func reloadUsers() {
        self.viewModel.loadForksUsers(loadingMore: false, ownerRepo: ownerRepo)
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
}

extension ForksUsersViewController {
    
    private func setupTableView() {
        viewModel.users.bind(to: tableView.rx.items(
            cellIdentifier: UserTableViewCell.className,
            cellType: UserTableViewCell.self
        )) { (index, user, cell) in
            cell.avatarImageView.setImage(with: user.owner.avatarUrl)
            cell.nameLabel.text = user.owner.login
        }.disposed(by: bag)
        
        tableView.rx.willDisplayCell.map {
            $1
        }.withLatestFrom(viewModel.users) {
            ($0, $1)
        }.filter {
            $1.count > 99 && $1.count - 1 == $0.row
        }.bind { [weak self] users, indexPath in
            guard let self = self else { return }
            self.viewModel.loadForksUsers(loadingMore: true, ownerRepo: self.ownerRepo)
        }.disposed(by: bag)
        
        tableView.refreshControl = UIRefreshControl.init()
        tableView.refreshControl?.rx.controlEvent(.valueChanged).bind { [weak self] index in
            guard let self = self else { return }
            self.reloadUsers()
            self.tableView.refreshControl?.endRefreshing()
        }.disposed(by: bag)
    }
}
