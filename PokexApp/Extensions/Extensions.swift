//
//  Extensions.swift
//  PokexApp
//
//  Created by Gustavo Santos on 09/01/21.
//

import Foundation


extension StringProtocol {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
   
}

