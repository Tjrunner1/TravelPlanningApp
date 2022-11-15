//
//  CalendarView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/8/22.
//

import SwiftUI


struct CalendarView: View {
    @EnvironmentObject var TVM: TripsViewModel
    @Binding var selectedTrip: Trip?
    @State var width = 0
    var days: [Day]{
        get{
            return selectedTrip!.days
        }
    }
    
    
    var body: some View {
        TagsView(items: days)
    }
}

struct TagsView: View{
    
    let items: [Day]
    var groupedItems: [[Day]] = [[Day]]()
    let screenWidth = UIScreen.main.bounds.width
    
    init(items: [Day]){
        self.items = items
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
        VStack(alignment: .leading){
            ForEach(groupedItems.indices){index in
                HStack{
                    ForEach(groupedItems[index]){day in
                        Text(String(format: "%02d", day.id))
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(.white)
                    }
                }
                
            }
        }
    }
}

