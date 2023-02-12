import UIKit
import AVFoundation

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
    
    var buttonsSrackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let progressView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let eggReadinessProgressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressViewStyle = .bar
        progressView.progressTintColor = .yellow
        progressView.backgroundColor = . gray
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    let eggTimes = [0 : 300,
                    1 : 420,
                    2 : 720]
    
    var timer = Timer()
    
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        setupButtons()
        setViews()
        setConstraints()
    }
    
    private func setViews() {
        view.addSubview(startLabel)
        view.addSubview(buttonsSrackView)
        view.addSubview(progressView)
        view.addSubview(eggReadinessProgressView)
    }
    
    private func setupButtons() {
        let images = ["soft_egg", "medium_egg", "hard_egg"]
        for index in 0..<3 {
            let button = UIButton()
            button.setBackgroundImage(UIImage(named: images[index]), for: .normal)
            button.tag = index
            button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            buttonsSrackView.addArrangedSubview(button)
        }
    }
    
    @objc private func buttonPressed(_ sender: UIButton) {
        timer.invalidate()
        eggReadinessProgressView.progress = 0
        let timeEgg = 1 * eggTimes[sender.tag]!
        var passedTime = 1
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.eggReadinessProgressView.progress = Float(passedTime) / Float(timeEgg)
            passedTime += 1
            if timeEgg == passedTime - 1{
                self.timer.invalidate()
                self.playSound()
                self.startLabel.text = "Done!"
            }
        })
    }
    
    private func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    
}

extension ViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            startLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            startLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            startLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            startLabel.bottomAnchor.constraint(equalTo: buttonsSrackView.topAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            buttonsSrackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            buttonsSrackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            buttonsSrackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            buttonsSrackView.heightAnchor.constraint(equalTo: buttonsSrackView.widthAnchor, multiplier: 0.42508711)
        ])
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: buttonsSrackView.bottomAnchor, constant: 0),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            progressView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            eggReadinessProgressView.centerYAnchor.constraint(equalTo: progressView.centerYAnchor, constant: 0),
            eggReadinessProgressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            eggReadinessProgressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            eggReadinessProgressView.heightAnchor.constraint(equalToConstant: 3)
        ])
        
        
    }
}
