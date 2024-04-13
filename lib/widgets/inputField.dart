import 'package:flutter/material.dart';

class InputFieldForm extends StatelessWidget {
  //final String title;
  final String hintText;
  final TextEditingController? textEditingController;
  final Widget? widget;
  const InputFieldForm(
      {super.key,
      //required this.title,
      required this.hintText,
      this.textEditingController,
      this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.black,
      //margin: EdgeInsets.only(top: 16),
      child: Column(
        children: [
          Container(
            height: 60,
            // margin: EdgeInsets.only(top: 8.0),
            // padding: EdgeInsets.only(left: 14),
            // decoration: BoxDecoration(
            //     border: Border.all(
            //       color: Colors.grey,
            //       width: 1.0,
            //     ),
            //     borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    controller: textEditingController,
                    // style: TextStyle(
                    //   fontSize: 14,
                    //   fontWeight: FontWeight.w400,
                    // ),
                    decoration: InputDecoration(
                        hintText: hintText,
                        // hintStyle: TextStyle(
                        //   fontSize: 16,
                        //   fontWeight: FontWeight.w400,
                        // ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.background,
                          width: 0,
                        ))),
                  ),
                ),
                widget == null ? Container() : Container(child: widget)
              ],
            ),
          )
        ],
      ),
    );
  }
}
