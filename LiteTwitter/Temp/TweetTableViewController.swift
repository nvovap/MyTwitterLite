//
//  TweetTableViewController.swift
//  LiteTwitter
//
//  Created by Vladimir Nevinniy on 4/17/18.
//  Copyright © 2018 Vladimir Nevinniy. All rights reserved.
//

import UIKit
import TwitterKit





class TweetTableViewController: UITableViewController {

    var tweetIDs = [String]()
    
    var favoriteTweetIDs = [String:Bool]()
    
    var tweets = [TWTRTweet]()
    
    
  //  var tweetViews = [TWTRTweetView]()
    
    @IBAction func addNewTweet(_ sender: UIBarButtonItem) {
        
        if (TWTRTwitter.sharedInstance().sessionStore.hasLoggedInUsers()) {
            // App must have at least one logged-in user to compose a Tweet
            let composer = TWTRComposerViewController.emptyComposer()
            present(composer, animated: true, completion: nil)
        } else {
            // Log in, and then check again
            TWTRTwitter.sharedInstance().logIn { session, error in
                if session != nil { // Log in succeeded
                    let composer = TWTRComposerViewController.emptyComposer()
                    self.present(composer, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "No Twitter Accounts Available", message: "You must log in before presenting a composer.", preferredStyle: .alert)
                    
                    let cancelAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler:{
                        (action: UIAlertAction!) -> Void in
                    })
                    alert.addAction(cancelAction)
                    
                    self.present(alert, animated: false, completion: nil)
                }
            }
        }
        
    }
    
    
    @IBAction func onClickFavorite(_ sender: UIButton) {
        let tweetID = tweetIDs[sender.tag]
        
        if favoriteTweetIDs.removeValue(forKey: tweetID) == nil {
            favoriteTweetIDs[tweetID] = false
            
            if let app = UIApplication.shared.delegate as? AppDelegate {
                let contexData = app.persistentContainer.viewContext
                
                let favorite = Favorite(context: contexData)
                favorite.idTweet = tweetID
                
                app.saveContext()
            }
            
        } else {
            if let app = UIApplication.shared.delegate as? AppDelegate {
                let contexData = app.persistentContainer.viewContext
                
                let request = NSFetchRequest<Favorite>(entityName: "Favorite")
                request.predicate = NSPredicate.init(format: "idTweet==\(tweetID)")
                
                
                do {
                    let objects = try contexData.fetch(request)
                    for object in objects {
                        contexData.delete(object)
                    }
                    
                    app.saveContext()
                } catch let error {
                    print(error)
                }
            
                
                
                
               
            }
        }
        
        
        self.tableView.beginUpdates()
        
        let indexPath = IndexPath(item: sender.tag, section: 0)
        
        self.tableView.reloadRows(at: [indexPath], with: .none)
        
        self.tableView.endUpdates()
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load Favorite
        tweetIDs.removeAll()
        
        if let app = UIApplication.shared.delegate as? AppDelegate {
            let contexData = app.persistentContainer.viewContext
        
            let request = NSFetchRequest<Favorite>(entityName: "Favorite")
        
            do {
                let objects = try contexData.fetch(request)
                for object in objects {
                    if let idTweet = object.idTweet {
                        favoriteTweetIDs[idTweet] = true
                    }
                }
            } catch let error {
                print(error)
            }
        }
        
         tweetIDs = ["887501877864157184", "887422223681699844", "886020352995770368", "886004210528944129", "885551779210907648", "885238919553400832", "884900813998440448", "884500991227207680", "884457185580732416", "880924631531569152", "887413255118897152", "887388673045544960", "887169021908369408", "887106427277291520", "887085114282319872", "887081820688310272", "887044403507769344", "887034086337822720", "886379158783221760", "886362573670555648", "886359162254270464", "886010291095457792", "885920800653561857", "885920657527132160", "885906706630299652", "885891254759825408", "885817132109492225", "885814925062483968", "885732773511680000", "885717018996989953", "885703673296306176", "885671865544450049", "885667255404511232", "885663207913803776", "885642012426358784", "885610141332025344", "885551016053166080", "885402524794052608", "885359270941700097", "885331504708018176","887501877864157184", "887422223681699844", "886020352995770368", "886004210528944129", "885551779210907648", "885238919553400832", "884900813998440448", "884500991227207680", "884457185580732416", "880924631531569152", "887413255118897152", "887388673045544960", "887169021908369408", "887106427277291520", "887085114282319872", "887081820688310272", "887044403507769344", "887034086337822720", "886379158783221760", "886362573670555648", "886359162254270464", "886010291095457792", "885920800653561857", "885920657527132160", "885906706630299652", "885891254759825408", "885817132109492225", "885814925062483968", "885732773511680000", "885717018996989953", "885703673296306176", "885671865544450049", "885667255404511232", "885663207913803776", "885642012426358784", "885610141332025344", "885551016053166080", "885402524794052608", "885359270941700097", "885331504708018176","887501877864157184", "887422223681699844", "886020352995770368", "886004210528944129", "885551779210907648", "885238919553400832", "884900813998440448", "884500991227207680", "884457185580732416", "880924631531569152", "887413255118897152", "887388673045544960", "887169021908369408", "887106427277291520", "887085114282319872", "887081820688310272", "887044403507769344", "887034086337822720", "886379158783221760", "886362573670555648", "886359162254270464", "886010291095457792", "885920800653561857", "885920657527132160", "885906706630299652", "885891254759825408", "885817132109492225", "885814925062483968", "885732773511680000", "885717018996989953", "885703673296306176", "885671865544450049", "885667255404511232", "885663207913803776", "885642012426358784", "885610141332025344", "885551016053166080", "885402524794052608", "885359270941700097", "885331504708018176","887501877864157184", "887422223681699844", "886020352995770368", "886004210528944129", "885551779210907648", "885238919553400832", "884900813998440448", "884500991227207680", "884457185580732416", "880924631531569152", "887413255118897152", "887388673045544960", "887169021908369408", "887106427277291520", "887085114282319872", "887081820688310272", "887044403507769344", "887034086337822720", "886379158783221760", "886362573670555648", "886359162254270464", "886010291095457792", "885920800653561857", "885920657527132160", "885906706630299652", "885891254759825408", "885817132109492225", "885814925062483968", "885732773511680000", "885717018996989953", "885703673296306176", "885671865544450049", "885667255404511232", "885663207913803776", "885642012426358784", "885610141332025344", "885551016053166080", "885402524794052608", "885359270941700097", "885331504708018176","887501877864157184", "887422223681699844", "886020352995770368", "886004210528944129", "885551779210907648", "885238919553400832", "884900813998440448", "884500991227207680", "884457185580732416", "880924631531569152", "887413255118897152", "887388673045544960", "887169021908369408", "887106427277291520", "887085114282319872", "887081820688310272", "887044403507769344", "887034086337822720", "886379158783221760", "886362573670555648", "886359162254270464", "886010291095457792", "885920800653561857", "885920657527132160", "885906706630299652", "885891254759825408", "885817132109492225", "885814925062483968", "885732773511680000", "885717018996989953", "885703673296306176", "885671865544450049", "885667255404511232", "885663207913803776", "885642012426358784", "885610141332025344", "885551016053166080", "885402524794052608", "885359270941700097", "885331504708018176","887501877864157184", "887422223681699844", "886020352995770368", "886004210528944129", "885551779210907648", "885238919553400832", "884900813998440448", "884500991227207680", "884457185580732416", "880924631531569152", "887413255118897152", "887388673045544960", "887169021908369408", "887106427277291520", "887085114282319872", "887081820688310272", "887044403507769344", "887034086337822720", "886379158783221760", "886362573670555648", "886359162254270464", "886010291095457792", "885920800653561857", "885920657527132160", "885906706630299652", "885891254759825408", "885817132109492225", "885814925062483968", "885732773511680000", "885717018996989953", "885703673296306176", "885671865544450049", "885667255404511232", "885663207913803776", "885642012426358784", "885610141332025344", "885551016053166080", "885402524794052608", "885359270941700097", "885331504708018176","887501877864157184", "887422223681699844", "886020352995770368", "886004210528944129", "885551779210907648", "885238919553400832", "884900813998440448", "884500991227207680", "884457185580732416", "880924631531569152", "887413255118897152", "887388673045544960", "887169021908369408", "887106427277291520", "887085114282319872", "887081820688310272", "887044403507769344", "887034086337822720", "886379158783221760", "886362573670555648", "886359162254270464", "886010291095457792", "885920800653561857", "885920657527132160", "885906706630299652", "885891254759825408", "885817132109492225", "885814925062483968", "885732773511680000", "885717018996989953", "885703673296306176", "885671865544450049", "885667255404511232", "885663207913803776", "885642012426358784", "885610141332025344", "885551016053166080", "885402524794052608", "885359270941700097", "885331504708018176","887501877864157184", "887422223681699844", "886020352995770368", "886004210528944129", "885551779210907648", "885238919553400832", "884900813998440448", "884500991227207680", "884457185580732416", "880924631531569152", "887413255118897152", "887388673045544960", "887169021908369408", "887106427277291520", "887085114282319872", "887081820688310272", "887044403507769344", "887034086337822720", "886379158783221760", "886362573670555648", "886359162254270464", "886010291095457792", "885920800653561857", "885920657527132160", "885906706630299652", "885891254759825408", "885817132109492225", "885814925062483968", "885732773511680000", "885717018996989953", "885703673296306176", "885671865544450049", "885667255404511232", "885663207913803776", "885642012426358784", "885610141332025344", "885551016053166080", "885402524794052608", "885359270941700097", "885331504708018176","887501877864157184", "887422223681699844", "886020352995770368", "886004210528944129", "885551779210907648", "885238919553400832", "884900813998440448", "884500991227207680", "884457185580732416", "880924631531569152", "887413255118897152", "887388673045544960", "887169021908369408", "887106427277291520", "887085114282319872", "887081820688310272", "887044403507769344", "887034086337822720", "886379158783221760", "886362573670555648", "886359162254270464", "886010291095457792", "885920800653561857", "885920657527132160", "885906706630299652", "885891254759825408", "885817132109492225", "885814925062483968", "885732773511680000", "885717018996989953", "885703673296306176", "885671865544450049", "885667255404511232", "885663207913803776", "885642012426358784", "885610141332025344", "885551016053166080", "885402524794052608", "885359270941700097", "885331504708018176"]

        
        
//        TWTRTwitter.sharedInstance().logIn {guestSession, error in
//            if (guestSession != nil) {
//                // make API calls that do not require user auth
//            } else {
//                print("error: \(error!.localizedDescription)");
//            }
//        }
        
        let client = TWTRAPIClient.withCurrentUser()
        
     
        
        client.loadTweets(withIDs: tweetIDs) { [weak self] (tweet, error) in
          //  SVProgressHUD.dismiss()
            if let error = error {
                debugPrint("Error Loading Tweets: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self?.tweets = tweet
                self?.tableView.reloadData()
                
            } else {
                debugPrint("An unexpected error has occured");
            }
        }
        
     
     
    }

  
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweets.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TweetTableViewCell

        
        let tweet = tweets[indexPath.row]
        cell.tweetView.configure(with: tweet)
        cell.buttonFavorite.tag = indexPath.row
        
        let favorite = (favoriteTweetIDs[tweet.tweetID] == nil ? true : false)
        
        cell.addToFavorites = favorite

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
