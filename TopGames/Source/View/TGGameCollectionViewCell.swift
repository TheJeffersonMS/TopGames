//
//  TGGameCollectionViewCell.swift
//  TopGames
//
//  Created by Jefferson Martins on 04/02/2018.
//  Copyright © 2018 Jefferson Martins. All rights reserved.
//

import UIKit

class TGGameCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var gameCoverImageView: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameSpectatorsLabel: UILabel!
    
    var game = TGGame()
    
    func setCell(game: TGGame) {
        
        self.game = game
        
        self.gameNameLabel.text = self.game.name
        self.gameSpectatorsLabel.text = "\(self.game.viewers) espectadores"
        self.gameCoverImageView.imageFromServerURL(urlString: self.game.imageLarge)
    }
}

extension UIImageView {
    
    func imageFromServerURL(urlString: String) {
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error as Any)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }
}
