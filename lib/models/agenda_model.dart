class AgendaUndangan {
  int? id;
  String? tglAgenda;
  String? isiAcara;
  String? peserta;
  String? tempat;
  String? waktu;

  AgendaUndangan(
      {this.id,
      this.tglAgenda,
      this.isiAcara,
      this.peserta,
      this.tempat,
      this.waktu});

  AgendaUndangan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tglAgenda = json['tgl_agenda'];
    isiAcara = json['isi_acara'];
    peserta = json['peserta'];
    tempat = json['tempat'];
    waktu = json['waktu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tgl_agenda'] = tglAgenda;
    data['isi_acara'] = isiAcara;
    data['peserta'] = peserta;
    data['tempat'] = tempat;
    data['waktu'] = waktu;
    return data;
  }
}
