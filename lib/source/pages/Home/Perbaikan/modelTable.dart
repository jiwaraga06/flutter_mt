class MyTable {
   String? id_struktur_mesin;
   String? nama;
   int? id_material;
   String? jumlah;
   String? catatan;

  MyTable(this.id_struktur_mesin, this.nama, this.id_material, this.jumlah, this.catatan);

  Map toJson() => {
        'id_struktur_mesin': id_struktur_mesin,
        'id_material': id_material,
        'jumlah': jumlah,
        'catatan': catatan,
      };
  @override
  toString() => "{id_struktur_mesin : ${id_struktur_mesin}, id_material : $id_material, jumlah : ${jumlah}, catatan : ${catatan}}";
}
