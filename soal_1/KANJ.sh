# AWK script

BEGIN {
    soal = ARGV[2]
    # Remove the soal argument from ARGV so that it doesn't interfere with the main processing
    delete ARGV[2]

    if (soal != "a" && soal != "b" && soal != "c" && soal != "d" && soal != "e") {
        print "Mas Amba, Soal tidak dikenali! Gunakan a, b, c, d, atau e."
        print "Contoh penggunaan: awk -f KANJ.sh passenger.csv a|b|c|d|e"
        print ""
        print "Semangat belajar, Mas Amba!"
        exit 1 
    }

    # Field Separator
    FS = ","
}

# Soal a: Hitung jumlah penumpang
soal == "a" {
    if (NR > 1) { # Skip header
        count++
    }
}

# Soal b: Berapa banyak gerbong unik yang ada di KANJ?
soal == "b" {
    if (NR > 1) { # Skip header
        gerbong[$2] = 1
    }
}

# Soal c: Cari penumpang tertua
soal == "c" {
    if (NR > 1) {
        # Bandingkan usia penumpang saat ini dengan usia tertua yang sudah ditemukan
        if (oldest_age == "" || $2 > oldest_age) {
            oldest_age = $2
            oldest_passenger = $1
        }
    }
}

# Soal d: Rata-rata usia penumpang
soal == "d" {
    if (NR > 1) {
        total_age += $2
        total_passengers++
    }
}

# Soal e: Jumlah penumpang Business Class
soal == "e" {
    if (NR > 1) {
        if ($3 == "Business") {
            business_count++
        }
    }
}

END {
    if (soal == "a") {
        print "Jumlah seluruh penumpang KANJ adalah " count
    }

    if (soal == "b") {
        len_gerbong = length(gerbong)
        print "Jumlah gerbong penumpang KANJ adalah " len_gerbong
    }

    if (soal == "c") {
        print oldest_passenger " adalah penumpang kereta tertua dengan usia " oldest_age " tahun"
    }

    if (soal == "d") {
        average_age = int(total_age / total_passengers)

        print "Rata-rata usia penumpang adalah " average_age " tahun"
    }

    if (soal == "e") {
        print "Jumlah penumpang business class ada " business_count " orang"
    }
}

