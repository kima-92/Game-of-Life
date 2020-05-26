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
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTimer()
    }
    
    private func setUpTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(refreshGrid), userInfo: nil, repeats: true)
    }
    
    @objc private func refreshGrid() {
        print("Timer fired!")
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
