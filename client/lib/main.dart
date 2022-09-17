// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_flutter/motor_flutter.dart';
import 'login_page.dart';

Future<void> main() async {
  // Init Services
  WidgetsFlutterBinding.ensureInitialized();
  await MotorFlutter.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final WhoIs? whoIs;
  late final SchemaDefinition? testSchema;
  late final SchemaDocument? testDocument;
  late final List<int>? dscKey;
  late final List<int>? pskKey;
  String titleMsg = "DATS";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Motor Flutter Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(titleMsg),
          leading: IconButton(
            icon: const Icon(Icons.account_circle_rounded),
            //
            // 1. Register a new account
            //
            onPressed: () async {
              // When running your application in Debug mode the device keychain is unavailble in the Simulator.
              // We have provided a callback which returns your dsc and psk for storing your keys securely.
              // The Sonr team reccomends either of the following packages to store your keys:
              // - [biometric_storage] https://pub.dev/packages/biometric_storage
              // - [flutter_keychain] https://pub.dev/packages/flutter_keychain
              final res = await MotorFlutter.to.createAccount("mko09ijn",
                  onKeysGenerated: (dsc, psk) {
                dscKey = dsc;
                pskKey = psk;
              });
              whoIs = res;
            },
          ),
          actions: [
            IconButton(
                //
                // 2. Login to new account
                //
                onPressed: () async {
                  // This line is unnecessary it is the Developers Job to provide a UI
                  // to be able to input Password, and Account Address. In production mode
                  // the dscKey and pskKey are stored by the motor_flutter plugin in the device
                  // keychain.
                  if (whoIs == null) {
                    Get.snackbar("Error", "WhoIs Field has not been set");
                    return;
                  }
                  final res = await MotorFlutter.to.login(
                    password: "mko09ijn",
                    address: whoIs!.owner,
                    dscKey: dscKey,
                    pskKey: pskKey,
                  );
                  whoIs = res;
                  Get.snackbar("Error", "Failed to login user");
                  return;
                },
                icon: const Icon(Icons.login))
          ],
        ),
        body: Column(
          children: [
            //
            // 3. Try creating a Schema
            //
            MaterialButton(
              child: const Text("New Example Schema"),
              onPressed: () async {
                // Set the label, followed by a map with the property name and the
                // associated primitive type.
                final res = await MotorFlutter.to.createSchema(
                    "Profile",
                    Map<String, SchemaKind>.from({
                      "name": SchemaKind.STRING,
                      "age": SchemaKind.INT,
                      "height": SchemaKind.FLOAT,
                    }));
                testSchema = res.schemaDefinition;
              },
            ),
            //
            // 4. Lets build a Document from that schema
            //
            MaterialButton(
              child: const Text("Build Document from Schema"),
              onPressed: () async {
                if (testSchema == null) {
                  Get.snackbar(
                    "Error",
                    "Failed to create schema",
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                  return;
                }

                testDocument = testSchema?.newDocument();
                testDocument!.set<String>("name", "Todd");
                testDocument!.set<int>("age", 24);
                testDocument!.set<double>("height", 5.11);
              },
            ),

            //
            // 5. Upload Document to App-Specific Data Store
            //
            MaterialButton(
              child: const Text("Upload Document to User Data Store"),
              onPressed: () async {
                if (testDocument == null) {
                  Get.snackbar(
                    "Error",
                    "Failed to find testDocument",
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                  return;
                }

                final doc = await testDocument?.save("hello-flutter");
                if (doc == null) {
                  Get.snackbar(
                    "Error",
                    "Failed to Upload testDocument",
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                  return;
                }
                Get.snackbar("Success",
                    "Uploaded document to user encrypted IPFS Store. CID: ${doc.cid}");
              },
            ),
          ],
        ),
      ),
    );
  }
}
