//
//  SwiftUIView.swift
//  
//
//  Created by Willian Policiano on 2022-12-05.
//

import SwiftUI

public struct LyricsView: View {
    public init() { }

    let a = "Tua beleza, porém, por toda eternidade é!"

    let lyrics = """
    A beleza da tua santidade é maior
    Que as maravilhas da Terra
    Pois aqui cada uma se encerra

    Céus e terra passarão
    Tua palavra permanecerá
    A matéria envelhecerá
    Mas teu amor pra sempre existirá!

    A beleza da tua santidade é maior
    Que as maravilhas da Terra
    Pois aqui cada uma se encerra
    """

    lazy var textWidth = lyrics.widthOfString(usingFont: .monospacedSystemFont(ofSize: 16, weight: .regular))

    public var body: some View {
        VStack {
            Text(lyrics)
                .font(.body.monospaced())
                .scaledToFit()
                .minimumScaleFactor(0.5)
                .lineSpacing(8)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)

    }
}

struct LyricsView_Previews: PreviewProvider {
    static var previews: some View {
        LyricsView()
    }
}

extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
