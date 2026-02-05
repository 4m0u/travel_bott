# 🌍 TravelBot MVP

**TravelBot**, Flutter ile geliştirilmiş premium, yapay zeka-yerel (AI-native) bir seyahat asistanıdır. Üretken yapay zekanın gücünü kullanarak doğal dildeki talepleri etkileşimli deneyimlere dönüştürür; kullanıcılara dinamik otel kartları, rota görselleştirmeleri ve rezervasyon seçenekleri sunar.

---

## 🚀 Vizyon
Kullanıcıların ihtiyaçlarını sadece anlatarak (örneğin: *"Roma'da butik bir otel bul"*) planlayabildikleri, asistanın sadece metinle değil, anlamlı ve aksiyon alınabilir kullanıcı arayüzü (UI) bileşenleriyle yanıt verdiği kusursuz bir seyahat planlama deneyimi oluşturmak.

## 🛠️ Teknoloji Yığıtı
- **Framework:** [Flutter](https://flutter.dev) 3.38.9
- **Dil:** [Dart](https://dart.dev) 3.10.8
- **Durum Yönetimi:** [Flutter BLoC](https://pub.dev/packages/flutter_bloc) (Olay tabanlı)
- **Bağımlılık Enjeksiyonu:** [GetIt](https://pub.dev/packages/get_it) & [Injectable](https://pub.dev/packages/injectable)
- **Navigasyon:** [GoRouter](https://pub.dev/packages/go_router)
- **Backend:** [Firebase](https://firebase.google.com) (Auth, Firestore, AI SDK)
- **Fonksiyonel Programlama:** [FpDart](https://pub.dev/packages/fpdart) (`Either` ile hata yönetimi)
- **Doğrulama:** [Formz](https://pub.dev/packages/formz)
- **Linter:** `very_good_analysis`

---

## 🏗️ Mimari (DDCA)
Bu proje, endişelerin kesin olarak ayrılmasını ve yüksek test edilebilirliği sağlayan **Domain-Driven Clean Architecture (DDCA)** prensiplerini takip eder.

### 1. Domain Katmanı (Saf Dart)
*Çekirdek iş mantığı ve kuralları.*
- **Entities:** Değişmez (Immutable) veri modelleri (`Equatable` kullanarak).
- **Repositories:** Veri operasyonları için soyut arayüzler.
- **Failures:** Standartlaştırılmış hata türleri.
- *Kesin Kural: Bu katmanda Flutter kütüphaneleri kullanılamaz.*

### 2. Application Katmanı
*İş akışının orkestrasyonu.*
- **Use Cases:** Belirli bir eylemden sorumlu tek amaçlı sınıflar.
- **BLoC:** UI ve veri katmanları arasındaki durum geçişlerini yönetir.

### 3. Infrastructure Katmanı
*Dış entegrasyonlar ve veri uygulamaları.*
- **DataSources:** Uzak (Firebase) ve yerel servis çağrıları.
- **Models:** JSON serileştirme özellikli veri transfer nesneleri.
- **Repository Implementation:** Domain arayüzleri için somut mantıklar.

### 4. Presentation Katmanı
*Kullanıcı arayüzü ve GenUI bileşenleri.*
- **Pages:** Tam ekran görünümler.
- **GenUI Bileşenleri:** Yapay zeka yanıtlarına göre anlık oluşturulan widget'lar (örn: `RouteWidget`, `HotelCard`).
- **Widgets:** Tekrar kullanılabilir UI elemanları ve yardımcı bileşenler.

---

## 🤖 GenUI Akışı
1. **Talep:** Kullanıcı seyahatle ilgili bir soru sorar.
2. **AI Çıkarımı:** Backend (Gemini via `firebase_ai`) talebi işler ve bir "tip" belirteci içeren yapılandırılmış JSON döner.
3. **Dinamik Oluşturma:** Uygulama tipi tanımlar (örn: `hotel_card`) ve gelen verilerle ilgili `GenUI` bileşenini ekrana basar.

---

## 📂 Proje Yapısı
```text
lib/
├── domain/           # Çekirdek mantık ve Arayüzler (Saf Dart)
├── application/      # BLoC ve Use Case'ler
├── infrastructure/   # Firebase, Modeller, Repository Uygulamaları
└── presentation/     # GenUI Bileşenleri, Sayfalar, Widget'lar
```

---

## 📦 Başlangıç

### Ön Koşullar
- Flutter SDK (3.38.9)
- Dart SDK (3.10.8)
- Firebase Hesabı ve CLI

### Kurulum
1.  **Projeyi klonlayın:**
    ```bash
    git clone https://github.com/your-repo/travel_bott.git
    cd travel_bott/travel_bott
    ```
2.  **Bağımlılıkları yükleyin:**
    ```bash
    flutter pub get
    ```
3.  **Build runner'ı çalıştırın:**
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```
4.  **Uygulamayı başlatın:**
    ```bash
    flutter run
    ```

---

## 🛡️ Kod Kalitesi
Yüksek kod kalitesi standartlarımızı şu şekilde sağlıyoruz:
- **Sıkı Linting:** `very_good_analysis` ile sıfır uyarı.
- **Hata Yönetimi:** `Either<Failure, Success>` ile fonksiyonel yönetim.
- **Test:** Kapsamlı birim (unit) ve widget testleri.

Analizi çalıştırın:
```bash
flutter analyze
```

---

## 📄 Lisans
Bu proje MIT Lisansı ile lisanslanmıştır - detaylar için LICENSE dosyasına bakınız.
