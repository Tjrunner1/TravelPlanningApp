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
    
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height

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
                }.frame(width: width/1.3, alignment: .center)
                
                    DatePicker("Start Time:", selection: $startTime, displayedComponents: [.hourAndMinute])
                    .frame(width: width/1.3, alignment: .leading)
                DatePicker("End Time:", selection: $endTime, in: startTime... , displayedComponents: [.hourAndMinute])
                    .frame(width: width/1.3, alignment: .center)
                VStack(alignment: .leading, spacing: 0){
                    Text("Notes:                       ")
                    TextEditor(text: $description)
                        .border(.gray)
                        .frame(height: height/6)
                }.frame(width: width/1.3, alignment: .center)
                VStack(alignment:.leading, spacing: 0){
                    Text("URL:                       ")
                    TextField("https://www.google.com",text: $url)
                        .textFieldStyle(.roundedBorder)
                        .border(.gray)
                }.frame(width: width/1.3, alignment: .center)
                VStack(alignment:.leading, spacing: 0){
                    Text("Address:                       ")
                    TextField("Copy Maps Address Here",text: $url)
                        .textFieldStyle(.roundedBorder)
                        .border(.gray)
                }.frame(width: width/1.3, alignment: .center)
                    .padding(.bottom)
                
                Group{
                    HStack{
                        ForEach(images.indices, id: \.self) { i in
                            Button{
                                self.imageIndex = i
                                self.isShowAttachment = true
                            } label: {
                                Image(uiImage: images[i])
                                    .resizable()
                                    .cornerRadius(5)
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: width/12, height: height/12, alignment: .center)
                                    .padding()
                            }
                        }
                    }
                    VStack(alignment:.leading, spacing: 0){
                        Text("Photos:")
                    
                        Button{
                            self.isShowPhotoLibrary = true
                        } label: {
                            HStack {
                                Image(systemName: "photo")
                                    .font(.system(size: 20))
                                    
                                Text("Photo library")
                                    .font(.callout)
                            }
                            .frame(minWidth: width/1.3, minHeight: 30, maxHeight: 50)
                            .border(.gray)
                        }
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
