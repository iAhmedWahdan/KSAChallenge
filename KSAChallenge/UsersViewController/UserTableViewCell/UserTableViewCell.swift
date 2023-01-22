//
//  UserTableViewCell.swift
//  KSAChallenge
//
//  Created by Ahmed Wahdan on 21/01/2023.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var repositoriesLabel: UILabel!
    @IBOutlet var followersLabel: UILabel!
    
    func setupCell(user: Users) {
        avatarImageView.setImage(with: user.avatarUrl)
        nameLabel.text = user.login
        //repositoriesLabel.text = "\(user.publicRepos) repositories"
        //followersLabel.text = "\(user.followers) followers" 
    }
}
