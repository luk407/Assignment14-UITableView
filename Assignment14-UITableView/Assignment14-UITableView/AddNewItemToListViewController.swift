
import UIKit

final class AddNewItemToListViewController: UIViewController {
    
    //MARK: - Properties
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    let selectedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 2
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name:"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 2
        return textField
    }()
    
    private let addImageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2
        button.setTitle("Add New Image", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let addSongButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2
        button.setTitle("Add song", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    //MARK: - Button Action
    var addSongAction: (()->Void)?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(selectedImageView)
        view.addSubview(mainStackView)
        setupMainStackView()
    }
    
    //MARK: - Private Methods
    private func setupMainStackView() {
        NSLayoutConstraint.activate([
            mainStackView.heightAnchor.constraint(equalToConstant: 200),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        mainStackView.addArrangedSubview(nameLabel)
        mainStackView.addArrangedSubview(nameTextField)
        mainStackView.addArrangedSubview(addImageButton)
        mainStackView.addArrangedSubview(addSongButton)
        setupSelectedImageView()
        setupNameLabel()
        setupNameTextField()
        setupAddImageButton()
        setupAddSongButton()
        addSongButtonAction()
    }
    
    private func setupSelectedImageView() {
        NSLayoutConstraint.activate([
            selectedImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            selectedImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            selectedImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            selectedImageView.heightAnchor.constraint(equalTo: selectedImageView.widthAnchor),
        ])
    }
    
    private func setupNameLabel() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func setupNameTextField() {
        NSLayoutConstraint.activate([
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            nameTextField.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
        ])
        
        nameTextField.leftView = paddingView
        nameTextField.leftViewMode = .always
    }
    
    private func setupAddImageButton() {
        NSLayoutConstraint.activate([
            addImageButton.heightAnchor.constraint(equalToConstant: 100),
            addImageButton.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            addImageButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
        ])
    }
    
    private func setupAddSongButton() {
        NSLayoutConstraint.activate([
            addSongButton.heightAnchor.constraint(equalToConstant: 50),
            addSongButton.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            addSongButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            addSongButton.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor)
        ])
        
    }
    
    private func addSongButtonAction() {
        addSongButton.addAction(UIAction(handler: { [weak self] action in
            self?.addSongAction?()
            self?.selectedImageView.image = nil
            self?.nameTextField.text = ""
        }), for: .touchUpInside)
    }
    
    @objc private func addButtonTapped() {
        showImagePickerController()
    }
}

//MARK: - ImagePickerController Delegate
extension AddNewItemToListViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func showImagePickerController() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImageView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
}

