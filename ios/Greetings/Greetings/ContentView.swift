//
//  ContentView.swift
//  Greetings
//
//  Created by Artem Kovardin on 07.10.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    private let greepings = RustGreetings();

    var body: some View {
        Text("\(greepings.sayHello(to: "Rust"))")
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
