//
//  Item.swift
//  FitFlow
//
//  Created by Himanshu KumarSingh on 09/12/24.
//


import SwiftUI

struct Item:Identifiable{
    var id:String=UUID().uuidString
    var image:String
    var title:String
    
    // these are location of item in view
    var scale: CGFloat=1
    var anchor:UnitPoint = .center
    var offset:CGFloat=0
    var rotation:CGFloat=0
    var zindex:CGFloat=0
    
    // as you can observe, the zindex won't have any animation effects. therefore , I will modify the offset value when it starts moving and rest its
    // original offset value after a slight delay. This will ultimatly make the icons appear to be swaping
    
    var extraOffset : CGFloat = -350
    
    
}


let items:[Item]=[
    .init(image: "figure.walk.circle.fill",
          title: "Keep an eye on Your Workout..",
          scale: 1),
    
    .init(
        image: "figure.run.circle.fill",
        title: "Maintain Your Cardio Fitness..",
        scale: 0.6,
        anchor: .topLeading,
        offset: -70,
        rotation: 30
    ),
    .init(image: "figure.badminton.circle.fill",
          title: "Take break from work and relax..",
          scale: 0.5,
          anchor: .bottomLeading,
          offset: -60,
          rotation: -35),
    .init(image: "figure.climbing.circle.fill",
          title: "Turn Climbing into hobby..",
          scale: 0.35,
          anchor: .bottomLeading,
          offset: -50,
          rotation: 160,
          extraOffset: -120
         ),
    .init(image: "figure.cooldown.circle.fill",
              title: "Cooldown after work..",
              scale: 0.35,
              anchor: .bottomLeading,
              offset: -50,
              rotation: 250,
          extraOffset: -100
         ),
    
    
]
