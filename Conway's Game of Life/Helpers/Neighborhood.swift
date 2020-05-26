//
//  Neighborhood.swift
//  Conway's Game of Life
//
//  Created by macbook on 5/26/20.
//  Copyright © 2020 WilmaRodriguez. All rights reserved.
//

import Foundation

struct Neighborhood {
    
    var top: Cell
    var bottom: Cell
    var right: Cell
    var left: Cell
    
    var upperRight: Cell
    var upperLeft: Cell
    var bottomRight: Cell
    var bottomLeft: Cell
}
