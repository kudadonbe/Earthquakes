//
//  QuakeDetailMap.swift
//  Earthquakes-iOS
//
//  Created by Hussain Shareef on 2/3/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import SwiftUI
import MapKit

struct QuakeDetailMap: View {
    let location: QuakeLocation
    let tintColor: Color
    private var place: QuakePlace
    
    @State private var region = MKCoordinateRegion()
    
    
    init(location: QuakeLocation, tintColor: Color) {
        self.location = location
        self.tintColor = tintColor
        self.place = QuakePlace(location: location)
    }
    
    
    
    var body: some View {
        
        
        
        Map(coordinateRegion: $region, annotationItems: [place]) { place in
            MapMarker(coordinate: place.location, tint: tintColor)
        }
            .onAppear {
                withAnimation {
                    region.center = place.location
                    region.span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
                }
            }
    }
}

struct QuakePlace: Identifiable {
    let id: UUID
    let location: CLLocationCoordinate2D
    
    init(id: UUID = UUID(), location: QuakeLocation) {
        self.id = id
        self.location = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
    }
}

