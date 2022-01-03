//
//  ATTrackTableViewCell.swift
//  AppleTracks
//
//  Created by Sanjay Kumar on 20/12/2021.
//

import UIKit
import Combine

class ATTrackTableViewCell: UITableViewCell {
    
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var artistImageView: UIImageView!
    private var cancellable: AnyCancellable?
    private var animator: UIViewPropertyAnimator?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /// Dont forget to stop the animator else the app would crash
    /// Cancel the AnyCancellable
    override func prepareForReuse() {
        super.prepareForReuse()
        artistImageView.image = nil
        artistImageView.alpha = 0.0
        animator?.stopAnimation(true)
        cancellable?.cancel()
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
        
        priceLabel.text = album.price.string
        guard let imageUrl = URL(string: (album.image)!) else { return }
        //artistImageView.load(url: imageUrl)
        cancellable = loadImage(for: imageUrl).sink { [unowned self] image in self.showImage(image: image) }
    }
    
    
    private func showImage(image: UIImage?) {
        artistImageView.alpha = 0.0
        animator?.stopAnimation(false)
        artistImageView.image = image
        animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.artistImageView.alpha = 1.0
        })
    }
    
    private func loadImage(for url: URL) -> AnyPublisher<UIImage?, Never> {
        return Just(url)
            .flatMap({ poster -> AnyPublisher<UIImage?, Never> in
                return ATImageLoader.shared.loadImage(from: url)
            })
            .eraseToAnyPublisher()
    }
}
