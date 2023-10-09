import UIKit
//Bu modül yardımcı: uygulama genelinde kullanacağımız tooları burada yazıcaz

//Enumun içerisinde değişken veya fonk. kullanmak için static keywordu kullanılır
enum UIHelper{
    static func createHomeFlowLayout() -> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()

        //CGFloat+ext ile cihazın yüksekliğini ve genişliğini aldık
        let itemWidth = CGFloat.deviceWidth

        layout.scroolDirection = .veritical //Dikey scroollama olacağı için
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.5)  //Hücrenin boyutunu ayarlıyoruz
        layout.minimumLineSpacing = 40
        return layout
    }
}