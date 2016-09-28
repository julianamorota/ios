/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var imageContainer: UIImageView!

    @IBAction func alert(sender: AnyObject) {
        let alert = UIAlertController(title: "Olá", message: "que bom você está aqui", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action) in
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBAction func pause(sender: AnyObject) {
        
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        //deixar como uma subview, dentro da principal
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    @IBAction func restore(sender: AnyObject) {
    
        activityIndicator.stopAnimating()
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    
    
    @IBAction func importImage(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        //câmera ou biblioteca
        //imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.allowsEditing = false;
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        print("Image selected")
        self.dismissViewControllerAnimated(true, completion: nil)
        //atualizar
        imageContainer.image = image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let product = PFObject(className: "Products")
//        
//        product["name"] = "refrigerante"
//        product["description"] = "limão"
//        product["price"] = 2.99
//        product.saveInBackgroundWithBlock { (success, error) -> Void in
//            if success == true {
//                print("Sucesso")
//            }else{
//                print("Failed")
//            }
//        }
        
//        let query = PFQuery(className: "Products")
//        query.getObjectInBackgroundWithId("k48z8h93Bm") { (object, error) in
//            if error != nil {
//                print(error)
//            }else{
//                print(object!.objectForKey("description"))
//            }
//        }
        
        let query = PFQuery(className: "Products")
        query.getObjectInBackgroundWithId("k48z8h93Bm") { (object, error) in
            if error != nil {
                print(error)
            }else if let product = object{
                product["price"] = 4
                
                //persistir a mudança
                product.saveInBackground()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
