//
//  AddActivityView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/8/22.
//

import SwiftUI

struct CreateActivityView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var TVM: TripsViewModel
    @ObservedObject var day: Day
    
    @State private var startTime = Date()
    @State private var endTime = Date()
    @State private var title: String = ""
    @State private var description = ""
    @State private var url = ""
    @State private var address = ""
    @State private var isShowPhotoLibrary = false
    @State private var isShowAttachment = false
    @State private var images = [UIImage]()
    @State var imageIndex = 0

    var body: some View {
        ScrollView{
            VStack{
                Text("\(applyDateFormat(date: day.date))")
                    .font(.title)
                Spacer()
            
                VStack(alignment:.leading, spacing: 0){
                    Text("Event Title:                 ")
                    TextField("", text: $title)
                        .textFieldStyle(.roundedBorder)
                        .border(.gray)
                }.frame(width: 250, alignment: .center)
                
                
                    DatePicker("Start Time:", selection: $startTime, displayedComponents: [.hourAndMinute])
                    .frame(width: 250, alignment: .leading)
                DatePicker("End Time:", selection: $endTime, in: startTime... , displayedComponents: [.hourAndMinute])
                    .frame(width: 250, alignment: .center)
                VStack(alignment: .leading, spacing: 0){
                    Text("Notes:                       ")
                    TextEditor(text: $description)
                        .border(.gray)
                        .frame(height: 75)
                }.frame(width: 250, alignment: .center)
                VStack(alignment:.leading, spacing: 0){
                    Text("URL:                       ")
                    TextField("https://www.google.com",text: $url)
                        .textFieldStyle(.roundedBorder)
                        .border(.gray)
                }.frame(width: 250, alignment: .center)
                VStack(alignment:.leading, spacing: 0){
                    Text("Address:                       ")
                    TextEditor(text: $address)
                        .border(.gray)
                        .frame(height: 75)
                }.frame(width: 250, alignment: .center)
                
                Group{
                    HStack{
                        ForEach(images.indices, id: \.self) { i in
                            Button{
                                self.imageIndex = i
                                self.isShowAttachment = true
                            } label: {
                                Image(uiImage: images[i])
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50, alignment: .center)
                                    .padding()
                            }
                        }
                    }
                    
//                    IDK WHAT THESE ARE
//                    Button{
//                VStack(alignment:.leading, spacing: 0){
//                    Text("Images:")
            
                    
                    Button{
                        self.isShowPhotoLibrary = true
                    } label: {
                        HStack {
                            Image(systemName: "photo")
                                .font(.system(size: 20))
                                
                            Text("Photo library")
                                .font(.callout)
                        }
                        .frame(minWidth: 250, minHeight: 30, maxHeight: 50)
                       // .background(Color(hue: 0.572, saturation: 0.792, brightness: 0.594))
                        //.foregroundColor(.white)
                        .border(.gray)
                    }
                }
                Button{
                    TVM.createActivity(day: day, title: title, startTime: startTime, endTime: endTime, description: description, url: url, address: address, attachments: images)
                    
                    dismiss()
                } label:{
                    ZStack{
                        Rectangle().fill(Color(hue: 0.294, saturation: 0.31, brightness: 0.661))
                            .cornerRadius(12)
                        Text("Create activity")
                            .foregroundColor(.white)
                            .padding()
                            
                    }.padding()
                    
                }.padding()
            }
        }.sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(sourceType: .photoLibrary, images: $images)
        }.sheet(isPresented: $isShowAttachment) {
            EditAttachmentView(images: $images, isShowAttachment: $isShowAttachment, index: imageIndex)
        }
    }
    
    func applyDateFormat(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        return dateFormatter.string(from: date)
    }
}
