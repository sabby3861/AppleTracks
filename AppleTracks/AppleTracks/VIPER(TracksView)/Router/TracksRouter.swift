//
//  TracksRouter.swift
//  AppleTracks
//
//  Created by Sanjay Kumar on 17/12/2021.
//

import Foundation
final class TracksRouter: TracksRouterProtocol {
    var presenter: TracksPresenterProtocol?
    
    /// Assemble the VIPER modules here
     func assembleModule(view: TracksViewProtocol) {
        let presenter = TracksViewPresenter()
        let interactor = TracksViewInteractor()
        let router = TracksRouter()
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        view.presenter = presenter
        router.presenter = presenter
    }
    
    func showDetailView(detailView: TracksDetailViewProtocol, album: ATResponseProtocol){
        TracksDetailRouter().assembleModule(response: album, view: detailView)
    }
}
