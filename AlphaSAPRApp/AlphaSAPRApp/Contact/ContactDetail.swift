//
//  ContactDetail.swift
//  AlphaSAPRApp
//
//  Created by Alex Hernandez on 3/23/21.
//

import SwiftUI

struct ContactDetail: View {
    @State private var NameVal: String = ""
    @State private var NumberVal: String = ""
    @State var passedContact: Contact
    @State var passedList : [Contact]
    
//    var contactIndex: Int {
//        modelData.myContacts.firstIndex(where: { $0.id == passedContact.id })!
//    }
    
    var body: some View {
        
       
        VStack{
            HStack{
                //Contact Name
                Spacer()
                Text("Name:")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                
                TextField(passedContact.name, text: $NameVal)
                    .padding(.leading)
                
            }
            .padding()
            HStack {
                Text("Phone Number:")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                Spacer()
                TextField(passedContact.phoneNumber, text: $NumberVal)
                    .padding(.leading)
            }
            .padding()
            
            HStack{
                Spacer()
            
                //Update Contact
                Button(action: {
                    //Update
                    if (NameVal != "") {
                        //modelData.myContacts[contactIndex].name = NameVal
                        passedContact.name = NameVal
                    }
                    if (NumberVal != "") {
                        passedContact.phoneNumber = NumberVal
                        //modelData.myContacts[contactIndex].phoneNumber = NumberVal
                    }
                    
                    do {
                        let encoder = JSONEncoder()
                        passedList[passedContact.id] = passedContact
                        let data = try encoder.encode(passedList)
                        UserDefaults.standard.set(data, forKey: "contact")
                    } catch {
                        print("error")
                    }
                    
                }, label: {
                    Text("Update")
                })
                Spacer()
            
                //Delete Contact
                DeleteButton(passedContact: passedContact, passedList: passedList)
                
                Spacer()
            }
            //Spacer()
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//struct ContactDetail_Previews: PreviewProvider {
//    static let modelData = ModelData()
//
//    static var previews: some View {
//        ContactDetail(passedContact: modelData.myContacts[0])
//            .environmentObject(modelData)
//            //.previewLayout(.fixed(width: 300, height: 40))
//    }
//}
//
