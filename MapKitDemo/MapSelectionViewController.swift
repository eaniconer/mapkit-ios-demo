import UIKit
import Foundation
import YandexMapKit

/**
 * This example shows how to activate selection.
 */
class MapSelectionViewController: UIViewController, YMKLayersGeoObjectTapListener, YMKMapInputListener {
    @IBOutlet weak var mapView: YMKMapView!
    
    let TARGET_LOCATION = YMKPoint(latitude: 59.936760, longitude: 30.314673)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.mapWindow.map.move(
            with: YMKCameraPosition(target: TARGET_LOCATION, zoom: 17, azimuth: 0, tilt: 0),
            animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 1),
            cameraCallback: nil)
        
        mapView.mapWindow.map.addTapListener(with: self)
        mapView.mapWindow.map.addInputListener(with: self)
    }
    
    func onObjectTap(with: YMKGeoObjectTapEvent) -> Bool {
        let event = with
        let metadata = event.geoObject.metadataContainer.getItemOf(YMKGeoObjectSelectionMetadata.self)
        if let selectionMetadata = metadata as? YMKGeoObjectSelectionMetadata {
            mapView.mapWindow.map.selectGeoObject(withObjectId: selectionMetadata.id, layerId: selectionMetadata.layerId)
            return true
        }
        return false
    }
    
    func onMapTap(with map: YMKMap, point: YMKPoint) {
        mapView.mapWindow.map.deselectGeoObject()
    }
    
    func onMapLongTap(with map: YMKMap, point: YMKPoint) {
    }
}
