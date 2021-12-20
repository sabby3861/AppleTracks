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
    var response: ATMusic? {get set}
    func showData(album: ATResponseProtocol)
}

/// Router Protocols and assembling Module
protocol TracksDetailRouterProtocol: AnyObject
{
    //var presenter: TracksPresenterProtocol? {get set}
    func assembleModule(response: ATResponseProtocol, view: TracksDetailViewProtocol)
}
