//
//  voltageViewController.swift
//  dpqrapp
//
//  Created by Vojtěch Honig on 17.10.16.
//  Copyright © 2016 Vojtěch Honig. All rights reserved.
//

import UIKit

class voltageViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var voltageLabel: UILabel!
    @IBOutlet weak var voltageStepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func voltageChanged(_ sender: UIStepper) {
        
        voltageLabel.text = "\(voltageStepper.value / 10)"
        
        newBeerVoltage = voltageStepper.value / 10
        
    }

    // MARK: - Actions
    @IBAction func nextSegueAction(_ sender: UIBarButtonItem) {
        
        self.performSegue(withIdentifier: "nextSegue", sender: nil)
        
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
