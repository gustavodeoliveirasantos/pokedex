//
//  PokemonSizeView.swift
//  PokexApp
//
//  Created by Gustavo Santos on 10/01/21.
//

import Foundation
import UIKit

class PokemonSizeView: UIView {
    
    var titleLabel = UILabel()
    var valueLabel = UILabel()
    
    init (title: String, value: String) {     
        
        
        super.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        titleLabel.text = title
        valueLabel.text = value
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setupLayout() {
       
      
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        
        
        addSubview(titleLabel)
        addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            
    
          //  self.widthAnchor.constraint(equalToConstant: 50),
       //     self.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            valueLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
         //   valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        
        ])
        
        
    }
    
    
    
}
