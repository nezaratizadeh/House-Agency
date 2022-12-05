//
//  SplashScreenView.swift
//  House-Agency
//
//  Created by Leila Nezaratizadeh on 03/11/2022.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    var body: some View {
        ZStack {
            Color("SplashBackGroundColor")
                .ignoresSafeArea(.all)
            
            if isActive {
                ContentView()
                    .environmentObject(HouseViewModel())
                
            }
            else {
                VStack {
                    VStack {
                        Image("dtt_logo")
                            .font(.system(size:80))
                            .foregroundColor(.red)
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear{
                        withAnimation(.easeIn(duration:1.2)) {
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                    }
                }
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now()+2.0){
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
