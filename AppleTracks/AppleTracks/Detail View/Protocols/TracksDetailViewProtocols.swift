//
//  TracksDetailViewProtocols.swift
//  AppleTracks
//
//  Created by Sanjay Kumar on 20/12/2021.
//

import Foundation

/// View Protocol
protocol TracksDetailViewProtocol: AnyObject
{
    var router: TracksDetailRouterProtocol? {get set}
    var response: ATMusic? {get set}
    func showData(album: ATResponseProtocol)
}

/// Router Protocols and assembling Module
protocol TracksDetailRouterProtocol: AnyObject
{
    func assembleModule(response: ATResponseProtocol, view: TracksDetailViewProtocol)
    func openWebPage(for UrlString: String)
}
