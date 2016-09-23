//
//  ViewController.swift
//  Onde estou
//
//  Created by Juliana Morota on 9/23/16.
//  Copyright © 2016 ios. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var cursoLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var velocidadeLabel: UILabel!
    @IBOutlet weak var enderecoLabel: UILabel!
    
    var manager:CLLocationManager!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        print(locations)
        let userLocation:CLLocation = locations[0]
        latitudeLabel.text = "\(userLocation.coordinate.latitude)"
        longitudeLabel.text = "\(userLocation.coordinate.longitude)"
        cursoLabel.text = "\(userLocation.course)"
        altitudeLabel.text = "\(userLocation.altitude)"
        velocidadeLabel.text = "\(userLocation.speed)"
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if (error != nil)
            {
                print(error)
            }
            else
            {
                let placemark = placemarks?[0]
                let userPlacemark = CLPlacemark(placemark: placemark!)
                print(userPlacemark)
                self.enderecoLabel.text = "\(userPlacemark.subLocality) \(userPlacemark.subAdministrativeArea) \(userPlacemark.postalCode) \(userPlacemark.country)"
            }
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }


}

