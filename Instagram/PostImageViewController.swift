//
//  PostImageViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Juliana Morota on 9/29/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class PostImageViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageToPost: UIImageView!
    @IBOutlet weak var message: UITextField!
    
    //animação de carregamento
    var activityIndicator = UIActivityIndicatorView()
    
    
    /**
    * ESCOLHENDO A IMAGEM NA GALERIA
    */
    @IBAction func chooseImage(sender: AnyObject)
    {
        let image = UIImagePickerController()
        image.delegate = self //colocando que esse controller é responsável pela imagem
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary //de onde vem a imagem (pode ser câmera tbm)
        image.allowsEditing = false
        self.presentViewController(image, animated: true, completion: nil) //mostrando
    }
    
    /**
     * QUANDO O USUÁRIO SELECIONOU A IMAGEM
     */
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?)
    {
        self.dismissViewControllerAnimated(true, completion: nil) //remove a parte de escolher imagem
        imageToPost.image = image //atualizando a imageview com a imagem da galeria
    }
    
    /**
     * QUANDO O USUÁRIO CLICA EM "ENVIAR"
     */
    @IBAction func postImage(sender: AnyObject)
    {
        //animação de carregamento
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        let post = PFObject(className: "Post") //declarando o post e a classe
        post["message"] = message.text //adicionando a mensagem
        post["userId"] = PFUser.currentUser()!.objectId! //colocando o id do usuário
        let imageData = UIImageJPEGRepresentation(imageToPost.image!, 0.2) //setando qual é a imagem
        let imageFile = PFFile(name: "image.png", data: imageData!) //convertendo a imagem pra file
        post["imageFile"] = imageFile //salvando a imagem
        
        post.saveInBackgroundWithBlock { (sucess, error) in
            self.activityIndicator.stopAnimating()
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            
            if error == nil
            {
                self.displayAlert("Imagem postada", message: "Sua imagem foi postada com sucesso")
                self.imageToPost.image = UIImage(named: "placeholder (1).png")
                self.message.text = ""
            }
            else
            {
                self.displayAlert("Falha no envio", message: "Por favor, tente novamente")
            }
        }
    }
    
    /**
     * exibir alertas
     * @param título do alert e mensagem
     **/
    func displayAlert(title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: {(action) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
}
