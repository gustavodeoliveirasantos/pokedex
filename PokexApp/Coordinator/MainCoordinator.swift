//
//  MainCoordinator.swift
//  PokexApp
//
//  Created by Gustavo Santos on 09/01/21.
//

import Foundation
import UIKit


protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

public class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        
        let pokedexViewController = PokedexViewController()
      
        pokedexViewController.delegate = self

        navigationController.viewControllers = [pokedexViewController]     

    }
}

extension MainCoordinator: PokedexViewControllerDelegate {
    func PokedexViewControllerDidTappedList(viewController: PokedexViewController) {
    //    viewController.setLoading (true)
        
        let url = "https://pokeapi.co/api/v2/pokemon?limit=20&offset=0"
        
        Services.invokePokemonService(from: url, type: PokemonList.self) { (pokemonList) in
            if let list = pokemonList {
                DispatchQueue.main.async {  
                    let pokemonListViewController = PokemonListViewController(pokemonList: list)
                    pokemonListViewController.delegate = self
                    self.navigationController.pushViewController(pokemonListViewController, animated: true)
                    }
            } else {
                print("Erro")
            }
        } failureHandler: {
            print("Erro")
        }
    }
    
    
}
extension MainCoordinator:PokemonListViewControllerDelegate {
    func pokemonListViewController(didSelect pokemonDetailsUrl: String, viewController: PokemonListViewController) {
        print(pokemonDetailsUrl)
        
        Services.invokePokemonService(from: pokemonDetailsUrl, type: Pokemon.self) { (pokemon) in
            if let pokemon = pokemon {
                DispatchQueue.main.async {
                    let pokemonDetailViewController = PokemonDetailViewController(pokemon: pokemon)
                    self.navigationController.pushViewController(pokemonDetailViewController, animated: true)
                }
            }
            else {
                print("Erro")
            }
            } failureHandler: {
            print("Erro")
        }
    
    }
    
    
}
