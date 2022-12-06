//
//  TextView.swift
//  TravelPlanningApp
//
//  Created by Tori Keener on 12/6/22.
//

import SwiftUI

struct TextView: UIViewRepresentable {
    @Binding var text: String
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.font = .preferredFont(forTextStyle: .body)
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ view: UITextView, context: Context) {
        view.text = text
    }
}

extension TextView {
    class Coordinator: NSObject, UITextViewDelegate{
        @Binding private var text: String
        
        init(text: Binding<String>){
            _text = text
        }
        
        func textViewDidChange(_ textView: UITextView) {
            text = textView.text
        }
    }
    
    
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
}

//struct TextView_Previews: PreviewProvider {
//    static var previews: some View {
//        TextView()
//    }
//}
