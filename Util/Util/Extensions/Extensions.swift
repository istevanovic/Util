//
//  Extensions.swift
//  Util
//
//  Created by Ilija Stevanovic on 6/6/19.
//  Copyright © 2019 util. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

extension UIViewController {

    /// Displays a system error popup with a custom title and a custom message
    func displayErrorPopup(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    /// Displays a system loading popup with a custom message
    func showLoadingAlert(title: String) {
        let alert = UIAlertController(title: nil, message: title, preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
}

extension Date {

    /// "dd.MM.yyyy" -> "yyyy-MM-dd"
    func formatTheDate(date: String) -> String {
        let chunks = date.components(separatedBy: ".")
        let dateFormatted = "\(chunks[2])-\(chunks[1])-\(chunks[0])"
        return dateFormatted
    }

    /// same as above, but with timestamp included
    func formatTimeAndDate(dateString: String) -> String {
        let components = dateString.components(separatedBy: " ")
        let dateComponents = components[0].components(separatedBy: "-")
        return "\(dateComponents[2]).\(dateComponents[1]).\(dateComponents[0])\n\(components[1])"
    }

}

extension UIImage {

    /// Resize the image
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height

        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }

        let rect = CGRect(x:0, y:0, width: newSize.width, height: newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}


/// mysc methods

/// Retrieves a coordinate from a user friendly adress
func getCoordinate( addressString : String,
                    completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
    let geocoder = CLGeocoder()
    geocoder.geocodeAddressString(addressString) { (placemarks, error) in
        if error == nil {
            if let placemark = placemarks?[0] {
                let location = placemark.location!

                completionHandler(location.coordinate, nil)
                return
            }
        }

        completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
    }
}


