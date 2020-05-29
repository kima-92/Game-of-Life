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
    var shadowColor: UIColor = .black
    
    var runButtons: [UIButton?] {
        let buttons = [playButton,
                       stopButton,
                       pauseButton,
                       clearButton,
                       forwardByOneButton,
                       backwardByOneButton,
                       fastforwardButton,
                       fastbackwardButton
        ]
        return buttons
    }
    
    // MARK: - Outlets
    @IBOutlet weak var grid: Grid!
    @IBOutlet weak var tapOnCellsLabel: UILabel!
    @IBOutlet weak var buttonsGreyView: UIView!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var forwardByOneButton: UIButton!
    @IBOutlet weak var backwardByOneButton: UIButton!
    @IBOutlet weak var fastforwardButton: UIButton!
    @IBOutlet weak var fastbackwardButton: UIButton!
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    // MARK: - Actions
    
    @IBAction func gridTapped(_ sender: Grid) {
        grid.setNeedsDisplay()
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        sender.pulsate()
        
        cellController.setCellsToDead()
        grid.setNeedsDisplay()
    }
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        sender.pulsate()
        
        cellController.setDidStartGame(to: false)
        timer.invalidate()
    }
    @IBAction func fastforwardButtonTapped(_ sender: UIButton) {
        sender.pulsate()
        
    }
    @IBAction func fastbackwardButtonTapped(_ sender: UIButton) {
        sender.pulsate()
        
    }
    
    @IBAction func backByOneButtonTapped(_ sender: UIButton) {
        sender.pulsate()
        
    }
    
    // User stated the timer
    @IBAction func playButtonTapped(_ sender: UIButton) {
        sender.pulsate()
        
        if cellController.startedTimer == false {
            playButton.setImage(UIImage(named: "pause"), for: .normal)
            setUpTimer()
            
        } else {
            playButton.setImage(UIImage(named: "play"), for: .normal)
            cellController.setDidStartGame(to: false)
            
            timer.invalidate()
        }
    }
    
    // Re-draws the grid Once
    @IBAction func forwardByOneButtonTapped(_ sender: UIButton) {
        sender.pulsate()
        
        cellController.setShouldGameRunOnce(to: true)
        self.grid.setNeedsDisplay()
    }
    
    // Stop the timer
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        sender.pulsate()
        
        cellController.setDidStartGame(to: false)
        timer.invalidate()
        cellController.setCellsToDead()
        grid.setNeedsDisplay()
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
    
    // Set up shadow and rounded courners for buttons
    private func setupButtonsViews() {
        
        for button in runButtons {
            
            guard let button = button else { return }
            
            button.imageView?.layer.cornerRadius = 15
            button.layer.shadowColor = shadowColor.cgColor
            button.layer.shadowOffset = CGSize(width: 3.0, height: 4.0)
            button.layer.shadowOpacity = 0.4
            button.layer.shadowRadius = 0.0
        }
    }
    
    // MARK: - Update Views
    private func updateViews() {
        // Pass the cellController to the Grid
        grid.cellController = cellController
        
        // Pass the cellSize to the cellController and the Grid
        cellController.cellSize = cellSize
        grid.cellSize = cellSize
        
        // Setting the cell size
        cellSize = grid.bounds.width / 4   //40  //8
        
        // Set up the buttons
        setupButtonsViews()
        
        tapOnCellsLabel.layer.cornerRadius = 15
        buttonsGreyView.layer.cornerRadius = 15
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
