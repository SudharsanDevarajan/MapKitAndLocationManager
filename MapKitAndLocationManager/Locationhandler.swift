//
//  Locationhandler.swift
//  MapKitAndLocationManager
//
//  Created by Sudharsan on 13/02/21.
//

import Foundation
import CoreLocation

class LocationHandler: NSObject, CLLocationManagerDelegate{
    
    static let shared = LocationHandler()
    
    let manager = CLLocationManager()
    var completion: ((CLLocation) -> Void)?
    
    func getUserLocation(completion: @escaping ((CLLocation) -> Void)){
        self.completion = completion
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else{return}
        
        completion?(location)
        manager.stopUpdatingLocation()
    }
    
    public func getLocationName(with location: CLLocation,
                                completion: @escaping ((String?) -> Void)){
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location, preferredLocale: .current) { placemark, error in
            
            guard let place = placemark?.first, error == nil else{
                completion(nil)
                return
            }
            print(place)
             var name = ""
            
            if let locality = place.locality{
                name +=  locality
            }
            
            if let region = place.administrativeArea{
                name += ", \(region)"
            }
            
            completion(name)
        }
    }
    
    
}
