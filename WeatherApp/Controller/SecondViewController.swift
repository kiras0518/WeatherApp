//
//  SecondViewController.swift
//  WeatherApp
//
//  Created by YU on 2018/10/8.
//  Copyright © 2018 ameyo. All rights reserved.
//

import UIKit

protocol delegateProtocal {
    
    func newCityName(city: String)
    
}

class SecondViewController: UIViewController {

    var delegate : delegateProtocal?
    
    @IBAction func goBackFirstView(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBAction func getCityDetail(_ sender: UIButton) {
        
        if cityTextField.text != "" {
            
            let input = cityTextField.text
            delegate?.newCityName(city: input!)
            
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    



}
