//
//  Grid.swift
//  Conway's Game of Life
//
//  Created by macbook on 5/26/20.
//  Copyright © 2020 WilmaRodriguez. All rights reserved.
//

import UIKit

class Grid: UIView {
    
    // Setup for the Grid before the screen loads
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setUpGrid()
    }
    
    // MARK: - Drawing the Grid
    override func draw(_ rect: CGRect) {
        
        // Set the size of each cell in the grid
        let cellSize: CGFloat = 8
        
        
        if let context = UIGraphicsGetCurrentContext() {
            
            // Doing work for each cell
            for x in stride(from: 0, through: rect.maxX, by: cellSize) {
                for y in stride(from: 0, through: rect.maxY, by: cellSize) {
                    
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
    
    private func setUpGrid(){
        
        // Accept user interaction
        isUserInteractionEnabled = false
        
        clipsToBounds = true
        
        // Settig the Grid's border to black
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
        
        // TODO: - Decided if you want rounded courners or not
        //layer.cornerRadius = bounds.width / 2
    }
}
