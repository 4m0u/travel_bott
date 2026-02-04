 Kısa Not:> "Bu dosya, Bölüm 2: Proje Ana Planı ve Mimari Yapılandırma dokümanı temel alınarak oluşturulmuştur. Temel amaç; AI Agent'ın kod yazımı, mimari katmanlama (DDCA) ve teknoloji yığını konularında projeye tam uyumlu hareket etmesini sağlamaktır. Dokümandan alınan verilerle .md formatında bir 'Kurallar Manifestosu' hazırlanmış ve Agent'ın çalışma dizinine eklenmiştir."

 Vizyon & Tech Stack: Flutter 3.38.9 ve Dart 3.10.8 sürümlerine sadık kalınması.
DDCA Mimari: Domain, Data, Application ve Presentation katmanlarının kesin sınırları.
Kod Disiplini: very_good_analysis linter kuralları ve FpDart ile fonksiyonel hata yönetimi.
GenUI Akışı: AI'dan gelen JSON verisinin dinamik widget'lara (HotelCard, RouteWidget vb.) dönüşüm stratejisi.

# TravelBot MVP - Constitution (Kurallar Manifestosu)

## 1. Proje Vizyonu [Sayfa 1.1 - Proje Amacı]

Kullanıcının doğal dildeki taleplerini (örn: "Roma'da butik otel bul") anlayıp, bunu sadece metin olarak değil; etkileşimli kartlar, rezervasyon butonları ve canlı rotalar olarak sunan bir yapay zeka asistanı üretmek.

## 2. Tech Stack (Kesin Kurallar)

* **Framework:** Flutter 3.38.9 (stable)
* **Language:** Dart 3.10.8 (stable)
* **IDE:** Antigravity (AI-Native Development Environment)
* **State Management:** Flutter BLoC (Event-based approach)
* **Navigation & DI:** GoRouter & GetIt / Injectable
* **Error Handling:** FpDart (Either tipi)
* **Validation:** Formz
* **Linter:** `very_good_analysis` (Sıfır uyarı)

---

## 3. Mimari Katmanlar (DDCA - Domain-Driven Clean Architecture)

### 3.1 Domain Layer (Pure Dart - NO FLUTTER IMPORTS)

**Kurallar:**

* Hiçbir Flutter kütüphanesi import edilemez.
* Hiçbir external package bağımlılığı olmaz (`equatable`, `fpdart` hariç).
* **Entities:** Immutable, Equatable kullanır.
* **Value Objects:** Değişmez küçük veri parçaları.
* **Repositories:** Sadece abstract interfaces (no implementation).
* **Schemas:** `json_schema_builder` ile AI kontratları.

**Dosya Yapısı (Layer-First):**

```text
lib/domain/
├── chat/
│   ├── entities/
│   │   ├── message.dart
│   │   └── chat_session.dart
│   └── repositories/
│       └── i_chat_repository.dart
├── trip/
│   ├── entities/
│   │   ├── trip.dart
│   │   └── destination.dart
│   ├── repositories/
│   │   └── i_trip_repository.dart
│   └── schemas/
│       ├── trip_schema.dart
│       └── destination_schema.dart
├── user/
│   ├── entities/
│   │   └── user.dart
│   ├── repositories/
│   │   └── i_user_repository.dart
│   └── value_objects/
│       ├── email.dart
│       └── password.dart
└── core/
    └── failures/
        └── failure.dart

```

### 3.2 Application Layer (Use Cases + BLoC)

**Kurallar:**

* **Use Cases:** Tek bir işi yapan, Repository'leri çağıran sınıflar.
* **BLoC:** State/Event pattern, use case'leri çağırır.
* **Hata yönetimi:** `Either<Failure, Success>` döner.

**Dosya Yapısı (Layer-First):**

```text
lib/application/
├── chat/
│   ├── bloc/
│   │   ├── chat_bloc.dart
│   │   ├── chat_event.dart
│   │   └── chat_state.dart
│   └── usecases/
│       ├── send_message_usecase.dart
│       └── get_chat_history_usecase.dart
├── trip/
│   └── usecases/
│       └── generate_itinerary_usecase.dart
└── auth/
    └── bloc/
        ├── auth_bloc.dart
        └── auth_event.dart

```

### 3.3 Infrastructure Layer (Firebase, Models, DataSources)

**Kurallar:**

* **DataSources:** Remote (Firebase) servis çağrıları.
* **Models:** `json_serializable` ile JSON dönüşümü.
* **Repositories (Impl):** Domain'deki arayüzlerin somut kodları.
* Firebase Auth, Firestore, `firebase_ai` SDK'sı kullanılır.

**Dosya Yapısı (Layer-First):**

```text
lib/infrastructure/
├── chat/
│   ├── datasources/
│   │   ├── firebase_chat_datasource.dart
│   │   └── firebase_ai_datasource.dart
│   ├── models/
│   │   └── message_model.dart
│   └── repositories/
│       └── chat_repository_impl.dart
├── trip/
│   ├── models/
│   │   ├── trip_model.dart
│   │   └── destination_model.dart
│   └── repositories/
│       └── trip_repository_impl.dart
├── user/
│   ├── datasources/
│   │   └── firebase_user_datasource.dart
│   ├── models/
│   │   └── user_model.dart
│   └── repositories/
│       └── user_repository_impl.dart
└── core/
    └── firebase_injectable_module.dart

```

### 3.4 Presentation Layer (GenUI + Flutter Widgets)

**Kurallar:**

* **GenUI Components:** AI'dan gelen veriye göre anlık render edilen widget'lar.
* **Widgets:** Stateless ve BLoC listener'lar ile state yönetimi.
* **UI Helpers:** `flutter_animate`, `flutter_markdown_plus` entegrasyonları.

**Dosya Yapısı (Layer-First):**

```text
lib/presentation/
├── pages/
│   ├── chat/
│   │   ├── chat_detail_page.dart
│   │   └── home_page.dart
│   └── auth/
│       ├── login_page.dart
│       └── signup_page.dart
├── widgets/
│   ├── genui_components/
│   │   ├── route_widget.dart
│   │   ├── destination_card.dart
│   │   ├── hotel_card.dart
│   │   └── ticket_card.dart
│   └── common/
│       ├── message_bubble.dart
│       ├── loading_indicator.dart
│       └── error_widget.dart
└── core/
    └── app_router.dart

```

---

## 4. Kod Disiplini

### 4.1 Linter Kuralları

* `very_good_analysis`: Sıfır uyarı/bilgi çizgisi.
* **Komut:** `flutter analyze` (0 hata döndürmelidir).

### 4.2 Hata Yönetimi

* FpDart `Either<Failure, Success>` pattern kullanılır.
* Tüm async operasyonlar `Either` döner.
* **Failure types:** `AuthFailure`, `NetworkFailure`, `ValidationFailure`, `ServerFailure`.

### 4.3 Naming Conventions

* **Variables:** camelCase (e.g., `userName`, `chatHistory`)
* **Classes:** PascalCase (e.g., `UserEntity`, `ChatRepository`)
* **Constants:** UPPER_SNAKE_CASE (e.g., `MAX_RETRY_COUNT`)
* **Files:** snake_case (e.g., `user_entity.dart`, `chat_bloc.dart`)
* **Enums:** PascalCase (e.g., `MessageRole`, `ChatStatus`)

### 4.4 Form Validation

* `Formz` package ile input validation.
* **Inline validation:** Kullanıcı yazarken anlık hata gösterimi.
* **Regex patterns:**
* Email: `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$`
* Password: Min. 6 karakter, en az 1 harf + 1 sayı.

---

## 5. Git & Branch Stratejisi

* **main:** Sadece kararlı sürümler (Production).
* **dev:** Entegrasyon ve ana geliştirme dalı.
* **feature/*:** Yeni özellik dalları (Merge öncesi `dart analyze` geçmelidir).
* **Commit Formatı:** `feat:`, `fix:`, `docs:`, `refactor:`.

---

## 6. AI & GenUI Bileşenleri

### 6.1 Paket Rolleri

| Paket | Rol | Fonksiyonel Görevi |
| --- | --- | --- |
| **firebase_ai** | Motor (Logic) | Gemini modelleriyle iletişim |
| **genui** | Orkestra Şefi | AI JSON'unu Flutter Widget'larına dönüştürme |
| **genui_firebase_ai** | Adaptör (Bridge) | `genui` ve `firebase_ai` arasındaki veri akışı |
| **json_schema_builder** | Kontrat Yazarı | AI'a verilecek veri kontratları (Schema) |

### 6.2 GenUI Akışı

1. **Talimat Gelir:** Bot, cevabıyla birlikte bir "tip" belirteci gönderir (Örn: `tip: "rota_cizimi"`).
2. **Karar Verilir:** Flutter uygulaması bu tipi okur ve uygun widget'ı seçer.
3. **İnşa Edilir:** Boş şablon (Widget), botun gönderdiği verilerle doldurulur ve ekrana basılır.

### 6.3 GenUI Component Türleri

* **RouteWidget:** Durakları ve rotaları görselleştiren widget.
* **DestinationCard:** Lokasyon önerileri (fotoğraf, hava durumu, "Oraya Git" butonu).
* **HotelCard:** Otel önerileri (fiyat, yıldız, rezervasyon butonu).
* **TicketCard:** Uçak/otobüs biletleri (fiyat, saat, "Satın Al" butonu).

---

## 7. Notion MCP Entegrasyonu

* Notion'daki PRD'den veri modeli otomatik olarak Entity'lere dönüştürülür.
* Notion'daki API endpoints tanımları, Repository interface'lerine dönüştürülür.
* Notion'daki validation rules'ları, Domain value objects'lerine dönüştürülür.

## 8. Stitch MCP Entegrasyonu

* Stitch'ten gelen UI tasarımları, GenUI components'lerine dönüştürülür.
* Tasarım wireframe'leri, Flutter widget şablonlarına dönüştürülür.

## 9. Hata Yönetimi Stratejisi

* **Try-catch:** Sadece Firebase operasyonlarında kullanılır.
* **Either<Failure, Success>:** Tüm use case'lerde kullanılır.
* **Failure types:**
* `AuthFailure`: Kimlik doğrulama hataları
* `NetworkFailure`: Ağ bağlantı hataları
* `ValidationFailure`: Form doğrulama hataları
* `ServerFailure`: Firebase/API hataları
* `CacheFailure`: Yerel depolama hataları

## 10. Testing Stratejisi

* **Unit Tests:** Domain layer (Pure Dart)
* **Widget Tests:** Presentation layer (UI components)
* **Integration Tests:** Firebase operasyonları
* **Komut:** `flutter test` (Tüm testler geçmelidir)

## 11. Performance & Optimization

* **Message history pagination:** 20 mesaj/sayfa
* **Image caching:** `flutter_cache_manager`
* **Lazy loading:** `ListView.builder`
* **Debouncing:** Arama ve mesaj gönderme operasyonları

## 12. Security Rules (Firebase)

* **Users collection:** Sadece kendi verilerine erişebilir.
* **Chats collection:** Sadece chat sahibi okuyabilir/yazabilir.
* **Messages subcollection:** Sadece chat sahibi okuyabilir/yazabilir.


