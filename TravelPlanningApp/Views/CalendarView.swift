//
//  CalendarView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/8/22.
//

import SwiftUI


struct CalendarView: View {
    @EnvironmentObject var TVM: TripsViewModel
    @Binding var identifier: Identifiers?
//    @Binding var selectedTrip: Trip?
    @State var width = 0
    var days: [Day]{
        get{
           // return TVM.trips[identifier!.tripID].days
            return TVM.trips[identifier!.tripID].days
        }
    }
    
    var body: some View {
        TagsView(items: days, identifier: $identifier)
    }
}

struct TagsView: View{
    @EnvironmentObject var TVM: TripsViewModel
    //var identifier: Identifiers?
    let items: [Day]
    @Binding var identifier: Identifiers?
    var groupedItems: [[Day]] = [[Day]]()
    let screenWidth = UIScreen.main.bounds.width
    @State var selectedDate: Int? = nil
    
    init(items: [Day], identifier: Binding<Identifiers?>){
        self.items = items
        self._identifier = identifier
        groupedItems = createGroupedItems(items)
    }
    
    private func createGroupedItems(_ items: [Day]) -> [[Day]]{
        
        var groupedItems: [[Day]] = [[Day]]()
        var TempItems: [Day] = [Day]()
        var width: CGFloat = 0

        for day in items{
            
            let label = UILabel()
            label.text = String(format: "%02d", day.id)
            label.sizeToFit()
            let labelWidth = label.frame.size.width + 32 // 16 padding on each size
     
            
            if(width + labelWidth + 32) < screenWidth{
                width += labelWidth
                TempItems.append(day)
            }else{
                width = labelWidth
                groupedItems.append(TempItems)
                TempItems.removeAll()
                TempItems.append(day)
            }
            
        }
        groupedItems.append(TempItems)
        
        return groupedItems
    }
    
    var body: some View{
        //var displayActivites: Bool = false
      
        NavigationView{
            VStack(alignment: .center){
                //TVM.trips[identifier?.tripID].startDate
                VStack(alignment: .leading){
                    ForEach(groupedItems.indices){index in
                        HStack{
                            ForEach(groupedItems[index]){day in
                                Button{
                                    selectedDate = day.id
                                    identifier?.dateID = day.id
                                } label: {
                                Text(String(format: "%02d", day.id+1))
                                    .padding()
                                    .background(Color.gray)
                                    .foregroundColor(.white)
                                }
                            }
                        }
                    }
                }
                    NavigationLink{
                        AddActivityView(identifier: $identifier)
                    } label: {
                        Image(systemName: "plus.circle").font(.title).frame(alignment: .center)
                    }
                    if(selectedDate != nil){
                        Text("Activities")
                        VStack{
                            ForEach(TVM.trips[identifier!.tripID].days){day in
                                if selectedDate == day.id{
                                    ForEach(TVM.trips[identifier!.tripID].days[identifier!.dateID!].activities){activity in
                                        Text("\(activity.title)")
                                        
                                    }
                                }
                            }
                        }
                    }
            }
        }
    }
}

