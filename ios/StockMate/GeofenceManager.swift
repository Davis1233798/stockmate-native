import CoreLocation
import UserNotifications

final class GeofenceManager: NSObject, CLLocationManagerDelegate {
    private let manager=CLLocationManager()
    override init(){super.init();manager.delegate=self}
    func requestPermission(){manager.requestAlwaysAuthorization();UNUserNotificationCenter.current().requestAuthorization(options:[.alert,.sound]){_,_ in}}
    func monitor(id:String, latitude:Double, longitude:Double, radius:Double=200){let r=CLCircularRegion(center:.init(latitude:latitude,longitude:longitude),radius:radius,identifier:id);r.notifyOnEntry=true;manager.startMonitoring(for:r)}
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion){let c=UNMutableNotificationContent();c.title="到賣場了";c.body="別忘了查看 StockMate 採買清單";let req=UNNotificationRequest(identifier:UUID().uuidString,content:c,trigger:nil);UNUserNotificationCenter.current().add(req)}
}
