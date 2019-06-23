//
//  IntroView.swift
//  BPT Tracker
//
//  Created by Jens Amund on 23/06/2019.
//  Copyright © 2019 Jakkaps. All rights reserved.
//

import SwiftUI
import EAIntroView

struct IntroView : UIViewRepresentable {
    func makeUIView(context: Context) -> EAIntroView {
        let page = EAIntroPage()
        page.title = "Yeeehello"
        page.desc = "Testing testing"
        
        
        let introView = EAIntroView(frame: CGRect(x: 0, y: 0, width: 500, height: 500), andPages: [page])!
        introView.showFullscreen()
        return introView
    }
    
    func updateUIView(_ view: EAIntroView, context: Context) {
        
    }
}

#if DEBUG
struct IntroView_Previews : PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
#endif
