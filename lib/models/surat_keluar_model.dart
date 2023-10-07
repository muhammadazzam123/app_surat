import 'package:app_surat/models/kode_surat_model.dart';
import 'package:app_surat/models/pegawai_model.dart';

class SuratKeluar {
  int? id;
  int? kodeSuratId;
  int? pegawaiId;
  String? noSurat;
  String? catatan;
  String? tujuanSurat;
  String? isiRingkas;
  int? lembar;
  String? fileSk;
  int? lampiran;
  String? tglKeluar;
  String? perihalindexSk;
  String? pengolah;
  String? createdAt;
  String? updatedAt;
  KodeSurat? kodeSurat;
  Pegawai? pegawai;

  SuratKeluar(
      {this.id,
      this.kodeSuratId,
      this.pegawaiId,
      this.noSurat,
      this.catatan,
      this.tujuanSurat,
      this.isiRingkas,
      this.lembar,
      this.fileSk,
      this.lampiran,
      this.tglKeluar,
      this.perihalindexSk,
      this.pengolah,
      this.createdAt,
      this.updatedAt,
      this.kodeSurat,
      this.pegawai});

  SuratKeluar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kodeSuratId = json['kode_surat_id'];
    pegawaiId = json['pegawai_id'];
    noSurat = json['no_surat'];
    catatan = json['catatan'];
    tujuanSurat = json['tujuan_surat'];
    isiRingkas = json['isi_ringkas'];
    lembar = json['lembar'];
    fileSk = json['file_sk'];
    lampiran = json['lampiran'];
    tglKeluar = json['tgl_keluar'];
    perihalindexSk = json['perihalindex_sk'];
    pengolah = json['pengolah'];
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
    data['no_surat'] = noSurat;
    data['catatan'] = catatan;
    data['tujuan_surat'] = tujuanSurat;
    data['isi_ringkas'] = isiRingkas;
    data['lembar'] = lembar;
    data['file_sk'] = fileSk;
    data['lampiran'] = lampiran;
    data['tgl_keluar'] = tglKeluar;
    data['perihalindex_sk'] = perihalindexSk;
    data['pengolah'] = pengolah;
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
