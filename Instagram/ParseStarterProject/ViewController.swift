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

class ViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    //variável pra verificar se o usuário está na parte de registro
    var signUpActive = true
    
    //criar o loading
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    /**
     * ação do botão "Registrar"
     **/
    @IBAction func signUp(sender: AnyObject)
    {
        //caso usuário não preencha os campos
        if username.text == "" || password.text == ""
        {
            displayAlert("Erro", message: "Por favor preencha usuário e senha")
        }
        //caso os campos sejam preenchidos corretamente
        else
        {
            //CRIAR O LOADING
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50)) //cria o frame
            activityIndicator.center = self.view.center //posiciona no centro da tela
            activityIndicator.hidesWhenStopped = true //sumir assim que for pausado
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray //define a cor
            view.addSubview(activityIndicator) //adicionando na view
            UIApplication.sharedApplication().beginIgnoringInteractionEvents() //bloquear os botões enquanto estiver rodando
            
            var errorMessage = "Por favor, tente novamente mais tarde"
            
            //PARTE DE REGISTRO (SIGN UP)
            if signUpActive == true
            {
                //PARTE DO SIGN UP DO PARSE
                let user = PFUser()
                user.username = username.text
                user.password = password.text
                
                user.signUpInBackgroundWithBlock({ (success, error) in
                    self.activityIndicator.stopAnimating() //parar o activity indicator
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()  //usuário voltar a interagir com o app
                    
                    //sign up realizado com sucesso
                    if error == nil
                    {
                        //indo para a próxima tela utilizando segue login
                        self.performSegueWithIdentifier("login", sender: self)
                    }
                    //erro no sign up
                    else{
                        //caso aconteça um erro
                        if let errorString = error!.userInfo["error"] as? String {
                            errorMessage = errorString
                        }
                        self.displayAlert("Cadastro não realizado", message: errorMessage)
                    }
                    
                })

            }
            //PARTE DE LOGIN
            else
            {
                PFUser.logInWithUsernameInBackground(username.text!, password: password.text!, block: { (user, error) in
                    self.activityIndicator.stopAnimating() //parar o activity indicator
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()  //usuário voltar a interagir com o app

                    if user != nil
                    {
                        //indo para a próxima tela utilizando segue login
                        self.performSegueWithIdentifier("login", sender: self)
                    }
                    else
                    {   //caso aconteça um erro
                        if let errorString = error!.userInfo["error"] as? String {
                            errorMessage = errorString
                        }
                        self.displayAlert("Login não efetuado", message: errorMessage)
                    }
                })
            }
        }
    }
    
    /**
     * ação do botão "Entrar"
     **/
    @IBAction func login(sender: AnyObject)
    {
        //caso o usuário esteja na parte de registro
        if signUpActive == true
        {
            signUpActive = false;
            
            registerButton.setTitle("Entrar", forState: UIControlState.Normal) //muda texto do botão "Registrar"
            registerLabel.text = "Nova conta?" //muda texto da label "Já possui uma conta?"
            loginButton.setTitle("Criar", forState: UIControlState.Normal) //muda texto do botão "Entrar"
        }
        //caso o usuário esteja na parte de login
        else
        {
            signUpActive = true;
            
            registerButton.setTitle("Registrar", forState: UIControlState.Normal) //muda texto do botão "Entrar"
            registerLabel.text = "Já possui uma conta?" //muda texto da label "Nova conta?"
            loginButton.setTitle("Entrar", forState: UIControlState.Normal) //muda texto do botão "Criar"
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
    
    override func viewDidAppear(animated: Bool) {
        //ver se já existe um usuário logado
        if PFUser.currentUser() != nil
        {
            self.performSegueWithIdentifier("login", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
