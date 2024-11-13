import 'package:flutter/material.dart';

class LoginImage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: 
        Image.network(
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhKZ_7LciBKF7SyPh9hN2rhojLN_M-2H69g9bCNZW_fbu_KHzQ7a5JKCE-9s59aCExhSbHF__AEH84xB8p6oWLvvixwnIpPvTPl6arccc', 
          width: 300,
          height: 300,
        ),
    );
  }

}