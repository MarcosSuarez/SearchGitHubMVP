//
//  RepositoryMemory.swift
//  SearchGitHubMVP
//
//  Created by Marcos Suarez on 9/8/18.
//  Copyright © 2018 Marcos Suarez. All rights reserved.
//

import Foundation


class RepositoryNetwork {
    
    typealias T = [DataClient]
    typealias R = Bool
    
    let api = APIGitHub.shared
    var textSearch: String = ""
    var filter: APIGitHub.GHFilters = .none
    
}

extension RepositoryNetwork: Repository {
    
    func get(completionHandler: @escaping (Transaction<[DataClient]?>) -> ()) {
        
        print("Se está solicitando datos.")
        
        api.search(byText: textSearch, filter: filter) { (arrayDataGitHub) in
            
            let arrayClient = arrayDataGitHub.map({ (dataGitHub) -> DataClient in
                return DataClient(with: dataGitHub)
            })
            completionHandler( Transaction.success(arrayClient) )
        }
    }
    
    func set(element: [DataClient], completionHandler: @escaping (Transaction<Bool?>) -> ()) {
        
        print("se esta solicitando cambio de la data")
        completionHandler( Transaction.success(true) )
    }
    
    func clear() {
        print("Se solicitó un clear")
    }
}
