//
//  Repository.swift
//  SearchGitHubMVP
//
//  Created by Marcos Suarez on 9/8/18.
//  Copyright © 2018 Marcos Suarez. All rights reserved.
//

import Foundation

protocol Repository {
    
    associatedtype T
    associatedtype R
    
    func get(completionHandler: @escaping (_ products: Transaction<T?>) -> ()) -> Void
    func set(element:T, completionHandler: @escaping (Transaction<R?>) -> ()) -> Void
    func clear() -> Void
}
