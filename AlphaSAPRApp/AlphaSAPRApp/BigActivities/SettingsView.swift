
//  SettingsView.swift
//  Hove_Prototype
//
//  Created by Johnson, Kendall   USN USNA Annapolis on 2/20/21.
//
import MapKit
import SwiftUI
import Foundation
import Contacts
import UIKit

//Location Information
struct Location: Identifiable, Hashable, Codable {

    var id: Int
    var description: String
    var latitude: Double
    var longitude: Double
    var isInactive: Bool
    
    var coordinate : CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
   
}

struct Contact: Identifiable, Hashable, Codable {
    var id : Int
    var phoneNumber: String
    var name: String
    var isInactive: Bool
    
}


func readContacts() -> [Contact] {
    var contacts : [Contact] = []
    if let data = UserDefaults.standard.data(forKey: "contact"){
        do {
            let decoder = JSONDecoder()
            
            contacts = try decoder.decode([Contact].self, from: data)
        } catch {
            print("error")
        }
    }

    return contacts
}

struct SettingsView: View {
    //@State private var NameVal: String = ""
    //@State private var NumberVal: String = ""
    @EnvironmentObject var locationData: LocationData
    @Binding var isOnboardingViewShowing: Bool
    
    var filteredLocations: [Location] {
        //WE SWITCHED THIS BACK. MAY CRASH
        locationData.myLocations.filter { location in
            (!location.isInactive)
        }
    }
    
    let testContact = CNMutableContact()
    let imagage = UIImage(systemName: "person.crop.circle")
    
    //Open settings to change app permissions directly
    private func openSettings(){
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {return}
        if (UIApplication.shared.canOpenURL(settingsURL)){UIApplication.shared.open(settingsURL)}
    }
    
    @State var cons : [Contact] = []
    var body: some View {
        NavigationView {
            VStack{
                
                //Link to location services settings:
                Button (action: {
                    openSettings()
                }) {
                    HStack{
                        Text("Location Servies")
                        Image(systemName: "location.fill")
                    }
                    .padding(7)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(15)
                }
                .padding(.top)
                
                NavigationView{
                    //List of Contacts
                    List(cons) { contact in
                        NavigationLink(destination: ContactDetail(passedContact: contact, passedList: cons)){
                            ContactRow(contact: contact)
                        }
                    }.onAppear{
                        cons = readContacts()
                    }
                    .navigationTitle("Contacts")          //.padding()
                }
                
                
                
                NavigationLink("Add Contact", destination: ContactAdd())
                
                NavigationView{
                    //List of Contacts
                    List(filteredLocations) { location in
                        NavigationLink(destination: LocationDetail(passedLocation: location)){
                            LocationRow(location: location)
                        }
                    }
                    //.padding()
                    .navigationTitle("Locations")
                }
                NavigationLink("Add Location", destination: LocationAdd())
                    .padding(.bottom)
                
            }
            .navigationTitle("Settings")
            .navigationBarItems(trailing: isOnboardingViewShowing ? Button("Done") {
                goHome()
            } : nil )
        }
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    @Binding var isOnboardingViewShowing: Bool
//    static var previews: some View {
//        SettingsView(isOnboardingViewShowing: Binding.constant(true))
//            .environmentObject(LocationData())
//    }
//}


