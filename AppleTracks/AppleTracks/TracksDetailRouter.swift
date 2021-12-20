//
//  TracksDetailRouter.swift
//  AppleTracks
//
//  Created by Sanjay Kumar on 20/12/2021.
//

import Foundation

class TracksDetailRouter: TracksDetailRouterProtocol {
    func assembleModule(response: ATResponseProtocol, view: TracksDetailViewProtocol) {
        let view =  view as? TracksDetailViewController
        view?.response = response as? ATMusic
    }
}
