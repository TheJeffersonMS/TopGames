//
//  TGGame.swift
//  TopGames
//
//  Created by Jefferson Martins on 05/02/2018.
//  Copyright © 2018 Jefferson Martins. All rights reserved.
//

import Foundation
import UIKit

struct TGGame {
    
    var name: String
    var viewers: Int
    var imageLarge: String
    var imageMedium: String
    var imageSmall: String
    
    fileprivate static let kName = "name"
    fileprivate static let kViewers = "viewers"
    fileprivate static let kLarge = "large"
    fileprivate static let kMedium = "medium"
    fileprivate static let kSmall = "small"
    fileprivate static let kBox = "box"
    fileprivate static let kGame = "game"
    
    init() {
        self.name = String.empty()
        self.viewers = Int()
        self.imageLarge = String.empty()
        self.imageMedium = String.empty()
        self.imageSmall = String.empty()
    }
    
    static func parse(data: [String: AnyObject]) -> TGGame? {
        
        var game = TGGame()
        
        if let gameStringAnyObject = data[kGame] as? [String: AnyObject] {
            
           fillWithDictionary(&game.name, key: kName, dictionary: gameStringAnyObject)
            
            if let box = gameStringAnyObject[kBox] as? [String: AnyObject] {
                
                fillWithDictionary(&game.imageLarge, key: kLarge, dictionary: box)
                fillWithDictionary(&game.imageSmall, key: kMedium, dictionary: box)
                fillWithDictionary(&game.imageSmall, key: kSmall, dictionary: box)
            }
        }

        fillWithDictionary(&game.viewers, key: kViewers, dictionary: data)
        
        return game
    }
    
    static func fillWithDictionary<T>(_ variable: inout T, key: String, dictionary: [String : AnyObject]) {
        if let tempField = dictionary[key] as? T {
            variable = tempField
        }
    }
}

