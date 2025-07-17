// class DatabaseHelper {
//   static final DatabaseHelper instance = DatabaseHelper._internal();
//   factory DatabaseHelper() => instance;
//   DatabaseHelper._internal();

//   Database? _database;

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     String path = join(await getDatabasesPath(), 'siaga_bumil.db');
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: _createTables,
//     );
//   }

//   Future<void> _createTables(Database db, int version) async {
//     // User data table
//     await db.execute('''
//       CREATE TABLE user_data (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         nama_lengkap TEXT,
//         username TEXT,
//         email TEXT,
//         usia INTEGER,
//         pekerjaan TEXT,
//         telepon TEXT,
//         alamat TEXT,
//         foto TEXT
//       )
//     ''');

//     // Tips table
//     await db.execute('''
//       CREATE TABLE tips (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         title TEXT NOT NULL,
//         content TEXT NOT NULL,
//         icon_code INTEGER NOT NULL,
//         created_at DATETIME DEFAULT CURRENT_TIMESTAMP
//       )
//     ''');

//     // Articles table (for caching)
//     await db.execute('''
//       CREATE TABLE articles (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         title TEXT NOT NULL,
//         content TEXT NOT NULL,
//         category TEXT NOT NULL,
//         image_url TEXT,
//         video_url TEXT,
//         publish_date TEXT,
//         created_at DATETIME DEFAULT CURRENT_TIMESTAMP
//       )
//     ''');

//     // Chat history table
//     await db.execute('''
//       CREATE TABLE chat_history (
//         id INTEGER PRIMARY KEY,
//         message TEXT NOT NULL,
//         is_user INTEGER NOT NULL,
//         timestamp DATETIME NOT NULL
//       )
//     ''');

//     // Food records table
//     await db.execute('''
//       CREATE TABLE food_records (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         trimester INTEGER NOT NULL,
//         date TEXT NOT NULL,
//         category TEXT NOT NULL,
//         food_name TEXT NOT NULL,
//         portion REAL NOT NULL,
//         unit TEXT NOT NULL,
//         calories REAL,
//         protein REAL,
//         carbs REAL,
//         fat REAL,
//         fiber REAL,
//         created_at DATETIME DEFAULT CURRENT_TIMESTAMP
//       )
//     ''');

//     // Insert sample data
//     await _insertSampleData(db);
//   }

//   Future<void> _insertSampleData(Database db) async {
//     // Sample tips
//     await db.insert('tips', {
//       'title': 'Minum Air Putih',
//       'content': 'Minumlah air putih minimal 8 gelas per hari untuk menjaga hidrasi tubuh dan kesehatan janin.',
//       'icon_code': 0xe5ef, // Icons.local_drink
//     });

//     await db.insert('tips', {
//       'title': 'Konsumsi Asam Folat',
//       'content': 'Pastikan asupan asam folat cukup untuk mencegah cacat tabung saraf pada janin.',
//       'icon_code': 0xe25d, // Icons.local_pharmacy
//     });

//     await db.insert('tips', {
//       'title': 'Olahraga Ringan',
//       'content': 'Lakukan olahraga ringan seperti jalan kaki atau yoga prenatal untuk menjaga kebugaran.',
//       'icon_code': 0xe571, // Icons.fitness_center
//     });

//     // Sample articles
//     await db.insert('articles', {
//       'title': 'Nutrisi Penting untuk Ibu Hamil',
//       'content': 'Selama kehamilan, tubuh membutuhkan nutrisi tambahan untuk mendukung pertumbuhan janin...',
//       'category': 'Nutrisi',
//       'image_url': 'https://example.com/nutrition.jpg',
//       'publish_date': '2024-01-15',
//     });

//     await db.insert('articles', {
//       'title': 'Olahraga Aman untuk Ibu Hamil',
//       'content': 'Olahraga selama kehamilan sangat penting untuk menjaga kesehatan ibu dan janin...',
//       'category': 'Olahraga',
//       'image_url': 'https://example.com/exercise.jpg',
//       'publish_date': '2024-01-10',
//     });
//   }

//   // User data methods
//   Future<Map<String, dynamic>?> getUserData() async {
//     final db = await database;
//     final result = await db.query('user_data', limit: 1);
//     return result.isNotEmpty ? result.first : null;
//   }

//   Future<void> saveUserData(Map<String, dynamic> userData) async {
//     final db = await database;
//     final existing = await getUserData();
    
//     if (existing != null) {
//       await db.update('user_data', userData, where: 'id = ?', whereArgs: [existing['id']]);
//     } else {
//       await db.insert('user_data', userData);
//     }
//   }

//   // Tips methods
//   Future<List<TipModel>> getTips() async {
//     final db = await database;
//     final result = await db.query('tips', orderBy: 'created_at DESC');
//     return result.map((json) => TipModel.fromJson(json)).toList();
//   }

//   // Articles methods
//   Future<List<ArtikelModel>> getArticles() async {
//     final db = await database;
//     final result = await db.query('articles', orderBy: 'created_at DESC');
//     return result.map((json) => ArtikelModel.fromJson(json)).toList();
//   }

//   // Chat methods
//   Future<List<ChatModel>> getChatHistory({int limit = 50}) async {
//     final db = await database;
//     final result = await db.query(
//       'chat_history',
//       orderBy: 'timestamp ASC',
//       limit: limit,
//     );
//     return result.map((json) => ChatModel.fromJson(json)).toList();
//   }
// }