//
//  Transaction.swift
//  SearchGitHubMVP
//
//  Created by Marcos Suarez on 9/8/18.
//  Copyright © 2018 Marcos Suarez. All rights reserved.
//

import Foundation

enum Transaction<T:Any> {
    
    case success(T)
    case fail(ClientError)
}
