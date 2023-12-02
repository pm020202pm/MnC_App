import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import '../../functions.dart';
import '../misc/my_icon_button.dart';
class ClubImageCard extends StatelessWidget {
  const ClubImageCard({super.key, required this.imgUrl, required this.caption, required this.clubName, required this.deleteId, required this.mediaDeleteId, required this.dim});
  final List<double> dim;
  final String imgUrl;
  final String caption;
  final String deleteId;
  final String mediaDeleteId;
  final String clubName;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        InkWell(
          onTap: (){
            showDialog(
                context: context,
                builder: (BuildContext context){
                  return StatefulBuilder(builder: (context, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 25),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade100, width: 2),
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.shade300,
                                ),
                                width: screenSize.width*0.8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                        child: Image.network(imgUrl, width: screenSize.width*0.8,)),
                                    const Gap(17),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(caption, style: GoogleFonts.varelaRound(textStyle: TextStyle(color: Colors.grey[700], fontSize: 15, fontWeight: FontWeight.w600,)),),
                                    ),
                                    const Gap(15),
                                  ],
                                ),
                              ),
                            ),
                            if(userName==clubName)Padding(
                                padding: const EdgeInsets.only(right: 25),
                                child: MyIconButton(height: 50, width: 50, iconSize: 28, iconColor: Colors.red, radius: 30, icon: Icons.delete_forever, backgroundColor:  Colors.red.shade100.withOpacity(0.9),
                                  onTap: (){showWarning(context, 'Are you sure to remove?', (){ deleteEntity(userName, deleteId).then((value) => deleteEntity('media', mediaDeleteId)).then((value) => Navigator.pop(context)).then((value) => Navigator.pop(context));});},
                                )
                            )
                          ],
                        ),
                      ],
                    );
                  });
                }
            );
          },
          child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: Image.network(imgUrl, width: dim[1], height: dim[0], fit: BoxFit.cover,)),
        ),
      ],
    );
  }
}
