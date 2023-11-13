//
//  NetworkTraceRouter.swift
//  NetworkDetecter
//
//  Created by winters on 2023/11/12.
//

import Foundation

import SwiftyPing
import SwiftUI
import Charts


struct NetworkTraceRouter: View {
    @State private var results = "";
    
   
    private func click(){
        print("start trace")
        SimpleTracer.trace(host: "114.114.114.114",
                           maxTraceTTL: 15) { result in
            print(result)
            results += result
        }
    }
    

    var body: some View {
        VStack(content: {
            Text("Result:" + results )
            Button("Trace", action: click)
        })
                .padding()
    }
}

