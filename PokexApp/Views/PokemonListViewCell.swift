//
//  PokemonListCollectionViewCell.swift
//  PokexApp
//
//  Created by Gustavo Santos on 09/01/21.
//

import Foundation
import UIKit

class PokemonListViewCell: UITableViewCell {
    
    var mainView =  UIView ()
    var pokemonImageView = UIImageView()
    var pokemonNameLabel = UILabel()
  
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout ()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout () {
        
        mainView.layer.cornerRadius = 5
      //  mainView.layer.borderWidth = 0.5
      //  mainView.layer.borderColor = UIColor.gray.cgColor
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowOpacity = 0.3
        mainView.layer.shadowOffset = .zero
        mainView.layer.shadowRadius = 5
        
        
        mainView.backgroundColor = UIColor.white
        mainView.translatesAutoresizingMaskIntoConstraints = false;
        pokemonImageView.translatesAutoresizingMaskIntoConstraints = false;

        pokemonNameLabel.textColor = UIColor.black
        pokemonNameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        pokemonNameLabel.translatesAutoresizingMaskIntoConstraints = false;
        
        contentView.addSubview(mainView)
        mainView.addSubview(pokemonImageView)
        mainView.addSubview(pokemonNameLabel)
      
        NSLayoutConstraint.activate([
         
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            mainView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),         
      
            
            pokemonImageView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10),
            pokemonImageView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 10),
            pokemonImageView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 50),
            
            
            pokemonNameLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10),
            pokemonNameLabel.leftAnchor.constraint(equalTo: pokemonImageView.rightAnchor, constant: 10),
            pokemonNameLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -10),
            pokemonNameLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10),
        ])

        
    }
    
    func updateCell (pokemonId: String,pokemonName: String, imageUrl: String ) {
                
        let url = URL(string: imageUrl)
       
        let data = try? Data(contentsOf: url!)
        DispatchQueue.main.async {
            self.pokemonImageView.image = UIImage(data: data!)
        }
        
        pokemonNameLabel.text = "\(pokemonId) - \(pokemonName)"
        
        
    }
    
    
    

    
}
