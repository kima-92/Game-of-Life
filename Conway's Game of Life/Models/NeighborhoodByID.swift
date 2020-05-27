//
//  NeighborhoodByID.swift
//  Conway's Game of Life
//
//  Created by macbook on 5/27/20.
//  Copyright © 2020 WilmaRodriguez. All rights reserved.
//

import Foundation

struct NeigborhoodByID {
    
    var cells: [Int?] {
        
        let cells = [
            top,
            bottom,
            left,
            right,
            
            upperLeft,
            upperRight,
            bottomLeft,
            bottomRight
        ]
        return cells
    }
    
    var top: Int?
    var bottom: Int?
    var left: Int?
    var right: Int?
    
    var upperLeft: Int?
    var upperRight: Int?
    var bottomLeft: Int?
    var bottomRight: Int?
}
