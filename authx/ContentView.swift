//
//  ContentView.swift
//  authx
//
//  Created by Raees on 06/06/2020.
//  Copyright © 2020 SteelBrain LLC. All rights reserved.
//

import SwiftUI

struct Credential {
    var Id: UUID
    var Issuer: String
    var AccountName: String
    var Key: String
}

struct CredentialRow: View {
    var credential: Credential

    var body: some View {
        HStack {
            Image(systemName: "icloud.fill")
                .resizable()
                .frame(maxWidth: 40, maxHeight: 40)
                .padding()
                .aspectRatio(contentMode: .fit)
            VStack (alignment: .leading, spacing: 8) {
                Text(credential.Issuer)
                    .font(.headline)
                Text(credential.AccountName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct CredentialsList: View {
    var credentialsData: Array<Credential>
    var body: some View {
        List(credentialsData, id: \.Id) { credential in
            CredentialRow(credential: credential)
        }
    }
}

struct SheetView: View {
    @Binding var showSheetView: Bool

    var body: some View {
        NavigationView {
            Text("New Credentials")
            .navigationBarTitle(Text("Add new credentials"), displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    print("Dismissing sheet view...")
                    self.showSheetView.toggle()
                }) {
                    Text("Done").bold()
                })
        }
    }
}

struct ContentView: View {
    @State private var selection = 0
    @State var showSheetView = false
    @State var credentialsData = [
        Credential(Id: UUID.init(), Issuer: "Google", AccountName: "Something", Key: ""),
        Credential(Id: UUID.init(), Issuer: "Twitter", AccountName: "Something", Key: ""),
        Credential(Id: UUID.init(), Issuer: "Facebook", AccountName: "Something", Key: ""),
        Credential(Id: UUID.init(), Issuer: "Github", AccountName: "Something", Key: ""),
    ]
    @State var activeCredential: Credential = nil
 
    var body: some View {
        TabView(selection: $selection){
            NavigationView {
                VStack{
                    Group {
                        VStack (alignment: .center, spacing: 4) {
                            Text("Google")
                                .font(.headline)
                            Text("Something")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Text("123 456").font(.system(.largeTitle, design: .monospaced)).bold()
                    }
                    CredentialsList(credentialsData: credentialsData)
                }
                .navigationBarItems(trailing: Button(action: {
                    self.showSheetView.toggle()
                }) {
                    Image(systemName: "plus")
                }).sheet(isPresented: $showSheetView) {
                    SheetView(showSheetView: self.$showSheetView)
                }
            }
                .tabItem {
                    VStack {
                        Image(systemName: "lock.shield")
                        Text("Credentials")
                    }
                }
                .tag(0)
            Text("Second View")
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                }
                .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
