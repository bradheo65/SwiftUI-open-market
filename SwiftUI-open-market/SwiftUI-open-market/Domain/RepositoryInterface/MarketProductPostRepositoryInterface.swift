//
//  MarketProductPostRepositoryInterface.swift
//  SwiftUI-open-market
//
//  Created by brad on 2023/01/28.
//

import Foundation
import UIKit

protocol MarketProductPostRepositoryInterface {
    
    func postProduct(images: [UIImage], parameters: Data, completion: @escaping (Result<DetailProduct, Error>) -> Void)

}
