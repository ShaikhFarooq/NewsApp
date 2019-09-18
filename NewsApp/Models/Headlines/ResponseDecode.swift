//
//  ResponseDecode.swift
//  NewsApp
//
//  Created by Admin on 9/11/19.
//  Copyright © 2019 Farooq. All rights reserved.
//

import Foundation

// MARK: - To Decode the model
struct ResponseDecode {
    fileprivate var data: Data
    init(data: Data) {
        self.data = data
    }
}


extension ResponseDecode {
    public func decode<T: Codable>(_ type: T.Type) -> T? {
        let jsonDecoder = JSONDecoder()
        do {
            let response = try jsonDecoder.decode(T.self, from: data)
            return response
        } catch let jsonError {
            print(jsonError)
            return nil
        }
    }
}
