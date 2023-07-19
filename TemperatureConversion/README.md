![image](https://github.com/usingkim/APPSCHOOL/assets/55521930/157dd190-5a15-4f99-b2dc-9be28cbbbc33)
# 섭씨를 화씨로, 화씨를 섭씨로

Storyboard의 코드를 이용하기

대표적인 코드
      ₩₩₩swift
        let fButton = UIButton()
        fButton.setTitle("화씨", for: .normal)
        fButton.setTitleColor(.blue, for: .normal)
        fButton.addTarget(self, action: #selector(FtoC), for: .touchUpInside)
        view.addSubview(fButton)
        fButton.translatesAutoresizingMaskIntoConstraints = false
        fButton.centerXAnchor.constraint(equalTo: inputTemp.centerXAnchor, constant: 20).isActive = true
        fButton.centerYAnchor.constraint(equalTo: inputTemp.centerYAnchor, constant: 50).isActive = true
      ```
