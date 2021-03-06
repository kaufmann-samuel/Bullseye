//
//  ContentView.swift
//  Bullseye
//
//  Created by Samuel Kaufmann on 03.11.20.
//

import SwiftUI
/*
    struct Joke : Identifiable {
        var id: Int
        
        var text : String?
        var school : String?
    }
*/
 struct ContentView: View {
    
    //@State private var isVisibleKnock: Bool = false
    @State private var isVisibleGame = false
    @State private var willMoveToNextScreen = false
    //@ObservedObject var leaderboardView = LeaderboardView()
    
    /*
    @State var jokeList = ["Samuel kauft Mann",
        "Max im Zelensky",
        "Valentin het Stein",
        "JSON Bayern",
        "Mr. Fischer",
        "Rami Malek",
        "Insert TBZ related person here",
        "object object",
        "undefined",
        "sample text",
        "Steve Jobs",
        "()"
    ].shuffled()
    
    func randJoke(){
        jokeList.shuffle()
    }
    */
    var body: some View {

        //NavigationView {
 
        VStack {
            
            Text("The worst iOS App ever")
                .font(.largeTitle)
            Text("Copyright Samuel Kaufmann©")
                .font(.custom("", size: 15))
                .padding(.bottom)
        Button(action: {
            print("Start Game tapped!"); isVisibleGame = true;
            }) {
            HStack {
                    Image(systemName: "play")
                        .font(.title)
                                    Text("Start Bullseye!")
                                        .fontWeight(.semibold)
                                        .font(.title)

                }
                .padding()
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(40)
            }
            .alert(isPresented: $isVisibleGame) {
                /*
                Alert(title: Text("Bullseye Game"), message:Text("App wird gestartet."), dismissButton: Alert.Button.default(Text("Ok")))
                */
                
                Alert(title: Text("Bullseye Game"), message: Text("Soll die App gestartet werden?"),
                    primaryButton: Alert.Button.default(Text("Ja"), action: {
                        print("Alert Yes Pressed!");
                        // Go to other View
                        willMoveToNextScreen = true
                        
                    }),
                    secondaryButton: Alert.Button.cancel(Text("Nein"), action: {
                        print("Alert No Pressed!")
                    })
                )
                
                
                /*
                Alert(title: Text("Bullseye Game"), message: Text("App Starten?"),
                    primaryButton: Alert.Button.default(Text("Yes"), action: {
                        print("Ja")
                    }),
                    secondaryButton: Alert.Button.cancel(Text("No"), action: {
                        print("Nein")
                    })
                )
                */
            }
            /*
            .alert(isPresented: $isVisibleKnock) {
                Alert(title: Text("Joke"), message: Text("Insert Joke here"), dismissButton: .default(Text("Ok")))
            }
            */
        }
        .navigate(to: ContentViewGame(), when: $willMoveToNextScreen)
    //}
 }
}


extension View {

    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    
                    .navigationBarTitle("")
                    .navigationBarHidden(true)

                NavigationLink(
                    destination: view
                    
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
    }
}


struct ContentViewGame : View {
    
    @State private var hitNumber = Int.random(in: 0..<200)
    @State private var sliderValue = 100.0
    @State private var alertIsVisible = false
    @State private var totalScore = 0
    @State private var rounds = 0
    @State private var willMoveToLeaderboard = false

    func sliderValueRounded() -> Int {
        return Int(sliderValue.rounded())
    }
    
    func pointsForCurrentRound() -> Int {
        return 100 - abs(hitNumber - sliderValueRounded())
    }
    
        var body: some View {

                VStack {
                    
                    // Header Row
                    HStack {
                        Text("Treffe die Zahl mit dem Schieber:")
                            .fontWeight(.semibold)
                            .font(.title3)
                            Spacer()
                        Text("Ziel: \(hitNumber)")
                            .fontWeight(.semibold)
                            .font(.title3)
                        Button(action: { print("Show Score Button Pressed!"); alertIsVisible = true;
                        }, label: {
                            Text("Prüfen")
                                .fontWeight(.semibold)
                                .font(.title3)
                        })
                        .padding()
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(40)
                    }
                    .padding()
                    .alert(isPresented: $alertIsVisible) { () -> Alert in
                        return Alert(title: Text("Punkte"), message: Text("Du hast diese Zahl getroffen: \(sliderValueRounded()).\n" + "Du erhälst \(pointsForCurrentRound()) Punkt/e"), dismissButton: .cancel(Text("Ok")) {
                            self.totalScore = self.totalScore + self.pointsForCurrentRound();
                            self.hitNumber = Int.random(in: 1...200)
                            self.rounds += 1
                        })
                    }
                    Spacer()
                    // Slider Row
                    HStack {
                        Text("1")
                        Slider(value: $sliderValue, in: 1...200)
                        Text("200")
                    }
                    // Try Again Button Row
                    HStack {
                        Button(action: { print("Try Again Button Pressed!"); totalScore = 0; rounds = 0; self.hitNumber = Int.random(in: 1...200); sliderValue = 100.0}, label: {
                            Text("Zurücksetzen")
                                //.fontWeight(.semibold)
                                .font(.body)
                        })
                    }
                    Spacer()
                    // Score Row
                    HStack {
                        Text("Punkte:")
                        Text("\(totalScore)")
                        Spacer()
                        Text("Runden:")
                        Text("\(rounds)")
                        Spacer()
                        /*
                        Button(action: { print("Leaderboard Button Pressed!"); willMoveToLeaderboard = true}, label: {
                            Text("Rangliste")
                        })
                        */
                        NavigationLink(
                            destination: ScoreView(),
                            label: {
                                Text("Rangliste")
                            })
                            .navigationBarTitle("Rangliste")
                            .navigationBarHidden(true)
                    }
                    .padding(.top, 20)
                    .padding()
                }//.navigate(to: ContentLeaderboardView(), when: $willMoveToLeaderboard)
                .navigationBarTitle("")
                .navigationBarHidden(true)
                
                /*
                func sliderValueRounded() -> Int {
                    return Int(sliderValue.rounded())
                }
                
                func pointsForCurrentRound() -> Int {
                    return 100 - abs(hitNumber - sliderValueRounded())
                }
                */
                
            }
        }



/*
struct ContentLeaderboardView : View {
    var body: some View {
        NavigationView {
            VStack{
                Text("Rangliste")

                Text("Bottom")
            }
            
        }
        .navigationBarTitle(Text("Zurück"))
        .navigationBarHidden(false)
    }
}
*/

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 844, height: 390))
    }
}
