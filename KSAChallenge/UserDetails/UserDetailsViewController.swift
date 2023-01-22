//
//  UserDetailsViewController.swift
//  KSAChallenge
//
//  Created by Ahmed Wahdan on 21/01/2023.
//

import UIKit
import RxSwift
import RxCocoa

class UserDetailsViewController: UIViewController {
    
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var repositoriesLabel: UILabel!
    @IBOutlet var followersLabel: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
    var viewModel = UserDetailsViewModel()
    
    let user: Users
    init(user: Users) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        self.viewModel.loadUsers(username: user.login)
        setupViewBindings()
        setupTableView()
    }

    private func setupViewBindings() {
        self.viewModel.isLoadingData.bind { [weak self] isLoading in
            guard let self = self else { return }
            if isLoading {
                self.view.showActivityIndicator()
            } else {
                self.view.hideActivityIndicator()
            }
        }.disposed(by: bag)
        
        self.viewModel.user.bind { [weak self] info in
            guard let self = self else { return }
            guard let user = info else { return }
            DispatchQueue.main.async {
                self.avatarImageView.setImage(with: user.avatarUrl)
                self.nameLabel.text = user.login
                self.repositoriesLabel.text = "\(user.publicRepos) repositories"
                self.followersLabel.text = "\(user.followers) followers"
            }
        }.disposed(by: bag)
        
        viewModel.loadRepositories(loadingMore: false, username: user.login)
    }
    
}

extension UserDetailsViewController {
    
    private func setupTableView() {
        tableView.register(
            UINib(nibName: RepositoryTableViewCell.className, bundle: nil),
            forCellReuseIdentifier: RepositoryTableViewCell.className
        )
        
        viewModel.repositories.bind(to: tableView.rx.items(
            cellIdentifier: RepositoryTableViewCell.className,
            cellType: RepositoryTableViewCell.self
        )) { (index, repository, cell) in
            cell.setupCell(repository: repository)
        }.disposed(by: bag)

        tableView.rx.modelSelected(Repositories.self).bind { [weak self] user in
            guard let self = self else { return }
            
            
        }.disposed(by: bag)

        tableView.rx.willDisplayCell.map {
            $1
        }.withLatestFrom(viewModel.repositories) {
            ($0, $1)
        }.filter {
            $1.count > 99 && $1.count - 1 == $0.row
        }.bind { [weak self] users, indexPath in
            guard let self = self else { return }
            self.viewModel.loadUsers(loadingMore: true, username: self.user.login)
        }.disposed(by: bag)
        
        tableView.refreshControl = UIRefreshControl.init()
        tableView.refreshControl?.rx.controlEvent(.valueChanged).bind { [weak self] index in
            guard let self = self else { return }
            self.viewModel.loadUsers(username: user.login)
            self.tableView.refreshControl?.endRefreshing()
        }.disposed(by: bag)
    }
}
