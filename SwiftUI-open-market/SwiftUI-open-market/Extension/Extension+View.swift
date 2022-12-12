//
//  Extension+View.swift
//  SwiftUI-open-market
//
//  Created by brad on 2022/12/12.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
