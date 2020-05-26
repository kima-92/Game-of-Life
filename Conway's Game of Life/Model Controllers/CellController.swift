//
//  CellController.swift
//  Conway's Game of Life
//
//  Created by macbook on 5/26/20.
//  Copyright © 2020 WilmaRodriguez. All rights reserved.
//

import Foundation

class CellController {
    
    // MARK: - Properties
    var cells: [Cell] = []
    
    // MARK: - Methods

    // Add a cell to the cells array
    func addNewCell(cell: Cell) {
        
        // When this funciton is called, this cell has NO neighborhood yet!
        
        // Add this cell to the cells array
        cells.append(cell)
    }
}
