//
//  MapViewController.swift
//  GuestLogix
//
//  Created by Jann Aleli Zaplan on 11/5/19.
//  Copyright © 2019 Jann Aleli Zaplan. All rights reserved.
//

import Foundation
import MapKit
import UIKit
import SwiftGraph
import SwiftMessages
import CoreData
import Material
import PMSuperButton
import TransitionButton
let locationManager = CLLocationManager()

class MapViewController: UIViewController,MKMapViewDelegate {
    
    @IBOutlet weak var backButton: PMSuperButton!
    @IBOutlet weak var mapView: MKMapView!
     @IBOutlet weak var iconButton: TransitionButton!
    var mapProtocol: MapProtocol = MapViewModel()
    var flightpathPolyline: MKGeodesicPolyline!
    var planeAnnotation: MKPointAnnotation!
    var planeAnnotationPosition = 0
    var planeDirection: CLLocationDirection = 0.0
    var source: Airports? = nil
    var destination: Airports? = nil
    
    //make this a protocol later pls
    
    enum State {
        case loading(Bool)
        case loaded([Airports])
        case empty
    }
    
    fileprivate var state: State = .loading(false){
        didSet {
            switch state {
            case .empty: break
            default: break
            }
        }
    }
    



    
    
    
    private func loadMap() {
        switch state {
        case .loaded(let finalDestination):
            loadinMap(finalDestination: finalDestination)
        case .empty:
            loadEmpty()
            break
        case .loading(_):
            break
        }
    }
    
    private func loadEmpty() {
        let message = "No Route Exists between \(source!.name) and \(destination!.name)."
         NotificationController().fireErrorNotification(message: message )
        
        
    }
    
    
    private func loadinMap(finalDestination: [Airports]) {
        let location = CLLocationCoordinate2D(
            latitude: (finalDestination.first?.latitute)!,
            longitude: (finalDestination.first?.longitude)!
        )
        
        let span = MKCoordinateSpan(latitudeDelta: 120, longitudeDelta: 120)
        let region = MKCoordinateRegion(center: location, span: span)
        
        self.mapView.setRegion(region, animated: true)
        self.mapView .regionThatFits(region)
        var coordinates: [CLLocationCoordinate2D] = []
      
        for each in finalDestination {
            let location = CLLocation(latitude: each.latitute!, longitude:each.longitude!)
  
            coordinates.append(location.coordinate)
        }
        
        flightpathPolyline = MKGeodesicPolyline(coordinates: &coordinates, count: coordinates.count)
        
        self.mapView.addOverlay(flightpathPolyline)
        
        let annotation = MKPointAnnotation()
        annotation.title = NSLocalizedString("Plane", comment: "Plane marker")
        self.mapView.addAnnotation(annotation)
        
        self.planeAnnotation = annotation
        self.updatePlanePosition()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Work with MKMapview

   

        // Since we don't specify the visit order of the neighbours of a vertex, we can't assure
        // all paths have lenght 2. By now, we are happy only asserting that at least one of the paths
        // is lenght 2. This indicates that we are not prematurely marking as visited the neighbours
        // of the current vertex.
        
        prepareButton()
       
        if source == nil || destination == nil {
       
            return
        }
        // 1.
        self.mapView.delegate = self

        let result = mapProtocol.determineStopovers(origin: source!, dest:  destination!)
        if result.0 == true {
            
            
            
            state = .loaded(result.1)
            loadMap()
            return
        }
        
        state = .empty
        loadMap()
        return
       
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyline = overlay as? MKPolyline else {
            return MKOverlayRenderer()
        }
        
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.lineWidth = 3.0
        renderer.alpha = 0.5
        renderer.strokeColor = UIColor.blue
        
        return renderer
    }
    
    func updatePlanePosition() {
        
        let step = 5
        guard planeAnnotationPosition + step < flightpathPolyline.pointCount
            else { return }
        
        let points = flightpathPolyline.points()
        self.planeAnnotationPosition += step
        let nextMapPoint = points[planeAnnotationPosition]
        
        self.planeAnnotation.coordinate = nextMapPoint.coordinate
        
        let previousMapPoint = points[planeAnnotationPosition]
        planeAnnotationPosition += step
        
        self.planeDirection = directionBetweenPoints(sourcePoint: previousMapPoint, nextMapPoint)
 
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.33) {
            // your function here
            self.updatePlanePosition()
        }
       
        
    }
    
    private func directionBetweenPoints(sourcePoint: MKMapPoint, _ destinationPoint: MKMapPoint) -> CLLocationDirection {
        let x = destinationPoint.x - sourcePoint.x
        let y = destinationPoint.y - sourcePoint.y
        
        return radiansToDegrees(radians: atan2(y, x)).truncatingRemainder(dividingBy: 360 + 90)       
    }
    
    private func radiansToDegrees(radians: Double) -> Double {
        return radians * 180 / .pi
    }
    
    private func degreesToRadians(degrees: Double) -> Double {
        return degrees * .pi / 180
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
       // self.planeDirection = 70.0
        
        let planeIdentifier = "Plane"
        
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: planeIdentifier)
            ?? MKAnnotationView(annotation: annotation, reuseIdentifier: planeIdentifier)
        
        annotationView.image = #imageLiteral(resourceName: "airplane")
        annotationView.annotation = annotation
        annotationView.canShowCallout = true

        let angle = CGFloat(degreesToRadians(degrees: planeDirection))
        annotationView.transform = CGAffineTransform(rotationAngle: angle)

        annotationView.displayPriority = .required
        return annotationView
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
}
extension Double {
    /** Converts the specified value in degrees into radians. */
    
    func degrees() -> CGFloat {
        return CGFloat(self) * CGFloat(.pi / 180.0)
    }
}
extension MapViewController {

    func prepareButton() {
        iconButton.backgroundColor = UIColor(red:0.54, green:0.71, blue:0.81, alpha:1.0)
        iconButton.setTitle("Back", for: .normal)
        iconButton.cornerRadius = 20
        iconButton.spinnerColor = .white
        iconButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
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
   
}
