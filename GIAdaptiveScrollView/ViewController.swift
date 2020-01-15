//
//  ViewController.swift
//  Scrolling1
//
//  Created by daleijn on 12/01/2020.
//  Copyright © 2020 daleijn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var scrollView: GIAdaptiveScrollView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.scrollView.contentInset = .init(top: 40, left: 50, bottom: 50, right: 50)
    }

}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
}

