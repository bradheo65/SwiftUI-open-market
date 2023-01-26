//
//  Cancellable.swift
//  SwiftUI-open-market
//
//  Created by brad on 2023/01/23.
//

import Foundation

protocol Cancellable {
    func cancel()
    func resume()
}

extension URLSessionDataTask: Cancellable { }
