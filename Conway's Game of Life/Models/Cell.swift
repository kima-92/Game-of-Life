//
//  Cell.swift
//  Conway's Game of Life
//
//  Created by macbook on 5/26/20.
//  Copyright © 2020 WilmaRodriguez. All rights reserved.
//

import Foundation
import UIKit

struct Cell {
    var indexID: Int
    var coordinates: Coordinates
    var state: CellState
    var neighborhoodByID: NeighborhoodCoordinates?
    var rect: CGRect
    var alpha: CGFloat
}
