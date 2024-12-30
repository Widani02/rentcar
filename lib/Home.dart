import 'package:flutter/material.dart';
import 'about_us.dart';

// Model untuk Mobil
class Car {
  final String name;
  final String image;
  final String description;

  Car({required this.name, required this.image, required this.description, required String fuelType, required String fuelEfficiency, required int seatCapacity});
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final List<Car> cars = [ 
  Car(
    name: 'Mitsubishi Pajero Sport',
    image: 'assets/images/pajero.png',
    fuelType: 'Diesel',
    fuelEfficiency: '13.9 km/L',
    seatCapacity: 7, description: '',
  ),
  Car(
    name: 'Toyota Avanza Veloz',
    image: 'assets/assets/car3.png',
    fuelType: 'Bensin',
    fuelEfficiency: '21.9 km/L',
    seatCapacity: 7, description: '',
  ),
  Car(
    name: 'Innova Reborn',
    image: 'assets/car3.png',
    fuelType: 'Bensin',
    fuelEfficiency: '22.9 km/L',
    seatCapacity: 7, description: '',
  ),
  Car(
    name: 'Xpander',
    image: 'assets/car4.jpg',
    fuelType: 'Diesel',
    fuelEfficiency: '22.1 km/L',
    seatCapacity: 7, description: '',
  ),
];



  final List<Car> keranjang = []; // Menyimpan mobil yang ada di keranjang

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addToKeranjang(Car car) {
    setState(() {
      keranjang.add(car);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${car.name} ditambahkan ke keranjang!')),
    );
  }

  void _removeFromKeranjang(Car car) {
    setState(() {
      keranjang.remove(car);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${car.name} dihapus dari keranjang!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(cars: cars, onBookNow: _addToKeranjang),
      KeranjangPage(keranjang: keranjang, onCancelBooking: _removeFromKeranjang),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Rental App'),
        actions: [
          // Tombol untuk navigasi ke About Us
          IconButton(
            icon: const Icon(Icons.person),  // Ikon orang untuk About Us
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutUs()),  // Navigasi ke About Us
              );
            },
          ),
        ],
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Keranjang', // Label untuk Keranjang
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

// Halaman HomePage
class HomePage extends StatelessWidget {
  final List<Car> cars;
  final Function(Car) onBookNow;

  const HomePage({super.key, required this.cars, required this.onBookNow});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cars.length,
      itemBuilder: (context, index) {
        final car = cars[index];
        return Card(
          margin: const EdgeInsets.all(12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // Vertikal tengah
              crossAxisAlignment: CrossAxisAlignment.center, // Horizontal tengah
              children: [
                // Gambar Mobil
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    car.image,
                    width: 250, // Perbesar lebar gambar
                    height: 150, // Perbesar tinggi gambar
                    fit: BoxFit.cover, // Memastikan gambar proporsional
                  ),
                ),
                const SizedBox(width: 100.0),
                // Informasi Mobil
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        car.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      const Row(
                        children: [
                          Icon(Icons.local_gas_station, size: 20),
                          SizedBox(width: 20),
                          Text('Diesel, 13.9 km/L'),
                        ],
                      ),
                      const SizedBox(height: 6.0),
                      const Row(
                        children: [
                          Icon(Icons.event_seat, size: 16),
                          SizedBox(width: 10),
                          Text('7 Seat'),
                        ],
                      ),
                      const SizedBox(height: 6.0),
                      const Row(
                        children: [
                          Icon(Icons.star, size: 16, color: Colors.amber),
                          SizedBox(width: 6),
                          Text('4.5/5'),
                        ],
                      ),
                    ],
                  ),
                ),
                // Tombol Book
                ElevatedButton(
                  onPressed: () => onBookNow(car),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 6.0,
                    ),
                  ),
                  child: const Text('Book Now'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Halaman Keranjang
class KeranjangPage extends StatelessWidget {
  final List<Car> keranjang;
  final Function(Car) onCancelBooking;

  const KeranjangPage({
    super.key,
    required this.keranjang,
    required this.onCancelBooking,
  });

  @override
  Widget build(BuildContext context) {
    if (keranjang.isEmpty) {
      return const Center(
        child: Text(
          'Keranjang Anda kosong!',
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return ListView.builder(
      itemCount: keranjang.length,
      itemBuilder: (context, index) {
        final car = keranjang[index];
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Image.asset(
              car.image,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
            title: Text(car.name),
            subtitle: Text(car.description),
            trailing: ElevatedButton(
              onPressed: () => onCancelBooking(car),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Cancel Booking'),
            ),
          ),
        );
      },
    );
  }
}
