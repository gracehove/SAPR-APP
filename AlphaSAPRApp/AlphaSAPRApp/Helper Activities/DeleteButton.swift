//
//  DeleteButton.swift
//  AlphaSAPRApp
//
//  Created by Alex Hernandez on 3/23/21.
//

import SwiftUI

struct DeleteButton: View {
    @State var passedContact : Contact
    @State var passedList : [Contact]
    
    var body: some View {
        Button(action: {
            do {
                let encoder = JSONEncoder()
                passedList.remove(at: passedContact.id)
                for (index, contact) in passedList.enumerated() {
                    print(index)
                    if(passedContact.id < contact.id) {
                        passedList[index].id = contact.id - 1
                    }
                        
                }
                let data = try encoder.encode(passedList)
                UserDefaults.standard.set(data, forKey: "contact")
            } catch {
                print("error")
            }
        }) {
            HStack{
                Text("Delete")
                Image(systemName: "trash")
            }
            .padding(7)
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(15)
        }
    }
}

//struct DeleteButton_Previews: PreviewProvider {
//    static var previews: some View {
//        DeleteButton(isSet: .constant(true))
//    }
//}
