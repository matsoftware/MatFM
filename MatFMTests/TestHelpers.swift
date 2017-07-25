//
//  TestHelpers.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import UIKit

var testURL: URL {
    return URL(string: "https://www.lloydsbank.com/")!
}

var simpleData: Data {
    return Data(base64Encoded: "SGlyZSBtZSA6KQ==")!
}

var jsonData: Data {
    return Data(base64Encoded: "ew0KICAgImZpcnN0IjogIk1hdHRpYSIsDQogICAic2Vjb25kIjogIkNhbXBvbGVzZSINCn0=")!
}

var imageData: Data {
    let size = CGSize(width: 30, height: 30)
    let color = UIColor.green
    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
    color.setFill()
    UIRectFill(rect)
    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return UIImagePNGRepresentation(image)!
}
