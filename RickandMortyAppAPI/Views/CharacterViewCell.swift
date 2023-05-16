//
//  CharacterViewCell.swift
//  RickandMortyAppAPI
//
//  Created by Александр Полочанин on 16.05.23.
//

import UIKit
import Kingfisher

class CharacterViewCell: UICollectionViewCell {
    
    @IBOutlet var characterImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    private let networkManager = NetworkManager.shared
    
    
    func configure(with character: Character) {
        nameLabel.text = character.name
        let imageURL = URL(string: character.image)
        let processor = DownsamplingImageProcessor(size: characterImage.bounds.size)
        characterImage.kf.indicatorType = .activity
        characterImage.kf.setImage(
            with: imageURL,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage
            ]
        ) { result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.lastPathComponent ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        
//        networkManager.fetchImage(with: character.image) { [weak self] result in
//            switch result {
//            case .success(let imageData):
//                self?.characterImage.image = UIImage(data: imageData)
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
}
