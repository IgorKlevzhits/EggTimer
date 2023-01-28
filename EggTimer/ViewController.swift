import UIKit

class ViewController: UIViewController {
    
    let startLabel: UILabel = {
        let label = UILabel()
        label.text = "How do you like your eggs?"
        label.textColor = .gray
        label.textAlignment = .center
        label.font = UIFont(name: label.font.fontName, size: 30)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var buttonsSrackView = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        setupButtons()
        setViews()
        setConstraints()
    }
    
    private func setViews() {
        view.addSubview(startLabel)
        
        buttonsSrackView.axis = .horizontal
        buttonsSrackView.spacing = 10
        buttonsSrackView.backgroundColor = .red
        buttonsSrackView.distribution = .fillEqually
        view.addSubview(buttonsSrackView)
    }
    
    private func setupButtons() {
        let images = ["soft_egg", "medium_egg", "hard_egg"]
        //        let titles = ["Soft", "Medium", "Hard"]
        for index in 0..<3 {
            let button = UIButton()
            button.setBackgroundImage(UIImage(named: images[index]), for: .normal)
            button.tag = index
            button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            buttonsSrackView.addArrangedSubview(button)
        }
    }
    
    
    
    @objc private func buttonPressed() {
        print("tap")
    }
    
    
}

extension ViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            startLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            startLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            startLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            startLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            buttonsSrackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            buttonsSrackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            buttonsSrackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            buttonsSrackView.heightAnchor.constraint(equalTo: buttonsSrackView.widthAnchor, multiplier: 0.7)
        ])
        
        
    }
}
