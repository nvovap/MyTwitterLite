//
//  TweetTableViewCell.swift
//  LiteTwitter
//
//  Created by Vladimir Nevinniy on 4/17/18.
//  Copyright © 2018 Vladimir Nevinniy. All rights reserved.
//

import UIKit
import TwitterKit

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tweetView: TWTRTweetView!
    @IBOutlet weak var buttonFavorite: UIButton!
    
    var addToFavorites: Bool = true {
        didSet {
            let title = (addToFavorites ? "Add to favorite" : "Delete from favorite")
            buttonFavorite.setTitle(title, for: UIControlState.normal)
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
