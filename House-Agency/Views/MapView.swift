//
//  MapVIew.swift
//  House-Agency
//
//  Created by Leila Nezaratizadeh on 07/11/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Binding var  region : MKCoordinateRegion
    @ObservedObject var house:House
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: [house]) { item in
            MapMarker(coordinate: CLLocation(latitude: CLLocationDegrees(item.latitude), longitude: CLLocationDegrees(item.longitude)).coordinate, tint: Color.red)
            
            
        }
        .onTapGesture {
        }
        .frame(width: UIScreen.main.bounds.width, height: 200)
    }
}


