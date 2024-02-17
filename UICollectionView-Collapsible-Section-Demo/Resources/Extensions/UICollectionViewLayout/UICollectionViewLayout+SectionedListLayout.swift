//
//  UICollectionViewLayout+SectionedListLayout.swift
//  UICollectionView-Collapsible-Section-Demo
//
//  Created by Seb Vidal on 17/02/2024.
//

import UIKit

extension UICollectionViewLayout {
    static var sectionedListLayout: UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { section, environment in
            var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
            configuration.headerMode = .firstItemInSection
            
            return NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: environment)
        }
    }
}
