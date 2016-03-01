//
//  ProductListViewController.swift
//  QXJS
//
//  Created by Yachen Dai on 2/4/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class StoreViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate
{

    @IBOutlet var mainMenuContainer : UIView!
    @IBOutlet var mainContainer : UIView!
    @IBOutlet var mapView: MKMapView!
    let locationManager:CLLocationManager = CLLocationManager()
    var mainMenuView : MainMenuView!
    var cllocation : CLLocationManager!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        mainMenuView = MainMenuView.sharedInstance()
        mainMenuView.removeFromSuperview()
        mainMenuContainer.addSubview(mainMenuView)
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.rotateEnabled = false
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //设置为最高的精度
        if ios8()
        {
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.startUpdatingLocation()  //start updating location
    }
    
    func ios8() -> Bool
    {
        let versionCode:String = UIDevice.currentDevice().systemVersion
        let index = versionCode.startIndex.advancedBy(0)
        let version = NSString(string: UIDevice.currentDevice().systemVersion.substringFromIndex(index))
        return version.doubleValue >= 8.0
    }
    //重写这个方法获取位置
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location:CLLocation = locations[locations.count - 1] //得到数组中的最后一个元素
        if location.horizontalAccuracy > 0 {
            //            let latitude = location.coordinate.latitude
            //            let longtitude = location.coordinate.longitude
            self.mapView.setCenterCoordinate(location.coordinate, animated: true)
            locationManager.stopUpdatingLocation() //stop updating location
        }
    }
    
    //重写当发生错误时要调用的方法
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print(error)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
