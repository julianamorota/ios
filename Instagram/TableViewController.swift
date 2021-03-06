//
//  TableViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Juliana Morota on 9/28/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class TableViewController: UITableViewController {

    //array pra salvar os usernames e ids iniciando vazia
    var usernames = [""]
    var userIds = [""]
    
    //dictionary pra saber quem tá seguindo
    var isFollowing = ["":false]
    
    //atualiza a página
    var refresher:UIRefreshControl!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Puxe para atualizar")
        //o que irá acontecer quando o usuário puxar a tela
        refresher.addTarget(self, action: #selector(TableViewController.refresh), forControlEvents: UIControlEvents.ValueChanged) //valor alterado
        self.tableView.addSubview(refresher) //adicionando na view
        refresh()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return usernames.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        cell.textLabel?.text = usernames[indexPath.row] //pegar os valores da array e exibir na tabela
        
        let userId = userIds[indexPath.row]
        
        if isFollowing[userId] == true
        {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark //colocar um checkmark ao lado da pessoa seguida
        }

        return cell
    }
    
    /**
     * TODA VEZ QUE O USUÁRIO CLICAR EM UMA LINHA
     **/
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let userId = userIds[indexPath.row]
        //pegar informações da tabela
        let cell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!

        //verificar se o current user já está seguindo o usuário
        //caso esteja, tem que deixar de seguir
        if isFollowing[userId] == true
        {
            isFollowing[userId] = false;
            cell.accessoryType = UITableViewCellAccessoryType.None
            let query = PFQuery(className: "Follower")
            query.whereKey("follower", equalTo: (PFUser.currentUser()?.objectId!)!)
            query.whereKey("following", equalTo: userId)
            
            query.findObjectsInBackgroundWithBlock({ (objects, error) in
                if let objects = objects
                {
                    for object in objects
                    {
                        object.deleteInBackground()
                    }
                }
            })
            
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark //colocar um checkmark ao lado da pessoa seguida
            
            //pegar as informações de seguidores
            let following = PFObject(className: "Follower")
            following["following"] = userIds[indexPath.row]
            following["follower"] = PFUser.currentUser()?.objectId //seguidor = usuário atual logado
            following.saveInBackground() //salvar sem que nada seja mostrado

        }
    }
    
    /**
     * TODA VEZ QUE O USUÁRIO PUXAR A TELA PRA ATUALIZAR
     **/
    func refresh()
    {
        //retirar primeiro index em branco
        usernames.removeAll(keepCapacity: true)
        userIds.removeAll(keepCapacity: true)
        isFollowing.removeAll(keepCapacity: true)
        
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
                        //adicionar na array menos o usuário atual
                        if user.objectId! != PFUser.currentUser()?.objectId {
                            //adicionar na array
                            self.usernames.append(user.username!)
                            self.userIds.append(user.objectId!)
                            
                            //busca
                            let query = PFQuery(className: "Follower")
                            //trazendo os seguidores e seguidos
                            query.whereKey("follower", equalTo: (PFUser.currentUser()?.objectId)!)
                            query.whereKey("following", equalTo: user.objectId!)
                            //executar um código ao fazer a pesquisa
                            query.findObjectsInBackgroundWithBlock({ (objects, error) in
                                //se resultados foram encontrados
                                if let objects = objects
                                {
                                    if objects.count > 0
                                    {
                                        self.isFollowing[user.objectId!] = true
                                    }
                                    else
                                    {
                                        self.isFollowing[user.objectId!] = false;
                                    }
                                }
                                if self.isFollowing.count == self.usernames.count
                                {
                                    //reload na tabela
                                    self.tableView.reloadData()
                                    self.refresher.endRefreshing() //esconder a parte de atualizando
                                }
                            })
                        }
                    }
                }
            }
        })
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
