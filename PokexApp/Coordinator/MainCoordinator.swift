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
        pokedexViewController.view.backgroundColor = UIColor.red
        navigationController.viewControllers = [pokedexViewController]     

    }
}

extension MainCoordinator: PokedexViewControllerDelegate {
    func PokedexViewControllerDidTappedList(viewController: PokedexViewController) {
        
     
    //    viewController.setLoading (true)
        Services.getPokemonList(limit: 20, offset: 0) { (pokemonList) in
            if let list = pokemonList {
                DispatchQueue.main.async {
        //            viewController.setLoading (false)
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
        
        Services.getPokemonDetail(from: pokemonDetailsUrl) { (pokemon) in
      
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
