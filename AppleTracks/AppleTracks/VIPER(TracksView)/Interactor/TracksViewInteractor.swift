//
//  TracksViewInteractor.swift
//  AppleTracks
//
//  Created by Sanjay Kumar on 17/12/2021.
//

import Foundation
class TracksViewInteractor: TracksInteractorProtocol, PayLoadFormat {
    var output: TracksOutputProtocol?
    
    func decodeJSONInformation() {
        var apiModule = ATAPIModule()
        apiModule.payloadType = ATHTTPPayloadType.requestMethodGET
        let payload = formatGetPayload(url: .albumsUrl, module: apiModule)
        let api = APIManager()
  
        api.getAlbumsInfo(payload: payload) { [unowned self] result in
            switch result {
            case .success(let data):
                guard let albums = data.albums else { return  }
                self.output?.albumsInfoDidFetch(albums: albums)
            case .failure(let error):
                self.output?.errorOccured(message: error.localizedDescription)
            }
        }
 
    }
}
