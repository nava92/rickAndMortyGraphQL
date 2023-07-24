//
//  CharacterDetailView.swift
//  RickAndMortyGraphQL
//
//  Created by Eduardo Navarrete Carmona on 22/07/23.
//

import SwiftUI
import Apollo
import Kingfisher

struct CharacterDetailView: View {
    
    @StateObject private var query: SingleQuery<GetCharacterQuery>
    var character: CharacterFull? {
        query.data?.character?.fragments.characterFull
    }
    
    init(id: GraphQLID) {
        _query = StateObject(wrappedValue: SingleQuery(query: GetCharacterQuery(id: id)))
    }
    
    
    var body: some View {
        ScrollView {
            VStack {
                if let image = character?.image, let url = URL(string: image) {
                    KFImage(url)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .shadow(color: Color.black.opacity(0.3), radius: 6, x: 0, y: 3)
                        .padding(.horizontal)
                        .redacted(reason: character == nil ? .placeholder : [])
                }
                
                Text(character?.name ?? "")
                    .font(.title)
                    .fontWeight(.black)
                    .redacted(reason: character == nil ? .placeholder : [])
                    .multilineTextAlignment(.center)
                    .padding()
                
                HStack(alignment: .center) {
                    VStack {
                        Text("SPECIES")
                            .fontWeight(.bold)
                        Text(character?.species ?? "Unknown")
                            .redacted(reason: character == nil ? .placeholder : [])
                    }
                    .padding()
                    VStack {
                        Text("GENDER")
                            .fontWeight(.bold)
                        Text(character?.gender ?? "Unknown")
                            .redacted(reason: character == nil ? .placeholder : [])
                    }
                    .padding()
                    VStack {
                        Text("STATUS")
                            .fontWeight(.bold)
                        Text(character?.status ?? "Unknown")
                            .redacted(reason: character == nil ? .placeholder : [])
                    }
                    .padding()
                }
                .padding(8)

                HStack(alignment: .center) {
                    VStack {
                        Text("LOCATION")
                            .fontWeight(.bold)
                        Text(character?.location?.name ?? "Unknown")
                            .redacted(reason: character == nil ? .placeholder : [])
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    VStack {
                        Text("ORIGIN")
                            .fontWeight(.bold)
                        Text(character?.origin?.name ?? "Unknown")
                            .redacted(reason: character == nil ? .placeholder : [])
                            .multilineTextAlignment(.center)
                    }
                }
                .padding(8)
            }

            Text("EPISODES")
                .font(.title)
                .fontWeight(.medium)
                .foregroundColor(.accentColor)
                .padding()
            if let episodes = character?.episode.compactMap({$0}) {
                ForEach(episodes, id: \.id) { episode in
                    VStack {
                        Text(episode.name ?? "")
                            .font(.body)
                            .foregroundColor(.gray)
                        Divider()
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("")
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView(id: GraphQLID(1))
    }
}
