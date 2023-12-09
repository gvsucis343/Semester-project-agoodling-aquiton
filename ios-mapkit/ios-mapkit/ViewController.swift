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
    var hunt: ScavengerHunts = ScavengerHunts(name: "")




    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        //check for Authorization to use users location
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
        //show users location
        mapView.showsUserLocation = true;
    }
    
    //Add pin to maps
    private func AddPin()
    {
        for pin in hunt.annotations{
            mapView.addAnnotation(pin)
        }
        mapView.showAnnotations(self.mapView.annotations, animated: true)
        
    }
    
    //Delegation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "huntSegue"){
            if let dest = segue.destination as? HuntTableViewController{
                dest.huntDelegate = self
            }
        }
    }
 
}

//Delegation
extension ViewController: HuntTableViewControllerDelegate {
    func hasSelected(entry: ScavengerHunts) {
        print("delegated")
        hunt = entry
        mapView.removeAnnotations(mapView.annotations)
        AddPin()
    }
    
    
}


