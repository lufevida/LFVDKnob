//
//  ViewController.swift
//  LFVDKnob
//
//  Created by lufevida on 11/29/2016.
//  Copyright (c) 2016 lufevida. All rights reserved.
//

import UIKit
import LFVDKnob

class ViewController: UIViewController {
    
    @IBOutlet var knobOutlet: Knob!
    
    @IBAction func knobAction(sender: AnyObject) {
        let percentage = Int(knobOutlet.value / 2.7)
        print("\(percentage)%")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}