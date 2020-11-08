//
//  ScoreData.swift
//  Bullseye
//
//  Created by Samuel Kaufmann on 08.11.20.
//

import Combine
import SwiftUI

final public class ScoreData:ObservableObject  {
    @Published var name:String = ""
    @Published var score:String = ""
}
