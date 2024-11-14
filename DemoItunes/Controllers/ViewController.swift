import UIKit
import SwiftyJSON
import Kingfisher


class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Variables
    var itunes: [ItuneResult] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 138)
        collectionView.collectionViewLayout = layout
        
        collectionView.register(MyCollectionViewCell.nib(), forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        searchBar.delegate = self
        searchBar.placeholder = "Search.."
        
        title = "Itune"
    }
}

// MARK: - Cấu hình cho CollectionView
extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let detailVC = storyboard.instantiateViewController(identifier: DetailViewController.identifier) as? DetailViewController {
            
            DispatchQueue.main.async {
                if let imageView = detailVC.imageView {
                    if let urlImage = self.itunes[indexPath.row].artworkUrl100, let imageURL = URL(string: urlImage) {
                        imageView.kf.setImage(with: imageURL)
                    } else {
                        imageView.image = UIImage(systemName: "photo")
                    }
                }
                detailVC.artistLabel?.text = "Artist: \(String(describing: self.itunes[indexPath.row].artistName!))"
                detailVC.trackLabel?.text = "Track: \(String(describing: self.itunes[indexPath.row].trackName!))"
                detailVC.priceLabel?.text = "Price: \(String(describing: self.itunes[indexPath.row].trackPrice!))"
                detailVC.countryLabel?.text = "Country: \(String(describing: self.itunes[indexPath.row].country!))"
                detailVC.primaryLabel?.text = "Primary: \(String(describing: self.itunes[indexPath.row].primaryGenreName!))"
                
                detailVC.urlVideo = self.itunes[indexPath.row].previewURL
            }
            
            navigationController?.pushViewController(detailVC, animated: true   )
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itunes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath) as! MyCollectionViewCell
        
        if let artworkUrl = itunes[indexPath.row].artworkUrl100 {
            let url = URL(string: artworkUrl)!
            cell.configure(with: url, itunes[indexPath.row].trackName ?? "Null")
        }
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 138)
    }
    
    // MARK: - Khoảng cách CollectionView với các cạnh bên trong chứa item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)
    }
    
    // MARK: - Khoảng cách các row với nhau
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(20)
    }
    
    // MARK: - Khoảng cách các item liền kề (col) với nhau: Luôn có một khoảng cách mặc định, k trả về 0 đc
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(0)
    }
}

// MARK: - Cấu hình Search bar
extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        /// Gọi đến 'getItunes'
        ManagerAPI.shared.getItunes(searchText) { [weak self] result in
            switch result {
            case .success(let itunesResults):
                self?.itunes = itunesResults ?? []
                self?.collectionView.reloadData()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
