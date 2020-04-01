//
//  UdacityApiClient.swift
//  OnTheMap
//
//  Created by Jan Skála on 31/03/2020.
//  Copyright © 2020 Jan Skála. All rights reserved.
//

import Foundation

class UdacityApiClient : BaseApiClient{
    static let shared = UdacityApiClient()
    
    private init() {
        super.init(baseUrl: "https://onthemap-api.udacity.com")
    }
    
    override func requestBuilder<R>() -> ApiRequest<R>.Builder where R : Decodable {
        return super
            .requestBuilder()
            .responseOffset(5)
            .addHeader(key: "Accept", value: "application/json")
            .addHeader(key: "Content-Type", value: "application/json")
    }
    
    lazy var createSessionProperty : ApiProperty<CreateSessionResponseBody> = apiProperty(id: "CreateSession")
    
    lazy var deleteSessionProperty : ApiProperty<DeleteSessionResponseBody> = apiProperty(id: "DeleteSession")
    
    func createSession(username: String, password: String){
        createSessionProperty.load(request:
            requestBuilder()
                .path("/v1/session")
                .method(.post)
                .body(CreateSessionRequestBody(username: username, password: password))
                .build()
        )
    }
    
    func deleteSession(){
        let xsrKey = "XSRF-TOKEN"
        let xsrfValue = getCookieValue(name: xsrKey)
        deleteSessionProperty.load(request:
            requestBuilder()
                .path("/v1/session")
                .method(.delete)
                .addHeader(key: xsrKey, value: xsrfValue ?? "")
                .build()
        )
    }
}
