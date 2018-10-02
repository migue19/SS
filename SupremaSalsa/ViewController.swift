//
//  ViewController.swift
//  SupremaSalsa
//
//  Created by miguel mexicano on 02/10/18.
//  Copyright © 2018 miguel mexicano. All rights reserved.
//

import UIKit
import AVFoundation
import FBSDKCoreKit
import FBSDKLoginKit


struct dataFacebook {
    var name: String?
    var lastname: String?
    var firstName: String?
    var email: String?
    var idFacebook: String
}

class ViewController: UIViewController,FBSDKLoginButtonDelegate {
    @IBOutlet var fondo: UIView!
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //playVideo(from: "intro.mp4")
        
        if(FBSDKAccessToken.current() == nil){
            print("Not Logged in..")
        }
        else{
            print("logged in..")
            let loginManager = FBSDKLoginManager()
            loginManager.logOut()
        }
        
        loginButton.readPermissions = ["public_profile"]
        loginButton.delegate = self
        
    }

    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }

    
    private func playVideo(from file:String) {
        let file = file.components(separatedBy: ".")
        
        guard let path = Bundle.main.path(forResource: file[0], ofType:file[1]) else {
            debugPrint( "\(file.joined(separator: ".")) not found")
            return
        }

        let avPlayer = AVPlayer(url: URL(fileURLWithPath: path))
        let avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        avPlayer.volume = 0
        avPlayer.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        
        avPlayerLayer.frame = view.layer.bounds
        view.backgroundColor = UIColor.clear
        view.layer.insertSublayer(avPlayerLayer, at: 0)
        avPlayer.play()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: avPlayer.currentItem)
    }
    
    
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: CMTime.zero, completionHandler: nil)
        
    }
    
    
    func returnUserDataFace()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "email,name,first_name,last_name,gender"], httpMethod: "GET")
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error!)")
            }
            else
            {
                print("fetched user: \(result!)")
                
                if let jsonResult = result! as? Dictionary<String, AnyObject> {
                
                    let data =   dataFacebook(name: jsonResult["name"] as? String, lastname: jsonResult["last_name"] as? String, firstName: jsonResult["first_name"] as? String, email: jsonResult["email"] as? String, idFacebook: jsonResult["id"] as! String)
                    
                    print("data: \(data.name!)")
                    
                }
                
                self.performSegue(withIdentifier: "ir_perfil", sender: self)
            }
        })
    }
    
    
    
    //Metodos Facebook
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("User Logged In")
        
        if ((error) != nil)
        {
            print(error.localizedDescription)
        }
        else if result.isCancelled {
            // Handle cancellations
            print("cnacelado")
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            print("Login Complete")
            self.returnUserDataFace()
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    
    
    
    
    
    
    
  
}

