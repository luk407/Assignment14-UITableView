
import UIKit

final class ItemDetailsViewController: UIViewController {
    
    //MARK: - Properties
    private let imageIV: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var mainSV: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageIV, nameLabel])
        stackView.backgroundColor = .white
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var music: Music?
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(mainSV)
        
        setupMainSVConstraints()
        setupImageIV()
        setupNameLabelConstraints()
        configureViews()
    }
    
    //MARK: - Methods
    func configureViews() {
        guard let music else { return }
        imageIV.image = music.image
        nameLabel.text = "Name: \(music.name)"
    }
    
    //MARK: - Private Methods
    private func setupImageIV() {
        NSLayoutConstraint.activate([
            imageIV.topAnchor.constraint(equalTo: mainSV.topAnchor),
            imageIV.leadingAnchor.constraint(equalTo: mainSV.leadingAnchor, constant: 20),
            imageIV.trailingAnchor.constraint(equalTo: mainSV.trailingAnchor, constant: -20),
            imageIV.heightAnchor.constraint(equalTo: imageIV.widthAnchor)
        ])
    }
    
    private func setupNameLabelConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalToConstant: 100),
            nameLabel.bottomAnchor.constraint(equalTo: mainSV.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: mainSV.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: mainSV.trailingAnchor, constant: -20),
        ])
    }
    
    private func setupMainSVConstraints() {
        NSLayoutConstraint.activate([
            mainSV.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            mainSV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainSV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainSV.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20)
        ])
    }
}
