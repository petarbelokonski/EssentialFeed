//
//  HTTPURLResponse+StatusCode.swift
//  EssentialFeed
//
//  Created by Petar Bel on 26.09.23.
//

import Foundation

extension HTTPURLResponse {
     private static var OK_200: Int { return 200 }

     var isOK: Bool {
         return statusCode == HTTPURLResponse.OK_200
     }
 }
