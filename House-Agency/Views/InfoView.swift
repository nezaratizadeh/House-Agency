//
//  InfoView.swift
//  House-Agency
//
//  Created by Leila Nezaratizadeh on 04/11/2022.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea(.all)

            VStack(alignment:.leading) {
                Text("ABOUT")
                    .font(Font.custom("GothamSSm-Bold", size: 16))
                    .padding(.bottom, 10.0)
                    .foregroundColor(Color("TextColor"))

                Text("DTT is not your average software development company because besides technical knowledge we also have a solid marketing background. With passion, we work on a perfect mix of technology, strategy, and creativity. DTT was established in 2010, and in a short period we have made significant steps forward; a substantial portfolio, excellent credentials, respectable clients, and most importantly a competent and driven team.")
                    .foregroundColor(Color("TextColor"))
                    .font(Font.custom("GothamSSm-Book", size: 10))
                    .padding(.bottom, 10.0)

                VStack {
                    Text("Design And Development")
                        .font(Font.custom("GothamSSm-Bold", size: 18))
                        .foregroundColor(Color("TextColor"))

                                            
                }
                HStack(alignment:.center) {
                    Image("dtt_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .padding(.trailing,30.0)
                    VStack(alignment:.leading) {
                        Text("by DTT")
                            .foregroundColor(Color("TextColor"))
                        Link("d-dtt.nl", destination: URL(string: "https://www.d-tt.nl/")!)
                    }
                    .opacity(0.5)
                    .font(.caption)

                }
                
              Spacer()
            }
            .padding()
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
