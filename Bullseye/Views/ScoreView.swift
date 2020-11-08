//
//  ScoreView.swift
//  Bullseye
//
//  Created by Samuel Kaufmann on 08.11.20.
//

import SwiftUI

@ObservedObject private var scoreData = ScoreData()

let listFor20Rnds = ["Back To The Future", "Samuel", "A Newbie"]
let listFor10Rnds = ["Back To The Past", "Nathaniel", "A Pro"]

struct ScoreView: View {
    var body: some View {
        Text("✨👑Rangliste👑✨")
            .font(.title)
            .padding()
        HStack {
            VStack {
            Text("✨20 Runden✨")
        List(listFor20Rnds, id: \.self) { discipline in
              Text(discipline)
        }
            }
            VStack {
            Text("✨10 Runden✨")
            List(listFor10Rnds, id: \.self) { discipline in
                  Text(discipline)
                }
            }
        }
        Spacer()
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView()
    }
}
