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
    
    var sum = 1
    
    // MARK: - Outlets
    @IBOutlet weak var grid: Grid!
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTimer()
        grid.cellController = cellController
    }
    
    // MARK: - Actions
    
    // Re-draws the grid
    @IBAction func runOnceButtonTapped(_ sender: UIButton) {
        grid.setNeedsDisplay()
    }
    
    // Stop the timer
    @IBAction func stopTimerButtonTapped(_ sender: UIButton) {
        timer.invalidate()
    }
    
    // MARK: - Methods
    
    // Starts the timer to refresh the grid
    private func setUpTimer() {
        
        // TODO: - Comment this back in to set the timer:
        
        //timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(refreshGrid), userInfo: nil, repeats: true)
    }
    
    // Selector function that re-draws (refreshes) the grid
    @objc private func refreshGrid() {
        grid.setNeedsDisplay()
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
