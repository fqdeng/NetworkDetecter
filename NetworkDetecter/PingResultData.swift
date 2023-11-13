//
// Created by winters on 2022/12/4.
//

import Foundation

struct PingResultData: Identifiable {
    let id = UUID()
    let count: Int
    let time: Double

    init(count: Int, costTime:Double) {
        self.count = count;
        time = costTime
    }
}