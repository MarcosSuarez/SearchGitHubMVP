//
//  GetReposUseCase.swift
//  SearchGitHubMVP
//
//  Created by Marcos Suarez on 8/8/18.
//  Copyright © 2018 Marcos Suarez. All rights reserved.
//

import Foundation

class UseCaseGetNextPage {
    
    private let service: SearchServiceProtocol
    
    init(withServiceSearch: SearchServiceProtocol) {
        self.service = withServiceSearch
    }
    
    func execute(completionHandler: @escaping ([DataClient]) -> Void ) {
        
        service.nextPage { (transaction) in
            // Envía la información al presenter.
            switch transaction
            {
            case .success(let data):
                if let dataUnwrapped:[DataClient] = data {
                    completionHandler(dataUnwrapped) }
            case .fail:
                completionHandler([])
            }
        }
    }
}
