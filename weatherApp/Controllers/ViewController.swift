//
//  ViewController.swift
//  weatherApp
//
//  Created by TimoXaq on 20/03/2018.
//  Copyright © 2018 TimoXaq. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    
    let sunImageView: UIImageView = UIImageView()
    let cloudImageView: UIImageView = UIImageView()
    let logoLabel: UILabel = UILabel()
    let gradient = CAGradientLayer()
    
    let locationService = LocationManager()
  
    override func viewDidLoad() {
        initialSteup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mainView.layer.addSublayer(gradient)
        mainView.animateGradient(gradient: gradient, gradientSet: Manager.colorArray, currentGradientIndex: 0)
        self.viewsSetup()
    }
    
    func initialSteup() {
        navigationController?.navigationBar.isHidden = true
        self.getWeatherInfo()
        self.cityListSetup()
    }

    func cityListSetup() {
        if Manager.result.count == 0 {
            saveCityListToRealm()
        }
    }
    
    func saveCityListToRealm() {
        NetworkManager.getCityList { (list) in
            DispatchQueue.main.async {
                try! Manager.realm.write {
                    Manager.realm.add(list.sorted(by: { $0.name < $1.name }))
                }
            }
        }
    }

    func getWeatherInfo() {
        if Manager.actualLat == "" && Manager.actualLocality == "" {
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                self.getWeatherInfo()
            }
        } else {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.6, delay: 0, animations: {
                    self.sunImageView.alpha = 1
                }) { (true) in
                    UIView.animate(withDuration: 0.6, delay: 0.3, animations: {
                        self.cloudImageView.alpha = 1
                    }, completion: { (true) in
                        UIView.animate(withDuration: 0.6, delay: 0.6, animations: {
                            self.logoLabel.alpha = 1
                        }, completion: { (true) in
                            self.goToMain()
                        })
                    })
                }
            }
        }
    }

    func goToMain() {
        NetworkManager.getWeatherForActualPlace(latitude: Manager.actualLat, longitude: Manager.actualLon) { (weather) in
            weather.name = Manager.actualLocality
            if let controller = self.storyboard?.instantiateViewController(withIdentifier: "WeatherInfoViewController") as? WeatherInfoViewController {
                controller.weather = weather
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
    
    func viewsSetup() {

        let sunSize = self.mainView.frame.width * 0.3
        let sunX = self.mainView.frame.size.width/2
        let sunY = self.mainView.frame.size.height/2-sunSize
        sunImageView.frame = CGRect(x: sunX, y: sunY, width: sunSize, height: sunSize)
        sunImageView.image = #imageLiteral(resourceName: "sun")
        sunImageView.contentMode = .scaleAspectFit
        sunImageView.alpha = 0
        mainView.addSubview(sunImageView)
      
        let cloudWidth = self.mainView.frame.width * 0.6
        let cloudHeight = self.mainView.frame.width * 0.45
        let cloudX = (self.mainView.frame.width - cloudWidth)/2
        let cloudY = (self.mainView.frame.height/2 - cloudHeight/2)
        cloudImageView.frame = CGRect(x: cloudX, y: cloudY, width: cloudWidth, height: cloudHeight)
        cloudImageView.image = #imageLiteral(resourceName: "cloud")
        cloudImageView.contentMode = .scaleAspectFill
        cloudImageView.alpha = 0
        mainView.addSubview(cloudImageView)
        
        let logoLabelHeight = self.mainView.frame.width * 0.1
        let logoLabelWidth = self.mainView.frame.width * 0.6
        let logoX = (self.mainView.frame.width - cloudWidth)/2
        let logoY = self.mainView.frame.height/2 + self.mainView.frame.width*0.1
        
        logoLabel.frame = CGRect(x: logoX, y: logoY, width: logoLabelWidth, height: logoLabelHeight)
        logoLabel.adjustsFontSizeToFitWidth = true
        logoLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 40)
        logoLabel.textColor = .white
        logoLabel.textAlignment = .center
        logoLabel.text = "WEATHAPP"
        logoLabel.alpha = 0
        mainView.addSubview(logoLabel)
    }
}
