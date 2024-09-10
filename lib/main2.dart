import 'package:flutter/material.dart';
import 'package:flutter_white2/home.dart';
import 'package:flutter_white2/product1.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'cartprovider.dart';
import 'cartscreen.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        home: AuthScreen(),
        routes: {
          '/main': (context) => MyApp(),
          '/cart': (context) => CartScreen(),
        },
      ),
    ),
  );
}

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _toggleAuthMode() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  void _submitAuthForm() {
    if (isLogin) {
      Navigator.pushReplacementNamed(context, '/main');
    } else {
      _showScratchCard(context);
    }
  }

  void _showScratchCard(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => ScratchCardDialog(),
    ).then((_) {
      Navigator.pushReplacementNamed(context, '/main');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/images/m1.jpg',
                fit: BoxFit.cover,
              ),
            ),
            pinned: true,
            backgroundColor: Colors.blueAccent,
          ),
          SliverFillRemaining(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Card(
                  color: Colors.white.withOpacity(0.9),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          isLogin ? 'Welcome Back!' : 'Create an Account',
                          style: GoogleFonts.dancingScript(
                            textStyle:
                                TextStyle(fontSize: 35, color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            prefixIcon: Icon(Icons.lock),
                          ),
                          obscureText: true,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _submitAuthForm,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 100, vertical: 15),
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            isLogin ? 'Login' : 'Sign Up',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextButton(
                          onPressed: _toggleAuthMode,
                          child: Text(
                            isLogin
                                ? 'New user? Sign Up'
                                : 'Already have an account? Login',
                            style: TextStyle(
                                fontSize: 16, color: Colors.blueAccent),
                          ),
                        ),
                      ],
                    ),
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

// Scratch Card Dialog with Sparkle Animation
class ScratchCardDialog extends StatefulWidget {
  @override
  _ScratchCardDialogState createState() => _ScratchCardDialogState();
}

class _ScratchCardDialogState extends State<ScratchCardDialog> {
  bool revealed = false;
  bool _showSparkle = false;
  final List<Product> randomProducts = [
    Product(name: 'Product 1', price: 0.0, imageUrl: 'assets/images/shoe6.jpg'),
    Product(name: 'Product 2', price: 0.0, imageUrl: 'assets/images/shoe8.jpg'),
    Product(
        name: 'Product 3', price: 0.0, imageUrl: 'assets/images/shorts.jpg'),
  ];

  Product? _selectedProduct;

  @override
  void initState() {
    super.initState();
    _selectedProduct = randomProducts[Random().nextInt(randomProducts.length)];
  }

  void _revealProduct() {
    setState(() {
      revealed = true;
    });

    final cart = Provider.of<CartProvider>(context, listen: false);
    if (_selectedProduct != null) {
      cart.addToCart(_selectedProduct!);
    }
  }

  void _showSparkleAnimation() {
    setState(() {
      _showSparkle = true;
    });

    Future.delayed(Duration(seconds: 3), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Center(
        child: Text(
          'Congratulations!',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              revealed
                  ? 'You have revealed a product!'
                  : 'Scratch to reveal your product!',
              textAlign: TextAlign.center,
              style: GoogleFonts.cookie(
                textStyle: TextStyle(
                  fontSize: 35,
                  color: revealed ? Colors.black : Colors.red,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: _revealProduct,
            child: Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: revealed
                      ? [Colors.green, Colors.blueAccent]
                      : [Colors.grey, Colors.black54],
                ),
              ),
              child: Center(
                child: revealed
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${_selectedProduct?.name} is available for Rs. 0!',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Image.asset(
                            _selectedProduct?.imageUrl ?? '',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ],
                      )
                    : Icon(Icons.lock, size: 50, color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _showSparkleAnimation,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              'Continue',
              style: TextStyle(fontSize: 18),
            ),
          ),
          if (_showSparkle)
            Lottie.asset(
              'assets/animations/sparkle.json',
              width: 150,
              height: 150,
              repeat: false,
              onLoaded: (composition) {
                Future.delayed(composition.duration, () {
                  Navigator.pop(context);
                });
              },
            ),
        ],
      ),
    );
  }
}
