//
//  RepositoryTableViewCell.swift
//  KSAChallenge
//
//  Created by Ahmed Wahdan on 22/01/2023.
//

import UIKit
import RxSwift
import RxCocoa

class RepositoryTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionStackView: UIStackView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var licenseLabel: UILabel!
    @IBOutlet var licenseStackView: UIStackView!
    @IBOutlet var forksCountButton: UIButton!
    
    private var bag = DisposeBag()
    
    var viewForksHandler: (() -> Void)?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupButtonBinding()
    }
    
    
    func setupButtonBinding() {
        forksCountButton.rx.tap.bind { [weak self] in
            guard let self = self else { return }
            self.viewForksHandler?()
        }.disposed(by: bag)
    }
    
    func setupCell(repository: Repositories) {
        nameLabel.text = repository.name
        let description = repository.description ?? ""
        descriptionStackView.isHidden = description.isEmpty
        descriptionLabel.text = repository.description
        forksCountButton.setTitle("Forks Count ( \(repository.forks) )", for: .normal)
        guard let license = repository.license else {
            licenseStackView.isHidden = true
            return
        }
        licenseLabel.text = ["License", license.name].joined(separator: " ")
    }
    
}
