//  ZOOMIN and ZOOMOUT IMAGES

// import 'package:flutter/material.dart';
//
// class Animationpart extends StatefulWidget {
//   final List<Map<String, dynamic>> data= [
//   {'imageUrl': 'https://cdn.pixabay.com/photo/2023/04/15/05/48/woman-7927039_1280.png', 'name': 'Alice', 'age': 25},
//   {'imageUrl': 'https://cdn.pixabay.com/photo/2023/04/15/05/48/woman-7927039_1280.png', 'name': 'Bob', 'age': 30},
//   {'imageUrl': 'https://cdn.pixabay.com/photo/2023/04/15/05/48/woman-7927039_1280.png', 'name': 'Charlie', 'age': 28},
//   ];
//
//   @override
//   _ZoomableCardGridState createState() => _ZoomableCardGridState();
// }
//
// class _ZoomableCardGridState extends State<Animationpart> {
//   int? _zoomedIndex;
//   bool _isZoomingOut = false;
//   void _toggleZoom(int index) {
//     if (_zoomedIndex == index) {
//       // Start zoom-out animation
//       setState(() {
//         _isZoomingOut = true;
//       });
//
//       // Wait for animation to complete before removing the card
//       Future.delayed(Duration(milliseconds: 1000), () {
//         if (mounted) {
//           setState(() {
//             _zoomedIndex = null;
//             _isZoomingOut = false;
//           });
//         }
//       });
//     } else {
//       // Zoom in to selected card
//       setState(() {
//         _zoomedIndex = index;
//         _isZoomingOut = false;
//       });
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//
//     return Stack(
//       children: [
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: List.generate(3, (index) {
//                 final item = widget.data[index];
//                 return GestureDetector(
//                   onTap: () => _toggleZoom(index),
//                   child: Card(
//                     elevation: 4,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Container(
//                       width: screenSize.width / 3 - 20,
//                       padding: EdgeInsets.all(8),
//                       child: Column(
//                         children: [
//                           Image.network(item['imageUrl'], height: 80, fit: BoxFit.cover),
//                           SizedBox(height: 20),
//                           Text(item['name'], style: TextStyle(fontWeight: FontWeight.bold)),
//                           Text('Age: ${item['age']}'),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               }),
//             ),
//           ],
//         ),
//
//         // Zoomed-in card with animation
//         AnimatedOpacity(
//           opacity: _zoomedIndex != null ? 1.0 : 0.0,
//           duration: Duration(milliseconds: 300),
//           curve: Curves.easeInOut,
//           child: IgnorePointer(
//             ignoring: _zoomedIndex == null,
//             child: Container(
//               color: Colors.black.withOpacity(0.5),
//               child: Center(
//                 child: AnimatedScale(
//                   scale: (_zoomedIndex != null && !_isZoomingOut) ? 1.0 : 0.8,
//                   duration: Duration(milliseconds: 300),
//                   curve: Curves.easeInOut,
//                   child: (_zoomedIndex != null)
//                       ? Stack(
//                     children: [
//                       Card(
//                         elevation: 12,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         child: Container(
//                           width: screenSize.width * 0.9,
//                           height: screenSize.height * 0.9,
//                           padding: EdgeInsets.all(16),
//                           child: Column(
//                             children: [
//                               Image.network(
//                                 widget.data[_zoomedIndex!]['imageUrl'],
//                                 height: 200,
//                                 fit: BoxFit.cover,
//                               ),
//                               SizedBox(height: 16),
//                               Text(
//                                 widget.data[_zoomedIndex!]['name'],
//                                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                 'Age: ${widget.data[_zoomedIndex!]['age']}',
//                                 style: TextStyle(fontSize: 18),
//                               ),
//                               SizedBox(height: 20),
//                               Text(
//                                 'This is full screen mode.',
//                                 style: TextStyle(fontSize: 16),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       // Close button
//                       Positioned(
//                         right: 8,
//                         top: 8,
//                         child: GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               _isZoomingOut = true;
//                             });
//
//                             Future.delayed(Duration(milliseconds: 300), () {
//                               if (mounted) {
//                                 setState(() {
//                                   _zoomedIndex = null;
//                                   _isZoomingOut = false;
//                                 });
//                               }
//                             });
//                           },
//                           child: CircleAvatar(
//                             backgroundColor: Colors.red,
//                             child: Icon(Icons.close, color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                       : SizedBox.shrink(),
//                 ),
//               ),
//             ),
//           ),
//         )
//
//
//       ],
//     );
//
//   }
// }







import 'package:flutter/material.dart';

class Animationpart extends StatefulWidget {
  final List<Map<String, dynamic>> data= [
    {'imageUrl': 'https://cdn.pixabay.com/photo/2023/04/15/05/48/woman-7927039_1280.png', 'name': 'Alice', 'age': 25},
    {'imageUrl': 'https://cdn.pixabay.com/photo/2023/04/15/05/48/woman-7927039_1280.png', 'name': 'Bob', 'age': 30},
    {'imageUrl': 'https://cdn.pixabay.com/photo/2023/04/15/05/48/woman-7927039_1280.png', 'name': 'Charlie', 'age': 28},
  ];

  @override
  _ZoomCardViewerState createState() => _ZoomCardViewerState();
}


//
// class ZoomCardViewer extends StatefulWidget {
//   final List<Map<String, dynamic>> data;
//
//   const ZoomCardViewer({Key? key, required this.data}) : super(key: key);
//
//   @override
//   _ZoomCardViewerState createState() => _ZoomCardViewerState();
// }

class _ZoomCardViewerState extends State<Animationpart> with SingleTickerProviderStateMixin {
  int? _zoomedIndex;
  bool _isZoomingOut = false;

  late AnimationController _springController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _springController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _springController,
      curve: Curves.elasticOut,
    );
  }

  @override
  void dispose() {
    _springController.dispose();
    super.dispose();
  }

  void _onCardTap(int index) {
    setState(() {
      _zoomedIndex = index;
      _isZoomingOut = false;
    });

    _springController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Main cards
          GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: widget.data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 1,
              mainAxisSpacing: 5,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _onCardTap(index),
                child: Card(
                  elevation: 4,
                  child: Column(
                    children: [
                      Image.network(
                        widget.data[index]['imageUrl'],
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 8),
                      Text(widget.data[index]['name']),
                    ],
                  ),
                ),
              );
            },
          ),

          // Zoomed view overlay
          AnimatedOpacity(
            opacity: _zoomedIndex != null ? 1.0 : 0.0,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: IgnorePointer(
              ignoring: _zoomedIndex == null,
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: (_zoomedIndex != null)
                        ? Stack(
                      children: [
                        Card(
                          elevation: 12,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Container(
                            width: screenSize.width * 0.9,
                            height: screenSize.height * 0.9,
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Image.network(
                                  widget.data[_zoomedIndex!]['imageUrl'],
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  widget.data[_zoomedIndex!]['name'],
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Age: ${widget.data[_zoomedIndex!]['age']}',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'This is full screen mode.',
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Close button
                        Positioned(
                          right: 8,
                          top: 8,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isZoomingOut = true;
                              });

                              Future.delayed(Duration(milliseconds: 300), () {
                                if (mounted) {
                                  setState(() {
                                    _zoomedIndex = null;
                                    _isZoomingOut = false;
                                  });
                                }
                              });
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              child: Icon(Icons.close, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )
                        : SizedBox.shrink(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

