//
//  ViewController.swift
//  Example
//
//  Created by 태우 on 2020/11/15.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = CarouselCollectionViewLayout()
        layout.delegate = self
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        
    }
    

}


extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScreenshotCell", for: indexPath) as! ScreenshotCell
        cell.imageUrl = imageUrls[indexPath.row]
        return cell
    }
    
}
