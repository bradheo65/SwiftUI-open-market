//
//  Extension+Double.swift
//  SwiftUI-open-market
//
//  Created by brad on 2022/12/05.
//

extension Double {
    var removeDecimal: String {
        let format = String(format: "%.f", self)
        
        return format
    }
}
