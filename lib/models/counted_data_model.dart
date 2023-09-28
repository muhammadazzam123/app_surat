class CountedDataPetugas {
  int? suratMasuks;
  int? suratKeluars;
  int? kodeSurats;
  int? agendaUndangans;

  CountedDataPetugas(
      {this.suratMasuks,
      this.suratKeluars,
      this.kodeSurats,
      this.agendaUndangans});

  CountedDataPetugas.fromJson(Map<String, dynamic> json) {
    suratMasuks = json['suratMasuks'];
    suratKeluars = json['suratKeluars'];
    kodeSurats = json['kodeSurats'];
    agendaUndangans = json['agendaUndangans'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['suratMasuks'] = suratMasuks;
    data['suratKeluars'] = suratKeluars;
    data['kodeSurats'] = kodeSurats;
    data['agendaUndangans'] = agendaUndangans;
    return data;
  }
}
