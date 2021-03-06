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
    var minAlpha: CGFloat = 0.2
    var maxAlpha: CGFloat = 1.5
    
    var cell: Cell?
    var startedTimer: Bool = false
    var shouldGameRunOnce: Bool = false
    
    var rects: [CGRect] {
        let rects = cells.compactMap({ $0.rect })
        
        return rects
    }
    
    // MARK: - Methods
    
    // Set for when the game starts using the timer
    func setDidStartGame(to bool: Bool) {
        if bool != startedTimer {
            startedTimer = bool
        }
    }
    
    // Set when the game should only change by one generation
    func setShouldGameRunOnce(to bool: Bool) {
        if bool != shouldGameRunOnce {
            shouldGameRunOnce = bool
        }
    }

    // Add a cell to the cells array
    func addNewCell(cell: Cell) {
        // When this funciton is called, this cell has NO neighborhood yet!

        cells.append(cell)
    }
    
    // Set all cells to dead
    func setCellsToDead() {
        for cell in cells {
            let id = cell.indexID
            cells[id].state = .dead
        }
    }
    
    // sum up cell alpha by one if possible
    func sumUpCellAlpha(id: Int) {
        
        let alpha = cells[id].alpha
        
        if alpha >= minAlpha && alpha <= maxAlpha {
            cells[id].alpha += 0.1
        }
    }
    
    // sum down the cell alpha by one if possible
    func sumDownCellAlpha(id: Int) {
        
        let alpha = cells[id].alpha
        
        if alpha >= minAlpha && alpha <= maxAlpha {
            cells[id].alpha -= 0.1
        }
    }
    
    // Get cell by Coordinates
    func getCellByCoordinates(coordinates: Coordinates) -> Cell {
        
        let cell = cells.filter({ $0.coordinates == coordinates })
        
        return cell[0]
    }
    
    // Return the Cell that has this CGPoint
    func getCellThatContains(cgPoint: CGPoint) -> Cell? {
        
        for cell in cells {
            if cell.rect.contains(cgPoint){
                return cell
            }
        }
        return nil
    }
    
    // Return the CGRect that has this CGPoint
    func getRectThatContains(cgPoint: CGPoint) -> CGRect? {
        
        for rect in rects {
            if rect.contains(cgPoint){
                return rect
            }
        }
        return nil
    }
    
    // Get coordinates for touched cell
    func getTouchedCell(for location: CGPoint) -> Cell? {
                
        let cell = getCellThatContains(cgPoint: location)

        return cell
    }
    
    func getAPattern() -> [Int] {
        let liveCells = cells.filter({ $0.state == .live })
        let ids = liveCells.compactMap({ $0.indexID })
        return ids
        
    }
    
    // Fetch the neighborhood of One cell
    func getNeighborhoodFor(cell: Cell) -> NeigborhoodByID? {
        
        guard let cellSize = cellSize else { return nil }
        
        var newNeighborhood = NeigborhoodByID()
        
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
                newNeighborhood.top = foundCell.indexID
//                newNeighborhood.topCellCoordinates = topCoordinates
                //break
            }
            
            else if foundCell.coordinates.x == bottomCoordinates.x && foundCell.coordinates.y == bottomCoordinates.y {
                newNeighborhood.bottom = foundCell.indexID
//                newNeighborhood.bottomCellCoordinates = bottomCoordinates
//                //break
            }
            
            else if foundCell.coordinates.x == leftCoordinates.x && foundCell.coordinates.y == leftCoordinates.y {
                newNeighborhood.left = foundCell.indexID
//                newNeighborhood.leftCellCoordinates = leftCoordinates
                //break
            }
            
            else if foundCell.coordinates.x == rightCoordinates.x && foundCell.coordinates.y == rightCoordinates.y {
                newNeighborhood.right = foundCell.indexID
//                newNeighborhood.rightCellCoordinates = rightCoordinates
                //break
            }
            
            // Diagonal
            
            else if foundCell.coordinates.x == upperLeftCoordinates.x && foundCell.coordinates.y == upperLeftCoordinates.y {
                newNeighborhood.upperLeft = foundCell.indexID
//                newNeighborhood.upperLeftCellCoordinates = upperLeftCoordinates
                //break
            }
            
            else if foundCell.coordinates.x == upperRightCoordinates.x && foundCell.coordinates.y == upperRightCoordinates.y {
                newNeighborhood.upperRight = foundCell.indexID
//                newNeighborhood.upperRightCellCoordinates = upperRightCoordinates
                //break
            }
            
            else if foundCell.coordinates.x == bottomLeftCoordinates.x && foundCell.coordinates.y == bottomLeftCoordinates.y {
                newNeighborhood.bottomLeft = foundCell.indexID
//                newNeighborhood.bottomLeftCellCoordinates = bottomLeftCoordinates
                //break
            }
            
            else if foundCell.coordinates.x == bottomRightCoordinates.x && foundCell.coordinates.y == bottomRightCoordinates.y {
                newNeighborhood.bottomRight = foundCell.indexID
//                newNeighborhood.bottomRightCellCoordinates = bottomRightCoordinates
                //break
            }
        }
        return newNeighborhood
    }
    
    func getNextStateFor(cell: Cell) -> CellState? {
        
        var neighborhood: [Cell] = []
        
        
        // Id's of all the neighboring cells (as an neigborhoodById Object)
        guard let neighborhoodByID = getNeighborhoodFor(cell: cell) else { return nil}
        
        
        
        // Array of ID's, of all the neighboring cells
        let ids = neighborhoodByID.cells
        
        // Fetch each none nil cell of this cell's neighborhood
        // And add it to the neighborhood array
        for id in ids {
            if let id = id {
                neighborhood.append(self.cells[id])
            }
        }
        
        // Store the dead and the alive cells in 2 arrays
        _ = neighborhood.filter({$0.state == .dead})
        let aliveCells = neighborhood.filter({$0.state == .live})
        
        // Apply the Game of Life Rules to decide what's this cell's next state
        if cell.state == .live && aliveCells.count < 2 {
            return .dead
            
        } else if cell.state == .live && aliveCells.count > 3 {
            return .dead
            
        } else if cell.state == .live && aliveCells.count == 2 {
            return .live
            
        } else if cell.state == .live && aliveCells.count == 3 {
            return .live
            
        } else if cell.state == .dead && aliveCells.count == 3 {
            return .live
            
        } else {
            return .dead
        }
    }
    
    // Change the state of One Cell
    func changeStateForCellWith(id: Int) {
        
        switch cells[id].state {
            
        case .dead:
            cells[id].state = .live
        case .live:
            cells[id].state = .dead
        }
    }
    
    // Set a random Pattern of cells to live
    func setARandomPatternToLive() {
        
        guard !cells.isEmpty else { return }
        
        // Set all cells to dead
        setCellsToDead()
        
        // Set a pattern
        let patternByIDs = makeList(cells.count / 2)
        
        var pattern: [Cell] = []
        
        // append pattern cells to pattern array
        for i in patternByIDs {
            pattern.append(cells[i])
        }
        
        // Change the state of each cell in the pattern to live
        for cell in pattern {
            cells[cell.indexID].state = .live
        }
    }
    
    // Make an array of random numbers
    func makeList(_ n: Int) -> [Int] {
        return (1..<n).map { _ in .random(in: 1...cells.count - 1) }
    }
}
