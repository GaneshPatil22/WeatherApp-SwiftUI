//
//  ContentView.swift
//  WeatherApp-SwiftUI
//
//  Created by Ganesh Patil on 06/12/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var isNight: Bool = false
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: $isNight)
            
            VStack {
                StateTitleView(state: "Madhya Pradesh")
                
                VStack(spacing: 8) {
                    TodayWeatherView(image: "cloud.sun.fill", temp: "28°C")
                    
                    HStack(spacing: 20) {
                        DayView(day: "Mon", image: "cloud.drizzle.fill", temp: "22°C")
                        DayView(day: "Tue", image: "cloud.rainbow.half", temp: "20°C")
                        DayView(day: "Wed", image: "cloud.sun.rain.fill", temp: "18°C")
                        DayView(day: "Thru", image: "cloud.bolt.fill", temp: "20°C")
                    }
                    .padding(.bottom, 20)
                    HStack(spacing: 20) {
                        DayView(day: "Fri", image: "cloud.moon.rain.fill", temp: "15°C")
                        DayView(day: "Sat", image: "cloud.sun.rain.fill", temp: "18°C")
                        DayView(day: "Sun", image: "cloud.drizzle.fill", temp: "12°C")
                    }
                    
                    Spacer()
                    Button {
                        isNight = !isNight
                    } label: {
                        Text("Change Theme")
                            .font(.system(size: 20, weight: .bold))
                            .frame(width: 250, height: 50)
                            .foregroundStyle(.blue)
                            .background(Color.white)
                            .cornerRadius(10)
                            
                    }
                    
                    Spacer()
                }
            }
                
            
        }
    }
}

#Preview {
    ContentView()
}


struct DayView: View {
    
    var day: String
    var image: String
    var temp: String
    
    var body: some View {
        VStack {
            Text(day)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.white)

            Image(systemName: image)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            

            Text(temp)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.white)
        }
    }
}

struct TodayWeatherView: View {
    
    var image: String
    var temp: String
    
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: image)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
            
            Text(temp)
                .font(.system(size: 50, weight: .bold))
                .foregroundStyle(.white)
                .padding(.bottom, 20)
        }
    }
}

struct StateTitleView: View {
    
    var state: String
    
    var body: some View {
        Text(state)
            .font(.system(size: 40, weight: .bold))
            .foregroundStyle(.white)
    }
}

struct BackgroundView: View {
    
    @Binding var isNight: Bool
    
    var body: some View {
        LinearGradient(colors: [ isNight ? .black : .blue, isNight ? .gray : Color("lightBlue")], startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea(.all)
    }
}
