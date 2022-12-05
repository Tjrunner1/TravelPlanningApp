//
//  EditAttachmentView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 12/4/22.
//

import SwiftUI

struct EditAttachmentView: View {
    @Binding var images: [UIImage]
    @Binding var isShowAttachment: Bool
    var index: Int
    
    var body: some View {
        VStack{
            if (index < images.count) {
                Image(uiImage: images[index]).resizable().scaledToFit()
            }
            Button{
                images.remove(at: index)
                isShowAttachment = false
            } label: {
                Text("Delete Image")
            }
        }
    }
}

