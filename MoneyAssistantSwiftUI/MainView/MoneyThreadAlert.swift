//
//  MoneyThreadAlert.swift
//  MoneyAssistantSwiftUI
//
//  Created by Jackson  on 16/06/2022.
//

import SwiftUI
import AudioToolbox

enum MoneyAlertEventType {
    case spentButtonDidTap
    case earnButtonDidTap
}

struct MoneyThreadAlert: View {
    @Binding var isPresented: Bool
    @Binding var threadTitle: String
    @Binding var threadAmount: String
    @Binding var threadDescription: String
    
    var cellAction: ((MoneyAlertEventType) -> ())?
    
    private var dataProvidedCorrectly: Bool {
        !(threadAmount + threadTitle).isEmpty
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            if isPresented {
                
                // MARK: - Background
                
                Rectangle()
                    .foregroundColor(.green)
                    .opacity(isPresented ? 0.175 : 0)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation(.customSpring) {
                            threadTitle = ""
                            threadAmount = ""
                            
                            hideKeyboard()
                            isPresented.toggle()
                        }
                    }
            }
            
            // MARK: - Alert View
            
            GeometryReader { proxy in
                VStack {
                    Text("New money thread")
                        .padding(.top)
                        .font(.system(.title2, design: .default))
                    
                    TextField("Title", text: $threadTitle)
                        .disableAutocorrection(true)
                        .textFieldStyle(.roundedBorder)
                        .frame(maxWidth: proxy.size.width * 0.9)
                        .overlay(makeRequiredView())
                    
                    TextField("Amount", text: $threadAmount)
                        .disableAutocorrection(true)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                        .frame(maxWidth: proxy.size.width * 0.9)
                        .overlay(makeRequiredView())
                    
                    TextField("Description", text: $threadDescription)
                        .disableAutocorrection(true)
                        .textFieldStyle(.roundedBorder)
                        .frame(maxWidth: proxy.size.width * 0.9)
                    
                    HStack {
                        makeAlertButton(title: "Spent", alertProxy: proxy) {
                            if dataProvidedCorrectly {
                                cellAction?(.spentButtonDidTap)
                                
                                hideKeyboard()
                                
                                AudioServicesPlaySystemSound(SystemSound.train.rawValue)
                                                                
                                withAnimation(.customSpring) {
                                    isPresented.toggle()
                                }
                            }
                        }
                        
                        makeAlertButton(title: "Earn", alertProxy: proxy) {
                            if dataProvidedCorrectly {
                                cellAction?(.earnButtonDidTap)
                                
                                hideKeyboard()
                                                                
                                withAnimation(.customSpring) {
                                    isPresented.toggle()
                                }
                            }
                        }
                    }
                }
                .cornerRadius(12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .shadow(color: .black.opacity(0.3), radius: 6)
                        .foregroundColor(.green)
                        .frame(maxWidth: proxy.size.width * 0.98, maxHeight: .infinity)
                )
                .position(x: proxy.size.width / 2, y: proxy.size.height / 2)
                .frame(maxWidth: proxy.size.width * 0.98, maxHeight: .infinity)
            }
            .opacity(isPresented ? 1 : 0)
        }
    }
}

// MARK: - Additional Views

private extension MoneyThreadAlert {
    
    @ViewBuilder func makeAlertButton(title: String, alertProxy: GeometryProxy, buttonDidTap:  @escaping EmptyClosure) -> some View {
        
        Button(action: buttonDidTap) {
            Text(title)
                .foregroundColor(.black)
                .font(.system(.title2, design: .default))
        }
        .frame(
            width: alertProxy.size.width / 2,
            height: 54, alignment: .center
        )
    }
    
    @ViewBuilder func makeRequiredView() -> some View {
        GeometryReader { proxy in
            Text("Required")
                .font(.caption2)
                .foregroundColor(.red)
                .frame(height: 10, alignment: .leading)
                .position(x: proxy.size.width / 1.1, y: proxy.size.height / 2)
        }
    }
    
    
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MoneyThreadsContentView(viewModel: MainScreenViewModel(moneyThreadCDController: MoneyThreadCDController()))
    }
}
