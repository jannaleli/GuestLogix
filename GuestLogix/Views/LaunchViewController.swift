//
//  ViewController.swift
//  GuestLogix
//
//  Created by Jann Aleli Zaplan on 11/5/19.
//  Copyright © 2019 Jann Aleli Zaplan. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ViewController: UIViewController {
    
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    
    var mapStore: MapStoreProtocol = MapStore()
    
    override func viewDidLoad() {
        
        activityIndicatorView.type = .ballClipRotateMultiple
        
        activityIndicatorView.color = .red
        
        activityIndicatorView.startAnimating()
        
        mapStore.loadData()
        
        mapStore.loadCityGraph()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            let balanceViewController = storyBoard.instantiateViewController(withIdentifier: "initial") as! InitialViewController
            
            self.present(balanceViewController, animated: true, completion: nil)
            
        })
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        activityIndicatorView.stopAnimating()
        
    }


}

