//
//  ViewController.swift
//  TemperatureConversion
//
//  Created by 김유진 on 2023/07/19.
//

import UIKit

class ViewController: UIViewController {
    
    let inputTemp = UITextField()
    let resultLabel = UILabel()
    let signLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        buildInterface()
    }
    
    func buildInterface() {
        inputTemp.placeholder = "온도를 입력하세요"
        inputTemp.textAlignment = .center
        view.addSubview(inputTemp)
        inputTemp.translatesAutoresizingMaskIntoConstraints = false
        inputTemp.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputTemp.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50).isActive = true
        
        
        signLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signLabel)
        signLabel.leadingAnchor.constraint(equalTo: inputTemp.trailingAnchor).isActive = true
        signLabel.centerYAnchor.constraint(equalTo: inputTemp.centerYAnchor).isActive = true
        
        let cButton = UIButton()
        cButton.setTitle("섭씨", for: .normal)
        cButton.setTitleColor(.blue, for: .normal)
        cButton.addTarget(self, action: #selector(CtoF), for: .touchUpInside)
        view.addSubview(cButton)
        cButton.translatesAutoresizingMaskIntoConstraints = false
        cButton.centerXAnchor.constraint(equalTo: inputTemp.centerXAnchor, constant: -20).isActive = true
        cButton.centerYAnchor.constraint(equalTo: inputTemp.centerYAnchor, constant: 50).isActive = true
        
        let fButton = UIButton()
        fButton.setTitle("화씨", for: .normal)
        fButton.setTitleColor(.blue, for: .normal)
        fButton.addTarget(self, action: #selector(FtoC), for: .touchUpInside)
        view.addSubview(fButton)
        fButton.translatesAutoresizingMaskIntoConstraints = false
        fButton.centerXAnchor.constraint(equalTo: inputTemp.centerXAnchor, constant: 20).isActive = true
        fButton.centerYAnchor.constraint(equalTo: inputTemp.centerYAnchor, constant: 50).isActive = true
        
        resultLabel.text = "0"
        view.addSubview(resultLabel)
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.centerXAnchor.constraint(equalTo: inputTemp.centerXAnchor).isActive = true
        resultLabel.centerYAnchor.constraint(equalTo: inputTemp.centerYAnchor, constant: 100).isActive = true
        
    }
    
    @objc func FtoC() {
        // 화씨를 섭씨로 변환해주는 함수
        guard let tempString = inputTemp.text else {
            return
        }
        
        guard var temp = Double(tempString) else {
            return
        }
        
        temp = (temp - 32) / 1.8
        
        signLabel.text = "℉"
        resultLabel.text = "\(temp)°C"
        
    }
    
    @objc func CtoF() {
        // 화씨를 섭씨로 변환해주는 함수
        guard let tempString = inputTemp.text else {
            return
        }
        
        guard var temp = Double(tempString) else {
            return
        }
        
        temp = (temp * 1.8) + 32
        
        signLabel.text = "°C"
        resultLabel.text = "\(temp)℉"
        
    }
}

