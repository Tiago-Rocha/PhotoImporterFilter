//
//  ViewController.swift
//  BackgroundFilter
//
//  Created by Tiago Rocha on 15/04/16.
//  Copyright © 2016 Tiago Rocha. All rights reserved.
//
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    //Assign a var to the image
    @IBOutlet var photoImageView: UIImageView!
    
    // Create a place to render the filtered image
    let context = CIContext(options: nil)
    
    // Create an image picker constant
    let imagePicker = UIImagePickerController()
    
    @IBAction func importPhoto(sender: AnyObject) {
        NSLog("Button Pressed")
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    //Apply filter function
    @IBAction func applyFilter(sender: AnyObject) {
        
        // Create an image to filter
        let inputImage = CIImage(image: photoImageView.image!)
        
        // Create a random color to pass to a filter
        let randomColor = [kCIInputAngleKey: (Double(arc4random_uniform(314)) / 100)]
        
        // Apply a filter to the image
        let filteredImage = inputImage!.imageByApplyingFilter("CIHueAdjust", withInputParameters: randomColor)
        
        // Render the filtered image
        let renderedImage = context.createCGImage(filteredImage, fromRect: filteredImage.extent)
        
        // Reflect the change back in the interface
        photoImageView.image = UIImage(CGImage: renderedImage)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imagePicker.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info :[String : AnyObject]) {
        NSLog("sdfkjslfjslf")
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            photoImageView.contentMode = .ScaleAspectFit
            photoImageView.image = pickedImage
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}