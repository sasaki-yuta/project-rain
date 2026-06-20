//
//  MapLocationPickerViewRed.swift
//  TASTingNote
//
//  Created by 佐々木 勇太 on 2026/06/20.
//
import SwiftUI
import MapKit

struct MapLocationPickerViewRed: View {

    @Environment(\.dismiss) private var dismiss

    @Binding var latitude: Double?
    @Binding var longitude: Double?

    @StateObject private var locationManager =
        RedWineLocationManager()

    @State private var position: MapCameraPosition =
        .automatic

    @State private var centerCoordinate =
        CLLocationCoordinate2D()
    
    @State private var hasMovedToCurrentLocation = false

    var body: some View {

        NavigationStack {

            Map(position: $position)
                .onMapCameraChange { context in

                    centerCoordinate =
                        context.region.center
                }
                .onAppear {

                    guard let location =
                        locationManager.location
                    else { return }

                    let coordinate =
                        location.coordinate

                    centerCoordinate = coordinate

                    position = .region(
                        MKCoordinateRegion(
                            center: coordinate,
                            span: MKCoordinateSpan(
                                latitudeDelta: 0.01,
                                longitudeDelta: 0.01
                            )
                        )
                    )
                }

            .overlay {

                Image(systemName: "mappin.circle.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(.red)
            }

            .navigationTitle("場所を選択")

            .toolbar {

                ToolbarItem(
                    placement: .topBarLeading
                ) {

                    Button("キャンセル") {
                        dismiss()
                    }
                }

                ToolbarItem(
                    placement: .topBarTrailing
                ) {

                    Button("保存") {

                        latitude =
                            centerCoordinate.latitude

                        longitude =
                            centerCoordinate.longitude

                        dismiss()
                    }
                }
            }
            .onReceive(locationManager.$location) { location in

                guard !hasMovedToCurrentLocation else {
                    return
                }

                guard let location else {
                    return
                }

                hasMovedToCurrentLocation = true

                let coordinate = location.coordinate

                centerCoordinate = coordinate

                position = .region(
                    MKCoordinateRegion(
                        center: coordinate,
                        span: MKCoordinateSpan(
                            latitudeDelta: 0.01,
                            longitudeDelta: 0.01
                        )
                    )
                )
            }
            .onAppear {

                if let lat = latitude,
                   let lon = longitude {

                    let coordinate = CLLocationCoordinate2D(
                        latitude: lat,
                        longitude: lon
                    )

                    centerCoordinate = coordinate

                    position = .region(
                        MKCoordinateRegion(
                            center: coordinate,
                            span: MKCoordinateSpan(
                                latitudeDelta: 0.01,
                                longitudeDelta: 0.01
                            )
                        )
                    )

                    hasMovedToCurrentLocation = true
                }
            }
        }
    }
}
