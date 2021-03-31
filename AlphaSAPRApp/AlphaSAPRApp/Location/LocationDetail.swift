//
//  LocationDetail.swift
//  AlphaSAPRApp
//
//  Created by Alex Hernandez on 3/23/21.
//

import SwiftUI
import MapKit



struct LocationDetail: View {
    @StateObject private var manager = LocationManager()
    @EnvironmentObject var locationData: LocationData
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 38.978774, longitude: -76.484496),
        span: MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004))
    
    private func updateMap(){
        //Update the coordinate region to be displayed.
        self.region = MKCoordinateRegion(
            center: passedLocation.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004))
    }
    
    var passedLocation: Location
    
    var locationIndex: Int {
        locationData.myLocations.firstIndex(where: { $0.id == passedLocation.id })!
    }
    
    var body: some View {
        
        //ADD A MARKER AND TRY TO RECENTER
        VStack(alignment: .leading){
            
            //Add a map pin for all the saved locations!
            Map(coordinateRegion: $region, annotationItems: locationData.myLocations){
                MapPin(coordinate: $0.coordinate)
            }
                .frame(height: 150)
            
            HStack{
                Text(passedLocation.description)
                    .font(.headline)
                    .padding(.leading)
                Spacer()
//                DeleteButton(isSet: $locationData.myLocations[locationIndex].isInactive)
                    .padding(.trailing)
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: updateMap) //Need the region to contain preferred location
        }
    }
}

struct LocationDetail_Previews: PreviewProvider {
    static let locationData = LocationData()
    
    static var previews: some View {
        LocationDetail(passedLocation: locationData.myLocations[0])
            .environmentObject(locationData)
    }
}
