//
//  MapTabView.swift
//  TASTingNote
//
//  Created by 佐々木 勇太 on 2026/05/10.
//


import SwiftUI
import MapKit
import CoreLocation
import Combine
import SwiftData

struct MapTabView: View {

    @StateObject private var locationManager = LocationManager()
    @Query private var wines: [Wine]
    @State private var selectedWine: Wine?

    @State private var selectedLocationWines: [Wine] = []
    @State private var showWineList = false
    
    var body: some View {

        NavigationStack {

            Map(position: $locationManager.cameraPosition) {

                UserAnnotation()

                ForEach(wines) { wine in
                    if let lat = wine.latitude,
                       let lon = wine.longitude {

                        Annotation(
                            wine.name,
                            coordinate: CLLocationCoordinate2D(
                                latitude: lat,
                                longitude: lon
                            )
                        ) {

                            Button {

                                let nearbyWines = wines.filter { otherWine in

                                    guard let otherLat = otherWine.latitude,
                                          let otherLon = otherWine.longitude,
                                          let wineLat = wine.latitude,
                                          let wineLon = wine.longitude
                                    else {
                                        return false
                                    }

                                    let distance = CLLocation(
                                        latitude: wineLat,
                                        longitude: wineLon
                                    )
                                    .distance(
                                        from: CLLocation(
                                            latitude: otherLat,
                                            longitude: otherLon
                                        )
                                    )

                                    return distance < 30
                                }

                                if nearbyWines.count <= 1 {

                                    selectedWine = wine

                                } else {

                                    selectedLocationWines = nearbyWines
                                    showWineList = true
                                }

                            } label: {

                                if let image = wine.image {

                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 60, height: 60)
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle()
                                                .stroke(.white, lineWidth: 3)
                                        )
                                        .shadow(radius: 4)

                                } else {

                                    Image(systemName: "wineglass.fill")
                                        .font(.title)
                                        .foregroundStyle(.red)
                                }
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $showWineList) {

                NavigationStack {

                    List(selectedLocationWines) { wine in

                        Button {

                            showWineList = false

                            DispatchQueue.main.asyncAfter(
                                deadline: .now() + 0.3
                            ) {
                                selectedWine = wine
                            }

                        } label: {

                            HStack {

                                if let image = wine.image {

                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(
                                            width: 50,
                                            height: 50
                                        )
                                        .clipShape(Circle())
                                }

                                VStack(alignment: .leading) {

                                    Text(wine.name)

                                    Text(
                                        wine.tastingDate,
                                        format: .dateTime.year().month().day()
                                    )
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }
                    .navigationTitle("この場所のワイン")
                }
            }
            .sheet(item: $selectedWine) { wine in

                NavigationStack {

                    WhiteWineTastingSheetView(
                        wine: wine
                    )
                }
            }
            .ignoresSafeArea(edges: .bottom)
            .navigationTitle("Map")

            .overlay(alignment: .bottomTrailing) {

                Button {

                    locationManager.moveToCurrentLocation()

                } label: {

                    Image(systemName: "location.fill")
                        .font(.title2)
                        .foregroundStyle(.blue)
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                        .shadow(radius: 3)
                }
                .padding()
            }
        }
    }
}

final class LocationManager:
    NSObject,
    ObservableObject,
    CLLocationManagerDelegate {

    private let manager = CLLocationManager()

    @Published var cameraPosition:
        MapCameraPosition = .automatic

    @Published var currentLocation:
        CLLocation?

    // 初回だけ現在地へ移動するためのフラグ
    private var hasCenteredMap = false

    override init() {

        super.init()

        manager.delegate = self

        manager.desiredAccuracy =
            kCLLocationAccuracyBest

        manager.requestWhenInUseAuthorization()

        manager.startUpdatingLocation()
    }

    // 現在地ボタン用
    func moveToCurrentLocation() {

        guard let location =
            currentLocation else {
            return
        }

        let region = MKCoordinateRegion(
            center: location.coordinate,
            span: MKCoordinateSpan(
                latitudeDelta: 0.01,
                longitudeDelta: 0.01
            )
        )

        cameraPosition = .region(region)
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {

        guard let location =
            locations.first else {
            return
        }

        currentLocation = location

        // 初回のみ現在地へ移動
        guard !hasCenteredMap else {
            return
        }

        hasCenteredMap = true

        let region = MKCoordinateRegion(
            center: location.coordinate,
            span: MKCoordinateSpan(
                latitudeDelta: 0.01,
                longitudeDelta: 0.01
            )
        )

        cameraPosition = .region(region)

        // 以降は更新停止
        manager.stopUpdatingLocation()
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {

        print(
            "位置情報取得エラー:",
            error.localizedDescription
        )
    }

    func locationManagerDidChangeAuthorization(
        _ manager: CLLocationManager
    ) {

        switch manager.authorizationStatus {

        case .authorizedAlways,
             .authorizedWhenInUse:

            manager.startUpdatingLocation()

        default:
            break
        }
    }
}
