//
//  MainWindowController.swift
//  Mapper
//
//  Created by Rodney Dyer on 2/10/18.
//  Copyright © 2018 Rodney Dyer. All rights reserved.
//

import Cocoa
import MapKit


class MainWindowController : NSWindowController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let regionRadius: CLLocationDistance = 5000
    let initialLocation = CLLocationCoordinate2DMake(37.53, -77.47)
    
    
    override var windowNibName: NSNib.Name? {
        get {
            return NSNib.Name(rawValue: "MainWindowController" )
        }
    }
    
    func centerMapOnLocation( location: CLLocationCoordinate2D ) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(initialLocation, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    func centerMap() {
        var zoomRect = MKMapRectNull
        for annotation in mapView.annotations {
            let annotationPoint = MKMapPointForCoordinate(annotation.coordinate)
            let pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0)
            if (MKMapRectIsNull(zoomRect)) {
                zoomRect = pointRect
            } else {
                zoomRect = MKMapRectUnion(zoomRect, pointRect)
            }
        }
        
        let dx = zoomRect.size.width * -0.2
        let dy = zoomRect.size.height * -0.2
        
        let newRect: MKMapRect = MKMapRectInset(zoomRect, dx , dy)
        mapView.setVisibleMapRect(newRect, animated: true)
    }
    
    override func windowDidLoad() {
        print("MainWindowController::windowDidLoad()")
        
        mapView.addAnnotation( PopulationNode(title: "CES",
                                     subtitle: "Center for Environmental Studies",
                                     coordinate: CLLocationCoordinate2DMake(37.545010, -77.454849)))
        
        mapView.addAnnotation( PopulationNode(title: "Monroe Park",
                                     subtitle: "The Monroe Park Open Area",
                                     coordinate: CLLocationCoordinate2DMake(37.547043, -77.450012)))
        
        mapView.addAnnotation( PopulationNode(title: "Kúba Kúba",
                                     subtitle: "An Awesome Place to Eat",
                                     coordinate: CLLocationCoordinate2DMake(37.551187, -77.458865)))
        
        var e1 = mapView.annotations.map { $0.coordinate }
        let geoline = MKGeodesicPolyline(coordinates: &e1, count: 3)

        mapView?.add(geoline)
        
        centerMap()
        
        mapView?.delegate = self
    }
    
}


extension MainWindowController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if overlay is MKGeodesicPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = NSColor.orange
            renderer.lineWidth = 3
            return renderer
        }
        else {
            return MKOverlayRenderer()
        }
    }
    
}


