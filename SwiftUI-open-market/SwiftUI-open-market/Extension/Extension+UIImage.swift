//
//  Extension+UIImage.swift
//  SwiftUI-open-market
//
//  Created by brad on 2022/11/22.
//

import SwiftUI

extension UIImage {
    func logImageSizeInKB(scale: CGFloat) -> Int {
        let data = self.jpegData(compressionQuality: scale)!
        let formatter = ByteCountFormatter()
        
        formatter.allowedUnits = ByteCountFormatter.Units.useKB
        formatter.countStyle = ByteCountFormatter.CountStyle.file
        
        return Int(Int64(data.count) / 1024)
    }
}
