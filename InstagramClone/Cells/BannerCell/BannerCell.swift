//
//  BannerCell.swift
//  AppStore Card Transition
//
//  Created by Артём Балашов on 04/01/2019.
//  Copyright © 2019 Артём Балашов. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class BannerCell: UIView {
    
    //MARK: - IBOutlets
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    //MARK: - Properties
    var needTransformOnTouch: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fromNib()
    }
    
    func configure(with image: UIImage, needTransformOnTouch: Bool = true) {
        self.image.image = image
        self.needTransformOnTouch = needTransformOnTouch
        if needTransformOnTouch {
            self.subviews.first?.clipsToBounds = true
            self.subviews.first?.layer.cornerRadius = 16
        }
    }
    
    func configure(with item: InstaMedia?, needTransformOnTouch: Bool = true) {
        guard let url = URL(string: item?.images?.lowRes?.url ?? ""), let placeholderURL = URL(string: item?.images?.standardRes?.url ?? "") else {return}
        SDWebImageManager.shared().loadImage(with: placeholderURL, options: [], progress: nil) {[weak self] (image, _, _, _, _, _) in
            guard let `self` = self else {return}
            self.image.image = image
        }
        self.image.sd_setImage(with: url, completed: nil)
        self.needTransformOnTouch = needTransformOnTouch
        if needTransformOnTouch {
            self.subviews.first?.clipsToBounds = true
            self.subviews.first?.layer.cornerRadius = 16
        }
        commentsLabel.text = "\(item?.comentsCount ?? 0)"
        likesLabel.text = "\(item?.likesCount ?? 0)"
    }
}

extension BannerCell {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard needTransformOnTouch else {
            return
        }
        UIView.animate(withDuration: 0.3) {
            self.transform = .init(scaleX: 0.95, y: 0.95)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard needTransformOnTouch else {
            return
        }
        UIView.animate(withDuration: 0.3) {
            self.transform = .identity
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        guard needTransformOnTouch else {
            return
        }
        UIView.animate(withDuration: 0.3) {
            self.transform = .identity
        }
    }
}
