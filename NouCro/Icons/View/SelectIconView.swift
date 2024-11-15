//
//  SelectIconView.swift
//  NouCro
//
//  Created by AliReza on 2024-11-14.
//

import SwiftUI

struct SelectIconView: View {
    @ObservedObject var viewModel: SelectIconViewModel
    let cols = [GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())]
    var tintColor: SwiftUI.Color {
        return .init(viewModel.color.uiColor)
    }
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .trailing) {
                Button {
                    viewModel.shouldDismiss.toggle()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 25, height: 25)
                }
                .frame(width: 25, height: 25)
                .foregroundColor(tintColor)
                .padding([.top, .trailing], 5)
                ScrollView {
                    LazyVGrid(columns: cols, spacing: 20) {
                        ForEach(viewModel.iconNames, id: \.self) { name in
                            ZStack(alignment: .topTrailing) {
                                Image(systemName: viewModel.selectedIconName == name ? "square.fill" : "square")
                                    .frame(alignment: .topTrailing)
                                    .padding(.all, 4)
                                    .foregroundColor(tintColor)
                                Image(systemName: name)
                                    .resizable()
                                    .scaledToFill()
                                    .foregroundColor(tintColor)
                                    .frame(width: 50, height: 50)
                                    .padding(.all, 25)
                            }
                            .onTapGesture {
                                viewModel.didSelectItem(withName: name)
                            }
                            .background(SwiftUI.Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(SwiftUI.Color.gray, lineWidth: 2)
                            )
                        }
                    }
                    .padding()
                }
            }
            .frame(maxHeight: 500, alignment: .bottom)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(SwiftUI.Color(UIColor.systemGray6))
                    .shadow(radius: 5)
            )
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    SelectIconView(viewModel: .init(player: Player(name: "Test", color: NCColor.init(mode: .random), icon: "xmark")))
}
