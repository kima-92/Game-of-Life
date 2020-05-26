//
//  Neighborhood.swift
//  Conway's Game of Life
//
//  Created by macbook on 5/26/20.
//  Copyright © 2020 WilmaRodriguez. All rights reserved.
//

import Foundation

struct Neighborhood {
    
    var top: UUID
    var bottom: UUID
    var right: UUID
    var left: UUID
    
    var upperRight: UUID
    var upperLeft: UUID
    var bottomRight: UUID
    var bottomLeft: UUID
}
