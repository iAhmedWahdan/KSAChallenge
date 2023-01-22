//
//  UserDetailsViewModel.swift
//  KSAChallenge
//
//  Created by Ahmed Wahdan on 21/01/2023.
//


import Foundation
import RxSwift
import RxRelay

class UserDetailsViewModel {
    
    private let bag = DisposeBag()
    
    private var page = 1
    let isLoadingData = BehaviorRelay(value: false)
    
    var user = BehaviorRelay<User?>(value: nil)
    
    var repositories = BehaviorRelay<[Repositories]>(value: [])
    
    func loadUsers(username: String) {
        isLoadingData.accept(true)
        NetworkService.shared.getUser(for: username) { [weak self] result in
            guard let self = self else { return }
            self.isLoadingData.accept(false)
            switch result {
            case .success(let user):
                self.user.accept(user)
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    func loadRepositories(loadingMore: Bool, username: String) {
        page = loadingMore ? page + 1 : 1
        isLoadingData.accept(true)
        NetworkService.shared.getRepositoriesList(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            self.isLoadingData.accept(false)
            switch result {
            case .success(let repositories):
                if loadingMore {
                    if repositories.isEmpty {
                        self.page -= 1
                    } else {
                        self.repositories.acceptAppending(repositories)
                    }
                } else {
                    self.repositories.accept(repositories)
                }
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
}

