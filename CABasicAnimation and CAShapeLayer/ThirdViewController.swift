//
//  ThirdViewController.swift
//  CABasicAnimation and CAShapeLayer
//
//  Created by Nodirbek on 22/06/22.
//

import UIKit

class ThirdViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        configureTable()
//        table.delegate = self
//        table.dataSource = self
        configureCollectionView()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        view.addSubview(table)
//        table.frame = view.bounds
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
    }
    
    func configureTable(){
        table = UITableView(frame: .zero, style: .insetGrouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func configureCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 20, left: 16, bottom: 10, right: 16)
        layout.itemSize = CGSize(width: (view.frame.width / 2) - 21, height: (view.frame.width / 2) - 21 + 30)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    func transform(cell: UICollectionViewCell){
        let coverFrame = cell.convert(cell.bounds, to: view)
        let transformOffsetY = collectionView.bounds.height * 2/3
        let percent = getPercent(value: (coverFrame.minY - transformOffsetY) / (collectionView.bounds.height - transformOffsetY))
//        let maxScaleDifference: CGFloat = 1
        let maxScaleDifference: CGFloat = 0.2
        let scale = percent * maxScaleDifference
        
        cell.transform = CGAffineTransform(scaleX: 1 - scale, y: 1 - scale)
    }
    
    func transformTable(cell: UITableViewCell){
        let coverFrame = cell.convert(cell.bounds, to: view)
        let transformOffsetY = table.bounds.height * 2/3
        let percent = getPercent(value: (coverFrame.minY - transformOffsetY) / (table.bounds.height - transformOffsetY))
//        let maxScaleDifference: CGFloat = 1
        let maxScaleDifference: CGFloat = 0.2
        let scale = percent * maxScaleDifference
        
        cell.transform = CGAffineTransform(scaleX: 1 - scale, y: 1 - scale)
    }
    
    func getPercent(value: CGFloat) -> CGFloat {
        let lBound: CGFloat = 0
        let uBound: CGFloat = 1
        if value < lBound {
            return lBound
        }
        else if value > uBound {
            return uBound
        }
        return value
    }
}

extension ThirdViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        transformTable(cell: cell)
        cell.backgroundColor = .green
        return cell
    }
}

extension ThirdViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        transform(cell: cell)
        cell.backgroundColor = .green
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //table.visibleCells.forEach{transformTable(cell: $0)}
        collectionView.visibleCells.forEach{transform(cell: $0)}
    }
}
