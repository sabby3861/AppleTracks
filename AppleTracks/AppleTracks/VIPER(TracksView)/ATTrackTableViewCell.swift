//
//  ATTrackTableViewCell.swift
//  AppleTracks
//
//  Created by Sanjay Kumar on 20/12/2021.
//

import UIKit

class ATTrackTableViewCell: UITableViewCell {

    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var artistImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    /// Display data on table view cell
    ///
    /// - Parameter data: Results containing all info
    func displayData(album: ATMusic) {
        if let title = album.track {
            trackNameLabel.text = title
        } else {
            trackNameLabel.text = noAlbum
        }
        if let name = album.name {
            artistNameLabel.text = name
        } else {
            artistNameLabel.text = noArtist
        }
        guard let imageUrl = URL(string: (album.image)!) else { return }
        artistImageView.load(url: imageUrl)
    }
}
