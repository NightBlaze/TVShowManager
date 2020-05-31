//
//  Network.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 31.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation
import Parse

protocol INetwork: INetworkInitializer, INetworkData {
}

protocol INetworkInitializer {
    func initialize()
}

protocol INetworkData {
    func save(request: SaveTVShowRequest, completion: @escaping (Result<String, Error>) -> Void)
    func fetchTVShows(request: FetchTVShowRequest, completion: @escaping (Result<[PFObject]?, Error>) -> Void)
}

final class Network: INetwork {
    
}

// MARK: - INetworkInitializer

extension Network: INetworkInitializer {
    enum Errors: Error {
        case saveTVShowNotSuccess
        case objectIdIsNil
    }

    private static var applicationId: String { "UvBvjdPeATFfYW9PeMjuoyX0ZGkD9XVY6NJAwshV" }
    private static var clientKey: String { "rxbpcYTOYya1NXcMbyaXNdLOCNs2VwY86OZ6w9ZE" }
    private static var server: String { "https://parseapi.back4app.com/" }

    func initialize() {
        let parseConfig = ParseClientConfiguration {
            $0.applicationId = Network.applicationId
            $0.clientKey = Network.clientKey
            $0.server = Network.server
        }
        Parse.initialize(with: parseConfig)
    }
}

// MARK: - INetworkData

extension Network: INetworkData {
    func save(request: SaveTVShowRequest, completion: @escaping (Result<String, Error>) -> Void) {
        let objectToSave = request.pfObject
        objectToSave.saveInBackground { (successed, error) in
            if let error = error {
                completion(.failure(error))
            } else if !successed {
                completion(.failure(Errors.saveTVShowNotSuccess))
            } else if let objectId = objectToSave.objectId{
                completion(.success(objectId))
            } else {
                completion(.failure(Errors.objectIdIsNil))
            }
        }
    }

    func fetchTVShows(request: FetchTVShowRequest, completion: @escaping (Result<[PFObject]?, Error>) -> Void) {
        request.pfQuery.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(objects))
            }
        }
    }
}
