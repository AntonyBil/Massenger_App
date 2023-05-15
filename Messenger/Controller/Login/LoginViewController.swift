//
//  LoginViewController.swift
//  Messenger
//
//  Created by apple on 15.05.2023.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    var collectionView: UICollectionView!
 
    var slides: [SlideModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configCollectionView()
        pageControl.numberOfPages = slides.count
        
        let slide1 = SlideModel(id: 1, text: "Text 1", image: UIImage(imageLiteralResourceName: "slide_1"))
        let slide2 = SlideModel(id: 2, text: "Text 2", image: UIImage(imageLiteralResourceName: "slide_2"))
        let slide3 = SlideModel(id: 3, text: "Text 3", image: UIImage(imageLiteralResourceName: "slide_3"))
        
        slides.append(slide1)
        slides.append(slide2)
        slides.append(slide3)
    }
    
    //Create CollectionView programmatically
    func configCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .lightGray
        collectionView.isPagingEnabled = true
        
        self.view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: SlideCollectionViewCell.identifire, bundle: nil), forCellWithReuseIdentifier: SlideCollectionViewCell.identifire)
        
        
    }

}


extension LoginViewController: UICollectionViewDelegate,
                               UICollectionViewDataSource,
                               UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SlideCollectionViewCell.identifire, for: indexPath) as! SlideCollectionViewCell
        cell.configure(slide: slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.view.frame.size
    }
    
    
    
    
}
