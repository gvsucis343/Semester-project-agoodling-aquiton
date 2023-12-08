//
//  ViewController.swift
//  ios-mapkit
//
//  Created by Alex Quiton on 11/28/23.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var hunt: ScavengerHunts = ScavengerHunts()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()

        switch locationManager.authorizationStatus {
                    case .notDetermined:
                        print("Not determined")
                    case .restricted:
                        print("Restricted")
                    case .denied:
                        print("Denied")
                    case .authorizedAlways:
                        print("Authorized Always")
                    case .authorizedWhenInUse:
                        print("Authorized When in Use")
                    @unknown default:
                        print("Unknown status")
                    }
        mapView.showsUserLocation = true;
    }
    
    
    private func AddPin()
    {
        let annotation1 = MKPointAnnotation()
//        annotation1.coordinate = CLLocationCoordinate2D(latitude: hunt.latitudes[0], longitude: hunt.longitudes[0])
//        annotation1.title = hunt.huntName
//        annotation1.subtitle = hunt.huntProgress
//        mapView.addAnnotation(annotation1)
        mapView.showAnnotations(self.mapView.annotations, animated: true)
        print("added annotation")
        
        
        for i in 0...(hunt.latitudes.count - 1){
            annotation1.coordinate = CLLocationCoordinate2D(latitude: hunt.latitudes[i], longitude: hunt.longitudes[i])
            annotation1.title = hunt.huntName
            annotation1.subtitle = hunt.huntProgress
            mapView.addAnnotation(annotation1)
        }
        
        mapView.showAnnotations(self.mapView.annotations, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "huntSegue"){
            if let dest = segue.destination as? HuntTableViewController{
                dest.huntDelegate = self
            }
        }
    }
 
}

extension ViewController: HuntTableViewControllerDelegate {
    func hasSelected(entry: ScavengerHunts) {
        print("delegated")
        hunt = entry
        mapView.removeAnnotations(mapView.annotations)
        AddPin()
    }
    
    
}


