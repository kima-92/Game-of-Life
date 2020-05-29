//
//  HomeViewController.swift
//  Conway's Game of Life
//
//  Created by macbook on 5/28/20.
//  Copyright © 2020 WilmaRodriguez. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var welcomeLabelGreyView: UIView!
    @IBOutlet weak var startGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Actions
    
    @IBAction func startGameButtonTapped(_ sender: UIButton) {
    }
    
    // MARK: - Update Views
    private func updateViews() {
        welcomeLabelGreyView.layer.cornerRadius = 10
        startGameButton.layer.cornerRadius = 10
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
