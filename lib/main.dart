import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        ),
      ),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Kişilik Anketi"),
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 77, 175, 255),
          ),
          body: const SurveyForm(),
        ),
      ),
    );
  }
}

class SurveyForm extends StatefulWidget {
  const SurveyForm({Key? key}) : super(key: key);

  @override
  State<SurveyForm> createState() => _SurveyFormState();
}

class _SurveyFormState extends State<SurveyForm> {
  bool isAdult = false;
  bool isSmoker = false;
  String? selectedGender;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController smokerCountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text("Adınız ve Soyadınız"),
                const SizedBox(height: 40),
                TextField(controller: nameController),
                const SizedBox(height: 40),
                DropdownButton<String>(
                  items: [
                    DropdownMenuItem(
                      value: "Erkek",
                      child: Row(
                        children: [
                          Icon(Icons.male, color: Colors.blue),
                          const SizedBox(width: 8),
                          Text("Erkek"),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: "Kadın",
                      child: Row(
                        children: [
                          Icon(Icons.female, color: Colors.pink),
                          const SizedBox(width: 8),
                          Text("Kadın"),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: "Diğer",
                      child: Row(
                        children: [
                          Icon(Icons.transgender, color: Colors.purple),
                          const SizedBox(width: 8),
                          Text("Diğer"),
                        ],
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                  value: selectedGender,
                  hint: const Text("Cinsiyetiniz"),
                ),
                const SizedBox(height: 20),
                CheckboxListTile(
                  value: isAdult,
                  onChanged: (newValue) {
                    setState(() {
                      isAdult = newValue ?? false;
                    });
                  },
                  title: const Text("Reşit misiniz?"),
                ),
                const SizedBox(height: 20),
                SwitchListTile(
                  value: isSmoker,
                  onChanged: (newValue) {
                    setState(() {
                      isSmoker = newValue;
                    });
                  },
                  title: const Text("Sigara kullanıyor musunuz?"),
                ),
                if (isSmoker)
                  TextField(
                    controller: smokerCountController,
                    decoration: InputDecoration(
                      labelText: "Günde kaç tane sigara içiyorsunuz?",
                    ),
                    keyboardType: TextInputType.number,
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: const Text("Bilgileri Kaydet"),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Bilgileriniz"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Adınız ve Soyadınız: ${nameController.text}"),
                            Text("Cinsiyetiniz: $selectedGender"),
                            Text(
                              "Reşit misiniz?: ${isAdult ? "Evet" : "Hayır"}",
                            ),
                            Text(
                              "Sigara kullanıyor musunuz?: ${isSmoker ? "Evet" : "Hayır"}",
                            ),
                            if (isSmoker)
                              Text(
                                "Günde ${smokerCountController.text} tane sigara içiyorsunuz. \nBağımlılıkları önlemek için lütfen dikkatli olun!",
                              ),
                            if (isSmoker &&
                                int.tryParse(smokerCountController.text) !=
                                    null &&
                                int.parse(smokerCountController.text) > 5)
                              Text(
                                "Uyarı: Günde 5'ten fazla sigara içiyorsunuz, lütfen sağlığınıza dikkat edin!",
                                style: const TextStyle(color: Colors.red),
                              ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("Kapat"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
