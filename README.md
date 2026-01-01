# Rick and Morty iOS App

SwiftUI take-home assignment showcasing **VIPER-inspired Clean Architecture** with **MVVM** presentation layer.

## ✅ Requirements Met

**Functional:**
- ✅ Character list with search, filters, infinite scroll
- ✅ Character detail with full information
- ✅ Loading/Error/Empty states with retry
- ✅ Search debouncing (300ms)
- ✅ Pagination resets on filter change

**Technical:**
- ✅ SwiftUI + iOS 16+
- ✅ Clean Architecture (VIPER-inspired)
- ✅ SOLID principles applied
- ✅ Constructor-based dependency injection
- ✅ 12 unit tests (deterministic, no network)
- ✅ Zero third-party dependencies

**Time:** ~3 hours

---

## 🏗 Architecture

**VIPER-Inspired + MVVM Hybrid:**
```
UI Layer (SwiftUI Views + ViewModels)
    ↓
Domain Layer (UseCases + Models)
    ↓
Data Layer (Repositories + Services + DTOs)
    ↓
Rick and Morty API
```

**Why this approach?**
- VIPER benefits (testability, separation) without boilerplate
- UseCases = Business logic (VIPER Interactor)
- ViewModels = Presentation logic (replaces VIPER Presenter)
- No Router needed (NavigationStack handles it)
- Protocol-based for easy mocking

---

## 🔗 Dependency Injection

All layers use **constructor injection with protocols:**
```swift
Service → Repository → UseCase → ViewModel → View
   ↑          ↑          ↑          ↑
Protocol   Protocol   Protocol   Protocol
```

No singletons. Easy to test. Clear dependency graph.

---

## 🧪 Testing

**12 Unit Tests:**
- `CharacterListUseCaseTests` (4 tests) → Business logic validation
- `CharacterListViewModelTests` (5 tests) → State transitions, debouncing
- `CharacterDetailUseCaseTests` (2 tests) → Fetch by ID
- `CharacterDetailViewModelTests` (4 tests) → Loading states

All tests use mocks. No real network calls.

---

## 🎨 Key Decisions

**1. Shimmer Loading States**  
Skeleton screens instead of spinners → Better UX (Instagram-style)

**2. Search Debouncing**  
300ms delay using Combine → Prevents API spam

**3. Infinite Scroll**  
Loads next page when reaching last 5 items → Smooth experience

**4. DTO → Domain Mapping**  
API models stay in Data layer → Domain is API-agnostic

---

## 🚀 Setup
```bash
# Clone and run
git clone https://github.com/juancbernier/rick-and-morty.git
open RickAndMortyApp.xcodeproj
# Press Cmd + R

# Run tests
# Press Cmd + U
```

**Requirements:** Xcode 15+, iOS 16+

---

## 📂 Structure
```
Core/
├── CharacterList/
│   ├── UI/ (Views + ViewModels)
│   ├── Domain/ (UseCases + Models)
│   └── Data/ (Repositories + Services + DTOs)
└── CharacterDetail/
    └── (same structure)

Shared/
└── Views/ (Reusable components)

Tests/
├── CharacterListTests/
├── CharacterDetailTests/
└── Mocks/
```

**Stats:** ~1,500 LOC, 0 dependencies, 4 architectural layers

---

## 🔮 Next Steps

With more time I would add:
1. Offline caching (CoreData)
2. UI/Snapshot tests
3. Better error handling (retry with backoff)
4. Accessibility improvements
5. Analytics integration

---

## 👨‍💻 Author

**Juan Bernier** - iOS Developer  
[@juancbernier](https://github.com/juancbernier) • [LinkedIn](https://linkedin.com/in/juan-bernier)

---

Built with SwiftUI, Clean Architecture, and professional iOS practices.
