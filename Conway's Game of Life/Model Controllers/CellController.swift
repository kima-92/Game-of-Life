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
                
        // Find the off set of the center of the weel
        
        let cell = getCellThatContains(cgPoint: location)
        
        
        //        let gridCenter = CGPoint(x: bounds.midX, y: bounds.midY)
        //
        //        let dy = location.y - gridCenter.y
        //        let dx = location.x - gridCenter.x
        //
        //        let offset = CGPoint(x: dx / center.x, y: dy / center.y)
        //
        //        return color
        
        return cell
        
    }
    
    // Set initial Pattern for Testing
    func setInitialPattern() {
        guard !cells.isEmpty else { return }
        
        // 1
        
        let cellIndex = 0 //1_000
        
        let myCell = cells[cellIndex]
        
        cells[cellIndex].state = .live
        
        let cellNeighborhood = getNeighborhoodFor(cell: myCell)
        
        let topID = cellNeighborhood?.top
        let bottomID = cellNeighborhood?.bottom
        let leftID = cellNeighborhood?.left
        let rightID = cellNeighborhood?.right
        
        if let topID = topID {
            
            cells[topID].state = .live
        }
        
        if let bottomID = bottomID {
            
            cells[bottomID].state = .live
        }
        
        if let leftID = leftID {
            
            cells[leftID].state = .live
        }
        
        if let rightID = rightID {
            
            cells[rightID].state = .live
        }
        
        
        
        
        // 2
        
        let secondCellIndex = 2 //1_000
        
        let mySecondCell = cells[secondCellIndex]
        
        cells[secondCellIndex].state = .live
        
        let secondCellNeighborhood = getNeighborhoodFor(cell: mySecondCell)
        
        let topID2 = secondCellNeighborhood?.top
        let bottomID2 = secondCellNeighborhood?.bottom
        let leftID2 = secondCellNeighborhood?.left
        let rightID2 = secondCellNeighborhood?.right
        
        if let topID2 = topID2 {
            
            cells[topID2].state = .live
        }
        
        if let bottomID2 = bottomID2 {
            
            cells[bottomID2].state = .live
        }
        
        if let leftID2 = leftID2 {
            
            cells[leftID2].state = .live
        }
        
        if let rightID2 = rightID2 {
            
            cells[rightID2].state = .live
        }
        
        
        
        // 3
        
        let thirdCellIndex = 3 //1_000
        
        let myThirdCell = cells[thirdCellIndex]
        
        cells[thirdCellIndex].state = .live
        
        let thirdCellNeighborhood = getNeighborhoodFor(cell: myThirdCell)
        
        let topID3 = thirdCellNeighborhood?.top
        let bottomID3 = thirdCellNeighborhood?.bottom
        let leftID3 = thirdCellNeighborhood?.left
        let rightID3 = thirdCellNeighborhood?.right
        
        if let topID3 = topID3 {
            
            cells[topID3].state = .live
        }
        
        if let bottomID3 = bottomID3 {
            
            cells[bottomID3].state = .live
        }
        
        if let leftID3 = leftID3 {
            
            cells[leftID3].state = .live
        }
        
        if let rightID3 = rightID3 {
            
            cells[rightID3].state = .live
        }
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
}
