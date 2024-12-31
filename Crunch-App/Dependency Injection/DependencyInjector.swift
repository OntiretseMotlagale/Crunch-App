//
//  Container.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/06/11.
//

import Foundation
import Swinject

struct DependencyInjector {
    private static var dependencyList: [String: Any] = [:]
    
    static func resolve<T>() -> T {
        guard let t = dependencyList[String(describing: T.self)] as? T else {
            fatalError("No Registered dependency found \(T.self)")
        }
        return t
    }
    static func register<T>(dependency: T) {
        self.dependencyList[String(describing: T.self)] = dependency
    }
}
@propertyWrapper struct Inject<T> {
    var wrappedValue: T
    
    init() {
        self.wrappedValue = DependencyInjector.resolve()
    }
}
@propertyWrapper struct Provider<T> {
    var wrappedValue: T
    
    init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        DependencyInjector.register(dependency: wrappedValue)
    }
}

