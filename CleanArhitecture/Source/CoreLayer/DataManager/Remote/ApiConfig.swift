//
//  ApiManager.swift
//  CleanArhitecture
//
//  Created by MSI on 19/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import MoyaNetworkClient
import Moya

struct ApiConfig {
    static let urlBase = "https://my-json-server.typicode.com/peeoner174/demo"
    static let networkClient =
        DefaultMoyaNetworkClient(jsonDecoder: JSONDecoder(), provider: MoyaProvider<MultiTarget>(stubClosure: MoyaProvider.immediatelyStub))
}
