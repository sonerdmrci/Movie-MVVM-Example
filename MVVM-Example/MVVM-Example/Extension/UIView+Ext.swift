import UIKit

//Viewin ekranı kaplamasını sağladık
extension UIView{
    func pinToEdgesOf(view: UIView){
        NSLayoutConstraint.activate([
            //self.topAnchor.constraint(equalTo: view.topAnchor)  //Buradaki self HomeSreendeki collectionViewe Karşılık geliyor swift bunu anlıyor ve self yazmaya gerek yok

            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)

        ])
    }
}