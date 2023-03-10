//
//  UsersViewModel.swift
//  KSAChallenge
//
//  Created by Ahmed Wahdan on 21/01/2023.
//

import Foundation
import RxSwift
import RxRelay

class UsersViewModel {
    
    private let bag = DisposeBag()
    
    private var page = 1
    let isLoadingData = BehaviorRelay(value: false)
    
    var allUsers = BehaviorRelay<[Users]>(value: [])
    
    var users = BehaviorRelay<[Users]>(value: [])
        
    func loadUsers(loadingMore: Bool) {
        page = loadingMore ? page + 1 : 1
        isLoadingData.accept(true)
        NetworkService.shared.getUsersList(page: page) { [weak self] result in
            guard let self = self else { return }
            self.isLoadingData.accept(false)
            switch result {
            case .success(let users):
                if loadingMore {
                    if users.isEmpty {
                        self.page -= 1
                    } else {
                        self.allUsers.acceptAppending(users)
                        self.users.acceptAppending(users)
                    }
                } else {
                    self.allUsers.accept(users)
                    self.users.accept(users)
                }
            case .failure(let error):
                self.page -= 1
                DispatchQueue.main.async {
                    ToastHelper.showAlert(WithMessage: error.localizedDescription) {
                        self.loadUsers(loadingMore: loadingMore)
                    }
                }
            }
        }
    }
    
    
    func searchUsers(searchText: String) {
        let users = self.allUsers.value.filter ({$0.login.lowercased().contains( searchText.lowercased())})
        self.users.accept(users)
    }
    
}
