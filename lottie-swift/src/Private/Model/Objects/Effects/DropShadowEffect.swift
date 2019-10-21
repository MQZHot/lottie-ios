//
//  DropShadowEffect.swift
//  Lottie_iOS
//
//  Created by Viktor Radulov on 9/10/19.
//  Copyright © 2019 YurtvilleProds. All rights reserved.
//

import Foundation
import QuartzCore

class DropShadowEffect: Effect {
	
	override func apply(layer: CALayer, frame: CGFloat) {
		values?.forEach({ (value) in
			switch value.name {
			case "Shadow Color":
				if let colorArray = value as? ArrayEffectValue {
					layer.shadowColor = CGColor(red: CGFloat(colorArray.value[0]), green: CGFloat(colorArray.value[1]), blue: CGFloat(colorArray.value[2]), alpha: CGFloat(colorArray.value[3]))
				}
			case "Direction":
				if let direction = value as? VolumeEffectValue<Vector1D> {
					if let distance = values?.first(where: { $0.name == "Distance" }) as? VolumeEffectValue<Vector1D> {
                        let directionValue = (direction.interpolator.value(frame: frame) as! Vector1D).value
                        let distanceValue = (distance.interpolator.value(frame: frame) as! Vector1D).value
                        
						layer.shadowOffset = NSSize(width: -cos(directionValue * .pi / 180) * distanceValue, height: sin(directionValue * .pi / 180) * distanceValue)
					}
				}
			case "Opacity":
				if let opacity = value as? VolumeEffectValue<Vector1D> {
                    let opacityValue = (opacity.interpolator.value(frame: frame) as! Vector1D).value
					layer.shadowOpacity = Float(opacityValue) / 255.0
				}
			case "Softness":
				if let softness = value as? VolumeEffectValue<Vector1D> {
                    let softnessValue = (softness.interpolator.value(frame: frame) as! Vector1D).cgFloatValue
					layer.shadowRadius = softnessValue / 5.0
				}
			default:
				break
			}
		})
	}
}
