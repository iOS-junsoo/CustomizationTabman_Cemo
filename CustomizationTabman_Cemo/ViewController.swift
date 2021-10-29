//
//  ViewController.swift
//  CustomizationTabman_Cemo
//
//  Created by 준수김 on 2021/10/29.
//

import UIKit
import Tabman
import Pageboy

class ViewController: TabmanViewController {

    private var viewControllers: Array<UIViewController> = []

    var array = ["배달", "배민1", "포장", "쇼핑라이브", "선물하기"]
 
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc1 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController1") as! ViewController1
        let vc2 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController2") as! ViewController2
        let vc3 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController3") as! ViewController3
        let vc4 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController4") as! ViewController4
        let vc5 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController5") as! ViewController5
    
        viewControllers.append(vc1)
        viewControllers.append(vc2)
        viewControllers.append(vc3)
        viewControllers.append(vc4)
        viewControllers.append(vc5)
        
        self.dataSource = self
        // Create bar
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap // Customize
        bar.backgroundColor = .clear
        // Add to view
        addBar(bar, dataSource: self, at: .top)
    
//        bar.backgroundView.style = .blur(style: .extraLight) //bar 배경스타일 변경
        
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0) //bar item 위치변경
        bar.backgroundView.alpha = 0 //bar 투명하게 만들기
        bar.buttons.customize { (button) in
        button.tintColor = .lightGray
        button.selectedTintColor = .white
        button.backgroundColor = self.hexStringToUIColor(hex: "#29bbb6") //버튼 배경색
        button.layer.cornerRadius = 15 //버튼 둥글게
            
        }
    
        bar.indicator.alpha = 0 //인디케이터 없애기
        bar.indicator.overscrollBehavior = .compress //오버스크롤 스타일
    }


}

extension ViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let item = TMBarItem(title: "")
        item.title = array[index]
        
        
        return item
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}

//MARK: - HEXCOlor
extension ViewController {
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}

