//
//  DetailViewController.swift
//  CodeKit
//
//  Created by 김유진 on 2023/07/19.
//

import UIKit

class DetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        title = "Hi"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
