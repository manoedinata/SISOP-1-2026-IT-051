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
