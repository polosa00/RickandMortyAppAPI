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
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var originLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var createdLabel: UILabel!
    
    
    var character: Character!
    private let networkManager = NetworkManager.shared
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = character.name
        speciesLabel.text = character.species
        genderLabel.text = character.gender
        originLabel.text = character.origin.name
        locationLabel.text = character.location.name
        createdLabel.text = character.created
        
        if character.type != "" {
            typeLabel.text = character.type
        } else {
            typeLabel.text = "-"
        }
        
        
        
        networkManager.fetchImage(with: character.image) { [weak self] imageData in
            self?.characterImage.image = UIImage(data: imageData)
        }
    }


}

