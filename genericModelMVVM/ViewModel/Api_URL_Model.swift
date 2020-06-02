//
//  Api_URL_Model.swift
//  genericModelMVVM
//
//  Created by STUser on 27/06/19.
//  Copyright © 2019 abc. All rights reserved.
//

import UIKit

 var api_URL_Model : Api_URL_Model?

 struct Api_URL_Model: Codable {
    
    var personListUrl : String
    var baseUrl : String
    var login : String
}
