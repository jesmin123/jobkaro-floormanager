import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/constants/app_font_style.dart';
import 'package:job_karo_floor_manager/constants/colors.dart';
import 'package:job_karo_floor_manager/ui/widget/add_new_item.dart';


class AddnewTab extends StatefulWidget {
  @override
  _AddnewTabState createState() => _AddnewTabState();
}




class _AddnewTabState extends State<AddnewTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
           children: [
             Padding(
               padding: const EdgeInsets.all(12.0),
               child: TextFormField(
                 decoration: InputDecoration(
                     focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
                   enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
                   hintText: 'Search by car No.',
                   prefixIcon: Icon(Icons.search),
                   contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),


                 ),

               ),
             ),
             AddNewItem(),
           ],
      ),
    );
  }
}
