//
//  ContentView.swift
//  FitFlow
//
//  Created by Himanshu KumarSingh on 09/12/24.
//


import SwiftUI

struct ContentView:View {
    
    @State private var selectItem:Item=items.first!
    @State private var introItems:[Item]=items
    
    @State private var activeIndex: Int=0
    var body: some View {
        VStack(spacing: 0){
            
            // Back Button
            Button{
                updateItem(isForward: false)
            }label: {
                Image(systemName: "chevron.left")
                    .font(.title3.bold())
                    .foregroundStyle(.green.gradient)
                    .contentShape(.rect)
            }.padding(15)
                .frame(maxWidth: .infinity,alignment: .leading)
            /// Only Visible from second item
                .opacity(selectItem.id != introItems.first?.id ? 1 : 0)
            
            
            ZStack{
                //Animated Icons
                
                ForEach(introItems) { item in
                    AnimatedIconView(item)
                }
                
                
            }.frame(height: 250)
                .frame(height: .infinity)
            
            VStack(spacing: 6){
                //Progress Indicator View
                HStack(spacing: 4){
                    ForEach(introItems) { item in
                        Capsule()
                            .fill(selectItem.id == item.id ? Color.primary: .gray )
                            .frame(width: selectItem.id == item.id ? 24:4, height: 4)
                    }
                }
                .padding(.bottom,15)
                
                
                Text(selectItem.title)
                    .font(.title.bold())
                    .contentTransition(.numericText())
                
                Text("Himanshu Kumar Singh  github.com/to4to")
                    .font(.caption2)
                    .foregroundStyle(.gray)
                
                Button{
                    
                    updateItem(isForward: true)
                }label: {
                    Text(selectItem.id==introItems.last?.id ? "Continue":"Next")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .contentTransition(.numericText())
                        .frame(width: 250)
                        .padding(.vertical,12)
                        .background(.green.gradient,in: .capsule)
                }.padding(.top,25)
                
                                       
            }
            .frame(width: 300)
            .frame(maxWidth: .infinity)
        }
    }
    
    
    
    @ViewBuilder
    func AnimatedIconView(_ item :Item)->some View{
        
        let isSelected=selectItem.id == item.id
        
        Image(systemName: item.image)
            .font(.system(size: 80))
            .foregroundStyle(.white.shadow(.drop(radius: 10)))
            .blendMode(.overlay)
            .frame(width: 120,height: 120)
            .background(.green.gradient,in: .rect(cornerRadius: 32))
            .background(
                RoundedRectangle(cornerRadius: 35)
                    .fill(.background)
                    .shadow(color: .primary.opacity(0.2), radius: 1,x: 1,y: 1)
                    .shadow(color: .primary.opacity(0.2), radius: 1,x: -1,y: -1)
                    .padding(-3)
                    .opacity(selectItem.id == item.id ? 1 : 0)
            )
        
        //resetting rotation
            .rotationEffect(.init(degrees: -item.rotation))
            .scaleEffect(isSelected ? 1.1 : item.scale, anchor: item.anchor)
            .offset(x:item.offset)
            .rotationEffect(.init(degrees: item.rotation))
        //placing activ icon the top
            .zIndex(isSelected ? 2: item.zindex)
        
        
    }
    
    
    
    // shift Active icon on the centre when continue or backword is pressed
    
    func updateItem(isForward:Bool){
        guard isForward ? activeIndex != introItems.count - 1 : activeIndex != 0 else {return }
        var fromIndex: Int
        var extraOffset: CGFloat=0
      //To index
        if isForward{
            activeIndex += 1
        }else{
            activeIndex -= 1
           extraOffset = introItems[activeIndex].extraOffset
        }
        //from index
        if isForward {
            fromIndex  = activeIndex - 1
        }else {
            fromIndex  = activeIndex + 1
             
        }
      
        
        //resetting zindex
        for index in introItems.indices{
            introItems[index].zindex=0
            
        }
        
        Task{
            [fromIndex , extraOffset ] in
            //Shifting from and to icon location
            
            withAnimation(.bouncy(duration: 1)){
                
                introItems[fromIndex].scale = introItems[activeIndex].scale
                introItems[fromIndex].rotation = introItems[activeIndex].rotation
                introItems[fromIndex].anchor = introItems[activeIndex].anchor
                introItems[fromIndex].offset = introItems[activeIndex].offset
                //temporary adjustment
                introItems[activeIndex].offset = extraOffset
                
                
                // the moment selected item is updated, it pushs the from card all the way to the back in terms of zindex
                // to solve this we can make use of zindex property to just place the from card below the card
                // Eg: to card position 2
                //from card position 1
                // others 0
                introItems[fromIndex].zindex=1
                
            }
            
            try? await Task.sleep(for: .seconds(0.1))
            withAnimation(.bouncy(duration: 0.9 )){
                
                // to location is always at the centre
                introItems[activeIndex].scale = 1
                introItems[activeIndex].rotation = .zero
                introItems[activeIndex].anchor = .center
                introItems[activeIndex].offset = .zero
                
                
                //Updating selected item
                selectItem = introItems[activeIndex]
            }
        }
    }
}

#Preview {
    ContentView()
}

