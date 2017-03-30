//
//  BarrelCreationViewController.swift
//  dpqrapp
//
//  Created by Vojtěch Honig on 06.12.16.
//  Copyright © 2016 Vojtěch Honig. All rights reserved.
//

import UIKit

class BarrelCreationViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    // MARK: - Properties
    @IBOutlet weak var beerDescriptionTextView: UITextView!
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerPicker: UIPickerView!
    @IBOutlet weak var finishBeerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beerDescriptionTextView.delegate = self
        
        beerPicker.dataSource = self
        
        beerPicker.delegate = self
        
        newBarrelBeer = beerArray[0]
    
    }
    // MARK: - UIPickerViewDataSource, UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return beerArray[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        newBarrelBeer = beerArray[row]
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return beerArray.count
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    @IBAction func imagePickingPreparation(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: "Vyber způsob", message: "Chceš fotit nebo vybírat?", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Zrušit", style: .cancel, handler: nil)
        
        let cameraAction = UIAlertAction(title: "Fotit", style: .default, handler: {
            (action) in
            
            self.present(self.createImagePickerController(source: .camera), animated: true, completion: nil)
            
        })
        let photoLibraryAction = UIAlertAction(title: "Vybrat", style: .default, handler: {
            (action) in
            
            self.present(self.createImagePickerController(source: .photoLibrary), animated: true, completion: nil)
            
        })
        
        actionSheet.addAction(cancelAction)
        
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photoLibraryAction)
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    @IBAction func finishBarrel(_ sender: UIButton) {
        
        newBarrelID = barrelID
        
        barrelArray.append(barrelID)
        
        if let description = beerDescriptionTextView.text {
            
            newBarrelDescription = description
            
        }
        
        let barrel = [
            
            "Obsah": beerDict[newBarrelBeer]!,
            "Popis": newBarrelDescription,
            "Místo": "-KX_VN9WEmTJPMFhM0X3"
            
            ] as [String : Any]
        
        realtimeDatabaseReference.child("Sudy/\(barrelID)").setValue(barrel)
        
        if beerImageView.alpha == 1 {
        
            newBarrelPhoto = beerImageView.image
            
            let imageData: Data = UIImagePNGRepresentation(newBarrelPhoto!)!
        
            task = storage.child(newBarrelID).put(imageData, metadata: nil)
            
            self.performSegue(withIdentifier: "finishBarrelWithPhotoSegue", sender: nil)
        
        }
        
        self.performSegue(withIdentifier: "finishBarrelSegue", sender: nil)
        
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    // MARK: - Functions
    
    func createImagePickerController(source: UIImagePickerControllerSourceType) -> UIImagePickerController {
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        
        imagePickerController.sourceType = source
        
        return imagePickerController
        
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        newBarrelPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage?
        
        beerImageView.image = newBarrelPhoto
        
        beerImageView.alpha = 1
                
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    // MARK: - Handeling Touches
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        beerDescriptionTextView.resignFirstResponder()
        
    }
    
    // MARK: - UITextView Delegate
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            
            textView.resignFirstResponder()
            return false
            
        }
        
        return true
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
