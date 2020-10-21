//
//  ContentView.swift
//  Notifications-Demo
//
//  Created by Stevhen on 21/10/20.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    
    @State var show = false
    
    func sendNotification() {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _,_ in
            
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Message"
        content.body = "Learning Notification"
        
        let open = UNNotificationAction(identifier: "open", title: "Open", options: .foreground)
        let cancel = UNNotificationAction(identifier: "cancel", title: "Cancel", options: .destructive)
        let categories = UNNotificationCategory(identifier: "action", actions: [open, cancel], intentIdentifiers: [])
            
        UNUserNotificationCenter.current().setNotificationCategories([categories])
        
        content.categoryIdentifier = "action"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "request", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                
                NavigationLink(destination: Detail(show: self.$show), isActive: self.$show) {
                    Text("")
                }
                
                Button(action: {
                    sendNotification()
                }, label: {
                    Text("Send Notification")
                })
                
            }
            .onAppear {
                NotificationCenter.default.addObserver(forName: NSNotification.Name("Detail"), object: nil, queue: .main) { _ in
                    self.show.toggle()
                }
            }
            .padding()
            
            .navigationTitle("Home")
        }
    }
}

struct Detail: View {
    
    @Binding var show: Bool
    
    var body: some View {
        Text("Detail")
            
        .navigationTitle("Detail View")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            
            Button(action: {
                self.show.toggle()
            }, label: {
                Image(systemName: "arrow.left")
                    .font(.title)
            })
                            
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
