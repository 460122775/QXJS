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

class StoreViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource
{

    @IBOutlet var mainMenuContainer : UIView!
    @IBOutlet var mainContainer : UIView!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var storeTableView: UITableView!
    
    @IBOutlet var mainStoreImgView: UIImageView!
    @IBOutlet var mainStoreNameLabel: UILabel!
    @IBOutlet var mainStoreAddressLabel: UILabel!
    @IBOutlet var mainStorePhoneLabel: UILabel!
    
    var matchingItems:[MKMapItem] = []
    let TableCellIndentifier : String = "StoreTableViewCell"
    let locationManager:CLLocationManager = CLLocationManager()
    var mainMenuView : MainMenuView!
    var cllocation : CLLocationManager!
    var storeDataArr : NSMutableArray?
    var selectedStoreData : NSMutableDictionary?
    var MapViewReuseIdentifier : String = "MapViewReuseIdentifier"
    
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
        self.storeTableView.delegate = self
        self.storeTableView.dataSource = self
        self.storeTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.storeTableView.registerNib(UINib(nibName: "StoreTableViewCell", bundle: nil), forCellReuseIdentifier: TableCellIndentifier)
        // Map.
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.rotateEnabled = false
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // IOS8
        if ios8()
        {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startUpdatingLocation()  //start updating location
        // getStoreData
        self.getStoreData()
    }
    
    func getStoreData()
    {
        self.storeDataArr = StoreModel.getStoreData()
        if self.storeDataArr != nil && self.storeDataArr?.count > 0
        {
            let mainStore : NSMutableDictionary = (self.storeDataArr?.objectAtIndex(0) as? NSMutableDictionary)!
            self.mainStoreNameLabel.text = mainStore.objectForKey("storeName") as? String
            self.mainStorePhoneLabel.text = mainStore.objectForKey("phone") as? String
            self.mainStoreAddressLabel.text = mainStore.objectForKey("address") as? String
//            self.mainStoreImgView.image = UIImage(named: mainStore.objectForKey("img") as! String)
            // Set mapview.
            self.setMapViewByAddress(mainStore.objectForKey("address") as! String)
            // Must reload data in main queue, or maybe crashed.
            dispatch_async(dispatch_get_main_queue(), {
                self.storeTableView.reloadData()
            });
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if self.storeDataArr != nil
        {
            return self.storeDataArr!.count
        }else{
            return 0
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 88
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell : StoreTableViewCell? = tableView.dequeueReusableCellWithIdentifier(TableCellIndentifier) as? StoreTableViewCell
        let storeDataDic = (self.storeDataArr?.objectAtIndex(indexPath.row as Int) as? NSMutableDictionary)!
        cell?.setDataDic( storeDataDic, index: indexPath.row, selected: (storeDataDic == selectedStoreData))
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        var arry = tableView.visibleCells;
        for i in 0 ..< arry.count
        {
            let _cell : StoreTableViewCell = arry[i] as! StoreTableViewCell
            _cell.setBgStyle(i, selected: false)
        }
        selectedStoreData = (self.storeDataArr?.objectAtIndex(indexPath.row as Int) as? NSMutableDictionary)!
        let cell : StoreTableViewCell = tableView.cellForRowAtIndexPath(indexPath) as! StoreTableViewCell
        cell.setBgStyle(indexPath.row, selected: true)
        self.setMapViewByAddress(selectedStoreData?.objectForKey("address") as! String)
    }
    
    func ios8() -> Bool
    {
        let versionCode:String = UIDevice.currentDevice().systemVersion
        let index = versionCode.startIndex.advancedBy(0)
        let version = NSString(string: UIDevice.currentDevice().systemVersion.substringFromIndex(index))
        return version.doubleValue >= 8.0
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location:CLLocation = locations[locations.count - 1]
        if location.horizontalAccuracy > 0
        {
            self.mapView.setCenterCoordinate(location.coordinate, animated: true)
            locationManager.stopUpdatingLocation() //stop updating location
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print(error)
    }
    
    var annotation:MKAnnotation!
    var localSearchRequest:MKLocalSearchRequest!
    var localSearch:MKLocalSearch!
    var localSearchResponse:MKLocalSearchResponse!
    var error:NSError!
    var pointAnnotation:MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
    @IBAction func locateBtnClick(sender: UIButton)
    {
        self.setMapViewByAddress("四川省成都市双流县天府大道南段会龙大道")
    }
    
    func setMapViewByAddress(addressStr : String)
    {
        localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = addressStr
        localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.startWithCompletionHandler { (localSearchResponse, error) -> Void in
            if localSearchResponse == nil{
                let alertController = UIAlertController(title: "地址未找到", message: "对不起，该定位有误，请核对后重置。", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "返回", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                return
            }
            if self.pointAnnotation == nil
            {
                self.pointAnnotation = MKPointAnnotation()
                
            }
            self.pointAnnotation.title = addressStr
            self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude:     localSearchResponse!.boundingRegion.center.longitude)
            if self.pinAnnotationView == nil
            {
                self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: self.MapViewReuseIdentifier)
                self.mapView.addAnnotation(self.pinAnnotationView.annotation!)
            }
            self.mapView.centerCoordinate = self.pointAnnotation.coordinate
            self.mapView.setRegion(self.mapView.regionThatFits(MKCoordinateRegionMakeWithDistance(localSearchResponse!.boundingRegion.center, 5000, 5000)), animated: true)
            self.mapView.showsUserLocation = true
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
