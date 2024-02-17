//
//  CollectionViewController.swift
//  UICollectionView-Collapsible-Section-Demo
//
//  Created by Seb Vidal on 17/02/2024.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    // MARK: - Private Properties
    private var diffableDataSource: DiffableDataSource!
    
    // MARK: - init(collectionViewLayout:)
    override init(collectionViewLayout layout: UICollectionViewLayout = .sectionedListLayout) {
        super.init(collectionViewLayout: layout)
        setupNavigationItem()
        setupDiffableDataSource()
        populateCollectionView()
    }
    
    // MARK: - init(coder:)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupNavigationItem() {
        let moreBarButtonItem = UIBarButtonItem()
        moreBarButtonItem.image = UIImage(systemName: "ellipsis.circle")
        
        navigationItem.rightBarButtonItem = moreBarButtonItem
    }
    
    private func setupDiffableDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Item> { cell, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .header(let string):
                var contentConfiguration = UIListContentConfiguration.sidebarHeader()
                contentConfiguration.text = string
                
                cell.contentConfiguration = contentConfiguration
                cell.accessories = [.outlineDisclosure()]
            case .location(let systemSymbolName, let name):
                var contentConfiguration = UIListContentConfiguration.cell()
                contentConfiguration.image = UIImage(systemName: systemSymbolName)
                contentConfiguration.text = name
                
                cell.contentConfiguration = contentConfiguration
                cell.accessories = [.disclosureIndicator()]
            case .tag(let color, let name):
                var contentConfiguration = UIListContentConfiguration.cell()
                contentConfiguration.image = UIImage(systemName: "circle.fill")
                contentConfiguration.imageProperties.tintColor = color
                contentConfiguration.imageProperties.preferredSymbolConfiguration = UIImage.SymbolConfiguration(textStyle: .body)
                contentConfiguration.text = name
                
                cell.contentConfiguration = contentConfiguration
                cell.accessories = [.disclosureIndicator()]
            }
        }
        
        diffableDataSource = DiffableDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
    }
    
    private func populateCollectionView() {
        var snapshot = DiffableDataSourceSnapshot()
        snapshot.appendSections([.locations, .favourites, .tags])
        
        diffableDataSource.apply(snapshot, animatingDifferences: false)
        
        let locationsSectionItem: Item = .header(string: "Locations")
        var locationsSectionSnapshot = DiffableDataSourceSectionSnapshot()
        locationsSectionSnapshot.append([locationsSectionItem])
        locationsSectionSnapshot.append([.location(systemSymbolName: "iphone", name: "On My iPhone")], to: locationsSectionItem)
        locationsSectionSnapshot.append([.location(systemSymbolName: "trash", name: "Recently Deleted")], to: locationsSectionItem)
        locationsSectionSnapshot.expand([locationsSectionItem])
        
        let favouritesSectionItem: Item = .header(string: "Favourites")
        var favouritesSectionSnapshot = DiffableDataSourceSectionSnapshot()
        favouritesSectionSnapshot.append([favouritesSectionItem])
        favouritesSectionSnapshot.append([.location(systemSymbolName: "arrow.down.circle", name: "Downloads")], to: favouritesSectionItem)
        favouritesSectionSnapshot.expand([favouritesSectionItem])
        
        let tagsSectionItem: Item = .header(string: "Tags")
        var tagsSectionSnapshot = DiffableDataSourceSectionSnapshot()
        tagsSectionSnapshot.append([tagsSectionItem])
        tagsSectionSnapshot.append([.tag(color: .systemRed, name: "Red")], to: tagsSectionItem)
        tagsSectionSnapshot.append([.tag(color: .systemOrange, name: "Orange")], to: tagsSectionItem)
        tagsSectionSnapshot.append([.tag(color: .systemYellow, name: "Yellow")], to: tagsSectionItem)
        tagsSectionSnapshot.append([.tag(color: .systemGreen, name: "Green")], to: tagsSectionItem)
        tagsSectionSnapshot.append([.tag(color: .systemBlue, name: "Blue")], to: tagsSectionItem)
        tagsSectionSnapshot.append([.tag(color: .systemPurple, name: "Purple")], to: tagsSectionItem)
        tagsSectionSnapshot.append([.tag(color: .systemGray, name: "Gray")], to: tagsSectionItem)
        tagsSectionSnapshot.expand([tagsSectionItem])
        
        diffableDataSource.apply(locationsSectionSnapshot, to: .locations)
        diffableDataSource.apply(favouritesSectionSnapshot, to: .favourites)
        diffableDataSource.apply(tagsSectionSnapshot, to: .tags)
    }
    
    // MARK: - UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
