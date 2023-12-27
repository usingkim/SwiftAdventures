//
//  plusTwoViewController.swift
//  CodeKitTabBar
//
//  Created by 김유진 on 2023/07/19.
//

import UIKit

class plusTwoViewController: UIViewController {

    let countLabel: UILabel = UILabel()
    
    var count: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        buildInterface()
    }

    func buildInterface() {
        countLabel.text = "0"
        countLabel.font = UIFont(name: "Helvetica", size: 50)
        countLabel.textColor = .black
        
        /*
        우리는 이제 이런 절대 좌표를 사용하는 코드를 쓰지 않겠다!
        countLabel.frame.origin = CGPoint(x: 150, y: 250)
        countLabel.frame.size = CGSize(width: 100, height: 100)
        */
        
        view.addSubview(countLabel)
        // addSubview 이후에 AutoLayout 관련 코드를 적어야한다
        // 이유는 viewController의 view와 해당 subview의 기본 관계가 성립되어야 레이아웃의 상대성이 생기기 때문이다
        
        // 처음 할 일은 자동으로 위치를 알아서 잡겠다는 의사를 포기해야한다
        // 그러니까 이제 우리가 새로 잡는 제약조건 안에서 autolayout이 적용된다는 선언이 된다
        // "자동으로 제약을 변환하는 기능을 꺼버리자"
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 직접 제약조건을 만들어보자 - countLabel을 화면 한가운데로 만들어보자
        NSLayoutConstraint.activate([
            // countLabel의 중심 X축을 viewController의 view가 가지는 중심 X축과 동일하게 만든다
            countLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // countLabel의 중심 Y축을 viewController의 view가 가지는 중심 Y축과 동일하게 만든다
            countLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        // 버튼도 만들어보자
        let plusTwoButton: UIButton = UIButton()
        plusTwoButton.setTitle("Plus Two", for: .normal)
        plusTwoButton.setTitleColor(.blue, for: .normal)
        // 같은 viewController의 plusTwo 함수를 실행시킬거라 self라고 적는다
        // Objective-C 시절의 UIKit 코드를 내부에서 쓰기 때문에 plusTwo를 지칭하는 방법이 필요하다
        plusTwoButton.addTarget(self, action: #selector(plusTwo), for: .touchUpInside)
        
        view.addSubview(plusTwoButton)
        
        plusTwoButton.translatesAutoresizingMaskIntoConstraints = false
        
        /*
        // 이 방법도 있고
        NSLayoutConstraint.activate([
            // plusTwoButton의 중심 X축을 viewController의 view가 가지는 중심 X축과 동일하게 만든다
            plusTwoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // plusTwoButton 가장 윗 부분을 countLabel의 가장 아랫부분보다 50만큼 떨어진 위치로 만든다
            plusTwoButton.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 50),
        ])
         */
        
        // 이 방법으로 개별 제약조건들의 isActive를 true로 만든는 방법도 있다
        plusTwoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        plusTwoButton.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 50).isActive = true
        
    }
    
    // Interface Builder와 연결되는 함수가 아니때문에 @IBAction이라고 안붙여줘도 된다
    // Objective-C 시절의 UIKit 코드를 내부에서 쓰기 때문에 @objc라고 붙여야한다
    @objc func plusTwo() {
        print("+2 버튼이 눌렸습니다")
        
        count += 2
        
        countLabel.text = "\(count)"
    }

}
