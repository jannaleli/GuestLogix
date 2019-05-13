//
//  InitialViewController.swift
//  GuestLogix
//
//  Created by Jann Aleli Zaplan on 11/5/19.
//  Copyright © 2019 Jann Aleli Zaplan. All rights reserved.
//

import Foundation
import MapKit
import UIKit
import SearchTextField
import CoreData
import SkyFloatingLabelTextField
import TransitionButton

class InitialViewController: UIViewController{
    
    var initialProtocol: InitialProtocol = InitialViewModel()
    @IBOutlet weak var segue: UIStoryboardSegue!
    private var sorurce: [Airports] = []
    private var destination: [Airports] = []
    @IBOutlet weak var sourceLocation: SearchTextField!
    @IBOutlet weak var destinationLocation: SearchTextField!
    @IBOutlet weak var button: TransitionButton!
    @IBOutlet weak var mapView: MKMapView!
    var lastClickedField: SearchTextField?
    
    

    
    func prepareButton() {
        button.backgroundColor = UIColor(red:0.54, green:0.71, blue:0.81, alpha:1.0)
        button.setTitle("Search", for: .normal)
        button.cornerRadius = 20
        button.spinnerColor = .white
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
    }
    @IBAction func buttonAction(_ button: TransitionButton) {
        button.startAnimation() // 2: Then start the animation when the user tap the button
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            
            sleep(3) // 3: Do your networking task or background work here.
            
            DispatchQueue.main.async(execute: { () -> Void in
                // 4: Stop the animation, here you have three options for the `animationStyle` property:
                // .expand: useful when the task has been compeletd successfully and you want to expand the button and transit to another view controller in the completion callback
                // .shake: when you want to reflect to the user that the task did not complete successfly
                // .normal
                button.stopAnimation(animationStyle: .expand, completion: {
                    let secondVC = UIViewController()
                    self.present(secondVC, animated: true, completion: nil)
                })
            })
        })
    }

    
    func prepareTextField(textField: SearchTextField) {
        let allAirpirt = airportRecords.compactMap {
                 $0.name
        }
        
        textField.filterStrings(allAirpirt as! [String])
   
        
        // Set a visual theme (SearchTextFieldTheme). By default it's the light theme
        textField.theme = SearchTextFieldTheme.lightTheme()
        // Modify current theme properties
        textField.theme.font = UIFont.systemFont(ofSize: 14)
        textField.theme.bgColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
        textField.theme.borderColor = UIColor(red:0.00, green:0.00, blue:0.00, alpha:1.0)
        textField.theme.separatorColor = UIColor(red:0.00, green:0.00, blue:0.00, alpha:1.0)
        textField.theme.cellHeight = 50
        
       
        
    }
    
 

    
    override func viewDidLoad() {

        self.lastClickedField = self.sourceLocation
        prepareTextField(textField: sourceLocation)
        prepareTextField(textField: destinationLocation)
        self.prepareButton()
    }
    

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is MapViewController
        {
            let vc = segue.destination as? MapViewController
            let okay =  initialProtocol.determineEligibleAirports(sourceText: sourceLocation.text ?? "", destinationText: destinationLocation.text ?? "")
            if okay.0 {
                vc?.destination = okay.2.first
                vc?.source = okay.1.first
            }else{
                NotificationController().fireErrorNotification(message: "No Source or Destination Exists" )
                vc?.destination = nil
                vc?.source = nil
            }
       
        }
    }
}
