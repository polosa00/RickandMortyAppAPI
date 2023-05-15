//
//  ViewController.swift
//  RickandMortyAppAPI
//
//  Created by Александр Полочанин on 15.05.23.
//

import UIKit

class CharacterViewController: UIViewController {

    @IBOutlet var characterImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var speciesLabel: UILabel!
    
    var character: Character!
    private let networkManager = NetworkManager.shared
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = character.name
        speciesLabel.text = character.species
        
        networkManager.fetchImage(with: character.image) { [weak self] imageData in
            self?.characterImage.image = UIImage(data: imageData)
        }
    }


}

