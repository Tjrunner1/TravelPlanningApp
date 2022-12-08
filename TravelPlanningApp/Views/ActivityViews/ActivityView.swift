//
//  ActivityView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/8/22.
//

import SwiftUI

struct ActivityView: View {
    @EnvironmentObject var TVM: TripsViewModel
    @ObservedObject var day: Day
    @ObservedObject var activity: Activity
    @State private var isShowAttachment = false
    @State var imageIndex = 0
    
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
   
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                Text(activity.title)
                    .font(.title)
                    .frame(alignment: .center)
                    .padding()
                Text("\(applyDateFormat(date:activity.startTime)) - \(applyDateFormat(date:activity.endTime))").padding()
                Divider().padding(.horizontal)
                if activity.description != nil {
                    HStack(){
                        Image(systemName: "note")
                        Text("Notes: ")
                        Text(activity.description!)
                    }.padding()
                    Divider().padding(.horizontal)
                }
                if activity.url != nil {
                    HStack{
                        Image(systemName: "link")
                        Text("Link: ").frame(alignment: .leading)
                        Link(activity.url!, destination: URL(string: activity.url!) ?? URL(string: "https://www.google.com")!)
                    }.padding()
                    Divider().padding(.horizontal)
                }
                if activity.address != nil {
                    HStack{
                        Image(systemName: "map")
                        Text("Address: ")
                        Link(activity.address!, destination: URL(string: activity.address!) ?? URL(string: "https://www.google.com")!)
                    }.padding()
                }
                if activity.attachments != nil {
                    HStack(alignment: .center){
                        ForEach(activity.attachments!.indices, id: \.self) { i in
                            Button{
                                self.imageIndex = i
                                self.isShowAttachment = true
                            } label: {
                                Image(uiImage: activity.attachments![i])
                                    .resizable()
                                    .cornerRadius(5)
                                    .aspectRatio(contentMode: .fit)
                            }.padding()
                        }
                    }.frame(width: width)
                }
             Spacer()
                Button(action:{
                    TVM.deleteActivity(activity: activity)
                }, label:{
                    ZStack{
                        Rectangle().fill(Color(hue: 1, saturation: 0.47, brightness: 0.85)).cornerRadius(12).padding()
                            .frame(height: height/10)
                        Text("Delete Activity")
                            .foregroundColor(.white)
                    }
                }).padding()
            }.sheet(isPresented: $isShowAttachment) {
                AttachmentView(selectedImage: activity.attachments![imageIndex])
                
            }.toolbar{ToolbarItem{
                NavigationLink{
                    EditActivityView(day: day, activity: activity, title: activity.title, startTime: activity.startTime, endTime: activity.endTime, description: activity.description ?? "", url: activity.url ?? "", address: activity.address ?? "", attachments: activity.attachments ?? [UIImage]())
                } label: {
                    Image(systemName: "pencil")
                }
            }}
        }
    }
    
    func applyDateFormat(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        
        return dateFormatter.string(from: date)
    }
}
