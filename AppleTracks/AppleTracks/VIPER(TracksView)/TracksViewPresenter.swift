//
//  TracksViewPresenter.swift
//  AppleTracks
//
//  Created by Sanjay Kumar on 17/12/2021.
//

import Foundation
class TracksViewPresenter: TracksPresenterProtocol {
    
    
    var view: TracksViewProtocol?
    var interactor: TracksInteractorProtocol?
    var router: TracksRouterProtocol?
    var response: [ATMusic]?
    
    func fetchAlbumsInformation() {
        interactor?.decodeJSONInformation()
    }
    
    func pushToDetailView(detailView: TracksDetailViewProtocol, forIndex: Int) {
        guard let response = response?[forIndex] else { return }
        router?.showDetailView(detailView: detailView, album: response)
    }
    
}


// MARK: - Presenter to view communcation
extension TracksViewPresenter: TracksOutputProtocol {
    func albumsInfoDidFetch(albums: [ATMusic]) {
        self.response = [ATMusic]()
        self.response = albums.sorted(by: \.date, using: >)
        reloadData()
    }
    
    func errorOccured(message: String) {
        ATAlertViewController.showAlert(withTitle: alertTitle, message: message)
        view?.activity.removeActivity()
    }
    
    func reloadData()  {
        view?.tableView.reloadData()
        view?.activity.removeActivity()
    }
}



