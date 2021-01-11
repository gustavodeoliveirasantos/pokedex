//
//  PokemonListCollectionViewCell.swift
//  PokexApp
//
//  Created by Gustavo Santos on 09/01/21.
//

import Foundation
import UIKit

class AbilityViewCell: UITableViewCell {
      
    public var isDetailHidden = true
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()
  
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout ()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout () {
        
      
       

        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false;
        
        
        descriptionLabel.textColor = UIColor.black
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 16)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false;
        
        
        
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
    
      
        NSLayoutConstraint.activate([
         
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
      
            
        ])

        
    }
    
    func updateCell (title: String,description: String ) {
       
        titleLabel.text = title
        descriptionLabel.text = description
        
        
    }

    
    

    
}
