//
//  FeedViewController.swift
//  InstagramClone
//
//  Created by Артём Балашов on 04/01/2019.
//  Copyright © 2019 Артём Балашов. All rights reserved.
//

import Foundation
import CollectionKit
import Alamofire

class FeedViewController: UIViewController {
    
    //MARK: - ViewController-based statusBar appearance
    var statusBarIsHidden: Bool = false {
        didSet {
            self.animatableUpdateStatusBarAppearance()
        }
    }
    override var prefersStatusBarHidden: Bool {
        return statusBarIsHidden
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    //MARK: - properties
    let collectionView = CollectionView()
    let dataSource = ArrayDataSource<InstaMedia?>()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.fillSuperview()
        let tapHandler: ((BasicProvider<InstaMedia?, BannerCell>.TapContext)->(Void))? = {[weak self] context in
            guard let `self` = self, let media = context.data else {return}
            self.open(media, with: context.view)
        }
        let provider = BannersListProvider(dataSource, tapHandler: tapHandler, isBannersList: true)
        collectionView.provider = provider
        collectionView.delaysContentTouches = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        statusBarIsHidden = false
        fillData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        statusBarIsHidden = true
    }
    
    func fillData() {
        print("START REQUEST")
        Alamofire.request(URL(string: "https://api.instagram.com/v1/users/self/media/recent/")!, method: .get, parameters: ["access_token": APItoken ?? ""], encoding: URLEncoding.default, headers: nil).validate().responseJSON {[weak self] (response) in
            guard let `self` = self else {return}
            switch response.result {
            case .success(let data):
                if let json = data as? [String: Any], let arrayJson = json["data"] as? [[String: Any]]{
                    do {
                        self.dataSource.data = try arrayJson.map {try InstaMedia(object: $0)}
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func open(_ media: InstaMedia, with view: UIView) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "InsideViewController") as! InsideViewController
        vc.media = media
        vc.mediaDataSource.data = [media]
        let data = CardViewPresentationData(view: view, rect: view.frameToWindow(withoutTransform: false), radius: view.layer.cornerRadius)
        self.presentAsCard(vc, with: data, animated: true, completion: nil)
    }
}
