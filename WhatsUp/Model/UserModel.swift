//
//  UserModel.swift
//  WhatsUp
//
//  Created by python on 06/11/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

@MainActor
class UserModel: ObservableObject{
    
    @Published var groups: [Group] = []
    @Published var chatMessages: [ChatMessage] = []
    
    var firestoreListener: ListenerRegistration?
    
    func updateDisplayName(for user: User, displayName: String ) async throws{
        let request = user.createProfileChangeRequest()
        request.displayName = displayName
        try? await request.commitChanges()
    }
    
    
    func saveGroup(group: Group, completion: @escaping (Error?) -> Void){
        
        let db = Firestore.firestore()
        var docRef: DocumentReference? = nil
        docRef = db.collection("groups")
//            .addDocument(data: ["subject": group.subject])
            .addDocument(data: group.toDictionary()){ [weak self] error in
                
                if error != nil{
                    completion(error)
                }
                else{
                    if let docRef {
                        var newGroup = group
                        newGroup.documentId = docRef.documentID
                        self?.groups.append(newGroup)
                        completion(nil)
                    }
                    else{
                        completion(nil)
                    }
                }
      
            }
    }
    
    
    func populateGroups() async throws{
        
        let db = Firestore.firestore()
        let snapshot = try await db.collection("groups")
            .getDocuments()
        
        groups = snapshot.documents.compactMap { snapshot in
            Group.fromSnapshot(snapshot: snapshot)
        }
    }
    
    
//    func saveChatMessageToGroup(text: String, group: Group, completion: @escaping (Error?) -> Void){
//        
//        let db = Firestore.firestore()
//        guard let groupDocumentId = group.documentId else{ return }
//        
//        db.collection("groups")
//            .document(groupDocumentId)
//            .collection("message")
//            .addDocument(data: ["chatText": text]){ error in
//                completion(error)
//            }
//    }
    
    func saveChatMessageToGroup(chatMessage: ChatMessage, group: Group) async throws{
        
        let db = Firestore.firestore()
        guard let groupDocumentId = group.documentId else { return }
        
        let _ = try await db.collection("groups")
            .document(groupDocumentId)
            .collection("messages")
            .addDocument(data: chatMessage.toDictonary())
    }
    
    
    func detachFirebaseListerner(){
        self.firestoreListener?.remove()
    }
    
    func listenForChatMeassages(in group: Group){
        
        let db = Firestore.firestore()
        chatMessages.removeAll()
        
        guard let groupDocumentId = group.documentId else { return }
        
        self.firestoreListener = db.collection("groups")
            .document(groupDocumentId)
            .collection("messages")
            .order(by: "dateCreated", descending: false)
            .addSnapshotListener({ [weak self] snapshot, error in
                
                guard let snapshot = snapshot else{
                    print("Error fetching Snapshots: \(error)")
                    return
                }
                
                snapshot.documentChanges.forEach { diff in
                    
                    if diff.type == .added{
                        let chatMessage = ChatMessage.fromSnapshot(snapshot: diff.document)
                        if let chatMessage{
                            let exitst = self?.chatMessages.contains(where: { cm in
                                cm.documentId == chatMessage.documentId
                            })
                            if !exitst! {
                                self?.chatMessages.append(chatMessage)
                            }
                        }
                    }
                }
            })
    }
    
}
