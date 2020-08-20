import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smk_losarangg/providers/p_users.dart';

class EditPassword extends StatefulWidget {
  EditPassword({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _EditPassword createState() => _EditPassword();
}

class _EditPassword extends State<EditPassword> {
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerPassword2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Ganti Password"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                controller: controllerPassword,
                decoration: InputDecoration(
                    labelText: "Baru",
                    hintText: "Password Baru",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                controller: controllerPassword2,
                decoration: InputDecoration(
                    labelText: "Verifikasi",
                    hintText: "Password baru sekali lagi",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            RaisedButton(
              color: Colors.amber,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text("Ganti"),
              textColor: Colors.white,
              onPressed: () {
                if (controllerPassword.text == controllerPassword2.text) {
                  Provider.of<ProviderUsers>(context, listen: false)
                      .updatePassword(
                    context: context,
                    password: controllerPassword.text,
                  );
                } else {
                  Flushbar(
                    message: "Password tidak sama",
                    icon: Icon(
                      Icons.info_outline,
                      size: 28.0,
                      color: Colors.blue[300],
                    ),
                    duration: Duration(seconds: 3),
                    leftBarIndicatorColor: Colors.blue[300],
                  )..show(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
