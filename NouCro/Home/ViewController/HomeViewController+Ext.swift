//
//  HomeViewController+Ext.swift
//  NouCro
//
//  Created by AliReza on 2024-10-20.
//

import UIKit

extension HomeViewController: Viewable {
    
    func show(result: Result<Any, any Error>) {
        switch result {
        case .success(let data):
            guard let source = data as? [Action] else { return }
            setupCollectionView(source: source)
        case .failure(let error):
            print(error)
        }
        return
    }
    
    private func setupCollectionView(source: [Action]) {
        dataSource = createDataSource(source)
        collecionView.dataSource = dataSource
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(source)
        dataSource.apply(snapshot)
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        return
    }
    
    fileprivate func createDataSource(_ source: [Action]) -> DataSource {
        let dataSource = DataSource(collectionView: collecionView) { collectionView, indexPath, action in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActionCollectionViewCell.reuseID, for: indexPath) as? ActionCollectionViewCell
            cell?.update(model: action)
            return cell
        }
        return dataSource
    }
    
}
