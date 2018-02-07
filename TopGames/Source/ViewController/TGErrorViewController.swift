//
//  TGErrorViewController.swift
//  TopGames
//
//  Created by Jefferson Martins on 06/02/2018.
//  Copyright © 2018 Jefferson Martins. All rights reserved.
//

import UIKit

class TGErrorViewController: UIViewController {
    
    @IBOutlet weak var iconErrorImageView: UIImageView!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    var type = TGErrorType.generic
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showError()
    }
    
    func showError(){
        
        switch self.type {
            
        case TGErrorType.internet:
            
            self.iconErrorImageView.image = UIImage(named: "wifi_icon")
            self.errorLabel.text = "Sem Conexão"
            
        default:
            self.iconErrorImageView.image = UIImage(named: "error_icon")
            self.errorLabel.text = "Tivemos um problema"
        }
    }
}
