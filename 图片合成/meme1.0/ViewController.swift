//
//  ViewController.swift
//  meme1.0
//
//  Created by blues on 15/8/21.
//  Copyright (c) 2015年 blues. All rights reserved.
//

import UIKit
var isTop = true

class ViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    let clearAndDissmis = textDelegate()
    
    @IBOutlet weak var toolBar: UIToolbar!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.topText.delegate = self.clearAndDissmis
        self.bottomText.delegate = self.clearAndDissmis
        
        self.topText.text = "顶部"
        self.bottomText.text = "底部"
        let memeTextAttributes = [
        NSStrokeColorAttributeName:UIColor.blackColor(),
            NSForegroundColorAttributeName:UIColor.whiteColor(),
            NSStrokeWidthAttributeName:6.0,
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!
        ]
        
        topText.defaultTextAttributes = memeTextAttributes
        bottomText.defaultTextAttributes = memeTextAttributes
        
        self.shareButton.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        self.subscribeToKeyboardNotifications()
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unscribeToKeyboardNotifications()
    }
    
    //pickAnimage

    @IBAction func pickAnImage(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker,animated:true,completion:nil)
    }
    
    @IBAction func pickAnImageFromCamera(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker,animated:true,completion:nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
           self.imagePickerView.image = image
            self.shareButton.enabled = true
            
        }else{
            print("not ok")
        }
    }
    
    func subscribeToKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unscribeToKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().removeObserver(self,name:UIKeyboardWillShowNotification,object:nil)
        NSNotificationCenter.defaultCenter().removeObserver(self,name:UIKeyboardWillHideNotification,object:nil)
    }
    //keyboardWillShow
    func keyboardWillShow(notification:NSNotification){
        if isTop {
            return
        }
        
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func getKeyboardHeight(notification:NSNotification) -> CGFloat{
        let userInfo = notification.userInfo
        let keyboardsize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardsize.CGRectValue().height
    }
    //keyboardWillhide
    func keyboardWillHide(notification:NSNotification){
        if isTop {
            return
        }
        self.view.frame.origin.y += getKeyboardHeight(notification)
    }
    
    //generate meme image
    func generateMemedImage() -> UIImage{
        self.navigationController?.navigationBarHidden=true
        self.toolBar.hidden = true
        //render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage :UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.navigationController?.navigationBarHidden = false
        self.toolBar.hidden = false
        return memedImage
    }
    
    @IBAction func ShareMeme(sender:UIBarButtonItem) {
        let image = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.presentViewController(controller, animated: true, completion: nil)
    }
    

}

