
import UIKit

class MusicTVCell: UITableViewCell {
    
    //MARK: - Properties
    private let mainSV: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 8, left: 24, bottom: 8, right: 24)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let imageIV: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    //MARK: = Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupView()
        addSubViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Prepare For Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageIV.image = nil
        nameLabel.text = nil
    }
    
    //MARK: - Configure
    func configureViews(with model: Music) {
        imageIV.image = model.image
        nameLabel.text = "Name: \(model.name)"
        
        imageIV.layer.masksToBounds = true
        imageIV.layer.cornerRadius = 16
    }
    
    //MARK: - Private Methods
    private func setupView() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    private func addSubViews() {
        addSubview(mainSV)
        mainSV.addArrangedSubview(imageIV)
        mainSV.addArrangedSubview(nameLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainSV.topAnchor.constraint(equalTo: self.topAnchor),
            mainSV.leftAnchor.constraint(equalTo: self.leftAnchor),
            mainSV.rightAnchor.constraint(equalTo: self.rightAnchor),
            mainSV.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }

}
