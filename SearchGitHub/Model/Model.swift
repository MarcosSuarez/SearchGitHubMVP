//
//  Model.swift
//  SearchGitHubMVP
//
//  Created by Marcos Suarez on 10/8/18.
//  Copyright © 2018 Marcos Suarez. All rights reserved.
//

import Foundation

protocol Model {
    
    associatedtype T
    associatedtype R
    associatedtype MEM
    associatedtype PER
    associatedtype NET
    
    var memory: MEM {get set}
    var persistence: PER {get set}
    var network: NET {get set}
    
    func get(completionHandler: @escaping (_ products: Transaction<T?>) -> ()) -> Void
    func set(element:T, completionHandler: @escaping (_ products: Transaction<R?>) -> ()) -> Void
    func clear() -> Void
}
