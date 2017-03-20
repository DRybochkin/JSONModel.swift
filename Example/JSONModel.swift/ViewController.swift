//
//  ViewController.swift
//  JSONModel.swift
//
//  Created by DRybochkin on 03/21/2017.
//  Copyright (c) 2017 DRybochkin. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {
    var simpleData: SimpleModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let json = JSON(parseJSON: "{amount:1.11, count: 12, dueDate:\"\", title:\"simle model data\"}")
        
        simpleData = SimpleModel(json: json)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

