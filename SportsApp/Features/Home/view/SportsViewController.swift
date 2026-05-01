//
//  ViewController.swift
//  SportsApp
//
//  Created by Manona on 29/04/2026.
//

import UIKit

class SportsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var sportsCollectionView: UICollectionView!
    
    let sports = [
        ("football", "Football"),
        ("tennis", "Tennis"),
        ("basketball", "Basketball"),
        ("cricket", "Cricket")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sportsCollectionView.dataSource = self
        sportsCollectionView.delegate = self
        
        if let layout = sportsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportsCell", for: indexPath) as! SportsCell
        
        let sport = sports[indexPath.row]
        cell.sportsLabel.text = sport.1
        cell.sportsImage.image = UIImage(named: sport.0)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat = 30
        let width = (collectionView.frame.width - padding) / 2
        
        return CGSize(width: width, height: width + 20)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
