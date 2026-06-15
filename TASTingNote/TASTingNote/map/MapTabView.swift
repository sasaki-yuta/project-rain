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


struct WineGroup: Identifiable {
    let id = UUID()
    let latitude: Double
    let longitude: Double
    let wines: [Wine]
}

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
                ForEach(groupedWines) { group in

                    Annotation(
                        "",
                        coordinate: CLLocationCoordinate2D(
                            latitude: group.latitude,
                            longitude: group.longitude
                        )
                    ) {

                        Button {

                            if group.wines.count == 1 {

                                selectedWine = group.wines[0]

                            } else {

                                selectedLocationWines = group.wines
                                showWineList = true
                            }

                        } label: {

                            VStack(spacing: 0) {

                                if let image = group.wines.first?.image {

                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 60, height: 60)
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle()
                                                .stroke(.white, lineWidth: 3)
                                        )

                                } else {

                                    Image(systemName: "wineglass.fill")
                                        .font(.title)
                                        .foregroundStyle(.red)
                                }

                                if group.wines.count > 1 {

                                    Text("\(group.wines.count)")
                                        .font(.caption.bold())
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 3)
                                        .background(.red)
                                        .foregroundStyle(.white)
                                        .clipShape(Capsule())
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
    
    private var groupedWines: [WineGroup] {

        var groups: [WineGroup] = []

        for wine in wines {

            guard let lat = wine.latitude,
                  let lon = wine.longitude
            else { continue }

            if let index = groups.firstIndex(where: {

                CLLocation(
                    latitude: $0.latitude,
                    longitude: $0.longitude
                )
                .distance(
                    from: CLLocation(
                        latitude: lat,
                        longitude: lon
                    )
                ) < 30

            }) {

                let existing = groups[index]

                groups[index] = WineGroup(
                    latitude: existing.latitude,
                    longitude: existing.longitude,
                    wines: existing.wines + [wine]
                )

            } else {

                groups.append(
                    WineGroup(
                        latitude: lat,
                        longitude: lon,
                        wines: [wine]
                    )
                )
            }
        }

        return groups
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
