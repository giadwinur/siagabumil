class PencatatanModel {
  final int? id;
  final int trimester;
  final String kategori;
  final String bahan;
  final double jumlah;
  final String satuan;
  final String tanggal;
  final String createdAt;

  PencatatanModel({
    this.id,
    required this.trimester,
    required this.kategori,
    required this.bahan,
    required this.jumlah,
    required this.satuan,
    required this.tanggal,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'trimester': trimester,
      'kategori': kategori,
      'bahan': bahan,
      'jumlah': jumlah,
      'satuan': satuan,
      'tanggal': tanggal,
      'created_at': createdAt,
    };
  }

  factory PencatatanModel.fromMap(Map<String, dynamic> map) {
    return PencatatanModel(
      id: map['id']?.toInt(),
      trimester: map['trimester']?.toInt() ?? 1,
      kategori: map['kategori'] ?? '',
      bahan: map['bahan'] ?? '',
      jumlah: map['jumlah']?.toDouble() ?? 0.0,
      satuan: map['satuan'] ?? '',
      tanggal: map['tanggal'] ?? '',
      createdAt: map['created_at'] ?? '',
    );
  }

  factory PencatatanModel.fromJson(Map<String, dynamic> json) {
    return PencatatanModel(
      id: json['id']?.toInt(),
      trimester: json['trimester']?.toInt() ?? 1,
      kategori: json['kategori'] ?? '',
      bahan: json['bahan'] ?? '',
      jumlah: json['jumlah']?.toDouble() ?? 0.0,
      satuan: json['satuan'] ?? '',
      tanggal: json['tanggal'] ?? '',
      createdAt: json['created_at'] ?? DateTime.now().toIso8601String(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'trimester': trimester,
      'kategori': kategori,
      'bahan': bahan,
      'jumlah': jumlah,
      'satuan': satuan,
      'tanggal': tanggal,
      'created_at': createdAt,
    };
  }
}
