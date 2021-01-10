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
        
        print("Carrgando dados")
        Services.getPokemonList(limit: 10, offset: 1) { (pokemonList) in
            
            
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
        self.navigationController.popViewController(animated: true)
    }
    
    
}
