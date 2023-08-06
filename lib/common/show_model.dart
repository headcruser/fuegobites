import 'package:flutter/material.dart';
import 'package:fuego_bites/constants/app_style.dart';
import 'package:gap/gap.dart';

class NewOrderModel extends StatelessWidget {
  const NewOrderModel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: double.infinity,
              child: Text(
                'Nuevo Pedido',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
              ),
            ),

            Divider(
              thickness: 1.2,
              color: Colors.grey.shade200,
            ),
            
            const Gap(12),

            const Text(
              'Titulo', 
              style: AppStyle.headingStyle
            ),
            
            const Gap(6),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: 'Escribe el titulo'
                ),
              )
            )
            
          ],
        ),
      ) 
    );
  }
}