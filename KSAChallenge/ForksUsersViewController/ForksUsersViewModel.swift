//
//  ForksUsersViewModel.swift
//  KSAChallenge
//
//  Created by Ahmed Wahdan on 22/01/2023.
//

import Foundation
import RxSwift
import RxRelay

class ForksUsersViewModel {
    
    private let bag = DisposeBag()
    
    private var page = 1
    let isLoadingData = BehaviorRelay(value: false)
    
    var users = BehaviorRelay<[ForksUsers]>(value: [])
    
    func loadForksUsers(loadingMore: Bool, ownerRepo: String) {
        page = loadingMore ? page + 1 : 1
        isLoadingData.accept(true)
        NetworkService.shared.getForksUsersList(for: ownerRepo, page: page) { [weak self] result in
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
                self.page -= 1
                DispatchQueue.main.async {
                    ToastHelper.showAlert(WithMessage: error.localizedDescription) {
                        self.loadForksUsers(loadingMore: loadingMore, ownerRepo: ownerRepo)
                    }
                }
            }
        }
    }
    
}
