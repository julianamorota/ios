//
//  FeedTableViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Juliana Morota on 9/29/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class FeedTableViewController: UITableViewController {
    
    var messages = [String]()
    var usernames = [String]()
    var imageFiles = [PFFile]()
    var users = [String:String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //variável pra busca
        let query = PFUser.query()
        
        //faz a pesquisa
        query?.findObjectsInBackgroundWithBlock({ (objects, error) in
            
            //se tem resultados
            if let users = objects
            {
                for object in users
                {
                    if let user = object as? PFUser
                    {
                        self.users[object.objectId!] = user.username!
                    }
                }
            }
        })

        
        
        //carregar os usuários
        let getFollowedUsersQuery = PFQuery(className: "Follower")
        getFollowedUsersQuery.whereKey("follower", equalTo: PFUser.currentUser()!.objectId!)
        getFollowedUsersQuery.findObjectsInBackgroundWithBlock { (objects, error) in
            if let objects = objects
            {
                for object in objects
                {
                    let followedUser = object["following"] as! String
                    //posts do usuário
                    let query = PFQuery(className: "Post")
                    query.whereKey("userId", equalTo: followedUser)
                    query.findObjectsInBackgroundWithBlock({ (objects, error) in
                        if let objects = objects
                        {
                            for object in objects
                            {
                                self.messages.append(object["message"] as! String)
                                self.imageFiles.append(object["imageFile"] as! PFFile)
                                self.usernames.append(self.users[object["userId"]! as! String]!)
                                
                                self.tableView.reloadData()
                                
                            }
                        }
                    })
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //do tipo postCell (tem acesso aos elementos da classe)
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! postCell
        imageFiles[indexPath.row].getDataInBackgroundWithBlock { (data, error) in
            if let downloadedImage = UIImage(data: data!)
            {
                cell.postedImage.image = downloadedImage
            }
        }
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}