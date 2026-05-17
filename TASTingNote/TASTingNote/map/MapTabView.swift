//
//  MapTabView.swift
//  TASTingNote
//
//  Created by 佐々木 勇太 on 2026/05/10.
//

import SwiftUI
import MapKit
import CoreLocation
internal import Combine

struct MapTabView: View {
    
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        NavigationView {
            Map(position: $locationManager.cameraPosition)
                .ignoresSafeArea(edges: .bottom)
                .navigationTitle("Map")
        }
    }
}

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let manager = CLLocationManager()
    @Published var cameraPosition: MapCameraPosition = .automatic
    
    override init() {
        super.init()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        // 位置情報許可
        manager.requestWhenInUseAuthorization()
        
        // GPS開始
        manager.startUpdatingLocation()
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.first else { return }
        
        let region = MKCoordinateRegion(
            center: location.coordinate,
            span: MKCoordinateSpan(
                latitudeDelta: 0.01,
                longitudeDelta: 0.01
            )
        )
        
        cameraPosition = .region(region)
    }
}
