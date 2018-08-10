//
//  APIGitHub.swift
//  SearchGitHub
//
//  Created by Marcos Suarez on 16/7/18.
//  Copyright © 2018 Marcos Suarez. All rights reserved.
//

import Foundation

/// API Protocol
protocol ClientProtocol {
    func getNextPage() -> String
    func getPreviousPage()-> String
    func search(byText: String, filter: GHFilters, completion: @escaping ([GHRepository])-> Void)
}


/// API to request information from GitHub
class APIGitHub {
    
    static var shared = APIGitHub()

    struct GHPagination {
        
        var nextPage:Int = 1
        var nextURLpage: String = ""
        
        var previosPage:Int = 1
        var previosURLpage: String = ""
        
        var lastPage:Int = 1
    }
    
    private static let basePath = "https://api.github.com/"
    private static let searchRepo = "search/repositories?q="
    
    //static var withPublicProyect:Bool = false
    var isLoading = false
    
    var pagination = GHPagination()
    
    private init() {}
    
    func resetPagination() {
        pagination = GHPagination()
    }
    
    private func setupPagination(response: URLResponse?, textSearch: String) {
        /* Example Github HEADER Link
         <https://api.github.com/search/repositories?q=Swift&page=29>; rel="prev",
         <https://api.github.com/search/repositories?q=Swift&page=31>; rel="next",
         <https://api.github.com/search/repositories?q=Swift&page=34>; rel="last",
         <https://api.github.com/search/repositories?q=Swift&page=1>; rel="first"
        */
        
        if let httpResponse = response as? HTTPURLResponse,
            let linkHeader = httpResponse.allHeaderFields["Link"] as? String {
            
            // separated components by ,
            let links = linkHeader.components(separatedBy: ",")
            
            links.forEach({
               
                let linkComponents = $0.components(separatedBy:"; ")
                let cleanborderRigth = linkComponents[0].replacingOccurrences(of: ">", with: "")
                let cleanborderLeft = cleanborderRigth.replacingOccurrences(of: "<" + APIGitHub.basePath + APIGitHub.searchRepo, with: "")
                let cleanSpaces = cleanborderLeft.replacingOccurrences(of: " ", with: "")
                
                var cleanNumber:Int = 1
                
                if let rango = cleanSpaces.range(of: "&page=") {
                    let rangoUpper = rango.upperBound
                    let pageNumber = cleanSpaces.suffix(from: rangoUpper)
                    cleanNumber = Int(pageNumber) ?? 1
                }
                
                if linkComponents[1].contains("prev") {
                    pagination.previosPage = cleanNumber
                    pagination.previosURLpage = cleanSpaces
                }
                
                if linkComponents[1].contains("next") {
                    pagination.nextPage = cleanNumber
                    pagination.nextURLpage = cleanSpaces
                }
                
                if linkComponents[1].contains("last") {
                    pagination.lastPage = cleanNumber
                }
            })
        }
    } // End setupPagination
}

extension APIGitHub: ClientProtocol {
    
    /// get string with URL next page.
    func getNextPage() -> String {
        return APIGitHub.shared.pagination.nextURLpage
    }
    
    /// get string with URL previous page.
    func getPreviousPage() -> String {
        return APIGitHub.shared.pagination.previosURLpage
    }
    
    /// Search repositories by String.
    func search(byText: String, filter: GHFilters, completion: @escaping ([GHRepository]) -> Void) {
        
        let textSearch = byText.replacingOccurrences(of: " ", with: "+")
        
        guard let url = URL(string: APIGitHub.basePath + APIGitHub.searchRepo + textSearch + filter.rawValue) else { completion([]); return }
        
        APIGitHub.shared.isLoading = true
        
        URLSession.shared.dataTask(with: url) { (data:Data?, response: URLResponse?, error: Error?) in
            
            APIGitHub.shared.isLoading = false
            
            guard error == nil else {
                print("--- request failed: \n",error ?? "Error hasn't description")
                completion([])
                return
            }
            
            APIGitHub.shared.setupPagination(response: response, textSearch: textSearch)
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let myStruct = try decoder.decode(GHSearchRepo.self, from: data)
                    completion(myStruct.items)
                } catch {
                    print("--- Error when decoding: ",error.localizedDescription)
                }
            }
            }.resume()
    }
}
