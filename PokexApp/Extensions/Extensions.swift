//
//  Extensions.swift
//  PokexApp
//
//  Created by Gustavo Santos on 09/01/21.
//

import Foundation
import UIKit


extension StringProtocol {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
   
}


extension UIImageView {
    
    func setImage(from url: URL) {
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
        
     
            
    }
}

