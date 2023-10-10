import UIKit
//Collection viewler ve table viewler main tharedte güncellenir. her seferinde bunu yapmak yerine sınıfına özellik ekledik
extension UICollectionView {
    func reloadOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}