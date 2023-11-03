//
//  CardView.swift
//  Phone
//
//  Created by KudzaisheMhou on 02/11/2023.
//

import SwiftUI
import Kingfisher

struct CardView: View {
    
    var showTitle: Bool
    var showChevron: Bool
    var showCircle: Bool
    
    var title: String = ""
    var avatar: String = ""
    var circleColor: String = "#FFFFF"
    var infoArray: [String]
    
    var body: some View {
        VStack(spacing: 0) {
            
            if !showTitle {
                Divider()
            }
            
            Group {
                if showTitle {
                    HStack {
                        Text(title)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(Color.black)
                        
                        Spacer()
                    }
                }
            }
            
            
            HStack {
                
                if showCircle {
                    Circle()
                    .fill(Color(hex: circleColor))
                    .frame(width: 30, height: 30)
                } else {
                    
                    KFImage(URL(string: avatar))
                    .resizable()
                    .diskCacheExpiration(.never)
                    .placeholder {
                        Rectangle().fill(Color.gray)
                    }
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.4), radius: 5, x: 0, y: 5)
                    
                    .frame(width: 40, height: 40)
                }
                
                VStack(spacing: 8) {
                    Group {
                        VStack(alignment: .leading, spacing: 4) {
                            ForEach(infoArray, id: \.self) { info in
                                Text(info)
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundStyle(Color.black)
                            }
                        }
                    }
                }
                
                Spacer()
                
                Group {
                    if showChevron {
                        Image(systemName: "chevron.forward")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(.gray)
                            .frame(width: 16, height: 16)
                    }
                }
                
            }
            .padding(.horizontal)
            .padding(.vertical)
            .background(Color("background"))
            
            Divider()
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    CardView(showTitle: false, showChevron: false, showCircle: false, infoArray: ["test", "test2"])
}
