//
//  CharacterViewCell.swift
//  RickandMortyAppAPI
//
//  Created by Александр Полочанин on 15.05.23.
//

import UIKit

class CharacterViewCell: UITableViewCell {

    
    @IBOutlet var characterImage: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var speciesLabel: UILabel!
   
    private let networkManager = NetworkManager.shared
        
    func configure(with character: Character) {
        nameLabel.text = character.name
        speciesLabel.text = character.species
        
        networkManager.fetchImage(with: character.image) { [weak self] imageData in
            self?.characterImage.image = UIImage(data: imageData)
        }
        
    }


}
