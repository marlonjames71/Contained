//
//  CustomScene.swift
//  Contained
//
//  Created by Marlon Raskin on 6/10/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import SpriteKit

class CustomScene: SKScene {
	let crab = SKSpriteNode()
	static var crabState = "HappyCrab"
	
	// Add and center child, initializing animation sequence
	override func sceneDidLoad() {
		super.sceneDidLoad()
		addChild(crab)
		crab.loadTextures(named: CustomScene.crabState, forKey: SKSpriteNode.textureKey)
		crab.position = CGPoint(x: frame.midX, y: frame.midY)
		crab.alpha = CGFloat(Settings.shared.crabFade)
	}
	
	// Move to touch
	public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		
		// Fetch a touch or leave
		guard !touches.isEmpty, let touch = touches.first else { return }
		
		// Retrieve position
		let position = touch.location(in: self)
		
		// Create move action
		let actionDuration = 1.0
		let moveAction = SKAction.move(to: position, duration: actionDuration)
		
		let rollAction = SKAction.rotate(byAngle: CGFloat.pi * 2, duration: actionDuration)
		let zoomAction = SKAction.scale(by: 1.3, duration: 0.3)
		let unzoomAction = SKAction.scale(to: 1.0, duration: 0.1)
		
		switch Settings.shared.shouldZoom {
		case false:
			crab.run(moveAction)
		case true:
			let sequenceAction = SKAction.sequence([zoomAction, moveAction, unzoomAction])
			crab.run(sequenceAction)
		}
		
		if Settings.shared.shouldRoll {
			crab.run(rollAction)
		}
	}
}
