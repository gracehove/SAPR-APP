//
//  ContentView.swift
//  AlphaSAPRApp
//
//  Created by Alex Hernandez on 3/23/21.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("OnBoardingView") var isOnboardingViewShowing = true
    var body: some View {
        if isOnboardingViewShowing {
            OnboardingView(isOnboardingViewShowing: $isOnboardingViewShowing).environmentObject(UserInfo())
        } else {
            TabView {
                HomeView()
//                    .environmentObject(ModelData())
//                    .environmentObject(LocationData())
                    .tabItem {
                        Image(systemName: "house")
                        Text("HOME")
                    }
                SettingsView(isOnboardingViewShowing: $isOnboardingViewShowing)
//                    .environmentObject(ModelData())
//                    .environmentObject(LocationData())
                    .tabItem {
                        Image(systemName: "gear")
                        Text("SETTINGS")
                    }
                ImpairedModeView()
                    .tabItem{
                        Image(systemName: "eye.slash")
                        Text("IMPAIRED MODE")
                    }
                MyFriendsView()//.environmentObject(ModelData())
                    .tabItem{
                        Image(systemName: "person.crop.circle")
                        Text("MY FRIENDS")
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(LocationData())
    }
}

struct HomeView: View {
    @State var showImpairedMode = false
    @State var showSafeWalk = false
    @State var showDetails = false
    @State var showAlertSafe = false
    //@EnvironmentObject var modelData : ModelData
    var body: some View {
        NavigationView {
            VStack {

                Spacer()
                
                //Expect Me
                NavigationLink("Expect Me", destination: ExpectMeView().environmentObject(UserInfo()))
                
                Spacer()
                
                //Find Me A Ride
                NavigationLink("Find Me a Ride", destination: FindMeARideView())//.environmentObject(ModelData()))
                
                Spacer()
                
                //Time to Leave
                NavigationLink("Time to Leave", destination: TimeToLeave())
                
                Spacer()
                
                //SAPR Information Center
                Link("SAPR Resource Center", destination: URL(string: "https:usna-sapr-app.web.app")!)
                
                Spacer()
                
            }
            .navigationTitle("Home")
        }
    }
}

//struct initialSettingsView: View{
//    @Binding var isOnboardingViewShowing: Bool
//    var body: some View {
//        NavigationView{
//            ZStack {
//                Color.blue
//            }
//            .navigationTitle("Settings")
//            .navigationBarItems(trailing: isOnboardingViewShowing ? Button("Done") {
//                goHome()
//            } : nil )
//        }
//    }
//}

func goHome() {
    if let window = UIApplication.shared.windows.first{
        window.rootViewController = UIHostingController(rootView: ContentView()
                                                            .environmentObject(LocationData()))
        window.makeKeyAndVisible()
    }
}

