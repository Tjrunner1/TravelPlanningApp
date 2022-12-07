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
        VStack(alignment: .leading){
            //TITLE
            TextField(activity.title, text: $title)
                .font(.title)
                .padding()
            
            //STARTTIME
            DatePicker("Start Time", selection: $startTime, displayedComponents: [.hourAndMinute])
                .frame(width: 250, alignment: .leading)
                .padding()
            //ENDTIME
            DatePicker("End Time:", selection: $endTime, in: startTime... , displayedComponents: [.hourAndMinute])
                .frame(width: 250, alignment: .center)
                .padding()
            //DESCRIPTION
           
            Text("Notes:").padding()
            TextField(description, text: $description)
            
            //URL
            TextField(url, text: $url)
            
            //ADDRESS
            TextField(address, text: $address)
            
            //IMAGES
                
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
                            } .padding()
                        }
                    }.frame(width: width)
                    
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
         
            Button{
                TVM.editActivity(day: day, activity: activity, title: title, startTime: startTime, endTime: endTime, description: description, url: url, address: address, attachments: attachments)
                
                dismiss()
            } label: {
                Text("Update Activity")
            }
        }.sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(sourceType: .photoLibrary, images: $attachments)
        }.sheet(isPresented: $isShowAttachment) {
            EditAttachmentView(images: $attachments, isShowAttachment: $isShowAttachment, index: imageIndex)
        }
        
    }
}

