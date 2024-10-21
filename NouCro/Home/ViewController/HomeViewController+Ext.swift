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
            if let source = data as? [Action] {
                setupCollectionView(source: source)
                undoButton.isEnabled = !source.enumerated().filter({ $0.element != .none(index: $0.offset)}).isEmpty
            }
            if let source = data as? String {
                annouceGameResult(source)
            }
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
    
    private func annouceGameResult(_ result: String) {
        let message: String
        if result == "" {
            message = "It's a draw!"
        } else {
            message = "\(result) won the game!"
        }
        let alert = UIAlertController(title: "Game Result!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: { [weak self] _ in
            self?.restartGame()
        }))
        navigationController?.present(alert, animated: true)
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItem(at: indexPath.row)
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
