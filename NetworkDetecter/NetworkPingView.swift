//
//  NetworkPingView.swift
//  NetworkDetecter
//
//  Created by winters on 2022/12/4.
//

import SwiftyPing
import SwiftUI
import Charts


struct NetworkPingView: View {

    @State private var result = 0;

    @State private var totalCostTime = 0;

    @State private var pingTotalCount = 0;

    @State private var pingResults: [PingResultData] = [];

    @State private var pingToggle: Bool = false;

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect();


    func ping() {
        if (!pingToggle) {
            return
        }
        let once = try? SwiftyPing(host: "c35s3.jamjams.net",
                configuration: PingConfiguration(interval: 0.5, with: 5), queue: DispatchQueue.global())
        once?.observer = { (response) in
            let duration = response.duration
            print(duration)
            result = (duration * 1000).clean
            totalCostTime += result
            if (pingResults.count > 10) {
                pingResults.remove(at: 0)
            }
            pingTotalCount += 1;
            pingResults.append(PingResultData(count: pingTotalCount, costTime: duration))
        }
        once?.targetCount = 1
        try? once?.startPinging()
    }

    func togglePing() {
        pingToggle.toggle()
    }

    var body: some View {
        VStack(content: {
            Chart {
                ForEach(pingResults.indices, id: \.self) { idx in
                    LineMark(
                            x: .value("Count", idx),
                            y: .value("CostTime", (pingResults[idx].time * 1000).clean)
                    )
                }
            }
                    .frame(height: 300)
                    .onReceive(timer) {
                        time in
                        ping()
                    }
            Button("Ping", action: togglePing)
            Text("LATEST ping:" + String(result) + "ms")
            Text("AVG ping:" + String(pingTotalCount == 0 ? 0 : totalCostTime / pingTotalCount) + "ms")
        })
                .padding()
                .onDisappear { pingToggle = false }
    }
}


extension Double {

    var clean: Int {
        Int(String(format: "%.0f", self)) ?? 0
    }
}
