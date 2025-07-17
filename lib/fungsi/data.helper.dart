// import 'package:path/path.dart';

import 'package:siagabumil/fungsi/artikel.model.dart';
import 'package:siagabumil/fungsi/chat.model.dart';
import 'package:siagabumil/fungsi/pencatatan.model.dart';
import 'package:siagabumil/fungsi/tip.model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    // _database = await _initDatabase();
    return _database!;
  }

  // Future<Database> _initDatabase() async {
  //   // String path = join(await getDatabasesPath(), 'siaga_bumil.db');
  //   // return await openDatabase(
  //     // path,
  //     // version: 1,
  //     // onCreate: _createDatabase,
  //   // );
  // }

  // ignore: unused_element
  Future<void> _createDatabase(Database db, int version) async {
    // Tabel tips
    await db.execute('''
      CREATE TABLE tips (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        image TEXT,
        created_at TEXT NOT NULL
      )
    ''');

    // Tabel artikel
    await db.execute('''
      CREATE TABLE artikel (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        category TEXT NOT NULL,
        image_url TEXT,
        video_url TEXT,
        publish_date TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');

    // Tabel chat
    await db.execute('''
      CREATE TABLE chat (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        message TEXT NOT NULL,
        is_user INTEGER NOT NULL,
        timestamp TEXT NOT NULL
      )
    ''');

    // Tabel pencatatan makanan
    await db.execute('''
      CREATE TABLE pencatatan (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        trimester INTEGER NOT NULL,
        kategori TEXT NOT NULL,
        bahan TEXT NOT NULL,
        jumlah REAL NOT NULL,
        satuan TEXT NOT NULL,
        tanggal TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');

    // Tabel biodata
    await db.execute('''
      CREATE TABLE biodata (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama_lengkap TEXT,
        username TEXT,
        email TEXT,
        usia INTEGER,
        kegiatan TEXT,
        nomor_telepon TEXT,
        alamat TEXT,
        foto TEXT
      )
    ''');

    // Insert sample tips
    await _insertSampleTips(db);
  }

  Future<void> _insertSampleTips(Database db) async {
    List<Map<String, dynamic>> sampleTips = [
      {
        'title': 'Minum Air Putih',
        'content': 'Minumlah air putih minimal 8 gelas per hari untuk menjaga hidrasi tubuh',
        'image': 'assets/images/tip_water.png',
        'created_at': DateTime.now().toIso8601String(),
      },
      {
        'title': 'Konsumsi Asam Folat',
        'content': 'Pastikan asupan asam folat cukup untuk mencegah cacat tabung saraf',
        'image': 'assets/images/tip_folat.png',
        'created_at': DateTime.now().toIso8601String(),
      },
      {
        'title': 'Olahraga Ringan',
        'content': 'Lakukan olahraga ringan seperti jalan kaki atau yoga prenatal',
        'image': 'assets/images/tip_exercise.png',
        'created_at': DateTime.now().toIso8601String(),
      },
    ];

    for (var tip in sampleTips) {
      await db.insert('tips', tip);
    }
  }

  // Tips operations
  Future<List<TipModel>> getTips() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tips');
    return List.generate(maps.length, (i) => TipModel.fromMap(maps[i]));
  }

  Future<int> insertTip(TipModel tip) async {
    final db = await database;
    return await db.insert('tips', tip.toMap());
  }

  // Artikel operations
  Future<List<ArtikelModel>> getArtikels() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('artikel');
    return List.generate(maps.length, (i) => ArtikelModel.fromMap(maps[i]));
  }

  Future<int> insertArtikel(ArtikelModel artikel) async {
    final db = await database;
    return await db.insert('artikel', artikel.toMap());
  }

  // Chat operations
  Future<List<ChatModel>> getChatHistory({int limit = 50}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('chat', orderBy: 'timestamp DESC', limit: limit);
    return List.generate(maps.length, (i) => ChatModel.fromMap(maps[i]));
  }

  Future<int> insertChat(ChatModel chat) async {
    final db = await database;
    return await db.insert('chat', chat.toMap());
  }

  Future<void> clearChatHistory() async {
    final db = await database;
    await db.delete('chat');
  }

  // Pencatatan operations
  Future<List<PencatatanModel>> getPencatatans({int? trimester}) async {
    final db = await database;
    String whereClause = trimester != null ? 'trimester = ?' : '';
    List<dynamic> whereArgs = trimester != null ? [trimester] : [];

    final List<Map<String, dynamic>> maps = await db.query(
      'pencatatan',
      where: whereClause.isNotEmpty ? whereClause : null,
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
      orderBy: 'tanggal DESC',
    );
    return List.generate(maps.length, (i) => PencatatanModel.fromMap(maps[i]));
  }

  Future<int> insertPencatatan(PencatatanModel pencatatan) async {
    final db = await database;
    return await db.insert('pencatatan', pencatatan.toMap());
  }

  Future<List<PencatatanModel>> getPencatatansByDate(String tanggal) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('pencatatan', where: 'tanggal = ?', whereArgs: [tanggal]);
    return List.generate(maps.length, (i) => PencatatanModel.fromMap(maps[i]));
  }

  // Biodata operations
  Future<Map<String, dynamic>?> getBiodata() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('biodata');
    return maps.isNotEmpty ? maps.first : null;
  }

  Future<int> insertOrUpdateBiodata(Map<String, dynamic> biodata) async {
    final db = await database;
    final existing = await getBiodata();

    if (existing != null) {
      return await db.update('biodata', biodata, where: 'id = ?', whereArgs: [existing['id']]);
    } else {
      return await db.insert('biodata', biodata);
    }
  }

  // Check recording status
  Future<Map<String, dynamic>> getRecordingStatus() async {
    final db = await database;
    final now = DateTime.now();
    final weekStart = now.subtract(const Duration(days: 7));

    // Check weekly status (minimal 2 kali per minggu)
    final weeklyCount = await db.rawQuery(
      '''
      SELECT COUNT(DISTINCT DATE(tanggal)) as days 
      FROM pencatatan 
      WHERE DATE(tanggal) >= DATE(?)
    ''',
      [weekStart.toIso8601String().split('T')[0]],
    );

    bool weeklyFulfilled = (weeklyCount.first['days'] as int) >= 2;

    // Check daily status (5 kategori: Pagi, Siang, Malam, Selingan Pagi, Selingan Sore)
    final today = now.toIso8601String().split('T')[0];
    final dailyRecords = await db.query('pencatatan', where: 'DATE(tanggal) = ?', whereArgs: [today]);

    Map<String, bool> dailyStatus = {
      'Pagi': false,
      'Siang': false,
      'Malam': false,
      'Selingan Pagi': false,
      'Selingan Sore': false,
    };

    for (var record in dailyRecords) {
      String kategori = record['kategori'] as String;
      if (dailyStatus.containsKey(kategori)) {
        dailyStatus[kategori] = true;
      }
    }

    return {'weeklyFulfilled': weeklyFulfilled, 'dailyStatus': dailyStatus};
  }
}

class Database {
  final String path;
  Database(this.path);

  // Mock execute SQL
  Future<void> execute(String sql) async {
    // ignore: avoid_print
    print('Executing SQL on $path: $sql');
    // Simulasi delay
    await Future.delayed(const Duration(milliseconds: 100));
  }

  Future<int> insert(String table, Map<String, dynamic> values) async {
    // ignore: avoid_print
    print('Insert into $table on $path: $values');
    await Future.delayed(const Duration(milliseconds: 100));
    return 1;
  }

  Future<List<Map<String, dynamic>>> query(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
    String? orderBy,
    int? limit,
  }) async {
    // ignore: avoid_print
    print('Query on $table with where: $where, whereArgs: $whereArgs on $path');
    await Future.delayed(const Duration(milliseconds: 100));
    return [];
  }

  Future<int> update(String table, Map<String, dynamic> values, {String? where, List<dynamic>? whereArgs}) async {
    // ignore: avoid_print
    print('Update $table with values: $values where: $where on $path');
    await Future.delayed(const Duration(milliseconds: 100));
    return 1;
  }

  Future<int> delete(String table, {String? where, List<dynamic>? whereArgs}) async {
    // ignore: avoid_print
    print('Delete from $table where: $where on $path');
    await Future.delayed(const Duration(milliseconds: 100));
    return 1;
  }

  Future<List<Map<String, Object?>>> rawQuery(String sql, [List<dynamic>? arguments]) async {
    // ignore: avoid_print
    print('Raw query: $sql, arguments: $arguments on $path');
    await Future.delayed(const Duration(milliseconds: 100));
    return [];
  }
}

// // Fungsi global yang dibutuhkan oleh DatabaseHelper
// Future<String> getDatabasesPath() async {
//   // Simulasi lokasi database, misal folder "databases" di direktori kerja aplikasi
//   final directory = Directory('databases');
//   if (!await directory.exists()) {
//     await directory.create(recursive: true);
//   }
//   return directory.path;
// }

// Fungsi untuk membuka atau membuat database
Future<Database> openDatabase(
  String path, {
  int? version,
  Future<void> Function(Database db, int version)? onCreate,
}) async {
  final db = Database(path);

  // Simulasi pengecekan apakah database baru dibuat
  // final file = File(path);
  // if (!await file.exists()) {
  //   // Panggil onCreate jika disediakan
  //   if (onCreate != null && version != null) {
  //     await onCreate(db, version);
  //   }
  //   // Simulasi membuat file database kosong
  //   await file.create(recursive: true);
  // }

  return db;
}
