import 'package:flutter/material.dart';
class ProfilePic extends StatelessWidget {
  const ProfilePic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: SizedBox(
              height: 40,
              width: 40,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade200,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.camera_alt_outlined),
                  color: Colors
                      .grey.shade600, // İcon rengi beyaz olarak ayarlanmıştır, isteğe bağlı olarak değiştirilebilir.
                  iconSize: 24,
                  padding: EdgeInsets
                      .zero, // İconButton içindeki padding sıfırlandı.
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}