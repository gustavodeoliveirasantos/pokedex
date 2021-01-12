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

extension UIViewController {
   // let alert: UIAlertController?
   
    
    func setLoading (_ isLoading: Bool) {
        if isLoading {
            
       let alert = UIAlertController(title: nil, message: "loading...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        }
        else {
            dismiss(animated: false, completion: nil)
        }
      
    }
    
    
   
    

    
}


