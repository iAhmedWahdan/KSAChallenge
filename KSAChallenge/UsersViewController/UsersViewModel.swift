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
    
    var users = BehaviorRelay<[Users]>(value: [])
    
    func loadUsers(loadingMore: Bool, searchText: String) {
        page = loadingMore ? page + 1 : 1
        isLoadingData.accept(true)
        NetworkService.shared.getUsersList(for: searchText, page: page) { [weak self] result in
            guard let self = self else { return }
            self.isLoadingData.accept(false)
            switch result {
            case .success(let users):
                if loadingMore {
                    if users.isEmpty {
                        self.page -= 1
                    } else {
                        self.users.acceptAppending(users)
                    }
                } else {
                    self.users.accept(users)
                }
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
}
