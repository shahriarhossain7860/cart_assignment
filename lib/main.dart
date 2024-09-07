import 'package:flutter/material.dart';

void main() {
  runApp(cartApp());
}

class cartApp extends StatelessWidget {
  const cartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: cartScreen(),
    );
  }
}

class cartScreen extends StatefulWidget {
  const cartScreen({super.key});

  @override
  State<cartScreen> createState() => _cartScreenState();
}

class _cartScreenState extends State<cartScreen> {
  List<Map<String, dynamic>> cartItems = [
    {
      'title': 'Pullover',
      'color': 'black',
      'size': 'L',
      'quantity': 1,
      'price': 51,
      'image':
          'https://img.freepik.com/premium-photo/black-tshirt-hanging-white-wall-simple-minimalistic-clothing-display_194498-14008.jpg',
    },
    {
      'title': 'T-Shirt',
      'color': 'Gray',
      'size': 'L',
      'quantity': 1,
      'price': 30,
      'image':
          'https://img.freepik.com/premium-photo/black-tshirt-hanging-white-wall-simple-minimalistic-clothing-display_194498-14008.jpg',
    },
    {
      'title': 'Sport Dress',
      'color': 'Black',
      'size': 'L',
      'quantity': 1,
      'price': 43,
      'image':
          'https://cdn.dsmcdn.com/mnresize/600/-/ty1404/product/media/images/prod/QC/20240707/14/1f6480e3-efe5-33ba-9bf6-7620b7318a9d/1_org_zoom.jpg',
    },
  ];

  void _increment(int index) {
    setState(() {
      cartItems[index]['quantity']++;
    });
  }

  void _decrement(int index) {
    setState(() {
      if (cartItems[index]['quantity'] > 1) {
        cartItems[index]['quantity']--;
      }
    });
  }

  double get totalAmount {
    double total = 0;
    for (var item in cartItems) {
      total += item['quantity'] * item['price'];
    }
    return total;
  }

  void checkOut() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Congratulations!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Bag',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    return Card(
                        margin: EdgeInsets.all(10.0),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          leading: Image.network(
                            cartItems[index]['image'],
                            width: 60,
                            height: 60,
                          ),
                          title: Text(
                            cartItems[index]['title'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Color: ${cartItems[index]['color']} Size: ${cartItems[index]['size']}'),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () => _decrement(index),
                                  ),
                                  Text('${cartItems[index]['quantity']}'),
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () => _increment(index),
                                  )
                                ],
                              )
                            ],
                          ),
                          trailing: Text(
                              '${cartItems[index]['quantity'] * cartItems[index]['price']}\$'),
                        )
                    );
                  }
                  )
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total amount:',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${totalAmount.toStringAsFixed(2)}\$',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(15),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: checkOut,
                    child: Text('CHECK OUT', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
