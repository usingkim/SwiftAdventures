//
//  ViewController.swift
//  UpDownGame2
//
//  Created by 김유진 on 2022/10/30.
//

import UIKit

class ViewController: UIViewController {
    
    // StoryBoard의 요소와 연결할때 사용하는 것
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var nowLabel: UILabel!
    @IBOutlet weak var tryCountLabel: UILabel!
    
    // 변수 생성
    var randomValue: Int = 0
    var tryCount: Int = 0
    let hitValue: Int = 0 // 상수

    override func viewDidLoad() {
        super.viewDidLoad()
        reset()
        // Do any additional setup after loading the view.
    }

    @IBAction func sliderValueChanged(_ sender: UISlider){
        nowLabel.text = String(Int(sender.value))
    }
    
    func showAlert(message: String){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",
                                     style:.default) { (action) in
            self.reset()
            
        }
                                     
        
        alert.addAction(okAction)
        present(alert,
        animated: true,
        completion: nil)
    }
    
    @IBAction func touchUpHitButton(_ sender: UIButton){
        // button을 눌렀을 때 현재 값을 확인해보고싶다.
        // Slider의 값을 활용하기 위함.
        let hitValue: Int = Int(slider.value)
        slider.value = Float(hitValue)
        
        tryCount = tryCount + 1
        tryCountLabel.text = "\(tryCount)/5"
        
        if randomValue == hitValue {
            showAlert(message: "YOU HIT!!!")
            reset()
            return
        }
        
        if tryCount >= 5{
            showAlert(message: "You lose...")
            reset()
            return
        }
        
        if randomValue > hitValue{
            slider.minimumValue = Float(hitValue)
            minLabel.text = String(hitValue)
        } else if randomValue < hitValue{
            slider.maximumValue = Float(hitValue)
            maxLabel.text = String(hitValue)
        }
    }
    
    @IBAction func touchUpResetButton(_ sender: UIButton){
        reset()
    }
    
    func reset(){
        print("reset!")
        // 범위 연산자
        // 폐쇄 : 앞 뒤 수 포함 a..b
        // half : a..<b 뒷 수 미포함
        // 앞 수 미포함 : a<..b
        randomValue = Int.random(in: 0...30)
        
        print(randomValue)
        slider.value = 15
        tryCount = 0
        tryCountLabel.text = "0/5"
        slider.minimumValue = 0
        slider.maximumValue = 30
        minLabel.text = "0"
        maxLabel.text = "30"
        nowLabel.text = "15"
    }
}

