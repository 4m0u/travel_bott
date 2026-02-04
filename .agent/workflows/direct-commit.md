---
description: description: Kullanıcı onayı olamadan commit 
---

# Title: direct-commit
# Description: Staged Changes alanındaki kodları otonom olarak analiz eder ve onay beklemeden commit/push yapar.

## Steps:
1. **Analiz:** `dart_format` ve `analyze_files` araçlarını kullanarak **SADECE** staged olan dosyaların Proje standartlarına uygunluğunu denetle.
2. **Review:** Değişiklikleri Clean Architecture ve SOLID prensiplerine göre hızlıca gözden geçir.
3. **Draft:** Yapılan değişiklikleri özetleyen, TÜRKÇE ve teknik derinliği olan bir commit mesajı hazırla.
4. **Execution:** **KULLANICI ONAYI BEKLEMEDEN** sırasıyla `git commit -m "..."` ve `git push` komutlarını çalıştır.
   - *Kritik Kural:* Sadece halihazırda staged olan (dizine eklenmiş) dosyaları gönder; asla `git add .` yapma.
