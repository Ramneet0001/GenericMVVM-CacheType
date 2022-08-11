//
//  genericModelMVVM
//
//  Created by Ramneet on 02/06/20.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit

class LoaderClass {

    func startLoader(message: String, controller:UIViewController){
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        controller.present(alert, animated: true, completion: nil)
    }
    


     func stopLoader(controller:UIViewController){
         controller.dismiss(animated: false, completion: nil)
    }
}
