import 'package:flutter/material.dart'; 
class CitySelection extends StatefulWidget { 
  String selection;
  @override
  _CitySelectionState createState() => _CitySelectionState();
}

class _CitySelectionState extends State<CitySelection> {  
  // get value of edittext to send the weather 
  final TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Text('City'),
      ), 
      body: Form( 
        child: Row( 
          children:[ 
            Expanded( 
              child: Padding( 
                padding: EdgeInsets.only(left: 10.0), 
                child: TextFormField(  
                  // save the edittext
                  controller: _textController, 
                  decoration: InputDecoration( 
                    labelText: 'City', 
                    hintText: 'Chicago'
                  ),
                ),
              ),
            ), 
            IconButton( 
              icon: Icon(Icons.search), 
              onPressed: (){ 
                // malakuakn intent ke halaman sebelumnya dengan mengirim data berupa editext  
                Navigator.pop(context, _textController.text);
              },
            )
          ],
        ),
      ),
    );
  }
}