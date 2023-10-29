
import UIKit

final class ItemDetailsViewController: UIViewController {
    
    //MARK: - Properties
    private let selectedImageView: UIImageView = {
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
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [selectedImageView, nameLabel])
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
        
        view.addSubview(mainStackView)
        
        setupMainStackViewConstraints()
        setupSelectedImageView()
        setupNameLabelConstraints()
        configureViews()
    }
    
    //MARK: - Methods
    func configureViews() {
        guard let music else { return }
        selectedImageView.image = music.image
        nameLabel.text = "Name: \(music.name)"
    }
    
    //MARK: - Private Methods
    private func setupSelectedImageView() {
        NSLayoutConstraint.activate([
            selectedImageView.topAnchor.constraint(equalTo: mainStackView.topAnchor),
            selectedImageView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 20),
            selectedImageView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -20),
            selectedImageView.heightAnchor.constraint(equalTo: selectedImageView.widthAnchor)
        ])
    }
    
    private func setupNameLabelConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalToConstant: 100),
            nameLabel.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -20),
        ])
    }
    
    private func setupMainStackViewConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20)
        ])
    }
}
