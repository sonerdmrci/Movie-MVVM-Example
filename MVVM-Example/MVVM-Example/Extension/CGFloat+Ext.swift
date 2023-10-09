import UIKit

//Bu sınıfta CGFloata özellik katıcaz

//Extensiona normal değişken koyamıyoruz: compitut property ya da static değişken olmalı

extension CGFloat {
    static let deviceWidth = UIScreen.main.bounds.width //main: Devicenin screenine, bounds: Sınırlarına ve onunda widhini alıyoruz
    static let deviceHeight = UIScreen.main.bounds.height
}