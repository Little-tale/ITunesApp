//
//  AutoPaginCollectionFlowLayout.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/7/24.
//

import UIKit

final class AutoPaginCollectionFlowLayout: UICollectionViewFlowLayout {
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = self.collectionView, let layoutArr = self.layoutAttributesForElements(in: collectionView.bounds) else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }
        
        var closestAttribute: UICollectionViewLayoutAttributes?
        let horizontalCenter = proposedContentOffset.x + (collectionView.bounds.width / 2)
        
        for attributes in layoutArr where attributes.representedElementCategory == .cell {
            if closestAttribute == nil {
                closestAttribute = attributes
                continue
            }
            
            let attributesCenterX = attributes.center.x
            let currentClosestCenterX = closestAttribute!.center.x
            
            if abs(attributesCenterX - horizontalCenter) < abs(currentClosestCenterX - horizontalCenter) {
                closestAttribute = attributes
            }
        }
        
        guard let closest = closestAttribute else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }
        
        let targetOffsetX = closest.center.x - collectionView.bounds.width / 2
        
        let maxPossibleOffsetX = collectionView.contentSize.width - collectionView.bounds.width
        
        let adjustedOffsetX = max(min(targetOffsetX, maxPossibleOffsetX), 0)
        
        return CGPoint(x: adjustedOffsetX, y: proposedContentOffset.y)
    }

    
}
