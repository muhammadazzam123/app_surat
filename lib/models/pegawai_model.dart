class Pegawai {
  int? id;
  int? userId;
  String? nip;
  String? nama;
  String? jenisKelamin;
  String? tempatLahir;
  String? tglLahir;
  String? noHp;
  String? email;
  String? alamat;
  String? createdAt;
  String? updatedAt;

  Pegawai(
      {this.id,
      this.userId,
      this.nip,
      this.nama,
      this.jenisKelamin,
      this.tempatLahir,
      this.tglLahir,
      this.noHp,
      this.email,
      this.alamat,
      this.createdAt,
      this.updatedAt});

  Pegawai.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    nip = json['nip'];
    nama = json['nama'];
    jenisKelamin = json['jenis_kelamin'];
    tempatLahir = json['tempat_lahir'];
    tglLahir = json['tgl_lahir'];
    noHp = json['no_hp'];
    email = json['email'];
    alamat = json['alamat'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['nip'] = nip;
    data['nama'] = nama;
    data['jenis_kelamin'] = jenisKelamin;
    data['tempat_lahir'] = tempatLahir;
    data['tgl_lahir'] = tglLahir;
    data['no_hp'] = noHp;
    data['email'] = email;
    data['alamat'] = alamat;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
