//
//  ItemViewController.swift
//  CollectionTracker
//
//  Created by Connor Jennison on 9/21/17.
//  Copyright © 2017 Connor Jennison. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var itemTapped: UIButton!
    
    var item: Item? = nil
    var imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        
        if item != nil
        {
            deleteButton.isHidden = false
            itemImageView.image = UIImage(data: item!.image! as Data)
            itemNameTextField.text = item!.title
            
            addButton.setTitle("Update in Collection", for: .normal)
            
        }
            
        else{
            deleteButton.isHidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func photosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        itemImageView.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        if item != nil && itemNameTextField.text != ""
        {
            item!.title = itemNameTextField.text
            item!.image = UIImagePNGRepresentation(itemImageView.image!)! as NSData
        }
            
        else
        {
            if itemNameTextField.text != ""
            {
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                let item = Item(context: context)
                
                
                item.title = itemNameTextField.text
                item.image = UIImagePNGRepresentation(itemImageView.image!)! as NSData
            }
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteTapped(_ sender: Any)
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        context.delete(item!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    
    
}
