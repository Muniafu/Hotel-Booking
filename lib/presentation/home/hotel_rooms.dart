import 'package:flutter/material.dart';
import 'package:muniafu_hotel/domain/models/hotel.dart';
import 'package:muniafu_hotel/presentation/home/room_details.dart';

class HotelRoomsScreen extends StatelessWidget {
  final Hotel hotel;

  const HotelRoomsScreen({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${hotel.name} Rooms'),
      ),
      body: ListView.builder(
        itemCount: hotel.rooms.length,
        itemBuilder: (context, index) {
          final room = hotel.rooms[index];
          return ListTile(
            title: Text(room.type),
            subtitle: Text('\$${room.rate.toStringAsFixed(2)}'),
            trailing: Icon(
              room.isAvailable ? Icons.check : Icons.close,
              color: room.isAvailable ? Colors.green : Colors.red,
            ),
            onTap: () {
              // Navigate to the RoomDetailsScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      RoomDetailsScreen(hotel: hotel, room: room),
                ),
              );
            },
          );
        },
      ),
    );
  }
}