import 'package:flutter/material.dart';

class BiodataScreen extends StatefulWidget {
  const BiodataScreen({super.key});

  @override
  State<BiodataScreen> createState() => _BiodataScreenState();
}

class _BiodataScreenState extends State<BiodataScreen> {
  // ignore: unused_field
  final _formKey = GlobalKey<FormState>();
  // ignore: unused_field, prefer_final_fields
  bool _isEditing = false;
  // ignore: unused_field, prefer_final_fields
  String _selectedImage = '';

  // ignore: unused_field
  final TextEditingController _namaLengkapController = TextEditingController();
  // ignore: unused_field
  final TextEditingController _usernameController = TextEditingController();
  // ignore: unused_field
  final TextEditingController _emailController = TextEditingController();
  // ignore: unused_field
  final TextEditingController _usiaController = TextEditingController();
  // ignore: unused_field
  final TextEditingController _pekerjaanController = TextEditingController();
  // ignore: unused_field
  final TextEditingController _teleponController = TextEditingController();
  // ignore: unused_field
  final TextEditingController _alamatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    // final userData = await DatabaseHelper.instance.getUserData();
    // if (userData != null) {
    //   setState(() {
    //     _namaLengkapController.text = userData['nama_lengkap'] ?? '';
    //     _usernameController.text = userData['username'] ?? '';
    //     _emailController.text = userData['email'] ?? '';
    //     _usiaController.text = userData['usia']?.toString() ?? '';
    //     _pekerjaanController.text = userData['pekerjaan'] ?? '';
    //     _teleponController.text = userData['telepon'] ?? '';
    //     _alamatController.text = userData['alamat'] ?? '';
    //     _selectedImage = userData['foto'] ?? '';
    //   });
    // }
  }
  // ignore: unused_element
  Future<void> _pickImage() async {
    // final ImagePicker picker = ImagePicker();
    // final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    // if (image != null) {
    //   setState(() {
    //     _selectedImage = image.path;
    //   });
    // }
  }

  Future<void> _saveUserData() async {
    if (_formKey.currentState!.validate()) {
      // ignore: unused_local_variable
      final userData = {
        'nama_lengkap': _namaLengkapController.text,
        'username': _usernameController.text,
        'email': _emailController.text,
        'usia': int.tryParse(_usiaController.text) ?? 0,
        'pekerjaan': _pekerjaanController.text,
        'telepon': _teleponController.text,
        'alamat': _alamatController.text,
        'foto': _selectedImage,
      };

      // await DatabaseHelper.instance.saveUserData(userData);

      setState(() {
        _isEditing = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data berhasil disimpan'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  // ignore: annotate_overrides
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Biodata'),
          backgroundColor: const Color(0xFFE91E63),
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: Icon(_isEditing ? Icons.save : Icons.edit),
              onPressed: () {
                if (_isEditing) {
                  // _saveUserData();
                } else {
                  setState(() {
                    _isEditing = true;
                  });
                }
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey[300],
                          // child: _selectedImage.isNotEmpty
                          // ? ClipOval(
                          //     child: _selectedImage.startsWith('http')
                          //         ? Image.network(
                          //             _selectedImage,
                          //             width: 120,
                          //             height: 120,
                          //             fit: BoxFit.cover,
                          //             errorBuilder: (context, error, stackTrace) {
                          //               return Icon(
                          //                 Icons.person,
                          //                 size: 60,
                          //                 color: Colors.grey[600],
                          //               );
                          //             },
                          //           )
                          //         :
                          //         Image.file(
                          //             File(_selectedImage),
                          //             width: 120,
                          //             height: 120,
                          //             fit: BoxFit.cover,
                          //             errorBuilder: (context, error, stackTrace) {
                          //               return Icon(
                          //                 Icons.person,
                          //                 size: 60,
                          //                 color: Colors.grey[600],
                          //               );
                          //             },
                          //           ),
                          //   )
                          // : Icon(
                          //     Icons.person,
                          //     size: 60,
                          //     color: Colors.grey[600],
                          //   ),
                        ),
                        if (_isEditing)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              // onTap: _pickImage,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFE91E63),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  // Form Fields
                  _buildTextField(
                    controller: _namaLengkapController,
                    label: 'Nama Lengkap',
                    icon: Icons.person,
                    enabled: _isEditing,
                  ),

                  _buildTextField(
                    controller: _usernameController,
                    label: 'Username/Nama Panggilan',
                    icon: Icons.alternate_email,
                    enabled: _isEditing,
                  ),

                  _buildTextField(
                    controller: _emailController,
                    label: 'Email',
                    icon: Icons.email,
                    enabled: _isEditing,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  _buildTextField(
                    controller: _usiaController,
                    label: 'Usia',
                    icon: Icons.cake,
                    enabled: _isEditing,
                    keyboardType: TextInputType.number,
                  ),

                  _buildTextField(
                    controller: _pekerjaanController,
                    label: 'Kegiatan/Pekerjaan',
                    icon: Icons.work,
                    enabled: _isEditing,
                  ),

                  _buildTextField(
                    controller: _teleponController,
                    label: 'Nomor Telepon',
                    icon: Icons.phone,
                    enabled: _isEditing,
                    keyboardType: TextInputType.phone,
                  ),

                  _buildTextField(
                    controller: _alamatController,
                    label: 'Alamat Lengkap',
                    icon: Icons.location_on,
                    enabled: _isEditing,
                    maxLines: 3,
                  ),

                  const SizedBox(height: 30),
                  if (_isEditing)
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _saveUserData,
                        child: const Text('Simpan Data'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE91E63),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                ],
              )),
        ));
  }
}

Widget _buildTextField({
  required TextEditingController controller,
  required String label,
  required IconData icon,
  required bool enabled,
  TextInputType keyboardType = TextInputType.text,
  int maxLines = 1,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    child: TextFormField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFFE91E63)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE91E63)),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
        filled: !enabled,
        fillColor: !enabled ? Colors.grey[50] : null,
      ),
      validator: (value) {
        // All fields are optional
        return null;
      },
    ),
  );
}
