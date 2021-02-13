//
//  HomeViewController.swift
//  MapKitAndLocationManager
//
//  Created by Sudharsan on 13/02/21.
//

import UIKit
import CoreLocation
import MapKit

class HomeViewController: UIViewController {
    
    private let map: MKMapView = {
       let map = MKMapView()
        return map
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(map)
        self.title = "Home"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        LocationHandler.shared.getUserLocation { [weak self] location in
            DispatchQueue.main.async {
                guard let strongSelf = self else{return}
                strongSelf.addMapPin(with: location)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        map.frame = view.bounds
    }
    
    func addMapPin(with location: CLLocation){
        let pin = MKPointAnnotation()
        pin.coordinate = location.coordinate
        map.setRegion(MKCoordinateRegion(center: location.coordinate,
                                         span: MKCoordinateSpan(latitudeDelta: 0.9, longitudeDelta: 0.9)), animated: true)
        map.addAnnotation(pin)
        
        LocationHandler.shared.getLocationName(with: location) { locationName in
            self.title = locationName
        }
    }

}
