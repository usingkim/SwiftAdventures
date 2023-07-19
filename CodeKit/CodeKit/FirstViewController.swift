//
//  ViewController.swift
//  CodeKit
//
//  Created by 김유진 on 2023/07/19.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground // dark or light mode에 따라서
        buildInterface()
    }
    
    func buildInterface() {
        
        let safeArea = view.safeAreaLayoutGuide
        
        let scrollView: UIScrollView = UIScrollView()
        scrollView.backgroundColor = .systemMint
        view.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height * 2)
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        scrollView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: view.bounds.height).isActive = true
        
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 40
        scrollView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        
        for _ in 0...20 {
            let label: UILabel = UILabel()
            label.text = "Hello World!"
            stackView.addArrangedSubview(label)
            
            let nextButton: UIButton = UIButton()
            nextButton.setTitle("다음 화면으로", for: .normal)
            nextButton.backgroundColor = .green
            nextButton.addTarget(self, action: #selector(goNext), for: .touchUpInside)
            stackView.addArrangedSubview(nextButton)
            
        }
    }
    
    @objc func goNext() {
        let detailViewContoller = DetailViewController()
        navigationController?.pushViewController(detailViewContoller, animated: true)
    }


}

