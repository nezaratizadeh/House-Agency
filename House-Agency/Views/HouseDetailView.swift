//
//  HouseDetailView.swift
//  House-Agency
//
//  Created by Leila Nezaratizadeh on 04/11/2022.
//

import SwiftUI
import MapKit

struct HouseDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var house : House
    
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        HStack {
            Image("left-arrow-2") // set image here
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
        }
    }
        
    }
    
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea(.all)
            
            ScrollView {
                VStack(alignment:.leading) {
                    AsyncImage(url: URL(string: Constants.ImageURL.rawValue+house.image)){image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .cornerRadius(5.0)
                    Spacer()
                    
                    HStack{
                        Text(house.price, format: .currency(code: "USD").precision(.fractionLength(0)))
                            .font(Font.custom("GothamSSm-Bold", size: 16))
                            .padding(.trailing, 4.0)
                       
                        DetailInfoView(house: house)
                    }
                    .foregroundColor(Color("TitleColor"))

                .font(.system(size:8))
                .padding(.bottom,14)
    
                Text("Description")
                    .font(Font.custom("GothamSSm-Bold", size: 16))
                    .padding(.bottom,10)
                Text(house.description)
                    .font(Font.custom("GothamSSm-Book", size: 10))
                    .padding(.bottom,10)
                    .foregroundColor(Color("TextColor"))
                
                
                Text("Location")
                    .font(Font.custom("GothamSSm-Bold", size: 16))
                    .padding(.bottom,10)
                
                MapView(region:.constant(MKCoordinateRegion(center: CLLocation(latitude: CLLocationDegrees(house.latitude), longitude: CLLocationDegrees(house.longitude)).coordinate, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
                                        ), house: house)
                }
            }
            .padding(.leading, 14.0)
            .foregroundColor(Color("TextColor"))
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: btnBack)
        }
        .padding(.leading, 18.0)
    }
    
}

struct HouseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HouseDetailView(house: House())
    }
}

