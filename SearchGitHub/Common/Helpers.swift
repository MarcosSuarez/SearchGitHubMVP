//
//  Helpers.swift
//  SearchGitHubMVP
//
//  Created by Marcos Suarez on 9/8/18.
//  Copyright © 2018 Marcos Suarez. All rights reserved.
//

import Foundation

enum ClientError: Error {
    
    case errorMessage(String)
    case NoInternet
    case Unknown
    case Serialization
    case Url
    case Unauthorized
    case UserExpired
    case CloseSession
    case Innaccesible
}

