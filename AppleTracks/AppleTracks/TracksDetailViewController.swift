//
//  TracksDetailViewController.swift
//  AppleTracks
//
//  Created by Sanjay Kumar on 20/12/2021.
//

import UIKit

class TracksDetailViewController: UIViewController, TracksDetailViewProtocol {
    
    var response: ATMusic?
    
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var artistImageView: UIImageView!
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let album = response else { return}
        showData(album: album)
    }
    

    func showData(album: ATResponseProtocol) {
        guard let album = album as? ATMusic else { return}
        trackNameLabel.text = album.track
        artistLabel.text = album.name
        priceLabel.text = album.price.string
        durationLabel.text = album.duration.string
        let date = DateFormatter.yyyyMMdd.string(from: album.date)
        releaseDateLabel.text = date
        guard let urlString = URL(string: album.image!) else { return }
        artistImageView.load(url: urlString)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
