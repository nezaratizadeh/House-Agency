//
//  ContentView.swift
//  House-Agency
//
//  Created by Leila Nezaratizadeh on 03/11/2022.
//

import SwiftUI
import MapKit

enum Tabs: String {
    case home = "DTT REAL ESTATE"
    case info = ""
}

struct ContentView: View {
    @State private var selectedTab:Tabs = .home
    @State private var searchText = ""
    @StateObject private var state = TabViewStatus()
   
    var body: some View {
        TabView(selection: $selectedTab){
            HouseListView(searchText: $searchText)
                .padding()
                .tabItem {
                    if !state.hideTabView {
                        
                        selectedTab == .home ? Image("home") : Image("home-2")
                        Text("Home")
                    }
                }
                .tag(Tabs.home)
                .background(Color("BackgroundColor"))
            
            InfoView()
                .tabItem {
                    if !state.hideTabView {
                        selectedTab == .info ? Image("info-button") : Image("info-button-2")
                        Text("Info")
                    }
                }
                .tag(Tabs.info)
                .background(Color("BackgroundColor"))
        }
        .environmentObject(state)
    }
}

struct HouseListView: View {
    @EnvironmentObject var houses : HouseViewModel
    @Binding  var searchText:String
    @EnvironmentObject private var state :TabViewStatus
    
    
    var filteredHouses : [House] {
        if searchText.isEmpty {
            return houses.houses
        }else {
            return houses.houses.filter {house in
                
                if let char = searchText.first {
                    if char.isNumber {
                        return house.zip.lowercased().starts(with:searchText.lowercased())
                        
                    }else {
                        return house.city.lowercased().starts(with:searchText.lowercased())
                        
                    }
                }else{
                    return false
                }
                
            }
            
        }
    }
    
    var body: some View {
        NavigationView{
            if (filteredHouses.isEmpty && !searchText.isEmpty){
                EmptySearchView()
            }else{
                ScrollView {
                    VStack {
                        ForEach(filteredHouses) { house in
                            NavigationLink(destination: HouseDetailView(house: house)
                                            .onAppear{
                                state.hideTabView=true
                            }
                                            .onDisappear{
                                state.hideTabView=false
                            }
                            ) {
                                HouseRowView(house:house)
                            }
                        }
                    }
                    .foregroundColor(Color("TextColor"))

                }
                .navigationBarTitle("RTT REAL EASTATE")
                .navigationBarTitleDisplayMode(.inline)
                .background(Color("BackgroundColor"))
                .onAppear(){
                    APIService.apiService.loadHouses(houses: houses)
                    
                }
            }
        }
        .searchable(text: $searchText)
        
        
    }
}

struct HouseRowView: View {
    var house: House
    @StateObject var locationManager = LocationManager()

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            AsyncImage(url: URL(string: Constants.ImageURL.rawValue+house.image)){image in
                
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            .cornerRadius(5.0)
            
            
            VStack(alignment: .leading){
                Text(house.price, format: .currency(code: "USD").precision(.fractionLength(0)))
                Text(house.zip + " " + house.city)
                    .opacity(0.5)
                    .font(.system(size:10))
                HStack {
                    DetailInfoView(house: house)
                }
                .opacity(0.5)
                .font(.system(size:10))
            }
            .foregroundColor(Color("TitleColor"))
            Spacer()
        }
        .padding()
        .background(Color.white)
        .contentShape(Rectangle())
        .cornerRadius(5.0)
    }
    
}

struct DetailInfoView: View {
    var house :House
    @StateObject var locationManager = LocationManager()
    
    
    var body: some View {
        Group {
            HStack {
                Image("bed-2")
                Text(String(house.bedrooms))
            }
            .padding(.trailing, 5.0)
            
            HStack {
                Image("shower")
                Text(String(house.bathrooms))
            }
            .padding(.trailing, 5.0)
            HStack {
                Image("square-measument")
                    .rotationEffect(.degrees(130))
                Text(String(house.size))
            }
            .padding(.trailing, 5.0)
            HStack {
                Image("pin")
                Text(String(round((CLLocation(latitude: CLLocationDegrees(locationManager.lastLocation?.coordinate.latitude ?? 0
                                                                         ), longitude: CLLocationDegrees(locationManager.lastLocation?.coordinate.longitude ?? 0
                                                                                                        )).distance(from: CLLocation(latitude: CLLocationDegrees(house.latitude), longitude: CLLocationDegrees(house.longitude)))
                                  )/1000))+"km")
                
                
            }
        }
        .opacity(0.5)
        .font(.system(size:8))
    }
}


extension View {
    var previewedInAllColorSchemes: some View {
        ForEach(ColorScheme.allCases , id:\.self, content: preferredColorScheme)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewedInAllColorSchemes
            .environmentObject(HouseViewModel())
        
    }
}



