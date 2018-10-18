//
//  LocationManager.swift
//  weatherApp
//
//  Created by Tima on 03.10.2018.
//  Copyright © 2018 TimoXaq. All rights reserved.
//

import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        configuration()
    }
    
    func configuration() {
        locationManager.delegate = self
    }
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func start() {
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .authorizedWhenInUse {return}
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
        if let location = manager.location {
            let locValue: CLLocationCoordinate2D = location.coordinate
            print(locValue.latitude,locValue.longitude)
            Manager.actualLat = String(locValue.latitude)
            Manager.actualLon = String(locValue.longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = manager.location {
            let locValue: CLLocationCoordinate2D = location.coordinate
            self.getNameLocation(lat: locValue.latitude, lon: locValue.longitude)
        }
    }
    
    func getNameLocation(lat: Double, lon: Double) {
        let location = CLLocation(latitude: lat, longitude: lon)
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            self.processResponse(withPlacemarks: placemarks, error: error)
        }
    }
    
    func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        if let error = error {
            print("Unable to Reverse Geocode Location (\(error))")
            print("Unable to Find Address for Location")
        } else {
            if let placemarks = placemarks, let placemark = placemarks.first, let address = placemark.compactAddress {
                
                Manager.actualLocality = address
                print(address)
            } else {
                print("No Matching Addresses Found")
            }
        }
    } 
}


