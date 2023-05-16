//
//  CharacterViewCell.swift
//  RickandMortyAppAPI
//
//  Created by Александр Полочанин on 16.05.23.
//

import UIKit

class CharacterViewCell: UICollectionViewCell {
    
    @IBOutlet var characterImage: UIImageView! 
    @IBOutlet var nameLabel: UILabel!
    
    private let networkManager = NetworkManager.shared
    
    
    func configure(with character: Character) {
        
        nameLabel.text = character.name
        
        networkManager.fetchImage(with: character.image) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.characterImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
