//
//  ViewController.swift
//  MarkdownWorkshop
//
//  Created by Matthew Barker on 9/23/18.
//  Copyright © 2018 Matt Barker. All rights reserved.
//

import UIKit

/// An object that represents a form of media within the app.
class Media {
    
    // MARK: Variables

    /// The name of the media, to be presented in cells, Now Playing, etc.
    var title: String
    
    /// The name of the artist that the media is published under.
    var artist: String
    
    /// The link to access the content. Use `convertToURL` to help set.
    var url: URL
    
    /// URL to the image used to represent the media
    var artwork: URL
    
    var type: MediaType
    
    
    // MARK: - Initializers

    
    /**
        Standard full initializer for Media.
     
        This is the full initializer for this class. There are several helper initializers that
        can be also used.
     */
    init(title: String, artist: String, url: URL, artwork: URL, type: MediaType) {
        self.title = title
        self.artist = artist
        self.url = url
        self.artwork = artwork
        self.type = type
    }
    
    
    /**
        A initializer that converts given Strings to URLs. Throws `.invalidURL`.
     
        You must make sure `url` and `artwork` is a URL!
     
        Don't mess this up, ![boi](https://i.imgur.com/HqgyPOy.jpg "breathe in")
     
     */
    convenience init(title: String, artist: String, url: String, artwork: String, type: MediaType) throws {
        do {
            guard
                let url = URL(string: url),
                let artwork = URL(string: artwork)
            else {
                throw MediaInitializerError.invalidURL
            }
            self.init(title: title, artist: artist, url: url, artwork: artwork, type: type)
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }

    
    /**
     
     Create a Media object from a JSON object.
     
     - Parameter json: A JSON object with valid scheme. See discussion below
     
     The JSON object **must** have the following schema:
     
     ```
     {
        "type"  :   "song" | "playlist" | "album" | "podcast" | "radio",
        "title" :   String
        "url"   :   String
     }
     ```
     If this isn't met, the initalizer will throw an error. Other media types have different keys,
     and these should be checked optionally!
     
     View [documentation](https://github.com/cuappdev/ithaca-transit-backend#transit-api-v1-rest-interface) for more information.
     
     */
    convenience init(json: JSON) throws {
        do {
            guard
                let url = URL(string: ""),
                let artwork = URL(string: "")
            else {
                throw MediaInitializerError.invalidURL
            }
            let song: String = "J'OUVERT"
            let artist: String = "Brockhampton"
            let type: MediaType = .song
            self.init(title: song, artist: artist, url: url, artwork: artwork, type: type)
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
    
    
    // MARK: - Computed Variables
    
    
    var description: String {
        return "\(title) by \(artist)"
    }
    
    
    // MARK: Functions
    
    /**
     
     Creates a playlist from given media.
     
     - Parameter playlistName: The name that the playlist will be called.
     - Parameter media: An array of media objects. Can be empty.
     
     - Returns
     A tuple with the new playlist Media object and an array of related Media content.
     
     This function will successfully created a playlist from the following media types
     * song
     * album
     * playlist
     
     Other media types will be ignored.
     
     ### Improvements
     
     This could be a much better data structure. Plz help!
     
    */
    func createPlaylist(named playlistName: String, from media: [Media]) -> (playlist: Media, content: [Media])? {
        
        let allowedMedia: [MediaType] = [.song, .album, .playlist]
        
        let content = media
            .filter { allowedMedia.contains($0.type) }
            .reduce(into: [Media]()) { (result, media) in
                switch media.type {
                case .song:
                    result.append(media)
                case .album, .playlist:
                    let songs = getContent(from: media)
                    result += songs
                default:
                    break
                }
            }
        
        let playlistURL = "http://mattbarker.me"
        let customPlaylistArtwork = "boi.png"
        
        do {
            
            let playlist = try Media(
                title: playlistName,
                artist: "Me",
                url: playlistURL,
                artwork: customPlaylistArtwork,
                type: .playlist
            )
            
            return (playlist, content)
        } catch _ {
            return nil
        }
        
    }
    
    func getContent(from media: Media) -> [Media] {
        // TODO: **Implement!**
        return []
    }

}

// MARK: - Helper Classes

/// Describes the type of media, typically defined by length or style.
enum MediaType {
    
    /// An individual song recorded by a musical artist.
    case song
    
    /// A podcast episode part of an existing series.
    case podcast
    
    /// A live or recorded segment that aired.
    case radio
    
    /// A collection of media from songs or albums.
    case playlist
    
    /// A collection of songs from the same source.
    case album
    
}

enum MediaInitializerError: Error {
    /// A URL is invalid, or a string that needed to be converted to a URL failed.
    case invalidURL
}

class JSON {}
