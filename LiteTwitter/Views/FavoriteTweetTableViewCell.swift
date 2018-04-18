import UIKit
import TwitterKit

class FavoriteTweetTableViewCell: UITableViewCell {
    

    @IBOutlet weak var tweetView: TWTRTweetView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
