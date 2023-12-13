//
//  ViewController.swift
//  ios-mapkit
//
//  Created by Alex Quiton on 11/28/23.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var hunt: ScavengerHunts!
    var hideCreateButtons = true
    var createCounter: Int = 0
    

    @IBOutlet weak var ScavHuntButton: UIButton!
    @IBOutlet weak var createPin: UIButton!
    @IBOutlet weak var cancelCreate: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapView.delegate = self
        
        createPin.isHidden = hideCreateButtons
        cancelCreate.isHidden = hideCreateButtons
        doneButton.isHidden = hideCreateButtons
        
        
        
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
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // Ensure the selected annotation is of type MKPointAnnotation
        guard let annotation = view.annotation as? MKPointAnnotation else {
            return
        }

        // Access the coordinates of the selected pin
        _ = annotation.coordinate

        // Print the coordinates to the terminal window
        let alert = UIAlertController(title: "Spot Visited?", message: "Has this spot been visited?", preferredStyle: .alert)

            // Add a button to the alert
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                // Handle the case where the spot has been visited
                annotation.subtitle = "Done"
    
            }))

            // Add a cancel button to the alert
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
            // Handle the case where the spot has been visited
            annotation.subtitle = "Uncompleted"
            
            
        }))

            // Present the alert
            present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func add(_ sender: UIButton) {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        hunt?.CreatePin(lat: locationManager.location?.coordinate.latitude, long: locationManager.location?.coordinate.longitude , pinName: "\(createCounter)")
        createCounter += 1
        AddPin()
        
    }
    
    
    
    
    @IBAction func cancel(_ sender: UIButton) {
        hideCreateButtons = true
        updateButtons()
        mapView.removeAnnotations(mapView.annotations)
    }
    
    @IBAction func done(_ sender: UIButton) {
        hideCreateButtons = true
        updateButtons()
        createCounter = 0
        print("done making hunt")
    }
    
    
    //Add pin to maps
    private func AddPin()
    {
        for pin in hunt.annotations{
            mapView.addAnnotation(pin)
        }
        mapView.showAnnotations(self.mapView.annotations, animated: true)
        
    }
    
    private func updateButtons(){
        createPin.isHidden = hideCreateButtons
        cancelCreate.isHidden = hideCreateButtons
        doneButton.isHidden = hideCreateButtons
        ScavHuntButton.isHidden = !hideCreateButtons
    }
    
    //Delegation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "huntSegue"){
            if let dest = segue.destination as? HuntTableViewController{
                dest.huntDelegate = self
                dest.checkHunts()
            }
        }
        if(segue.identifier == "doneSegue"){
            if let dest = segue.destination as? HuntTableViewController{
                dest.huntDelegate = self
                dest.huntCreated = hunt
               dest.updateScavengerHunts()
            }
        }
    }
 
}

//Delegation
extension ViewController: HuntTableViewControllerDelegate {
    func hasSelected(entry: ScavengerHunts) {
        hunt = entry
        mapView.removeAnnotations(mapView.annotations)
        AddPin()
    }
    
    func pressedCreate(entry: Bool, hunt: ScavengerHunts) {
        mapView.removeAnnotations(mapView.annotations)
        hideCreateButtons = entry
        self.hunt = hunt
        updateButtons()
    }
    
    
}


