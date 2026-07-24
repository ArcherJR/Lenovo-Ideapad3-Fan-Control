# Lenovo-Ideapad3-Fan-Control

╔═════════════════════════════════════════════════╗

║  L E N O V O - I D E A P A D 3 - F A N - C O N T R O L         ║

╚═════════════════════════════════════════════════╝

by ArcherJR

<h1></h1>

## Projenin Hikayesi / Project Overview

**TR:** IdeaPad 3 serisi laptoplarda varsayılan fan eğrisi, yoğun yük altında yeterli soğutmayı sağlamakta zaman zaman yetersiz kalabiliyor. Bu script, ACPI seviyesindeki `fan_mode` parametresini periyodik olarak FAST (1) moduna zorlayarak fanın düzenli aralıklarla maksimum hızda dönmesini sağlar ve ardından NORMAL (0) moduna geri döner. Böylece EC'nin kendi termal yönetimine müdahale etmeden, ek bir soğutma döngüsü devreye sokulmuş olur.

**EN:** The default fan curve on IdeaPad 3 series laptops can sometimes fail to provide adequate cooling under sustained load. This script periodically forces the ACPI-level `fan_mode` parameter into FAST (1) mode, letting the fan spin at maximum speed for a set duration before returning to NORMAL (0) mode — layering an extra active-cooling cycle on top of the EC's own thermal management.

## Gereksinimler / System Requirements

- **İşletim Sistemi / Operating System:** Ubuntu 24.04 (veya herhangi bir modern Linux dağıtımı) / (or any modern Linux distribution).
- **ACPI Desteği / ACPI Support:** `VPC2004:00` cihaz düğümünün sistemde mevcut olması gerekir / The `VPC2004:00` device node must be present on the system.
- **Yetkilendirme / Authorization:** Script `sudo tee` ile sysfs'e yazdığı için sudo şifresi istenir; şifresiz çalıştırmak isterseniz `visudo` üzerinden NOPASSWD tanımlayabilirsiniz. / The script writes to sysfs via `sudo tee`, so it will prompt for a password; for passwordless execution, define a NOPASSWD rule via `visudo`.

## Mimari Şema / Architectural Scheme

**TR:**
1. **Döngü:** Script, `fan_mode` dosyasına sürekli olarak 1 (FAST) ve 0 (NORMAL) değerlerini sırayla yazar.
2. **Zamanlama:** FAST modda ~9 saniye maksimum hızda kalınır, ardından NORMAL moda geçiş için EC'nin durumu görmesine izin verecek kısa bir bekleme (50ms) uygulanır.
3. **Güvenli Çıkış:** `Ctrl+C` (SIGINT) veya SIGTERM sinyali alındığında, fan otomatik olarak NORMAL moda (0) döndürülüp temiz bir şekilde çıkış yapılır.

**EN:**
1. **Loop:** The script continuously writes 1 (FAST) and 0 (NORMAL) to the `fan_mode` file in sequence.
2. **Timing:** The fan stays in FAST mode at max speed for ~9 seconds, followed by a short delay (50ms) to let the EC register the mode switch before returning to NORMAL.
3. **Safe Exit:** On receiving `Ctrl+C` (SIGINT) or SIGTERM, the fan is automatically reset to NORMAL mode (0) before a clean exit.

## Install Guide

```bash
git clone https://github.com/ArcherJR/Lenovo-Ideapad3-Fan-Control.git
```

```bash
cd Lenovo-Ideapad3-Fan-Control
```

```bash
chmod +x fan-control.sh
```

Test:

```bash
sudo ./fan-control.sh
```

Şifresiz çalıştırmak isterseniz / For passwordless execution:

```bash
sudo visudo
```
