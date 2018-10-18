//
//  FavoriteViewController.swift
//  weatherApp
//
//  Created by TimoXaq on 24/04/2018.
//  Copyright © 2018 TimoXaq. All rights reserved.
//

import UIKit

protocol FavoriteCVDelegate {
    func changeWeather(newWeather: Weather)
}

class FavoriteViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var mainView: UIView!
    
    var delegate: FavoriteCVDelegate?
    let gradient = CAGradientLayer()
    
    var list: [Weather]?
    
    override func viewDidLoad() {
        initialSetup()
    }
    
    func initialSetup() {
        mainView.layer.addSublayer(gradient)
        mainView.setGradient(gradient: gradient, colors: Manager.globalColor)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell") as? FavoriteTableViewCell, let list = list else {
            return FavoriteTableViewCell()
        }
        let item = list[indexPath.row]
        cell.loadWith(weather: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let list = list {
            let item = list[indexPath.row]
            delegate?.changeWeather(newWeather: item)
            navigationController?.popViewController(animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "") { (action, view, nil) in
            let favoriteList = Manager.realm.objects(Locality.self).filter("favorite = %@", true)
            try! Manager.realm.write {
                favoriteList[indexPath.row].favorite = false
            }
            self.list?.remove(at: indexPath.row)
            tableView.reloadData()
        }
        
        delete.backgroundColor = .red
        delete.image = #imageLiteral(resourceName: "trash")
        let config = UISwipeActionsConfiguration(actions: [delete])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}



