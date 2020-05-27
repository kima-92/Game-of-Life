//
//  Neighborhood.swift
//  Conway's Game of Life
//
//  Created by macbook on 5/26/20.
//  Copyright © 2020 WilmaRodriguez. All rights reserved.
//

import Foundation

struct Neighborhood {
    
    var top: Coordinates?
    var bottom: Coordinates?
    var right: Coordinates?
    var left: Coordinates?
    
    var upperRight: Coordinates?
    var upperLeft: Coordinates?
    var bottomRight: Coordinates?
    var bottomLeft: Coordinates?
}
