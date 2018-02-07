//
//  TGTopGamesViewController.swift
//  TopGames
//
//  Created by Jefferson Martins on 04/02/2018.
//  Copyright © 2018 Jefferson Martins. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class TGTopGamesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    let container: UIView = UIView()
    let loadingView: UIView = UIView()
    var games = [TGGame]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        if AppDelegate.hasInternetConnection {
            self.showActivityIndicator()
            self.searchGames()
            
        } else {
            
            self.performSegue(withIdentifier: "error", sender: TGErrorType.internet)
        }

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.searchGames()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TGGameCollectionViewCell
        
        cell.setCell(game: self.games[indexPath.row])
    
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let cell = collectionView.cellForItem(at: indexPath)
        
        self.performSegue(withIdentifier: "detail", sender: cell)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detail" {
            if let gameDetailVC = segue.destination as? TGGameDetailViewController {
                let cell = sender as! TGGameCollectionViewCell
                gameDetailVC.game = cell.game
            }
        }
        
        if segue.identifier == "error" {
            if let errorVC = segue.destination as? TGErrorViewController,
                let type = sender as? TGErrorType {
                    errorVC.type = type
            }
        }
        
    }
    
    
    func showActivityIndicator() {
        
        guard let window = UIApplication.shared.keyWindow else { return }
        
        container.frame = window.bounds
        container.center = window.center
        container.backgroundColor = UIColor.black
        container.alpha = 0.3
        
        loadingView.frame = CGRect(x: 0, y: 0, width: 80.0, height: 80.0)
        loadingView.center = container.center
        loadingView.backgroundColor = UIColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 1)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2,y: loadingView.frame.size.height / 2);
        
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        window.addSubview(container)
        activityIndicator.startAnimating()
        
    }
    
    func hideActivityIndicator() {
        
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
    }
    
    func searchGames() {
        
        let url = "https://api.twitch.tv/kraken/games/top?client_id=ucy16b5hc41xs87tja328ypcvrfphs&limit=10"
        Alamofire.request(url).validate().responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result

            switch response.result {
            case .success:
                print("Validation Successful")
                if let json = response.result.value {
                    print("JSON: \(json)")
                    print("Parse: Start!")
                    let gamesDic: Dictionary = json as! Dictionary<String, Any>
                    let tops = gamesDic["top"] as! [[String: AnyObject]]
                    for gameArray in tops {
                        
                        if let game = TGGame.parse(data: gameArray) {
                            self.games.append(game)
                        }
                    }
                    print("Parse: Complete!")
                    self.collectionView.reloadData()
                    self.hideActivityIndicator()
                }
            case .failure(let error):
               print(error)
               self.performSegue(withIdentifier: "error", sender: TGErrorType.generic)
            }
        }
    }
}


