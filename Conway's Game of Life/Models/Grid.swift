//
//  Grid.swift
//  Conway's Game of Life
//
//  Created by macbook on 5/26/20.
//  Copyright © 2020 WilmaRodriguez. All rights reserved.
//

import UIKit

class Grid: UIView {
    
    var cellController: CellController?
    var cellSize: CGFloat?
    
    //var sum = 1
    
    // Setup for the Grid before the screen loads
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setUpGrid()
    }
    
    // MARK: - Drawing the Grid
    override func draw(_ rect: CGRect) {
        
        guard let cellController = cellController,
            let cellSize = cellSize else { return }
        
        // Set the size of each cell in the grid
        
        
        // If we have no cells yet
        if cellController.cells.isEmpty {
            
            if let context = UIGraphicsGetCurrentContext() {
                
                // horizontal
                for x in stride(from: 0, through: rect.maxX, by: cellSize) {
                    // vertical
                    for y in stride(from: 0, through: rect.maxY, by: cellSize) {
                        
                        // Doing work for each cell
                        createNewCell(x: x, y: y)
                        
                        let lightGreyColor: UIColor = .lightGray

                        // Creating a cell at a specific spot
                        let pixelRect = CGRect(x: x, y: y, width: cellSize, height: cellSize)
                        
                        // TODO: - Before production, this should color all the cells white, with a black border
                        context.setFillColor(lightGreyColor.cgColor)
                        context.fill(pixelRect)
                        
//                        context.setStrokeColor(blackColor.cgColor)
//                        context.setLineWidth(<#T##width: CGFloat##CGFloat#>)
                    }
                }
            }
        }
            
        // If we do have cells already
        else {
            
            if let context = UIGraphicsGetCurrentContext() {
                
                // horizontal
                for x in stride(from: 0, through: rect.maxX, by: cellSize) {
                    // vertical
                    for y in stride(from: 0, through: rect.maxY, by: cellSize) {
                        //print("\nsum: \(sum), x: \(x), y: \(y), rect.maxX: \(rect.maxX), rect.maxY: \(rect.maxY),by: \(cellSize)")
                        
                        // Using color to see the size of the cells
                        let randomNum = Int.random(in: 1..<9)
                        
                        var color: UIColor
                        
                        // Giving each cell a different color ( for now )
                        if randomNum <= 3 {
                            color = .red
                        } else if randomNum == 4 || randomNum == 5 {
                            color = .purple
                        } else {
                            color = .cyan
                        }
                        
                        // Creating a cell at a specific spot
                        let pixelRect = CGRect(x: x, y: y, width: cellSize, height: cellSize)
                        
                        context.setFillColor(color.cgColor)
                        context.fill(pixelRect)
                        
                    }
                }
            }
        }
    }
    
    private func setUpGrid() {
        
        // Accept user interaction
        isUserInteractionEnabled = false
        
        clipsToBounds = true
        
        // Settig the Grid's border to black
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
        
        // TODO: - Decide if you want rounded courners or not
        //layer.cornerRadius = bounds.width / 2
    }
    
    // Create a new cell to add to cellController.cells
    private func createNewCell(x: CGFloat, y: CGFloat) {
        
        guard let cellController = cellController else { return }
        
        // Creating a Cell and adding it to the array
        let coordinates = Coordinates(x: x, y: y)
        
        let cell = Cell(coordinates: coordinates, state: .dead)
        
        cellController.addNewCell(cell: cell)
    }
}
