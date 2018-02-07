//
//  TGGameDetailViewController.swift
//  TopGames
//
//  Created by Jefferson Martins on 06/02/2018.
//  Copyright © 2018 Jefferson Martins. All rights reserved.
//

import UIKit

class TGGameDetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var gameCoverImageView: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameSpectatorsLabel: UILabel!
    
    var game = TGGame()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadGame()
    }
    
    func loadGame() {
        
        self.gameNameLabel.text = self.game.name
        self.gameSpectatorsLabel.text = "\(self.game.viewers) espectadores"
        self.gameCoverImageView.imageFromServerURL(urlString: self.game.imageLarge)

    }
}
