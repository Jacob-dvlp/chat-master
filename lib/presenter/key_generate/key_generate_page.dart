import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../core/app_thema.dart';
import 'key_generate_controller.dart';

class KeyGeneratePage extends GetView<KeyGenerateController> {
  const KeyGeneratePage({Key? key}) : super(key: key);
  static String routNamed = "/key";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      height: 90.0,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Success',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'Your OpenAI API key has been saved successfully. You wont need to enter it again in the future.',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.white,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              elevation: 0,
              duration: const Duration(seconds: 2),
            ),
          );
        },
        child: const CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.send_outlined,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: AppThema.primaryColor,
      appBar: AppBar(
        backgroundColor: AppThema.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                'Gerar a',
                style: TextStyle(fontSize: 20.0, color: Colors.black87),
              ),
              const SizedBox(
                height: 5.0,
              ),
              const Text(
                'API Key',
                style: TextStyle(fontSize: 20.0, color: Colors.black87),
              ),
              const SizedBox(
                height: 15.0,
              ),
              const Text(
                'To chat with me, get an API key from OpenAI. Simply click this button and follow the steps to generate a key. '
                'Then enter the key in our app to start chatting',
                style: TextStyle(fontSize: 12.0, color: Colors.black87),
              ),
              const SizedBox(
                height: 20.0,
              ),
              InkWell(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2.4,
                  child: Card(
                    elevation: 25,
                    shape: const StadiumBorder(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: const [
                          Icon(Icons.key_outlined),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'cria sua chave',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                child: const Text(
                  'After copied your Api key paste and save it here',
                  style: TextStyle(fontSize: 12.0, color: Colors.black87),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  floatingLabelStyle: const TextStyle(color: Colors.black87),
                  labelText: 'Colar sua API Key',
                  labelStyle:
                      const TextStyle(fontSize: 12.0, color: Colors.black87),
                  suffixIcon: IconButton(
                      onPressed: () async {
                        final clipPaste =
                            await Clipboard.getData(Clipboard.kTextPlain);
                        final text = clipPaste == null ? '' : clipPaste.text!;
                        // setState(() {
                        //   pasteController.text = text;
                        // });
                      },
                      icon: const Icon(
                        Icons.content_paste,
                        color: Colors.blueGrey,
                        size: 15.0,
                      )),
                ),
                //  controller: pasteController,
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
