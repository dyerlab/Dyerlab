//
//  Array.swift
//  MatrixKit
//
//  Created by Rodney Dyer on 2/4/18.
//  Copyright © 2018 Rodney Dyer. All rights reserved.
//

import Foundation

extension Array {
    
    public func randomElement() -> Element? {
        if isEmpty {
            return nil
        }
        let idx = Int(arc4random_uniform(UInt32(self.count)))
        return self[idx]
    }
    
}