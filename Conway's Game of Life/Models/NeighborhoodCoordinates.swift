//
//  NeighborhoodCoordinates.swift
//  Conway's Game of Life
//
//  Created by macbook on 5/27/20.
//  Copyright © 2020 WilmaRodriguez. All rights reserved.
//

import Foundation

struct NeighborhoodCoordinates {
    
    var cellsCoordinates: [Coordinates?] {
        
        let cells = [
            topCellCoordinates,
            bottomCellCoordinates,
            leftCellCoordinates,
            rightCellCoordinates,
            
            upperLeftCellCoordinates,
            upperRightCellCoordinates,
            bottomLeftCellCoordinates,
            bottomRightCellCoordinates
        ]
        return cells
    }
    
    var topCellCoordinates: Coordinates?
    var bottomCellCoordinates: Coordinates?
    var leftCellCoordinates: Coordinates?
    var rightCellCoordinates: Coordinates?
    
    var upperLeftCellCoordinates: Coordinates?
    var upperRightCellCoordinates: Coordinates?
    var bottomLeftCellCoordinates: Coordinates?
    var bottomRightCellCoordinates: Coordinates?
}
