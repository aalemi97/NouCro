//
//  HomeViewController.swift
//  NouCro
//
//  Created by AliReza on 2024-10-11.
//

import UIKit
import Combine

class HomeViewController: UIViewController, Storyboarded {
    
    enum CollectionViewSection {
        case main
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<CollectionViewSection, Action>
    typealias Snapshot = NSDiffableDataSourceSnapshot<CollectionViewSection, Action>
    
    private var viewModel: ViewModelProvider
    
    var dataSource: DataSource!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var settingsButton: UIButton! {
        didSet {
            settingsButton.setTitle("", for: .normal)
        }
    }
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var collecionView: UICollectionView!
    private var cancellables: Set<AnyCancellable> = []
    
    required init?(coder: NSCoder, viewModel: ViewModelProvider) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNameLabel()
        viewModel.viewDidLoad(self)
    }
    
    func didSelectItem(at index: Int) {
        (viewModel as? HomeViewModel)?.didSelectItem(at: index)
    }
    
    func restartGame() {
        (viewModel as? HomeViewModel)?.setupGameEngine()
    }
    
    @IBAction func didTapUndoButton(_ sender: UIButton) {
        let result = (viewModel as? HomeViewModel)?.revertAction()
        if result == -1 {
            sender.isEnabled = false
        }
    }
    
    @IBAction func didTapResetButton(_ sender: UIButton) {
        (viewModel as? HomeViewModel)?.setupGameEngine()
    }
    
    private func setupNameLabel() {
        (viewModel as? HomeViewModel)?.currentPlayerPublisher.sink(receiveValue: { [weak self] player in
            self?.nameLabel.text = player.name
        }).store(in: &cancellables)
    }
    private func setupCollectionView() {
        collecionView.delegate = self
        let nib = UINib(nibName: ActionCollectionViewCell.reuseID, bundle: .main)
        collecionView.register(nib, forCellWithReuseIdentifier: ActionCollectionViewCell.reuseID)
        let gridSize = (viewModel as? HomeViewModel)?.gridSize ?? 3
        collecionView.collectionViewLayout = createLayout(forGridSize: gridSize)
    }
    
    private func createLayout(forGridSize n: Int) -> UICollectionViewCompositionalLayout {
        let size: CGFloat = 1 / CGFloat(n)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(size), heightDimension: .fractionalHeight(1))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        itemLayout.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        let groupSize: NSCollectionLayoutSize
        if ((collecionView.frame.width) / CGFloat(n) > 44) {
            groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(size))
        } else {
            groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
        }
        let groupLayout: NSCollectionLayoutGroup
        if #available(iOS 16.0, *) {
            groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: itemLayout, count: n)
        } else {
            groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: itemLayout, count: n)
        }
        groupLayout.contentInsets = .init(top: 5, leading: 0, bottom: 5, trailing: 0)
        let sectionLayout = NSCollectionLayoutSection(group: groupLayout)
        return UICollectionViewCompositionalLayout(section: sectionLayout)
    }

}
