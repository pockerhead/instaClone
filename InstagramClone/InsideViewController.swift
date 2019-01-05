//
//  InsideViewController.swift
//  InstagramClone
//
//  Created by Артём Балашов on 04/01/2019.
//  Copyright © 2019 Артём Балашов. All rights reserved.
//

import UIKit
import CollectionKit

class InsideViewController: UIViewController, StatusBarHiddenViewController {
    //MARK: - ViewController-based statusBar appearance
    var statusBarIsHidden: Bool = false {
        didSet {
            self.animatableUpdateStatusBarAppearance()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return statusBarIsHidden
    }
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    //MARK: - IBOutlets
    @IBOutlet weak var dismissButton: UIButton!
    //MARK: - Properties
    let collectionView = CollectionView()
    var media: InstaMedia!
    var mediaDataSource = ArrayDataSource<InstaMedia?>()
    var destView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.insertSubview(collectionView, belowSubview: dismissButton)
        collectionView.fillSuperview()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        statusBarIsHidden = true
        let viewHandler: ((UIView) -> Void)? = {[weak self] view in
            self?.destView = view
        }
        collectionView.contentInsetAdjustmentBehavior = .never
        let fotoProvider = BannersListProvider(mediaDataSource, tapHandler: nil, viewHandler: viewHandler, isBannersList: false)
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "dd.MM.YYYY hh:mm"
        let date = formatter.string(from: Date.init(timeIntervalSince1970: media.caption?.createdTime ?? 0))
        let text = " ---- \n\(date)\n ---- \n\(media.caption?.text ?? "")"
        let textProvider = TextViewProvider(ArrayDataSource<String>(data: [text]))
        collectionView.provider = ComposedProvider(identifier: "f", layout: FlowLayout(), animator: nil, sections: [fotoProvider, textProvider])
    }

    @IBAction func didSelectDismissButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        statusBarIsHidden = false
    }
    
    override var cardDestinationView: UIView! {
        return destView ?? UIView()
    }
}
