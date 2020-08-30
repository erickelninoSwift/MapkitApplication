//
//  DropablePin.swift
//  PixelCityApp
//
//  Created by El nino Cholo on 2020/08/30.
//  Copyright © 2020 El nino Cholo. All rights reserved.
//

import UIKit
import MapKit


class dropPin: NSObject , MKAnnotation
{
    dynamic var coordinate:CLLocationCoordinate2D
    var identifier: String
    
    init(coordinate: CLLocationCoordinate2D , identifier:String)
    {
      
        self.coordinate = coordinate
        self.identifier = identifier
        super.init()
    }
    
}
