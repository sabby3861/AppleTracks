//
//  TracksDetailRouter.swift
//  AppleTracks
//
//  Created by Sanjay Kumar on 20/12/2021.
//

import Foundation
import UIKit

class TracksDetailRouter: TracksDetailRouterProtocol {
    func assembleModule(response: ATResponseProtocol, view: TracksDetailViewProtocol) {
        let router = TracksDetailRouter()
        let view =  view as? TracksDetailViewController
        view?.router = router
        view?.response = response as? ATMusic
    }
    
    func openWebPage(for UrlString: String) {
        if let url = URL(string: UrlString) {
            UIApplication.shared.open(url)
        }
    }
}
