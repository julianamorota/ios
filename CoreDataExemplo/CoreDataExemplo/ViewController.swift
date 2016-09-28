//
//  ViewController.swift
//  CoreDataExemplo
//
//  Created by Juliana Morota on 9/27/16.
//  Copyright © 2016 ios. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext
        
//        let newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context)
//        newUser.setValue("Sayuri", forKey: "username")
//        newUser.setValue("secret", forKey: "password")
//        
//        do{
//            try context.save()
//        } catch {
//            print("Erro ao salvar")
//        }
        
        let request = NSFetchRequest(entityName: "Users")
        request.returnsObjectsAsFaults = false
        
        do{
            let results = try context.executeFetchRequest(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject]{
                    print (result.valueForKey("username"))
                }
            }
        }catch{
            print("Erro ao carregar usuários")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

