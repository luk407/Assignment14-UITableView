
import UIKit

final class MainVC: UIViewController {
    
    // MARK: - Properties
    private let mainSV: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .white
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 20
        return stackView
    }()
    
    private let musicTV: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "plusIcon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var musics = Music.dummyData
    
    private let searchBar: UISearchBar = UISearchBar()
    
    private var filteredMusic: [Music]!

    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        filteredMusic = musics
        
        let editItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        let searchItem = UIBarButtonItem(customView: searchBar)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.leftBarButtonItems = [editItem, searchItem]
        searchBar.delegate = self
        
        searchBar.widthAnchor.constraint(equalToConstant: 250).isActive = true
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search..."
        searchBar.isTranslucent = false
        
        view.addSubview(mainSV)
        setupMainSV()
    }

    //MARK: - Private Methods
    private func setupMainSV() {
        NSLayoutConstraint.activate([
            mainSV.topAnchor.constraint(equalTo: view.topAnchor, constant: 64),
            mainSV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainSV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainSV.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
        ])
        
        mainSV.addArrangedSubview(musicTV)
        setupMusicTV()
        registerMusicTVCells()
    }
    
    @objc private func addTapped() {
        navigateToAddPage()
    }
    
    @objc private func editTapped() {
        if musicTV.isEditing {
            musicTV.isEditing = false
        } else {
            musicTV.isEditing = true
        }
    }

    private func setupMusicTV() {
        NSLayoutConstraint.activate([
            musicTV.heightAnchor.constraint(equalToConstant: 500),
            musicTV.bottomAnchor.constraint(equalTo: mainSV.bottomAnchor),
            musicTV.leadingAnchor.constraint(equalTo: mainSV.leadingAnchor),
            musicTV.trailingAnchor.constraint(equalTo: mainSV.trailingAnchor),
        ])
        
        musicTV.dataSource = self
        musicTV.delegate = self
    }
    
    private func navigateToAddPage() {
        let addPage = AddNewItemToListViewController()
        self.navigationController?.pushViewController(addPage, animated: true)
        
        addPage.addSongAction = {
            self.filteredMusic.append(Music(image: addPage.selectedImageView.image ?? UIImage(named: "x.square")!, name: addPage.nameTF.text ?? ""))
            self.musics.append(Music(image: addPage.selectedImageView.image ?? UIImage(named: "x.square")!, name: addPage.nameTF.text ?? ""))
            self.musicTV.reloadData()
        }
    }
    
    private func registerMusicTVCells() {
        musicTV.register(MusicTVCell.self, forCellReuseIdentifier: "musicCell")
    }
    
}

// MARK: - TableView DataSource
extension MainVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredMusic.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        let music = filteredMusic[indexPath.row]
        cell = tableView.dequeueReusableCell(withIdentifier: "musicCell", for: indexPath)
        if let musicCell = cell as? MusicTVCell {
            musicCell.configureViews(with: music)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Music"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let musicToDelete = filteredMusic[indexPath.row]
            if let index = filteredMusic.firstIndex(where: {$0 === musicToDelete}) {
                filteredMusic.remove(at: index)
            }
            if let index = musics.firstIndex(where: {$0 === musicToDelete}) {
                musics.remove(at: index)
            }
            musicTV.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if sourceIndexPath.row > destinationIndexPath.row {
            filteredMusic.insert(filteredMusic[sourceIndexPath.row], at: destinationIndexPath.row)
            filteredMusic.remove(at: sourceIndexPath.row + 1)
        } else {
            filteredMusic.insert(filteredMusic[sourceIndexPath.row], at: destinationIndexPath.row + 1)
            filteredMusic.remove(at: sourceIndexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
}

// MARK: - TableView Delegate
extension MainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsViewController = ItemDetailsViewController()
        detailsViewController.music = filteredMusic[indexPath.row]
        self.present(detailsViewController, animated: true)
    }
}

//MARK: - SearchBar Delegate
extension MainVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredMusic = searchText.isEmpty ? musics : musics.filter { (item: Music) -> Bool in
            return item.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        musicTV.reloadData()
    }
}
