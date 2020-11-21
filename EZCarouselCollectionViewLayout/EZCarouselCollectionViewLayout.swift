//
//  EZCarouselCollectionViewLayout.swift
//  EZCarouselCollectionViewLayout
//
//  Created by 태우 on 2020/11/15.
//

import Foundation
import UIKit


@objc
protocol EZCarouselCollectionViewLayoutDelegate: class {
    @objc optional var isOneStepPaging: Bool { get set }
}

open class EZCarouselCollectionViewLayout: UICollectionViewFlowLayout {
    
    weak var delegate: EZCarouselCollectionViewLayoutDelegate?
    
    var latestOffset: CGFloat?
    
    
    override init() {
        super.init()
        scrollDirection = .horizontal
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        scrollDirection = .horizontal
    }
    
    open override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView,
              let delegate = delegate else { return proposedContentOffset }
        
        let proposedRect: CGRect = createProposedRect(collectionView: collectionView,
                                                      proposedContentOffset: proposedContentOffset)
        
        guard let layoutAttributes = layoutAttributesForElements(in: proposedRect),
              let candidateAttributesForRect = attributesForRect(
                collectionView: collectionView,
                layoutAttributes: layoutAttributes,
                proposedContentOffset: proposedContentOffset) else {
            return proposedContentOffset
        }
        
        
//        if let isOneStepPaging = delegate.isOneStepPaging, isOneStepPaging {
//            let pageWidth = itemSize.width + minimumLineSpacing
//
//            if latestOffset == nil {
//                latestOffset = -collectionView.contentInset.left
//            }
//
//            if latestOffset! > proposedContentOffset.x {
//                latestOffset! -= pageWidth
//            } else if latestOffset! < proposedContentOffset.x {
//                if latestOffset! <= 0 {
//                    latestOffset = -collectionView.contentInset.left
//                } else {
//                    latestOffset! += pageWidth
//                }
//            } else {
//                latestOffset = candidateAttributesForRect.frame.origin.x - collectionView.contentOffset.x
//            }
//
//            return CGPoint(x: latestOffset!, y: proposedContentOffset.y)
//        }
        
        
        var newOffset: CGFloat
        let offset: CGFloat
        
        switch scrollDirection {
        case .horizontal:
            newOffset = candidateAttributesForRect.frame.origin.x - collectionView.contentInset.left
            offset = newOffset - collectionView.contentOffset.x
            
            if (velocity.x < 0 && offset > 0) || (velocity.x > 0 && offset < 0) {
                let pageWidth = itemSize.width + minimumLineSpacing
                newOffset += velocity.x > 0 ? pageWidth : -pageWidth
            }
            return CGPoint(x: newOffset, y: proposedContentOffset.y)
            
        case .vertical:
            newOffset = candidateAttributesForRect.frame.origin.y - collectionView.contentInset.top
            offset = newOffset - collectionView.contentOffset.y
            
            if (velocity.y < 0 && offset > 0) || (velocity.y > 0 && offset < 0) {
                let pageHeight = itemSize.height + minimumLineSpacing
                newOffset += velocity.y > 0 ? pageHeight : -pageHeight
            }
            return CGPoint(x: proposedContentOffset.x, y: newOffset)
            
        default:
            return .zero
        }
        
    }
}


private extension EZCarouselCollectionViewLayout {
    
    func createProposedRect(collectionView: UICollectionView, proposedContentOffset: CGPoint) -> CGRect {
        let size = collectionView.bounds.size
        let origin: CGPoint
        
        switch scrollDirection {
        case .horizontal:
            origin = CGPoint(x: proposedContentOffset.x, y: collectionView.contentOffset.y)
            
        case .vertical:
            origin = CGPoint(x: collectionView.contentOffset.x, y: proposedContentOffset.y)
            
        default:
            origin = .zero
        }
        
        return CGRect(origin: origin, size: size)
    }
    
    func attributesForRect(collectionView: UICollectionView,
                           layoutAttributes: [UICollectionViewLayoutAttributes],
                           proposedContentOffset: CGPoint) -> UICollectionViewLayoutAttributes? {
        
        var candidateAttributes: UICollectionViewLayoutAttributes?
        let proposedCenterOffset: CGFloat
        
        switch scrollDirection {
        case .horizontal:
            proposedCenterOffset = proposedContentOffset.x + collectionView.bounds.size.width / 2
            
        case .vertical:
            proposedCenterOffset = proposedContentOffset.y + collectionView.bounds.size.height / 2
            
        default:
            proposedCenterOffset = .zero
        }
        
        for (index, attributes) in layoutAttributes.enumerated() {
            if let isOneStepPaging = delegate?.isOneStepPaging,
               isOneStepPaging,
               index > 0 {
                continue
            }
            
            guard attributes.representedElementCategory == .cell else { continue }
            
            guard candidateAttributes != nil else {
                candidateAttributes = attributes
                continue
            }
            
            switch scrollDirection {
            case .horizontal where abs(attributes.center.x - proposedCenterOffset) < abs(candidateAttributes!.center.x - proposedCenterOffset):
                candidateAttributes = attributes
                
            case .vertical where abs(attributes.center.y - proposedCenterOffset) < abs(candidateAttributes!.center.y - proposedCenterOffset):
                candidateAttributes = attributes
                
            default:
                continue
            }
        }
           
        return candidateAttributes
    }
}
