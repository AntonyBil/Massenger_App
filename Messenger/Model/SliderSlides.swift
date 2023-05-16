//
//  SliderSlides.swift
//  Messenger
//
//  Created by apple on 16.05.2023.
//

import UIKit

class SliderSlides {
    func getSlides()->[SlideModel] {
        
        var slides: [SlideModel] = []
        
        let slide1 = SlideModel(id: 1, text: "Text 1", image: UIImage(imageLiteralResourceName: "slide_1"))
        let slide2 = SlideModel(id: 2, text: "Text 2", image: UIImage(imageLiteralResourceName: "slide_2"))
        let slide3 = SlideModel(id: 3, text: "Text 3", image: UIImage(imageLiteralResourceName: "slide_3"))
        slides.append(slide1)
        slides.append(slide2)
        slides.append(slide3)
        
        return slides
    }
}
