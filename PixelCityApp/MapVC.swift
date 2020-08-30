//
//  MapVC.swift
//  PixelCityApp
//
//  Created by El nino Cholo on 2020/08/29.
//  Copyright © 2020 El nino Cholo. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import MapKit
import CoreLocation

class MapVC: UIViewController {
    

    @IBOutlet weak var myMap: MKMapView!
    
    var locationmanager = CLLocationManager()
    let authorization = CLLocationManager.authorizationStatus()
    let radiusRegion:Double = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myMap.delegate = self
        locationmanager.delegate = self
        configurelocationservices()
        tapegesture()
        locationmanager.startUpdatingLocation()
    }

    @IBAction func mapbuttonwaspressed(_ sender: Any) {
        if authorization == .authorizedWhenInUse || authorization == .authorizedAlways
        {
            centertheMaptouser()
        }
    }
    
    
    func tapegesture()
    {
        let doubletape = UITapGestureRecognizer(target: self, action: #selector(tapped(sender:)))
        doubletape.numberOfTapsRequired = 2
        myMap.addGestureRecognizer(doubletape)
    }
    
    
    @objc func tapped(sender: UIGestureRecognizer)
    {
        removepin()
        let point = sender.location(in: myMap)
        let coordinate = myMap.convert(point, toCoordinateFrom: myMap)
        let annotation = dropPin(coordinate: coordinate, identifier: "Erick Elnino")
        myMap.addAnnotation(annotation)

        
        let coodinatregion = MKCoordinateRegion(center: coordinate, latitudinalMeters: radiusRegion * 2.0, longitudinalMeters: radiusRegion * 2.0)
        
        myMap.setRegion(coodinatregion, animated: true)
    }
    
    func removepin()
    {
        for annotation in myMap.annotations
        {
            myMap.removeAnnotation(annotation)
        }
    }
}
extension MapVC: MKMapViewDelegate
{
    func centertheMaptouser()
    {
        guard let coordinate = locationmanager.location?.coordinate else {return}
        let coordinateregion = MKCoordinateRegion(center: coordinate, latitudinalMeters: radiusRegion * 2.0, longitudinalMeters: radiusRegion * 2.0)
          myMap.setRegion(coordinateregion, animated: true)
        
    }
    
}
extension MapVC: CLLocationManagerDelegate
{
    func  configurelocationservices()
    {
        if authorization == .notDetermined
        {
            locationmanager.requestWhenInUseAuthorization()
        }else
        {
            return
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        centertheMaptouser()
    }
}
