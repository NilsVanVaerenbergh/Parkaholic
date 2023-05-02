import 'package:flutter/material.dart';

void pullUpMenu(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SizedBox(
            height: MediaQuery.of(context).size.height * .30,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text("Klik om uw parkeerplaats vrij te geven"),
                        IconButton(
                          icon: const Icon(Icons.cancel),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    )
                  ],
                )));
      });
}
