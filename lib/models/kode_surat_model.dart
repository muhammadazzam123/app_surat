class KodeSurat {
  int? id;
  String? kode;
  String? namaKode;
  String? keterangan;
  String? createdAt;
  String? updatedAt;

  KodeSurat(
      {this.id,
      this.kode,
      this.namaKode,
      this.keterangan,
      this.createdAt,
      this.updatedAt});

  KodeSurat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kode = json['kode'];
    namaKode = json['nama_kode'];
    keterangan = json['keterangan'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['kode'] = kode;
    data['nama_kode'] = namaKode;
    data['keterangan'] = keterangan;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
