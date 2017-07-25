//
//  TestHelpers.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import Foundation

var testURL: URL {
    return URL(string: "https://www.lloydsbank.com/")!
}

var simpleData: Data {
    return Data(base64Encoded: "SGlyZSBtZSA6KQ==")!
}

var jsonData: Data {
    return Data(base64Encoded: "ew0KICAgImZpcnN0IjogIk1hdHRpYSIsDQogICAic2Vjb25kIjogIkNhbXBvbGVzZSINCn0=")!
}
