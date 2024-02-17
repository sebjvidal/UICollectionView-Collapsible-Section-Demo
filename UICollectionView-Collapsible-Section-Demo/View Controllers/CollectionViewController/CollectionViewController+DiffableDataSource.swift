//
//  CollectionViewController+DiffableDataSource.swift
//  UICollectionView-Collapsible-Section-Demo
//
//  Created by Seb Vidal on 17/02/2024.
//

import UIKit

extension CollectionViewController {
    enum Section: Hashable {
        case locations
        case favourites
        case tags
    }
    
    enum Item: Hashable {
        case header(string: String)
        case location(systemSymbolName: String, name: String)
        case tag(color: UIColor, name: String)
    }
    
    typealias DiffableDataSource = UICollectionViewDiffableDataSource<Section, Item>
    
    typealias DiffableDataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    typealias DiffableDataSourceSectionSnapshot = NSDiffableDataSourceSectionSnapshot<Item>
}
