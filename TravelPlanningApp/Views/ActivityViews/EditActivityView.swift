//
//  EditActivityView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 12/3/22.
//

import SwiftUI

struct EditActivityView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var TVM: TripsViewModel
    @ObservedObject var day: Day
    @ObservedObject var activity: Activity
    
    @State var title: String
    @State var startTime: Date
    @State var endTime: Date
    @State var description: String
    @State var url: String
    @State var address: String
    @State var attachments: [UIImage]
    
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    @State private var isShowAttachment = false
    @State var imageIndex = 0
    @State private var isShowPhotoLibrary = false


    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: height/50){
                HStack{
                    //Text("Title:")
                     //  .padding(.horizontal)
                    //TITLE
                    if (activity.title == "") {
                        TextField("Activity Title", text: $title)
                            .font(.title)
                            .padding(.horizontal)
                            .border(.gray, width: 0.5)
                    }else{
                    TextField(activity.title, text: $title)
                        .font(.title)
                        .padding(.horizontal)
                    }
                }
                Divider()
                
                //STARTTIME
                DatePicker("Start Time:", selection: $startTime, displayedComponents: [.hourAndMinute])
                    .frame(width: 250, alignment: .leading)
                    .padding(.horizontal)
                //ENDTIME
                DatePicker("End Time:", selection: $endTime, in: startTime... , displayedComponents: [.hourAndMinute])
                    .frame(width: 250, alignment: .center)
                    .padding(.horizontal)
                //DESCRIPTION
                VStack(alignment: .leading, spacing: 0){
                    Text("Notes:                       ")
                    TextEditor(text: $description)
                        .border(.gray, width: 0.5)
                        .frame(height: height/6)
                }.frame(width: width/1.3, alignment: .center)
                    .padding(.horizontal)
                   
                //URL
                VStack(alignment:.leading, spacing: 0){
                    Text("URL:                       ")
                    TextField("https://www.google.com",text: $url)
                        .textFieldStyle(.roundedBorder)
                        .border(.gray, width: 0.5)
                }.frame(width: width/1.3, alignment: .center)
                    .padding(.horizontal)
                    
                
                //ADDRESS
                VStack(alignment:.leading, spacing: 0){
                    Text("Address:                       ")
                    TextField("Copy Maps Address Here",text: $address)
                        .textFieldStyle(.roundedBorder)
                        .border(.gray, width: 0.5)
                }.frame(width: width/1.3, alignment: .center)
                    .padding(.horizontal)
                
                //IMAGES
                Text("Photos:").padding(.horizontal)
                    Group{
                        HStack(alignment: .center){
                            ForEach(attachments.indices, id: \.self) { i in
                                Button{
                                    self.imageIndex = i
                                    self.isShowAttachment = true
                                } label: {
                                    Image(uiImage: attachments[i])
                                        .resizable()
                                        .cornerRadius(5)
                                        .aspectRatio(contentMode: .fit)
                                } .padding(.horizontal)
                            }
                        }.frame(width: width)
                        
                        Button{
                            self.isShowPhotoLibrary = true
                        } label: {
                            HStack {
                                Image(systemName: "photo")
                                    .font(.system(size: 20))
                                    .padding(.leading)
                                    
                                Text("Photo library")
                                    .font(.callout)
                                    .padding()
                            }
                           // .frame(minWidth: width/1.3, minHeight: 30, maxHeight: 50)
                            .border(.gray, width: 0.5)
                        }.frame(width: width, alignment: .center)
                    }
             
                Button{
                    TVM.editActivity(day: day, activity: activity, title: title, startTime: startTime, endTime: endTime, description: description, url: url, address: address, attachments: attachments)
                    
                    dismiss()
                } label: {
                    ZStack{
                        Rectangle().fill(Color(hue: 0.361, saturation: 0.15, brightness: 0.71)).cornerRadius(12).padding()
                            .frame(height: height/10)
                        Text("Update Activity")
                            .foregroundColor(.white)
                    }
                }
            }.sheet(isPresented: $isShowPhotoLibrary) {
                ImagePicker(sourceType: .photoLibrary, images: $attachments)
            }.sheet(isPresented: $isShowAttachment) {
                EditAttachmentView(images: $attachments, isShowAttachment: $isShowAttachment, index: imageIndex)
            }
        }
    }
}

