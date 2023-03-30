//
//  Validator.swift
//  
//
//  Created by Maxim Aliev on 29.01.2023.
//

import SwiftUI

final class Validator<T: Hashable, V: ValidationRule>: ObservableObject where T == V.Value {
    
    @Binding private var bindValue: T
    private var bindFailedValidationRules: Binding<[V]>?
    private let validationRules: [V]
    
    @Published var value: T {
        willSet { validate(newValue: newValue) }
        didSet { bindValue = value }
    }
    
    init(
        value: Binding<T>,
        validationRules: [V],
        failedValidationRules: Binding<[V]>? = nil
    ) {
        self.validationRules = validationRules
        self._bindValue = value
        self.bindFailedValidationRules = failedValidationRules
        self.value = value.wrappedValue
    }
    
    func validate(newValue: T? = nil) {
        let failedValidationRules = validationRules.filter {
            $0.check(value: newValue ?? value) == false
        }
        bindFailedValidationRules?.wrappedValue = failedValidationRules
    }
}
