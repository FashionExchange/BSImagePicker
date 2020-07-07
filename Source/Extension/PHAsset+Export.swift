//
//  PHAsset+Export.swift
//  BSImagePicker
//
//  Created by Eugen Spinu on 17/09/2018.
//

import UIKit
import Photos

enum PHAssetError: Error {
    case unknown
}

extension PHAsset {
    public func getImage(targetSize: CGSize = CGSize.zero,
                               isSynchronousRequest: Bool = true,
                               completion:@escaping (_ result: Result<UIImage, Error>) -> Void) -> Void {
        let requestOptions = PHImageRequestOptions()
        requestOptions.resizeMode = PHImageRequestOptionsResizeMode.exact
        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
        requestOptions.isNetworkAccessAllowed = true
        requestOptions.isSynchronous = isSynchronousRequest
        
        var unwrappedSize = targetSize
        if unwrappedSize == CGSize.zero {
            unwrappedSize = CGSize(width: self.pixelWidth, height: self.pixelHeight)
        }
        PHImageManager.default().requestImage(for: self, targetSize: unwrappedSize, contentMode: PHImageContentMode.default, options: requestOptions, resultHandler: { (image, info) in
            guard let unwrappedImage = image else {
                let error = info?[PHImageErrorKey] as? Error ?? PHAssetError.unknown
                completion(.failure(error))
                return
            }
            completion(.success(unwrappedImage))
        })
    }
}
