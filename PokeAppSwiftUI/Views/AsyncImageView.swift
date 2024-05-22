//
//  AsyncImageView.swift
//  PokeAppSwiftUI
//
//  Created by Sandeep on 22/05/24.
//

import SwiftUI
import Combine

struct AsyncImageView: View {
    @StateObject private var loader: ImageLoader
    
    init(url: URL) {
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if loader.isLoading {
                ProgressView()
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            loader.loadImage()
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading = false
    @Published var isUnsupportedFormat = false
    
    private let url: URL
    private var cancellable: AnyCancellable?
    
    init(url: URL) {
        self.url = url
        loadImage()
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func loadImage() {
        let fileExtension = url.pathExtension.lowercased()
        guard ["png", "jpeg", "jpg"].contains(fileExtension) else {
            isUnsupportedFormat = true
            return
        }
        isLoading = true
        
        if let cachedImage = ImageCache.shared.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
            self.isLoading = false
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                if let image = $0 {
                    ImageCache.shared.setObject(image, forKey: self?.url.absoluteString as NSString? ?? "")
                    self?.image = image
                }
                self?.isLoading = false
            }
    }
}

class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}
