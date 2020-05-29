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
    var timer: Timer?
    var waitTimer = Timer()
    
    var defaultGameSpeed = 0.5
    var gameSpeed: Double = 0.0   // will be set up in updateViews
    var gameSpeedLimit: Double = 0.4
    
    var cellSize: CGFloat = 20  //8
    var shadowColor: UIColor = .black
    
    var runButtons: [UIButton?] {
        let buttons = [playButton,
                       clearButton,
                       forwardByOneButton,
                       fastforwardButton,
                       fastbackwardButton,
                       createRandomPatternButton
        ]
        return buttons
    }
    
    // MARK: - Outlets
    @IBOutlet weak var grid: Grid!
    @IBOutlet weak var tapOnCellsLabel: UILabel!
    @IBOutlet weak var buttonsGreyView: UIView!
    @IBOutlet weak var createRandomPatternButton: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    @IBOutlet weak var forwardByOneButton: UIButton!
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
    
    @IBAction func createRandomPatternButtonTapped(_ sender: UIButton) {
        sender.pulsate()
        
        // Gettings a pattern of cells
        cellController.setARandomPatternToLive()
        grid.setNeedsDisplay()
    }
    
    // User stated the timer
    @IBAction func playButtonTapped(_ sender: UIButton) {
        sender.pulsate()
        
        //Play
        if cellController.startedTimer == false {
            playButton.setImage(UIImage(named: "pause"), for: .normal)
            setUpTimer()
            
            //Pause
        } else {
            playButton.setImage(UIImage(named: "play"), for: .normal)
            cellController.setDidStartGame(to: false)
            
            if let timer = timer {
                
                timer.invalidate()
            }
        }
    }
    
    // Clear Grid
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        sender.pulsate()
        
        // Change the Image of the play button
        playButton.setImage(UIImage(named: "play"), for: .normal)
        
        // If the timer is running, stop it and set variable
        if cellController.startedTimer == true {
            
            cellController.setDidStartGame(to: false)
            
            if let timer = timer {
                timer.invalidate()
            }
        }
        
        // Re-Set Grid to blank
        cellController.setCellsToDead()
        grid.setNeedsDisplay()
    }
    
    // Re-draws the grid Once
    @IBAction func forwardByOneButtonTapped(_ sender: UIButton) {
        sender.pulsate()
        
        cellController.setShouldGameRunOnce(to: true)
        self.grid.setNeedsDisplay()
    }
    
    @IBAction func fastforwardButtonTapped(_ sender: UIButton) {
        sender.pulsate()
        
        if let _ = timer {
            cancelTimer()
            
                if self.gameSpeed > self.defaultGameSpeed * self.gameSpeedLimit && self.gameSpeed < self.defaultGameSpeed / self.gameSpeedLimit {
                    
                    self.gameSpeed -= 0.3
                }
                self.setUpTimer()
        }
    }
    
    @IBAction func fastbackwardButtonTapped(_ sender: UIButton) {
        sender.pulsate()
        
        if let _ = timer {
            cancelTimer()
            
            //if gameSpeed > defaultGameSpeed * gameSpeedLimit && gameSpeed < defaultGameSpeed / gameSpeedLimit {
                
                gameSpeed += 0.3
            //}
            setUpTimer()
        }
    }
    
    // MARK: - Methods
    
    private func cancelTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    // Starts the timer to keep refreshing the Grid
    private func setUpTimer() {
        cellController.setDidStartGame(to: true)
        timer = Timer.scheduledTimer(timeInterval: gameSpeed, target: self, selector: #selector(refreshGrid), userInfo: nil, repeats: true)
        timer?.tolerance = 0.1
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
            button.layer.cornerRadius = 15
            button.layer.shadowColor = shadowColor.cgColor
            button.layer.shadowOffset = CGSize(width: 3.0, height: 4.0)
            button.layer.shadowOpacity = 0.4
            button.layer.shadowRadius = 0.0
        }
    }
    
    // MARK: - Update Views
    private func updateViews() {
        
        // Set up navigation bar
        navigationController?.navigationBar.isHidden = false
        navigationController?.hidesBarsOnSwipe = true
        
        // Pass the cellController to the Grid
        grid.cellController = cellController
        
        // Pass the cellSize to the cellController and the Grid
        cellController.cellSize = cellSize
        grid.cellSize = cellSize
        
        // Setting the cell size
        cellSize = grid.bounds.width / 4   //40  //8
        
        // Set up the buttons
        setupButtonsViews()
        
        // Round corners
        tapOnCellsLabel.layer.cornerRadius = 15
        buttonsGreyView.layer.cornerRadius = 15
        
        // Set up Runtime speed
        gameSpeed = defaultGameSpeed
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
