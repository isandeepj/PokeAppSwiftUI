# PokeAppSwiftUI

PokeAppSwiftUI is a simple SwiftUI application that fetches and displays a list of Pokemon using the [PokéAPI](https://pokeapi.co/). The app allows users to view Pokemon details and sort the list by name or ID.

## Features

- Fetch and display a list of 100 Pokemon.
- View Pokemon details including name, ID, base experience, height, weight, abilities, types, and stats.
- Sort the Pokemon list by name or ID.
- Display Pokemon sprites in a grid.
- Cache data for offline use (optional).
- Pagination to fetch more Pokemon (optional).

## Prerequisites

- Xcode 15.3 or later.
- iOS 16.0 or later.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/isandeepj/PokeAppSwiftUI.git

2. Open the project in Xcode
   ```bash
    cd PokeAppSwiftUI
    open PokeAppSwiftUI.xcodeproj   
3. Build and run the project on the simulator or a physical device


# Architecture Overview

### Models
- **PokemonSummary**: Represents a summary of a Pokemon with properties for name and URL.
- **Pokemon**: Represents detailed information about a Pokemon, including base experience, height, weight, abilities, types, stats, and sprites.
- **PokemonListResponse**: Represents the response from the Pokemon list endpoint.

### View Models
- **PokemonListViewModel**: Manages the state and logic for the Pokemon list view. Handles fetching Pokemon, sorting, and pagination.
- **PokemonDetailViewModel**: Manages the state and logic for the Pokemon detail view. Handles fetching detailed information about a selected Pokemon.

### Views
- **PokemonListView**: Displays a list of Pokemon with sorting options.
- **PokemonDetailView**: Displays detailed information about a selected Pokemon.
- **SpritesGridView**: Displays a grid of Pokemon sprites.
- **PokemonInfoView**: Displays basic information about a Pokemon.
- **PokemonHeaderView**: Displays the header with the Pokemon name and ID.
- **AsyncImageView**: Loads and displays images asynchronously.
