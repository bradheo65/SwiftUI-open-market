//
//  Extension+String.swift
//  SwiftUI-open-market
//
//  Created by brad on 2022/12/02.
//

import Foundation

extension String {
    var insertComma: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(for: Double(self)) ?? self
    }
}

