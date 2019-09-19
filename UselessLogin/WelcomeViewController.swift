//
//  WelcomeViewController.swift
//  UselessLogin
//
//  Created by Yoltic Cervantes Galeana on 9/16/19.
//  Copyright © 2019 Yoltic Cervantes Galeana. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class WelcomeViewController: UIViewController
{
    
    @IBOutlet weak var MapView: MKMapView!
    private let locationManager = CLLocationManager()
    private var currentLocation:  CLLocationCoordinate2D!
    private var destinations: [MKAnnotation] = []
    private var currentRoute: MKRoute?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocationServices()
    }
    
    private func configureLocationServices()
    {
        locationManager.delegate = self
        let status = CLLocationManager.authorizationStatus()
        if status == .notDetermined
        {
            locationManager.requestAlwaysAuthorization()
        } else if status == .authorizedAlways || status == .authorizedWhenInUse
        {
            beginLocationUpdates(locationManager: locationManager)
        }
    }
    
    private func beginLocationUpdates(locationManager: CLLocationManager)
    {
        MapView.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    private func  zoomToLatestLocation(with coordinate: CLLocationCoordinate2D)
    {
        let region = MKCoordinateRegion(center: coordinate , latitudinalMeters: 25000, longitudinalMeters: 25000)
        MapView.setRegion(region, animated: true)
    }
    
    private func addAnotations()
    {
        let Yol = MKPointAnnotation()
        Yol.title =  "Yoltic Cervantes Galeana"
        Yol.coordinate =  CLLocationCoordinate2D(latitude: 19.2868572, longitude: -99.6082923)
        MapView.addAnnotation(Yol)
        
        destinations.append(Yol)
        let Chuck = MKPointAnnotation()
        Chuck.title =  "Irving Salazar Ruiz"
        Chuck.coordinate =  CLLocationCoordinate2D(latitude: 19.262394, longitude: -99.709890)
        MapView.addAnnotation(Chuck)
        destinations.append(Chuck)
    }
    
    private func constructRoute(userLocation:  CLLocationCoordinate2D)
    {
        let directionsRequest = MKDirections.Request()
        directionsRequest.source = MKMapItem(placemark:  MKPlacemark(coordinate: userLocation))
        directionsRequest.destination = MKMapItem(placemark:  MKPlacemark(coordinate: destinations[0].coordinate))
        directionsRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionsRequest)
        
        directions.calculate
        { [weak self](directionsResponse, error) in
            guard let strongSelf = self else {return}
            if let err = error
            {
                print(err.localizedDescription)
            }
            else if let response = directionsResponse, response.routes.count > 0
            {
                strongSelf.currentRoute = response.routes[0]
                strongSelf.MapView.addOverlay(response.routes[0].polyline)
                strongSelf.MapView.setVisibleMapRect(response.routes[0].polyline.boundingMapRect, animated: true)
                
            }
        }
    }
}

extension WelcomeViewController: CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        guard let latestLocation = locations.first else {return}
        if currentLocation == nil
        {
            zoomToLatestLocation(with: latestLocation.coordinate)
            addAnotations()
            //constructRoute(userLocation: latestLocation.coordinate )
        }
        currentLocation = latestLocation.coordinate
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        if status == .authorizedAlways || status == .authorizedWhenInUse
        {
            beginLocationUpdates(locationManager: manager
            )
        }
    }
}
/*
extension WelcomeViewController: MKMapViewDelegate
{
    func mapView(_ mapView:MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer
    {
        guard let currRoute = currentRoute else
        {
            return MKOverlayRenderer()
        }
        
        let plRenderer = MKPolylineRenderer (polyline: currentRoute!.polyline )
        plRenderer.strokeColor = UIColor.blue
        return plRenderer
    }
    
    func mapView(_ mapView:MKMapView, didSelect view: MKAnnotationView)
    {
        print("The annotation was selected: \(String(describing: view.annotation?.title))")
    }
}
*/
