//
//  SwiftUIView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 12/4/22.
//

import SwiftUI

struct ContainerView: View {
    var color: Color
    var height = UIScreen.main.bounds.height
    
    var body: some View {
        Rectangle().cornerRadius(20).foregroundColor(color).shadow(radius: 5).frame(height: height/6).padding(7)
    }
}

struct AddButtonView: View {
    var color: Color
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    
    var body: some View {
        Image(systemName: "plus.circle")
            .resizable()
            .foregroundColor(color)
            .aspectRatio(contentMode: .fill)
            .frame(width: width/12, height: height/12, alignment: .center)
            .padding(.top)
    }
}
