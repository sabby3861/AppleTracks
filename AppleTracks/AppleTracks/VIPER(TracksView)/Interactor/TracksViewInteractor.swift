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
            print("")
            case .failure(let error):
                self.output?.errorOccured(message: error.localizedDescription)
            }
            /*
        switch apiModule.searchType {
        case .album:
            api.getAlbumsInfo(payload: payload) { [unowned self] result in
                switch result {
                case .success(let data):
                    guard let albums = data.albums.albumMatches.album else { return  }
                    self.output?.albumsInfoDidFetch(albums: albums)
                case .failure(let error):
                    self.output?.errorOccured(message: error.localizedDescription)
                }

            }
        case .artist:
            api.getArtistInfo(payload: payload) { [unowned self] result in
                switch result {
                case .success(let data):
                    guard let artists = data.result.artistMatches.matches else { return  }
                    self.output?.artistInfoDidFetch(artists: artists)
                case .failure(let error):
                    self.output?.errorOccured(message: error.localizedDescription)
                }

            }
        case .song:
            api.getSongsInfo(payload: payload) { [unowned self] result in
                switch result {
                case .success(let data):
                    guard let tracks = data.songs.trackMatches.matches else { return  }
                    self.output?.songsInfoDidFetch(tracks: tracks)
                case .failure(let error):
                    self.output?.errorOccured(message: error.localizedDescription)
                }

            }
        }*/
        }
 
    }
}
