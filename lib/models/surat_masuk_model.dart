import 'package:app_surat/models/kode_surat_model.dart';
import 'package:app_surat/models/pegawai_model.dart';

class SuratMasuk {
  int? id;
  int? kodeSuratId;
  int? pegawaiId;
  String? isiSurat;
  String? perihalindex;
  int? lampiran;
  String? noSurat;
  String? tglMasuk;
  String? fileSm;
  String? asalSurat;
  String? createdAt;
  String? updatedAt;
  KodeSurat? kodeSurat;
  Pegawai? pegawai;

  SuratMasuk(
      {this.id,
      this.kodeSuratId,
      this.pegawaiId,
      this.isiSurat,
      this.perihalindex,
      this.lampiran,
      this.noSurat,
      this.tglMasuk,
      this.fileSm,
      this.asalSurat,
      this.createdAt,
      this.updatedAt,
      this.kodeSurat,
      this.pegawai});

  SuratMasuk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kodeSuratId = json['kode_surat_id'];
    pegawaiId = json['pegawai_id'];
    isiSurat = json['isi_surat'];
    perihalindex = json['perihalindex'];
    lampiran = json['lampiran'];
    noSurat = json['no_surat'];
    tglMasuk = json['tgl_masuk'];
    fileSm = json['file_sm'];
    asalSurat = json['asal_surat'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    kodeSurat = json['kode_surat'] != null
        ? KodeSurat.fromJson(json['kode_surat'])
        : null;
    pegawai =
        json['pegawai'] != null ? Pegawai.fromJson(json['pegawai']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['kode_surat_id'] = kodeSuratId;
    data['pegawai_id'] = pegawaiId;
    data['isi_surat'] = isiSurat;
    data['perihalindex'] = perihalindex;
    data['lampiran'] = lampiran;
    data['no_surat'] = noSurat;
    data['tgl_masuk'] = tglMasuk;
    data['file_sm'] = fileSm;
    data['asal_surat'] = asalSurat;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (kodeSurat != null) {
      data['kode_surat'] = kodeSurat!.toJson();
    }
    if (pegawai != null) {
      data['pegawai'] = pegawai!.toJson();
    }
    return data;
  }
}
