//
//  CellController.swift
//  Conway's Game of Life
//
//  Created by macbook on 5/26/20.
//  Copyright © 2020 WilmaRodriguez. All rights reserved.
//

import Foundation
import UIKit

class CellController {
    
    // MARK: - Properties
    var cells: [Cell] = []
    var cellSize: CGFloat?
    
    var cell: Cell?
    
    // MARK: - Methods

    // Add a cell to the cells array
    func addNewCell(cell: Cell) {
        
        // When this funciton is called, this cell has NO neighborhood yet!
        
        // Add this cell to the cells array
        cells.append(cell)
    }
    
    // Fetch the neighborhood of One cell
    func getNeighborhoodFor(cell: Cell) -> Neighborhood? {
        
        guard let cellSize = cellSize else { return nil }
        
        var newNeighborhood = Neighborhood()
        
        // This cell's coordinates
        let x = cell.coordinates.x
        let y = cell.coordinates.y
        
        // Coordinates for this cell's neighborhood
        let topCoordinates = Coordinates(x: x - cellSize, y: y)
        let bottomCoordinates = Coordinates(x: x + cellSize, y: y)
        let leftCoordinates = Coordinates(x: x, y: y - cellSize)
        let rightCoordinates = Coordinates(x: x, y: y + cellSize)
        
        let upperLeftCoordinates = Coordinates(x: x - cellSize, y: y - cellSize)
        let upperRightCoordinates = Coordinates(x: x - cellSize, y: y + cellSize)
        let bottomLeftCoordinates = Coordinates(x: x + cellSize, y: y - cellSize)
        let bottomRightCoordinates = Coordinates(x: x + cellSize, y: y + cellSize)
        
        // Store correct cells in Neighborhood
        for foundCell in cells {
            
            // Vertial & Horizontal
            
            if foundCell.coordinates.x == topCoordinates.x && foundCell.coordinates.y == topCoordinates.y {
                newNeighborhood.top = topCoordinates
                //break
            }
            
            else if foundCell.coordinates.x == bottomCoordinates.x && foundCell.coordinates.y == bottomCoordinates.y {
                newNeighborhood.bottom = bottomCoordinates
                //break
            }
            
            else if foundCell.coordinates.x == leftCoordinates.x && foundCell.coordinates.y == leftCoordinates.y {
                newNeighborhood.left = leftCoordinates
                //break
            }
            
            else if foundCell.coordinates.x == rightCoordinates.x && foundCell.coordinates.y == rightCoordinates.y {
                newNeighborhood.right = rightCoordinates
                //break
            }
            
            // Diagonal
            
            else if foundCell.coordinates.x == upperLeftCoordinates.x && foundCell.coordinates.y == upperLeftCoordinates.y {
                newNeighborhood.upperLeft = upperLeftCoordinates
                //break
            }
            
            else if foundCell.coordinates.x == upperRightCoordinates.x && foundCell.coordinates.y == upperRightCoordinates.y {
                newNeighborhood.upperRight = upperRightCoordinates
                //break
            }
            
            else if foundCell.coordinates.x == bottomLeftCoordinates.x && foundCell.coordinates.y == bottomLeftCoordinates.y {
                newNeighborhood.bottomLeft = bottomLeftCoordinates
                //break
            }
            
            else if foundCell.coordinates.x == bottomRightCoordinates.x && foundCell.coordinates.y == bottomRightCoordinates.y {
                newNeighborhood.bottomRight = bottomRightCoordinates
                //break
            }
        }
        return newNeighborhood
    }
}
