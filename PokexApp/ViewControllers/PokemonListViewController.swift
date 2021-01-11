//
//  PokemonListCollectionViewController.swift
//  PokexApp
//
//  Created by Gustavo Santos on 09/01/21.
//

import Foundation
import UIKit

protocol PokemonListViewControllerDelegate: AnyObject { 
    func  pokemonListViewController (didSelect pokemonDetailsUrl: String, viewController: PokemonListViewController )
}

class PokemonListViewController: UIViewController {
    
    weak var delegate: PokemonListViewControllerDelegate?
    var tableView = UITableView()
    

    var pokemonList: PokemonList
        
    init (pokemonList: PokemonList) {

        self.pokemonList = pokemonList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupLayout()
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.view.backgroundColor = UIColor.yellow
      
    }
    
    func setupLayout() {
       
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PokemonListViewCell.self, forCellReuseIdentifier: "pokemonListViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        self.tableView.rowHeight = 90
        view.addSubview(tableView)
        
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        
    //    tableView.reloadData()
    }
    
    

}


extension PokemonListViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return pokemonList.results.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonListViewCell", for: indexPath)  as! PokemonListViewCell
        cell.selectionStyle = .none
        var pokemon = pokemonList.results[indexPath.row]
        
        var pokemonId = pokemon.url.replacingOccurrences(of: "https://pokeapi.co/api/v2/pokemon/", with: "")        
        pokemonId = pokemonId.replacingOccurrences(of: "/", with: "")
        
        cell.updateCell(pokemonId: pokemonId, pokemonName: pokemon.name.firstUppercased, imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonId).png")
        
        return cell
         
  
    }
    
   
}

extension PokemonListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var pokemon = pokemonList.results[indexPath.row]
        delegate?.pokemonListViewController(didSelect: pokemon.url, viewController: self)
    }
}

