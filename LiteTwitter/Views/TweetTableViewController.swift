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

  //  var tweetIDs = [String]()
    
    var favoriteTweetIDs = [String:Bool]()
    
    var tweets = [TWTRTweet]()
    
    
  //  var tweetViews = [TWTRTweetView]()
    
    
    @IBAction func onLogout(_ sender: Any) {
        let story = TWTRTwitter.sharedInstance().sessionStore
        if let userID = story.session()?.userID {
            story.logOutUserID(userID)
            
            let loginViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginScreen")
            
            UIApplication.shared.keyWindow?.rootViewController = loginViewController
        }
    }
    
    
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
        let tweetID = tweets[sender.tag].tweetID
        
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
        //tweetIDs.removeAll()
        
        //let dataSource = TWTRUserTimelineDataSource(screenName: "#twitterflock", apiClient: TWTRAPIClient.withCurrentUser())
        
        //let dataSource = TWTRSearchTimelineDataSource(searchQuery: "twitter", apiClient: TWTRAPIClient.withCurrentUser())
        
        
       // let story = TWTRTwitter.sharedInstance().sessionStore
        //if let userID = story.session()?.userID {
            
        
        
           // let dataSource =  TWTRSearchTimelineDataSource(searchQuery: "#twitterflock", apiClient: TWTRAPIClient(), languageCode: nil, maxTweetsPerRequest: 100, resultType: nil)
        
       // let dataSource =  TWTRSearchTimelineDataSource(searchQuery: "surfing", apiClient: TWTRAPIClient(), languageCode: nil, maxTweetsPerRequest: 100, resultType: nil)
        
           // let dataSource =  TWTRUserTimelineDataSource(searchQuery: "surfing", userID: nil, apiClient: TWTRAPIClient(), maxTweetsPerRequest: 100, includeReplies: true, includeRetweets: true)
            
            let dataSource =  TWTRUserTimelineDataSource(screenName: "surfing", userID: nil, apiClient: TWTRAPIClient(), maxTweetsPerRequest: 100, includeReplies: true, includeRetweets: true)
       
        
       
            readData(dataSource: dataSource, idTweet: "")
        
        
       
       
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
        
        
            
       // }

    }

    func readData(dataSource: TWTRTimelineDataSource, idTweet: String) {
        dataSource.loadPreviousTweets(beforePosition: idTweet) {[weak self]  (tweets, cursor, error) in
            if let tweets = tweets {
                print(tweets)
                if let iSelf = self {
                    
                DispatchQueue.main.async {
                   
                    
                    
                    if tweets.count > 0 {
                        iSelf.tableView.beginUpdates()
                        var indexes = [IndexPath]()
                        
                        
                        for i in  0 ..< tweets.count {
                            
                            print(iSelf.tweets.count + i)
                            
                            let indexRow = (iSelf.tweets.count==0 ? 0 : iSelf.tweets.count-1 )
                            
                            let indexPath = IndexPath(item: indexRow + i, section: 0)
                            
                            indexes.append(indexPath)
                            
                        }
                        
                        
                        iSelf.tweets += tweets
                        
                        iSelf.tableView.insertRows(at: indexes, with: .none)
                        iSelf.tableView.endUpdates()
                        
                        if let last = tweets.last {
                            iSelf.readData(dataSource: dataSource, idTweet: last.tweetID)
                        }
                        
                    }
     
                }
            }
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
        print(tweets.count)
        
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
