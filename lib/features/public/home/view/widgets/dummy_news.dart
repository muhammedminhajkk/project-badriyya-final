import 'package:flutter/material.dart';

class DummyNews extends StatelessWidget {
  const DummyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 120,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 17,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 220,
                          height: 20,
                          color: const Color.fromARGB(255, 167, 167, 167),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: 220,
                          height: 15,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 220,
                          height: 15,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 100,
                    height: 80,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(
                    width: 10,
                  )
                ],
              ),
            ),
          );
        });
  }
}
