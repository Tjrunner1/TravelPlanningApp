//
//  ShowAttachmentView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 12/4/22.
//

import SwiftUI

struct AttachmentView: View {
    var selectedImage: UIImage
    
    var body: some View {
        VStack{
            Image(uiImage: selectedImage).resizable().scaledToFit()
        }
    }
}

