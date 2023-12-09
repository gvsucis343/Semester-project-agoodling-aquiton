//
//  ScavengerHunts.swift
//  ios-mapkit
//
//  Created by Alex Quiton on 12/7/23.
//

import Foundation
import MapKit

class ScavengerHunts{
    var annotations: [MKPointAnnotation] = []
    var huntName: String = ""
    var huntProgress: String = "Uncompleted"
    
    init(name: String){
        self.huntName = name
    }
    
    func CreatePin(lat: Double, long: Double, pinName: String){
        var annotation1 = MKPointAnnotation()
        annotation1.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        annotation1.title = pinName
        annotation1.subtitle = "Uncompleted"
        self.annotations.append(annotation1)
        return
    }
    
    
}



