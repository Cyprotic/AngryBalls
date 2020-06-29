//
//  EndViewController.swift
//  wok2
//
//  Created by jf19abc on 18/01/2020.
//  Copyright © 2020 jf19abc. All rights reserved.
//

import UIKit

class EndViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //restart
    @IBAction func restartGame(_ sender: Any) {
        //we gain the view and dismiss it to give us the option to animate it
        self.dismiss(animated: false, completion: nil)
       //theoretically should dismiss all views and present the Home View
        
        self.presentingViewController?.dismiss(animated: false, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
