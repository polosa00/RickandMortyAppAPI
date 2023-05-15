//
//  CharacterListViewController.swift
//  RickandMortyAppAPI
//
//  Created by Александр Полочанин on 15.05.23.
//

import UIKit

class CharacterListViewController: UITableViewController {

    private var rickAndMorty: RickAndMorty?
    private let networkManager = NetworkManager.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRickAndMorty()
       
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rickAndMorty?.results.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chracterCell", for: indexPath)
        guard let cell = cell as? CharacterViewCell else { return UITableViewCell() }
        let character = (rickAndMorty?.results[indexPath.row])!
        cell.configure(with: character)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110
    }
    


    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        guard let chracterVC = segue.destination as? CharacterViewController else { return }
        chracterVC.character = rickAndMorty?.results[indexPath.row]
    }
    

}

extension CharacterListViewController {
    func fetchRickAndMorty() {
        networkManager.fetchRickAndMortyData(with: Link.urlRickAndMorty.url) { [weak self] result in
            switch result {
            case .success(let rickAndMorty):
                self?.rickAndMorty = rickAndMorty
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
