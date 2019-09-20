//
//  UIImageView+AlamofireImage.swift
//  CleanArhitecture
//
//  Created by MSI on 20/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {
    func af_setImage(
        withURL url: URL?,
        placeholderImage: UIImage? = nil,
        filter: ImageFilter? = nil,
        progress: ImageDownloader.ProgressHandler? = nil,
        progressQueue: DispatchQueue = DispatchQueue.main,
        imageTransition: ImageTransition = .noTransition,
        runImageTransitionIfCached: Bool = false,
        completion: ((DataResponse<UIImage>) -> Void)? = nil)
    {
        guard let url = url else { return }
        self.af_setImage(withURL: url,
                         placeholderImage: placeholderImage,
                         filter: filter,
                         progress: progress,
                         progressQueue: progressQueue,
                         imageTransition: imageTransition,
                         runImageTransitionIfCached: runImageTransitionIfCached,
                         completion: completion)
    }
}
