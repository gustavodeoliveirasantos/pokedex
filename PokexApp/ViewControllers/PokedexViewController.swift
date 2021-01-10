

import UIKit
import Foundation

protocol PokedexViewControllerDelegate: AnyObject  {
    func  PokedexViewControllerDidTappedList (viewController: PokedexViewController )
}

 class PokedexViewController: UIViewController {
   
    weak var delegate: PokedexViewControllerDelegate?
   // var titleLabel = UILabel()
    var idLabel = UILabel()
    var pokemonView = UIView()
    
    
    var showListButton = UIButton ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pokedex"

        setupLayout()
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setupLayout() {        
       

        
        showListButton.setTitle("Listar Todos", for: .normal)
        showListButton.backgroundColor = UIColor.yellow
        showListButton.tintColor = .blue
        showListButton.addTarget(self, action: #selector(showPokemonList), for: .touchUpInside)
        showListButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(showListButton)
        
        
        NSLayoutConstraint.activate([
            showListButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            showListButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showListButton.heightAnchor.constraint(equalToConstant: 100),
            showListButton.widthAnchor.constraint(equalToConstant: 100),
        ])
                                         
    }
    
    
    @objc func showPokemonList(sender: UIButton!) {
        delegate?.PokedexViewControllerDidTappedList(viewController: self)        
     
    }
    
    
    
    func getPokemon () {
       // print("hello pokemon")        
      
        Services.getPokemonByName(name: "ditto") {pokemon in
            if let pokemon = pokemon {
             //   self.idLabel.text = String(pokemon.height)
            }
         
        } failureHandler: {
            print("failure")
        }

     
        
    }
}

