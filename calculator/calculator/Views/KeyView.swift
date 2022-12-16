//
//  KeyView.swift
//  calculator
//
//  Created by Ankush Shandil on 17/11/22.
//
import SwiftUI

struct KeyView: View {
    
    //To repaint your UIView
    @State var value = "0" //for the default value
    @State var runningNumber = 0 //here is user putting the
    //to hold the running operation
    @State var currentOperation: Operation = .none
    @State private var changeColor = false
    
    
    let buttons : [[Keys]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .substract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    
    
    
    ]
    
    var body: some View{
        VStack{
            Spacer()
            HStack {
                RoundedRectangle(cornerRadius: 15)
                .foregroundColor(changeColor ? Color("num").opacity(0.4) : Color.pink.opacity(0.2))
                .scaleEffect(changeColor ? 1.5 : 1.0)
                .frame(width: 350, height: 280)
                .animation(Animation.easeInOut.speed(0.17).repeatForever(), value: changeColor)
                    .onAppear(perform: {
                        
                    self.changeColor.toggle()
                })
                    .overlay(Text(value)
                       .bold()
                       .font(.system(size: 100))
                       .foregroundColor(.black)
                )
            }.padding()
            ForEach(buttons, id: \.self){ row in
                HStack(spacing: 10){
                    ForEach(row, id: \.self){ elem in
                        Button {
                            self.didTap(button: elem)
                        } label: {
                            Text(elem.rawValue)
                                .font(.system(size: 30))
                                .frame(width:self.getWidth(elem: elem), height: self.getHeight(elem: elem))
                                .background(elem.buttonColor)
                                .foregroundColor(.black)
                                .cornerRadius(self.getWidth(elem: elem)/2)
                                .shadow(color: .purple.opacity(0.8),radius: 30 )
                            
                        }

                    }
                    
                }.padding(.bottom, 4)
                
            }
               
           
        }
    }
    func getWidth(elem: Keys) -> CGFloat {
        
        if elem == .zero {
            return (UIScreen.main.bounds.width - (5*10))/2
        }
        return (UIScreen.main.bounds.width - (5*10))/4
    }
    
   func getHeight (elem: Keys) -> CGFloat{
        return (UIScreen.main.bounds.width - (5*10))/5
    }
    
    
    
    func didTap(button: Keys){
        switch button {
        case .add, .substract, .multiply, .divide, .equal:
            if button == .add{
                self.currentOperation = .add
                self.runningNumber = Int(self.value) ?? 0
                
            }
            if button == .substract{
                self.currentOperation = .substract
                self.runningNumber = Int(self.value) ?? 0
                
            }
            if button == .multiply{
                self.currentOperation = .multiply
                self.runningNumber = Int(self.value) ?? 0
                
            }
            if button == .divide{
                self.currentOperation = .divide
                self.runningNumber = Int(self.value) ?? 0
                
            }
            if button == .equal{
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                
                switch self.currentOperation{
                case .add: self.value = "\(runningValue + currentValue)"
                    
                case .substract: self.value = "\(runningValue - currentValue)"
                    
                case .multiply: self.value = "\(runningValue * currentValue)"
                case .divide: self.value = "\(runningValue / currentValue)"
                case .none:
                    break
                }
                
            }
            
            if button != .equal{
                self.value = "0"
            }
                
            
        case .clear:
            self.value = "0"
        case .decimal, .negative, .percent:
            break
        default:
            let number = button.rawValue
            if self.value == "0"{
                value = number
            }
            else{
                self.value = "\(self.value)\(number)"
            }
        }
        
    }
    
}




struct KeyView_Previews: PreviewProvider{
    static var previews: some View{
        KeyView()
    }
}
