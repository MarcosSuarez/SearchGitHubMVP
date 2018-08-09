//
//  RepositoryMemory.swift
//  SearchGitHubMVP
//
//  Created by Marcos Suarez on 9/8/18.
//  Copyright © 2018 Marcos Suarez. All rights reserved.
//

import Foundation


class RepositoryMemory {
    
    typealias T = [DataClient]
    typealias R = [DataClient]
    
    
}

extension RepositoryMemory: Repository {
    
    func get(completionHandler: @escaping (Transaction<[DataClient]?>) -> ()) {
        
        print("Se está solicitando datos.")
        completionHandler( Transaction.success([]) )
    }
    
    func set(element: [DataClient], completionHandler: @escaping (Transaction<[DataClient]?>) -> ()) {
        
        print("se esta solicitando cambio de la data")
        completionHandler( Transaction.success([]) )
    }
    
    func clear() {
        print("Se solicitó un clear")
    }
}
