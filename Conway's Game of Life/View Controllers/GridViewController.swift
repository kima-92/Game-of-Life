//
//  GridViewController.swift
//  Conway's Game of Life
//
//  Created by macbook on 5/25/20.
//  Copyright © 2020 WilmaRodriguez. All rights reserved.
//

import UIKit
import Foundation

class GridViewController: UIViewController {
    
    // MARK: - Properties
    var cellController = CellController()
    var timer = Timer()
    
    var cellSize: CGFloat = 40  //8
    
    // MARK: - Outlets
    @IBOutlet weak var grid: Grid!
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    // MARK: - Actions
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
    }
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
    }
    @IBAction func fastforwardButtonTapped(_ sender: UIButton) {
    }
    @IBAction func fastbackwardButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func backByOneButtonTapped(_ sender: UIButton) {
    }
    
    
    
    @IBAction func gridTapped(_ sender: Grid) {
        grid.setNeedsDisplay()
    }
    
    // Set Initial Pattern
    @IBAction func setPatternButtonTapped(_ sender: UIButton) {
        // Testing the setInitialPattern function
        cellController.setInitialPattern()
    }
    
    // User stated the timer
    @IBAction func playButtonTapped(_ sender: UIButton) {
        setUpTimer()
    }
    
    // Re-draws the grid Once
    @IBAction func forwardByOneButtonTapped(_ sender: UIButton) {
        cellController.setShouldGameRunOnce(to: true)
        self.grid.setNeedsDisplay()
    }
    
    // Stop the timer
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        cellController.setDidStartGame(to: false)
        timer.invalidate()
    }
    
    // MARK: - Methods
    
    // Starts the timer to keep refreshing the Grid
    private func setUpTimer() {
        cellController.setDidStartGame(to: true)
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(refreshGrid), userInfo: nil, repeats: true)
    }
    
    // Selector function that re-draws (refreshes) the grid
    @objc private func refreshGrid() {
        grid.setNeedsDisplay()
    }
    
    private func updateViews() {
        // Pass the cellController to the Grid
        grid.cellController = cellController
        
        // Pass the cellSize to the cellController and the Grid
        cellController.cellSize = cellSize
        grid.cellSize = cellSize
        
        // Setting the cell size
        cellSize = grid.bounds.width / 4   //40  //8
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
