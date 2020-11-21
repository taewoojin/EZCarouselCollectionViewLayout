//
//  ViewController.swift
//  Example
//
//  Created by 태우 on 2020/11/15.
//

import UIKit


class ViewController: UIViewController, EZCarouselCollectionViewLayoutDelegate {

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.decelerationRate = .fast
            collectionView.showsHorizontalScrollIndicator = false
        }
    }
    
    var isOneStepPaging: Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = EZCarouselCollectionViewLayout()
        layout.delegate = self
        layout.itemSize = CGSize(width: 250, height: 500)
        layout.minimumLineSpacing = 10
        
        collectionView.collectionViewLayout = layout
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 30, bottom: 20, right: 30)
        collectionView.dataSource = self
        collectionView.register(ExampleCell.self, forCellWithReuseIdentifier: "ExampleCell")
    }

}


extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExampleCell", for: indexPath) as! ExampleCell
        return cell
    }
    
}
