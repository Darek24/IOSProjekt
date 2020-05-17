//
//  HighscoreController.swift
//  IOSGame
//
//  Created by Dix on 5/17/20.
//  Copyright © 2020 Dix. All rights reserved.
//

import UIKit

class HighscoreController: UIViewController {
    
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var highscoreTextView: UITextView!
    
    let HighscoreDefault = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        if(HighscoreDefault.array(forKey: "SavedIntArray")  != nil)
        {
            var array = HighscoreDefault.array(forKey: "SavedIntArray")  as? [Int] ?? [Int]()
            array.sort(by: >)
            array.forEach{ item in
                highscoreTextView.text.append(String(item) + "\n")
            }

        }
        
    }
    
    
}
