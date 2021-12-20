//
//  TracksViewProtocols.swift
//  AppleTracks
//
//  Created by Sanjay Kumar on 16/12/2021.
//

import Foundation
import UIKit

/// View Protocol
protocol TracksViewProtocol: AnyObject
{
    var presenter: TracksPresenterProtocol? { get set}
    var tableView: UITableView!{get set}
    var activity: ATActivityView {get set}
}

/// View -> Interactor and View -> Router Communication Protocols
protocol TracksPresenterProtocol: AnyObject
{
    var view: TracksViewProtocol? { get }
    var interactor: TracksInteractorProtocol?{get}
    var router: TracksRouterProtocol? { get }
    var response: [ATMusic]? {get}
    func fetchAlbumsInformation()
    func pushToDetailView(detailView: TracksDetailViewProtocol, forIndex: Int) 
}

/// Interactor -> Presenter Communication Protocols
protocol TracksInteractorProtocol: AnyObject
{
    var output: TracksOutputProtocol? { get }
    func decodeJSONInformation()
}

/// Interactor to Presenter Output Protocol
protocol TracksOutputProtocol: AnyObject
{
    func albumsInfoDidFetch(albums: [ATMusic])
    func errorOccured(message: String)
}

/// Router Protocols and assembling Module
protocol TracksRouterProtocol: AnyObject
{
    var presenter: TracksPresenterProtocol? {get set}
    func assembleModule(view: TracksViewProtocol)
    func showDetailView(detailView: TracksDetailViewProtocol, album: ATResponseProtocol)
}
