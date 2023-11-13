//
// Created by winters on 2022/12/11.
//

import Foundation
import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView(content: {
            ChooseView()
                    .navigationBarTitle(Text("Network Tools"))
        })
    }
}

struct ChooseView: View {
    var body: some View {
        List {
            Section(header: Text("Servers")) {
                ChooseServerView()
            }
            Section(header: Text("Tools")) {
                ChooseRowView(title: "Ping", logo: Image(systemName: "link"), content: NetworkPingView())
                ChooseRowView(title: "Trace Route", logo: Image(systemName: "target"), content: NetworkTraceRouter())
                ChooseRowView<NotInitView>(title: "DNS Lookup", logo: Image(systemName: "eye.circle"))
                ChooseRowView<NotInitView>(title: "Port Scan", logo: Image(systemName: "magnifyingglass"))
                ChooseRowView<NotInitView>(title: "Server Monitor", logo: Image(systemName: "s.circle"))
                ChooseRowView<NotInitView>(title: "LAN Scan", logo: Image(systemName: "network"))
                ChooseRowView<NotInitView>(title: "WiFi Signal", logo: Image(systemName: "wifi.circle"))
                ChooseRowView<NotInitView>(title: "Cellular Signal", logo: Image(systemName: "antenna.radiowaves.left.and.right.circle"))
            }
            Section(header: Text("Settings")) {
                ChooseRowView<NotInitView>(title: "Edit Servers", logo: Image(systemName: "network"))
            }
            Section(header: Text("Others")) {
                ChooseRowView<NotInitView>(title: "About", logo: Image(systemName: "info.circle"))
            }
        }
    }
}

struct ChooseServerView: View {
    var body: some View {
        Text("Choose Server")
    }
}

//pass a view to ChooseRowView  to show the detail view
struct ChooseRowView<Content: View>: View {
    var title: String
    var logo: Image
    var content: Content?

    var body: some View {
        NavigationLink(destination: content ?? NotInitView() as! Content) {
            HStack {
                logo
                Text(title)
            }
        }
    }
}

//simple view for test

struct NotInitView: View {
    var body: some View {
        Text("Not implemented")
    }
}


struct PersonUIView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
