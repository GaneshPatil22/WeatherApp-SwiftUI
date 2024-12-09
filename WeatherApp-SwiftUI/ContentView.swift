//
//  ContentView.swift
//  WeatherApp-SwiftUI
//
//  Created by Ganesh Patil on 06/12/24.
//

import SwiftUI

struct WeathAppViewModel {
    let allDate: [DailyWeatherModel] = [
        .init(day: "Mon", image: "cloud.drizzle.fill", temp: "22°C"),
        .init(day: "Tue", image: "cloud.rainbow.half", temp: "20°C"),
        .init(day: "Wed", image: "cloud.sun.rain.fill", temp: "18°C"),
        .init(day: "Thur", image: "cloud.bolt.fill", temp: "20°C"),
        .init(day: "Fri", image: "cloud.moon.rain.fill", temp: "15°C"),
        .init(day: "Sat", image: "cloud.sun.rain.fill", temp: "18°C"),
        .init(day: "Sun", image: "cloud.drizzle.fill", temp: "12°C"),
    ]
}


struct TabBarView: View {
    var body: some View {
        TabView {
            WeatherAppView(city: "Indore")
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            WeatherAppView(city: "Pune")
                .tabItem {
                    Image(systemName: "pencil.circle")
                    Text("Pune")
                }
            WeatherAppView(city: "Mumbai")
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("Mumbai")
                }
            WeatherAppView(city: "Banglore")
                .tabItem {
                    Image(systemName: "lasso")
                    Text("Banglore")
                }
        }
    }
}


struct WeatherAppView: View {
    
    @State var isNight: Bool = false
    let vm = WeathAppViewModel()
    var city: String
    var isLoading: Bool = false
    
    var body: some View {
        if isLoading {
            ZStack {
                Text("Hello, World! ")
                    
            }
        } else {
            ZStack {
                BackgroundView(isNight: isNight)
                
                VStack {
                    StateTitleView(state: city)
                    
                    VStack(spacing: 8) {
                        TodayWeatherView(image: "cloud.sun.fill", temp: "28°C")
                        
                        ForEach(vm.allDate.chunked(into: 4), id: \.self) { rowItems in
                            HStack(spacing: 20) {
                                ForEach(rowItems, id: \.self) { item in
                                    DayView(day: item.day, image: item.image, temp: item.temp)
                                }
                            }
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
}

#Preview {
    TabBarView()
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
    
    var isNight: Bool
    
    var body: some View {
        LinearGradient(colors: [ isNight ? .black : .blue, isNight ? .gray : Color("lightBlue")], startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea(.all)
    }
}

struct DailyWeatherModel: Hashable {
    var day: String
    var image: String
    var temp: String
}


extension Array {
    /// Splits an array into chunks of the specified size.
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: self.count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, self.count)])
        }
    }
}
