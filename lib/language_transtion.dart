import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTranstionPage extends StatefulWidget {
  const LanguageTranstionPage({super.key});

  @override
  State<LanguageTranstionPage> createState() => _LanguageTranstionPageState();
}

class _LanguageTranstionPageState extends State<LanguageTranstionPage> {
  var languages = ['French', 'English', 'Arabic', 'German', 'Italian'];
  var originLanguage = 'From';
  var destinationLanguage = 'To';
  var outPut = '';
  TextEditingController languageController = TextEditingController();
  bool isLoading = false;

  //translte function:
  void translate(String src, String dest, String input) async {
    if (src == '--' || dest == '--') {
      setState(() {
        outPut = "Fail to translate";
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      GoogleTranslator translator = GoogleTranslator();
      var translationText =
          await translator.translate(input, from: src, to: dest);
      setState(() {
        outPut = translationText.text.toString();
      });
    } catch (e) {
      setState(() {
        outPut = "Error translating";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

//get language function:
  String getLanguageCode(String language) {
    if (language == 'English') {
      return "en";
    } else if (language == 'French') {
      return "fr";
    } else if (language == 'Arabic') {
      return "ar";
    } else if (language == 'German') {
      return "de";
    } else if (language == 'Italian') {
      return "it";
    }
    return "--";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 86, 95),
      appBar: AppBar(
        title: const Text(
          'Language Translator',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black,
                  offset: Offset(-5, 2),
                )
              ]),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 16, 86, 95),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(
                    focusColor: Colors.transparent,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      originLanguage,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    dropdownColor: Colors.white,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                    ),
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        value: dropDownStringItem,
                        child: Text(
                          dropDownStringItem,
                          style: const TextStyle(
                            color: Color(0xff10223d),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        originLanguage = value!;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  const Icon(
                    Icons.arrow_right_alt_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  DropdownButton(
                    focusColor: Colors.transparent,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      destinationLanguage,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    dropdownColor: Colors.white,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                    ),
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        destinationLanguage = value!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                child: TextFormField(
                  cursorColor: Colors.white,
                  autofocus: false,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Please enter your text ..',
                    labelStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                  controller: languageController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter text to translate';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      ) // Show the circular progress indicator
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.2),
                        ),
                        onPressed: () {
                          translate(
                            getLanguageCode(originLanguage),
                            getLanguageCode(destinationLanguage),
                            languageController.text.toString(),
                          );
                        },
                        child: const Center(
                          child: Text(
                            'Translate',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
              ),
              const SizedBox(
                height: 20,
              ),
              isLoading
                  ? const Text('')
                  : Text(
                      "\n$outPut",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
