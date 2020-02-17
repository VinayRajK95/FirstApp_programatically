//
//  AppStoreMainPageViewController.swift
//  ASA_assignment
//
//  Created by Infosys on 1/16/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import UIKit

class AppStoreMainPageViewController: UIViewController, DownloadApps{
    
    var listOfApps: [AppModel]?
    
    @IBOutlet var collectionView: UICollectionView!
    
    let parser = JsonParser()
    
    var cellNames = ["CellOne","CellOne","CellOne","CellOne","CellOne","CellTwo"]
    
    let transition = BounceAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parser.downloaData()
        parser.delegate = self
        loaderView()
        // Do any additional setup after loading the view.
    }
    
    func loaderView() {
        let loadingView = UIView(frame: collectionView.frame)
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        loadingView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([activityIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),activityIndicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor)])
        collectionView.backgroundView = loadingView
        activityIndicator.startAnimating()
    }
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
        }
    }

}

extension AppStoreMainPageViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if cellNames[indexPath.row] == "CellOne"{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellNames[indexPath.row], for: indexPath) as! FirstCollectionViewCell
            let url = URL(string: listOfApps![indexPath.row].artworkUrl100)
            cell.downloadImage(urlOfImage : url!)
            
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellNames[indexPath.row], for: indexPath) as! SecondCollectionViewCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 32 , height: self.view.frame.height/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! CollectionReusableHeaderView
        setupDate(header : headerView)
        return headerView
    }
    
    func setupDate(header : CollectionReusableHeaderView) {
        let getDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd MMM, yyyy"
        let currentDateString: String = dateFormatter.string(from: getDate)
        header.dateLabel.text = currentDateString
        header.profile.layer.cornerRadius = header.profile.bounds.width/2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath)
//        UIView.animate(withDuration: 0.5, animations: {
//            cell?.transform = CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95)
//        }, completion: { (finish) in
//            UIView.animate(withDuration: 0.20, animations: {
//                cell?.transform = CGAffineTransform.identity
//            })
//        })
        presentVC( )
    }
    
    func presentVC(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "AnimateVC")
        vc?.transitioningDelegate = self
        present(vc!, animated: true, completion: nil)
    }
    
}

extension AppStoreMainPageViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfApps?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppTableViewCell", for: indexPath) as! AppTableViewCell
        cell.configureCell(apps: listOfApps![indexPath.row])
        return cell
    }
    
}

extension AppStoreMainPageViewController: UIViewControllerTransitioningDelegate{
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }

}

