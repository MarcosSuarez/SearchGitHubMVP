//
//  RepositoryMemory.swift
//  SearchGitHubMVP
//
//  Created by Marcos Suarez on 9/8/18.
//  Copyright © 2018 Marcos Suarez. All rights reserved.
//

import Foundation

protocol Repository {
    
    associatedtype T
    
    func get(completionHandler: @escaping (_ products: Transaction<T?>) -> ()) -> Void
    
    func clear() -> Void
}

class RepositoryNetwork {
    
    typealias T = [DataClient]
    
    let api = APIGitHub.shared
    var textSearch: String = ""
    var filter: GHFilters = .none
}

extension RepositoryNetwork: Repository {
    
    func get(completionHandler: @escaping (Transaction<[DataClient]?>) -> ()) {
        
        print("Se está solicitando datos.")
        
        // Solicitud de Datos a la API
        api.search(byText: textSearch, filter: filter) { (arrayDataGitHub) in
            
            // Convierto del modelo de Git al modelo de que requiere el presentador
            let arrayClient = arrayDataGitHub.map({ (dataGitHub) -> DataClient in
                return DataClient(with: dataGitHub)
            })
            // Respuesta de Repository Network
            completionHandler( Transaction.success(arrayClient) )
        }
    }
    
    func getNextPage(completionHandler: @escaping (Transaction<[DataClient]?>) -> ()) {
        
        let textSearch = api.getNextPage()
        
        api.search(byText: textSearch, filter: .none) { (arrayDataGitHub) in
            // Convierto del modelo de Git al modelo de que requiere el presentador
            let arrayClient = arrayDataGitHub.map({ (dataGitHub) -> DataClient in
                return DataClient(with: dataGitHub)
            })
            // Respuesta de Repository Network
            completionHandler( Transaction.success(arrayClient) )
        }
    }
    
    func clear() {
        print("Se solicitó un clear")
    }
}
