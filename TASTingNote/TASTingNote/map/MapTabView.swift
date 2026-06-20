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

struct MapWine: Identifiable {

    let id = UUID()

    let name: String
    let image: UIImage?
    let latitude: Double
    let longitude: Double
    let tastingDate: Date

    let whiteWine: Wine?
    let redWine: redWine?
}

struct WineGroup: Identifiable {
    var id: String {
        "\(latitude),\(longitude)"
    }

    let latitude: Double
    let longitude: Double
    let wines: [MapWine]
}

struct MapTabView: View {

    @StateObject private var locationManager = LocationManager()
    @Query private var wines: [Wine]
    @Query private var redWines: [redWine]
    @State private var followUser = true
    @State private var groupedWines: [WineGroup] = []
    
    enum ActiveSheet: Identifiable {

        case whiteWine(Wine)
        case redWine(redWine)
        case wineList([MapWine])

        var id: String {

            switch self {

            case .whiteWine(let wine):
                return "white-\(wine.persistentModelID)"

            case .redWine(let wine):
                return "red-\(wine.persistentModelID)"

            case .wineList(let wines):
                return UUID().uuidString
            }
        }
    }

    @State private var activeSheet: ActiveSheet?
    
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

                                let wine = group.wines[0]

                                if let white = wine.whiteWine {
                                    activeSheet = .whiteWine(white)
                                } else if let red = wine.redWine {
                                    activeSheet = .redWine(red)
                                }

                            } else {

                                activeSheet = .wineList(group.wines)
                            }

                        } label: {

                            VStack(spacing: 4) {

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

                                if group.wines.count == 1 {

                                    Text(group.wines[0].name)
                                        .font(.caption2)
                                        .lineLimit(1)
                                        .padding(.horizontal, 6)
                                        .padding(.vertical, 2)
                                        .background(.ultraThinMaterial)
                                        .clipShape(Capsule())

                                } else {

                                    Text("\(group.wines.count)本のワイン")
                                        .font(.caption2.bold())
                                        .padding(.horizontal, 6)
                                        .padding(.vertical, 2)
                                        .background(.ultraThinMaterial)
                                        .clipShape(Capsule())
                                }
                            }
                        }
                    }
                }
            }
            .simultaneousGesture(
                DragGesture(minimumDistance: 1)
                    .onChanged { _ in
                        followUser = false
                    }
            )
            .sheet(item: $activeSheet) { sheet in

                switch sheet {

                case .whiteWine(let wine):
                    WhiteWineTastingSheetView(wine: wine)

                case .redWine(let wine):
                    RedWineTastingSheetView(wine: wine)

                case .wineList(let wines):
                    WineListView(wines: wines)
                }
            }
            .ignoresSafeArea(edges: .bottom)
            .navigationTitle("Map")
            .onAppear {
                groupedWines = makeWineGroups()
            }
            .onChange(of: wines.count) {
                groupedWines = makeWineGroups()
            }
            .onChange(of: redWines.count) {
                groupedWines = makeWineGroups()
            }

            .overlay(alignment: .bottomTrailing) {

                Button {

                    followUser = true
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
            .onReceive(locationManager.$currentLocation.compactMap { $0 }) { location in
                guard followUser else { return }

                let region = MKCoordinateRegion(
                    center: location.coordinate,
                    span: MKCoordinateSpan(
                        latitudeDelta: 0.01,
                        longitudeDelta: 0.01
                    )
                )

                locationManager.cameraPosition = .region(region)
            }
        }
    }
    
    private func makeWineGroups() -> [WineGroup] {

        // 白・赤をまとめた配列
        var allWines: [MapWine] = []

        // 白ワイン
        for wine in wines {

            guard let lat = wine.latitude,
                  let lon = wine.longitude else {
                continue
            }

            allWines.append(
                MapWine(
                    name: wine.name,
                    image: wine.image,
                    latitude: lat,
                    longitude: lon,
                    tastingDate: wine.tastingDate,
                    whiteWine: wine,
                    redWine: nil
                )
            )
        }

        // 赤ワイン
        for wine in redWines {

            guard let lat = wine.latitude,
                  let lon = wine.longitude else {
                continue
            }

            allWines.append(
                MapWine(
                    name: wine.name,
                    image: wine.image,
                    latitude: lat,
                    longitude: lon,
                    tastingDate: wine.tastingDate,
                    whiteWine: nil,
                    redWine: wine
                )
            )
        }

        // 同じ場所をまとめる
        var groups: [WineGroup] = []

        for wine in allWines {

            if let index = groups.firstIndex(where: {

                CLLocation(
                    latitude: $0.latitude,
                    longitude: $0.longitude
                )
                .distance(
                    from: CLLocation(
                        latitude: wine.latitude,
                        longitude: wine.longitude
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
                        latitude: wine.latitude,
                        longitude: wine.longitude,
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
        guard let location = locations.first else { return }

        currentLocation = location
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
