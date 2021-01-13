

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

    var pikachuImageView = UIImageView()
    
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
        self.view.backgroundColor = .red
        
        
        pikachuImageView.translatesAutoresizingMaskIntoConstraints = false
  
        pikachuImageView.image = UIImage(named:"pikachuImage")
        
        showListButton.setTitle("List", for: .normal)
        showListButton.setTitleColor(.black, for: .normal)       
        showListButton.backgroundColor = UIColor.yellow
        showListButton.addTarget(self, action: #selector(showPokemonList), for: .touchUpInside)
        showListButton.translatesAutoresizingMaskIntoConstraints = false

        showListButton.layer.cornerRadius = 60
        showListButton.layer.shadowColor = UIColor.black.cgColor
        showListButton.layer.shadowOpacity = 0.7
        showListButton.layer.shadowOffset = .zero
        showListButton.layer.shadowRadius = 5

        
   
        view.addSubview(showListButton)
        view.addSubview(pikachuImageView)
        
        
        
        NSLayoutConstraint.activate([
            
            showListButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            showListButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            showListButton.heightAnchor.constraint(equalToConstant: 120),
            showListButton.widthAnchor.constraint(equalToConstant: 120),
            
            pikachuImageView.leftAnchor.constraint(equalTo: showListButton.rightAnchor, constant: 20),
            pikachuImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pikachuImageView.heightAnchor.constraint(equalToConstant: 150),
            pikachuImageView.widthAnchor.constraint(equalToConstant: 150),
        ])
                                         
    }
    
    
    @objc func showPokemonList(sender: UIButton!) {
        
        UIView.animate(withDuration: 0.1) {
            self.showListButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
          
        } completion: { (_) in
            UIView.animate(withDuration: 0.1) {
                     self.showListButton.transform = CGAffineTransform.identity
               }
            self.delegate?.PokedexViewControllerDidTappedList(viewController: self)
        }

      
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

