//
//  ViewController.swift
//  MixColorsApp
//
//  Created by Павел Широкий on 10.02.2024.
//

import UIKit

class ViewController: UIViewController, UIColorPickerViewControllerDelegate {
    
    @IBOutlet weak var colorOneLabel: UILabel!
    @IBOutlet weak var colorTwoLabel: UILabel!
    @IBOutlet weak var colorThreeLabel: UILabel!
    @IBOutlet var firstColor: UIButton!
    @IBOutlet var secondColor: UIButton!
    
    @IBOutlet weak var colorThreeView: UIView!
    @IBOutlet weak var languageToggle: UISegmentedControl!
    
    var activeButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFirstColor()
        setupSecondColor()
        colorOneLabel.text = "Grey"
        colorTwoLabel.text = "Orange"
        colorThreeLabel.text = "Смешанный цвет"
        
        firstColor.addTarget(self, action: #selector(firstButtontaped(_:)), for: .touchUpInside)
        secondColor.addTarget(self, action: #selector(secondButtomTaped(_:)), for: .touchUpInside)
            
    }

    func setupFirstColor() {
        firstColor.backgroundColor = .systemGray
    }
    
    @IBAction func firstButtontaped(_ sender: UIButton) {
        activeButton = sender
        presentColorPicker()
    }
    
   
    func setupSecondColor() {
        secondColor.backgroundColor = .systemOrange
    }
    
    @IBAction func secondButtomTaped(_ sender: UIButton) {
        activeButton = sender
        presentColorPicker()
    }
    
   
    func presentColorPicker() {
        let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.delegate = self
        present(colorPickerVC, animated: true)
    }
    
    func blendColors() {
        guard let color1 = firstColor.backgroundColor, let color2 = secondColor.backgroundColor else {
                    return
                }

        // Выполняем смешивание цветов
        let blendedColor = UIColor.blendColors(color1, color2)

        // Обновляем цвет на resultView
        colorThreeView.backgroundColor = blendedColor
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        
        guard let activeButton = activeButton else { return }
        activeButton.backgroundColor = viewController.selectedColor
        blendColors()
    }
     
}

extension UIColor {
    static func blendColors(_ color1: UIColor, _ color2: UIColor) -> UIColor {
        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0

        color1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)

        let blendedColor = UIColor(
            red: (r1 + r2) / 2,
            green: (g1 + g2) / 2,
            blue: (b1 + b2) / 2,
            alpha: (a1 + a2) / 2
        )

        return blendedColor
    }
}
