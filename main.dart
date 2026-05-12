import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BasvuruFormu(),
    );
  }
}

class BasvuruFormu extends StatefulWidget {
  const BasvuruFormu({super.key});

  @override
  State<BasvuruFormu> createState() => _BasvuruFormuState();
}

class _BasvuruFormuState extends State<BasvuruFormu> {
  final formKey = GlobalKey<FormState>();

  String? cv;
  String? egitim;
  String? isTipi;
  String? deneyim;

  final egitimList = [
    "Lise",
    "Ön Lisans",
    "Lisans",
    "Yüksek Lisans"
  ];

  final isList = [
    "Stajyer",
    "Yazılımcı",
    "Tasarımcı",
    "Grafik"
  ];

  final deneyimList = [
    "0-1 yıl",
    "1-3 yıl",
    "3-5 yıl",
    "5+ yıl"
  ];

  Widget field(
    String label, {
    TextInputType type = TextInputType.text,
    List<TextInputFormatter>? format,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        keyboardType: type,
        inputFormatters: format,
        validator: (v) {
          if (v == null || v.isEmpty) {
            return "Zorunlu alan";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget drop<T>(
    String label,
    T? value,
    List<T> items,
    ValueChanged<T?> onChg,
  ) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      items: items
          .map(
            (e) => DropdownMenuItem<T>(
              value: e,
              child: Text(e.toString()),
            ),
          )
          .toList(),
      onChanged: (v) {
        setState(() {
          onChg(v);
        });
      },
      validator: (v) {
        if (v == null) {
          return "Seçim yapınız";
        }
        return null;
      },
    );
  }

  void cvSec() {
    setState(() {
      cv = "cv.pdf";
    });
  }

  void gonder() {
    if (formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Başarılı"),
          content: const Text(
            "Başvurunuz başarıyla alındı.\nEn kısa sürede dönüş yapılacaktır.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Tamam"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://images.unsplash.com/photo-1498050108023-c5249f4df085",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(color: Colors.black54),

          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: SafeArea(
              child: Form(
                key: formKey,
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "İş Başvuru Formu",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      field("Ad Soyad"),

                      field(
                        "Telefon",
                        type: TextInputType.number,
                        format: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),

                      field("Adres"),

                      field(
                        "Yaş",
                        type: TextInputType.number,
                        format: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),

                      drop<String>(
                        "Eğitim",
                        egitim,
                        egitimList,
                        (v) => egitim = v,
                      ),

                      const SizedBox(height: 10),

                      drop<String>(
                        "İş",
                        isTipi,
                        isList,
                        (v) => isTipi = v,
                      ),

                      const SizedBox(height: 10),

                      drop<String>(
                        "Deneyim",
                        deneyim,
                        deneyimList,
                        (v) => deneyim = v,
                      ),

                      const SizedBox(height: 15),

                      ElevatedButton.icon(
                        onPressed: cvSec,
                        icon: const Icon(Icons.upload_file),
                        label: Text(cv ?? "CV Ekle"),
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: gonder,
                          child: const Text("Gönder"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}