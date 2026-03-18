# SISOP Modul 1

- [SISOP Modul 1](#sisop-modul-1)
  - [Soal 1: KANJ](#soal-1-kanj)
    - [Screenshot](#screenshot)
    - [Deskripsi Soal](#deskripsi-soal)
    - [Menjalankan Script](#menjalankan-script)
    - [Header Skip](#header-skip)
    - [Penjelasan Soal](#penjelasan-soal)
      - [Soal a: Hitung jumlah penumpang](#soal-a-hitung-jumlah-penumpang)
      - [Soal b: Berapa banyak gerbong unik yang ada di KANJ?](#soal-b-berapa-banyak-gerbong-unik-yang-ada-di-kanj)
      - [Soal c: Cari penumpang tertua](#soal-c-cari-penumpang-tertua)
      - [Soal d: Rata-rata usia penumpang](#soal-d-rata-rata-usia-penumpang)
      - [Soal e: Jumlah penumpang Business Class](#soal-e-jumlah-penumpang-business-class)
  - [Soal 2: Ekspedisi Pesugihan Gunung Kawi](#soal-2-ekspedisi-pesugihan-gunung-kawi)
    - [Screenshot](#screenshot-1)
    - [Deskripsi Soal](#deskripsi-soal-1)
    - [Directory Setup](#directory-setup)
    - [Penjelasan Soal](#penjelasan-soal-1)
      - [Install gdown](#install-gdown)
      - [Download file PDF](#download-file-pdf)
      - [Baca PDF](#baca-pdf)
      - [Clone hidden link](#clone-hidden-link)
      - [Analisis JSON](#analisis-json)
      - [Ekstrak informasi](#ekstrak-informasi)
      - [Hitung Titik Tengah](#hitung-titik-tengah)
      - [Hasil Akhir](#hasil-akhir)

## Soal 1: KANJ

### Screenshot

![Soal 1](assets/soal_1/image.png)

### Deskripsi Soal

KANJ adalah sebuah kereta api yang memiliki banyak penumpang. Data penumpang KANJ disimpan dalam sebuah file CSV dengan format sebagai berikut:

```
Nama,Usia,Kelas,Gerbong
```

Tugasnya adalah untuk melakukan analisis terhadap data penumpang KANJ berdasarkan beberapa pertanyaan (soal) yang diberikan, menggunakan AWK.

### Menjalankan Script

```bash
$ awk -f KANJ.sh KANJ.csv a|b|c|d|e
```

### Header Skip

Karena file CSV memiliki header, kita perlu memastikan bahwa kita tidak menghitung header sebagai data penumpang. Oleh karena itu, kita akan menggunakan kondisi sederhana untuk melewati baris pertama (header) saat melakukan perhitungan.

```
NR == 1 {
    next
}
```

### Penjelasan Soal

#### Soal a: Hitung jumlah penumpang

Hitung jumlah seluruh penumpang yang ada di KANJ.

Caranya cukup dengan menghitung jumlah baris data (kecuali header) dalam file CSV.

```
soal == "a" {
    total_passengers++
}
```

#### Soal b: Berapa banyak gerbong unik yang ada di KANJ?

Untuk menghitung jumlah gerbong unik, kita bisa menggunakan sebuah array untuk menyimpan nama gerbong yang sudah kita temui. Setiap kali kita menemukan gerbong baru, kita tambahkan ke array tersebut.

```
soal == "b" {
    gerbong[$2] = 1
}

END {
    len_gerbong = length(gerbong) # Menghitung jumlah gerbong unik
    print "Jumlah gerbong unik: " len_gerbong
}

```

#### Soal c: Cari penumpang tertua

Untuk mencari penumpang tertua, kita bisa menyimpan nama dan usia penumpang tertua yang kita temui selama iterasi.

```
soal == "c" {
    if (oldest_age == "" || $2 > oldest_age) {
        oldest_age = $2
        oldest_passenger = $1
    }
}

END {
    print oldest_passenger " adalah penumpang kereta tertua dengan usia " oldest_age " tahun"
}
```

#### Soal d: Rata-rata usia penumpang

Untuk menghitung rata-rata usia penumpang, kita perlu menjumlahkan semua usia penumpang dan menghitung jumlah penumpang, kemudian membagi total usia dengan jumlah penumpang.

```
soal == "d" {
    total_age += $2
    # total_passengers sudah dihitung di tiap iterasi sebelumnya
}

END {
    average_age = total_age / total_passengers
    print "Rata-rata usia penumpang adalah " average_age " tahun"
}
```

#### Soal e: Jumlah penumpang Business Class

Untuk menghitung jumlah penumpang Business Class, kita bisa menggunakan sebuah counter yang akan diincrement setiap kali kita menemukan penumpang dengan kelas "Business".

```
soal == "e" {
    if ($3 == "Business") {
        business_count++
    }
}

END {
    print "Jumlah penumpang business class ada " business_count " orang"
}
```

## Soal 2: Ekspedisi Pesugihan Gunung Kawi

### Screenshot

### Deskripsi Soal

- Mengunduh file PDF dari Google Drive melalui CLI
- Mengambil hidden link dari PDF melalui `cat`
- Clone hidden link tersebut dengan `git clone`
- Mengekstrak 4 koordinat dari JSON menggunakan awk, sed, dan grep
- Mencari titik tengah

### Directory Setup

```bash
$ mkdir -p ekspedsi/
$ cd ekspedisi/
```

### Penjelasan Soal

#### Install gdown

Untuk mengunduh file PDF dari Google Drive melalui CLI, kita bisa menggunakan `gdown`.

```bash
$ python3 -m venv venv
$ source venv/bin/activate
$ pip install gdown
```

![gdown install](assets/soal_2/image.png)

#### Download file PDF

Simpel aja sih:

```bash
$ gdown "https://drive.google.com/uc?id=1q10pHSC3KFfvEiCN3V6PTroPR7YGHF6Q" -O peta-ekspedisi-amba.pdf
```

![download pdf](assets/soal_2/image_2.png)

#### Baca PDF

Clue: Concatenate

```bash
$ cat peta-ekspedisi-amba.pdf
```

![hasil cat](assets/soal_2/image_3.png)

> Bisa juga dengan `tail peta-ekspedisi-amba.pdf` untuk melihat bagian akhir dari file PDF.

#### Clone hidden link

Link adalah: `https://github.com/pocongcyber77/peta-gunung-kawi.git`, berbentuk repositori GitHub, jadi kita bisa langsung clone:

```bash
$ git clone https://github.com/pocongcyber77/peta-gunung-kawi.git
$ cd peta-gunung-kawi/
```

![clone](assets/soal_2/image_4.png)

#### Analisis JSON

File JSON:

```json
{
  "type": "FeatureCollection",
  "name": "gunung_kawi_spatial_nodes",
  "dataset_info": {
    "crs": "EPSG:4326",
    "datum": "WGS84",
    "region": "Gunung Kawi, East Java, Indonesia",
    "edge_distance_m": 2000,
    "generated_at": "2026-03-13T10:02:00Z"
  },
  "features": [
    {
      "type": "Feature",
      "id": "node_001",
      "properties": {
        "site_name": "Titik Berak Paman Mas Mba",
        "node_class": "primary_reference_point",
        "latitude": -7.92,
        "longitude": 112.45,
        "elevation_m": 254,
        "status": "active"
      },
      "geometry": {
        "type": "Point",
        "coordinates": [112.45, -7.92]
      }
    },
    {
      "type": "Feature",
      "id": "node_002",
      "properties": {
        "site_name": "Basecamp Mas Fuad",
        "node_class": "field_operations_base",
        "latitude": -7.92,
        "longitude": 112.4681,
        "elevation_m": 261,
        "status": "active"
      },
      "geometry": {
        "type": "Point",
        "coordinates": [112.4681, -7.92]
      }
    },
    {
      "type": "Feature",
      "id": "node_003",
      "properties": {
        "site_name": "Gerbang Dimensi Keputih",
        "node_class": "anomaly_site",
        "latitude": -7.93796,
        "longitude": 112.4681,
        "elevation_m": 248,
        "status": "restricted"
      },
      "geometry": {
        "type": "Point",
        "coordinates": [112.4681, -7.93796]
      }
    },
    {
      "type": "Feature",
      "id": "node_004",
      "properties": {
        "site_name": "Tembok Ratapan Keputih",
        "node_class": "boundary_marker",
        "latitude": -7.93796,
        "longitude": 112.45,
        "elevation_m": 246,
        "status": "inactive"
      },
      "geometry": {
        "type": "Point",
        "coordinates": [112.45, -7.93796]
      }
    }
  ]
}
```

#### Ekstrak informasi

Key yang kita butuhkan adalah `id`, `properties.site_name`, `properties.latitude`, dan `properties.longitude`. Kita bisa mengunakan `awk`, `grep`, dan `sed` untuk mengekstrak informasi ini.

```bash
# parserkoordinat.sh

OUTPUT_FILE="titik-penting.txt"

FILE=$1
if [ -z "$FILE" ]; then
    # echo "Usage: $0 <file>"
    # exit 1
    FILE="gsxtrack.json"
fi

# Flow:
# 1. Ambil baris yang mengandung "id", "site_name", "latitude", atau "longitude" menggunakan grep
# 2. Gunakan sed untuk membersihkan dan memformat output menjadi "key: value"
# 3. Gunakan awk untuk menggabungkan informasi yang terkait (id, site_name, latitude, longitude) dan mencetaknya dalam format yang rapi

grep -E '"id":|"site_name":|"latitude":|"longitude":' $FILE | \
sed -E 's/^[[:space:]]*"(id|site_name|latitude|longitude)": "?([^",]+)"?,?.*/\1: \2/' | \
awk -F': ' '
  /^id:/ { id=$2 }
  /^site_name:/ { site=$2 }
  /^latitude:/ { lat=$2 }
  /^longitude:/ { lon=$2; printf "%s,%s,%s,%s\n", id, site, lat, lon }
' > $OUTPUT_FILE

echo "Koordinat titik penting telah disimpan di $OUTPUT_FILE"
```

![hasil ekstrak](assets/soal_2/image_5.png)

#### Hitung Titik Tengah

Setelah kita mendapatkan koordinat dari keempat titik penting, kita bisa menghitung titik tengahnya dengan menggunakan rumus rata-rata dari latitude dan longitude.

```bash
# nemupusaka.sh

FILE=$1
if [ -z "$FILE" ]; then
    FILE="titik-penting.txt"
fi

# Disini, diambil titik 1 dan titik 3 karena berseberangan.
lat1=$(sed -n '1p' "$FILE" | cut -d',' -f3)
lat3=$(sed -n '3p' "$FILE" | cut -d',' -f3)

lon1=$(sed -n '1p' "$FILE" | cut -d',' -f4)
lon3=$(sed -n '3p' "$FILE" | cut -d',' -f4)

lat_tengah=$(awk "BEGIN {printf \"%.6f\", ($lat1 + $lat3) / 2}")
lon_tengah=$(awk "BEGIN {printf \"%.6f\", ($lon1 + $lon3) / 2}")

echo "Koordinat pusat:"
echo "$lat_tengah,$lon_tengah"

echo "$lat_tengah,$lon_tengah" > posisipusaka.txt
```

#### Hasil Akhir

```bash
$ cat posisipusaka.txt
-7.929980,112.459050
```
