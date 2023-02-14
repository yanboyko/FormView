//
//  MyFormField.swift
//  Example
//
//  Created by Maxim Aliev on 12.02.2023.
//

import SwiftUI
import FormView

struct MyFormField: View {
    
    private let title: LocalizedStringKey
    private let text: Binding<String>
    private let rules: [TextValidationRule]
    
    @State private var failedRules: [TextValidationRule] = []
    
    init(
        _ title: LocalizedStringKey = "",
        text: Binding<String>,
        rules: [TextValidationRule] = []
    ) {
        self.title = title
        self.text = text
        self.rules = rules
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Color.white
                    .cornerRadius(12)
                    .shadow(
                        color: Color(red: 216/255.0, green: 220/255.0, blue: 232/255.0),
                        radius: 3,
                        x: .zero,
                        y: 3
                    )
                ZStack {
                    FormField(title, text: text, rules: rules, failedRules: $failedRules)
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                        .tint(Color.black)
                        .frame(height: 40)
                        .padding(.horizontal, 12)
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(failedRules.isEmpty ? Color.clear : .red, lineWidth: 1)
                }
            }
            .frame(height: 40)
            
            if failedRules.isEmpty == false {
                Text(String.concat(strings: failedRules.map { $0.message }))
                    .lineLimit(2)
                    .font(.system(size: 9, weight: .semibold))
                    .foregroundColor(.red)
            }
            
            Spacer(minLength: 0)
        }
        .padding(.horizontal, 4)
        .frame(height: 72)
    }
}
