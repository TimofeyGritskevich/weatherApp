//
//  CityListViewController.swift
//  weatherApp
//
//  Created by TimoXaq on 26/03/2018.
//  Copyright © 2018 TimoXaq. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

protocol CityListVCDelegate {
    func setNewWeather(newWeather: Weather)
}

class CityListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var tableViewBotConstr: NSLayoutConstraint!
    
    var cityList = Manager.result
    var delegate: CityListVCDelegate?
    var searchOptions = "name"
    
    let gradient = CAGradientLayer()
    
    override func viewDidLoad() {
        print(Manager.result.count)
        tableView.reloadData()
        registerForKeyboardNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mainView.layer.addSublayer(gradient)
        mainView.setGradient(gradient: gradient, colors: Manager.globalColor)
        searchBar.barTintColor = UIColor(cgColor: Manager.globalColor[0])
    }
    
    @objc func addToFavoriteList(sender: UIButton) {

        let citySorted = Manager.realm.objects(Locality.self).filter("id = %@", cityList[sender.tag].id)
        let favoriteSorted = Manager.realm.objects(Locality.self).filter("favorite = %@", true)
 
        if let city = citySorted.first {
            if favoriteSorted.count > 19 && city.favorite == false {
                showAlert()
            } else {
                try! Manager.realm.write {
                    city.favorite = city.favorite ? false: true
                }
            }
        }
        tableView.reloadData()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "The list of favorites is full", message: "You can select no more than 20 cities for selected locations.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func kbWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let kbFrameSize = (userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        tableViewBotConstr.constant = kbFrameSize.height - 60
        tableView.layer.layoutIfNeeded()
    }
    
    @objc func kbWillHide() {
        tableViewBotConstr.constant = 0
        tableView.layer.layoutIfNeeded()
    }
    
 
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchDetaliesButtonPressed(_ sender: UIButton) {
        if searchOptions == "name" {
            searchOptions = "country"
            sender.setTitle("Country", for: .normal)
        } else {
            searchOptions = "name"
            sender.setTitle("City", for: .normal)
        }
    }
    
    @IBAction func favoriteListButtonPressed(_ sender: UIButton) {
        if sender.titleLabel?.text == "favor" {
            cityList = Manager.realm.objects(Locality.self).filter("favorite = %@", true)
            sender.setTitle("All", for: .normal)
        } else {
            cityList = Manager.result
            sender.setTitle("favor", for: .normal)
        }
        tableView.reloadData()
    }
}

extension CityListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            cityList = Manager.realm.objects(Locality.self).filter("\(searchOptions) CONTAINS [c] %@", searchText)
        } else {
            cityList = Manager.result
        }
        tableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

extension CityListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cityList.count != 0 {
            return cityList.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityListCell") as? CityListCell else {
            return CityListCell()
        }
        let item = cityList[indexPath.row]
        cell.loadWith(locality: item)
        cell.favoriteButton.tag = indexPath.row
        cell.favoriteButton.addTarget(self, action: #selector(addToFavoriteList(sender:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NetworkManager.getWeatherById(id: cityList[indexPath.row].id) { (weather) in
            self.delegate?.setNewWeather(newWeather: weather)
            self.navigationController?.popViewController(animated: true)
        }
    }
}















