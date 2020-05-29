//
//  Grid.swift
//  Conway's Game of Life
//
//  Created by macbook on 5/26/20.
//  Copyright © 2020 WilmaRodriguez. All rights reserved.
//

import UIKit

@IBDesignable
class Grid: UIControl {
    
    var cellController: CellController?
    var cell: Cell?
    
    var cellSize: CGFloat?
    var cellRect: CGRect?
    var coordinates: Coordinates?
    
    var indexSum = 0
    var defaultColor: UIColor = UIColor(displayP3Red: 130/255, green: 130/255, blue: 180/255, alpha: 0.4)
    var cellColor: UIColor = .white
    var liveCellColor: UIColor = .black
    
    // Setup for the Grid before the screen loads
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setUpGrid()
    }
    
    // MARK: - Drawing the Grid
    override func draw(_ rect: CGRect) {
        
        guard let cellController = cellController else { return }
        
        // If we have no cells yet
        if cellController.cells.isEmpty {
            
            createGridForTheFirstTime(rect: rect)
        }
            
        // If we do have cells and the game will run only once
        else if cellController.shouldGameRunOnce == true {
            
            runGameByOneGeneration(rect: rect)
            cellController.setShouldGameRunOnce(to: false)
        }
            
        // If we do have cells and the game started using the timer
        else if cellController.startedTimer == true {
            
            continueslyRedrawTheGrid(rect: rect)
        }
            
        // The game didn't start but we need to redraw the grid after initial selection
        else {
            
            reDrawGrid(rect: rect)
        }
    }
    
    // MARK: - Drawing Options
    
    // Draw Grid when the screen loads
    private func createGridForTheFirstTime(rect: CGRect) {
        
        if let context = UIGraphicsGetCurrentContext() {
            
            guard let cellSize = cellSize else { return }
            
            // Work for each cell
            for x in stride(from: 0, through: rect.maxX, by: cellSize) {  // horizontal
                for y in stride(from: 0, through: rect.maxY, by: cellSize) {  // vertical
                    
                    cellColor = defaultColor
                    
                    // Creating a CGRect for this Cell
                    cellRect = CGRect(x: x, y: y, width: cellSize, height: cellSize)
                    // Create this cell
                    createNewCell(indexID: indexSum, x: x, y: y, rect: cellRect!)
                    
                    context.setFillColor(cellColor.cgColor)
                    context.fill(cellRect!)
                    
                    indexSum += 1
                }
            }
        }
    }
    
    // Re-Draw Drid when the Game runs only once
    private func runGameByOneGeneration(rect: CGRect) {
        
        guard let cellController = cellController,
            let cellSize = cellSize else { return }
        
        if let context = UIGraphicsGetCurrentContext() {
            
            for x in stride(from: 0, through: rect.maxX, by: cellSize) {  // horizontal
                for y in stride(from: 0, through: rect.maxY, by: cellSize) {  // vertical
                    
                    cellColor = defaultColor
                    coordinates = Coordinates(x: x, y: y)
                    
                    // Using these coordinates, get this cell from cellController.cells
                    cell = cellController.getCellByCoordinates(coordinates: coordinates!)
                    
                    guard let cell = cell else { return }
                    
                    cellRect = cell.rect
                    
                    // Get the next state for this cell
                    let nextState = cellController.getNextStateFor(cell: cell)
                    
                    guard nextState != nil else { return }
                    
                    // If the next state for this cell is alive,
                    // Set color to black
                    if nextState == .live {
                        cellColor = liveCellColor
                    }
                    
                    // Change this cell's state
                    // If the current state of this cell is not what it should be for this generation
                    if cell.state != nextState {
                        cellController.changeStateForCellWith(id: cell.indexID)
                    }
                    
                    // Color Cell
                    context.setFillColor(cellColor.cgColor)
                    context.fill(cellRect!)                    
                }
            }
        }
    }
    
    // Re-Draw Grid Continuesly due to the use of the timer
    private func continueslyRedrawTheGrid(rect: CGRect) {
        
        guard let cellController = cellController,
            let cellSize = cellSize else { return }
        
        if let context = UIGraphicsGetCurrentContext() {
            
            for x in stride(from: 0, through: rect.maxX, by: cellSize) {  // horizontal
                for y in stride(from: 0, through: rect.maxY, by: cellSize) {  // vertical
                    
                    cellColor = defaultColor
                    coordinates = Coordinates(x: x, y: y)
                    
                    // Using these coordinates, get this cell from cellController.cells
                    cell = cellController.getCellByCoordinates(coordinates: coordinates!)
                    
                    guard let cell = cell else { return }
                    
                    cellRect = cell.rect
                    
                    let nextState = cellController.getNextStateFor(cell: cell)
                    
                    guard nextState != nil else { return }
                    
                    // Set cellColor to liveColor if cell is alive
                    if nextState == .live {
                        cellColor = liveCellColor
                    }
                    
                    // Change this cell's state
                    // If the current state of this cell is not what it should be for this generation
                    if cell.state != nextState {
                        cellController.changeStateForCellWith(id: cell.indexID)
                    }
                    
                    // Color the cell
                    context.setFillColor(cellColor.cgColor)
                    context.fill(cellRect!)
                }
            }
        }
    }
    
    // Re-Draw Grid before starting the game
    // When selecting initial Cells
    private func reDrawGrid(rect: CGRect) {
        
        guard let cellController = cellController,
            let cellSize = cellSize else { return }
        
        if let context = UIGraphicsGetCurrentContext() {
            
            for x in stride(from: 0, through: rect.maxX, by: cellSize) {  // horizontal
                for y in stride(from: 0, through: rect.maxY, by: cellSize) {  // vertical
                    
                    cellColor = defaultColor
                    coordinates = Coordinates(x: x, y: y)
                    
                    cell = cellController.getCellByCoordinates(coordinates: coordinates!)
                    
                    guard let cell = cell else { return }
                    
                    cellRect = cell.rect
                    
                    // Set cellColor to liveColor if cell is alive
                    if cell.state == .live {
                        cellColor = liveCellColor
                    }
                    
                    context.setFillColor(cellColor.cgColor)
                    context.fill(cellRect!)
                }
            }
        }
    }
    
    // MARK: - Set Up Grid
    private func setUpGrid() {
        
        // Accept user interaction
        isUserInteractionEnabled = true
        
        clipsToBounds = true
        
        // Settig the Grid's border to black
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
        
        layer.cornerRadius = 10  // bounds.width / 2
    }
    
    // Create a new cell to add to cellController.cells
    private func createNewCell(indexID: Int, x: CGFloat, y: CGFloat, rect: CGRect) {
        
        guard let cellController = cellController else { return }
        
        // Creating a Cell and adding it to the array
        let coordinates = Coordinates(x: x, y: y)
        
        let cell = Cell(indexID: indexID, coordinates: coordinates, state: .dead, rect: rect)
        
        cellController.addNewCell(cell: cell)
    }
    

    
    //MARK: Touch Traking
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        
        if bounds.contains(touchPoint) {
            
            guard let cellController = cellController else { return false }
            
            //selectedColor = colorWheel.color(for: touchPoint)
            
            // Change state of touched cell
            if let cell = cellController.getCellThatContains(cgPoint: touchPoint) {
                
                cellController.changeStateForCellWith(id: cell.indexID)
                // Re-draw the grid
                self.setNeedsDisplay()
                
                sendActions(for: .valueChanged)
            }
        }
        sendActions(for: .touchDown)
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        let touchPoint = touch.location(in: self)
        
        if bounds.contains(touchPoint) {
            
            guard let cellController = cellController else { return false }
            
            if let cell = cellController.getCellThatContains(cgPoint: touchPoint) {
                
                cellController.changeStateForCellWith(id: cell.indexID)
                // Re-draw the grid
                self.setNeedsDisplay()
                
                sendActions(for: [.valueChanged, .touchDragInside])
            }
            
            //selectedColor = colorWheel.color(for: touchPoint)
        } else {
            sendActions(for: .touchDragOutside)
        }
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        
        guard let touch = touch,
            let cellController = cellController else { return }
        
        let touchPoint = touch.location(in: self)
        
        if bounds.contains(touchPoint) {
            
            //if let cell = cellController.getCellThatContains(cgPoint: touchPoint) {
                
                //cellController.changeStateForCellWith(id: cell.indexID)
                // Re-draw the grid
                //self.setNeedsDisplay()
                
                sendActions(for: [.valueChanged, .touchDragInside])
            //}
            //            selectedColor = colorWheel.color(for: touchPoint)
            
        } else {
            sendActions(for: .touchDragOutside)
        }
    }
    
    override func cancelTracking(with event: UIEvent?) {
        
        sendActions(for: .touchCancel)
        
    }
}

