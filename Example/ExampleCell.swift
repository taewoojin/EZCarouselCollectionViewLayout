//
//  ExampleCell.swift
//  Example
//
//  Created by 태우 on 2020/11/17.
//

import UIKit


class ExampleCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemYellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
