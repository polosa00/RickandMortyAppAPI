//
//  ViewController.swift
//  RickandMortyAppAPI
//
//  Created by Александр Полочанин on 15.05.23.
//

import UIKit
import Kingfisher

class CharacterViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var speciesLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var originLabel: UILabel!
    @IBOutlet var createdLabel: UILabel!
    
    var character:Character!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = character.name
        statusLabel.text = character.status
        speciesLabel.text = character.species
        genderLabel.text = character.gender
        locationLabel.text = character.location.name
        originLabel.text = character.origin.name
        createdLabel.text = character.created
        
        let imageURL = URL(string: character.image)
        let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
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
    }


}

