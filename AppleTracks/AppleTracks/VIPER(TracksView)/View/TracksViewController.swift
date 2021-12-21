//
//  TracksViewController.swift
//  AppleTracks
//
//  Created by Sanjay Kumar on 16/12/2021.
//

import UIKit

class TracksViewController: UIViewController, TracksViewProtocol {
    /// Presenter protocol
    weak var presenter: TracksPresenterProtocol?
    
    @IBOutlet weak var tableView: UITableView!
    
    /// Lazy property for activity indicator
    internal lazy var activity = ATActivityView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        activity.showActivityIndicatory(view: self.view, alertTitle)
        presenter?.fetchAlbumsInformation()
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? ATTrackTableViewCell else { return }
        guard let index = tableView.indexPath(for: cell)?.row else { return }
        guard let detailView = segue.destination as? TracksDetailViewController else { return }
        presenter?.pushToDetailView(detailView: detailView, forIndex: index)
   
        }
}

// MARK: - Extension for TableView DataSource
extension TracksViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = presenter?.response else { return 0 }
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ATTrackTableViewCell.reuseIdentifier, for: indexPath) as? ATTrackTableViewCell else {
            fatalError(cellError)
        }
        if let albumInfo = presenter?.response?[indexPath.row] {
            cell.displayData(album: albumInfo)
        }
        return cell
    }
}


