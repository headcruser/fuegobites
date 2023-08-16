import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuego_bites/constants/app_style.dart';
import 'package:fuego_bites/model/order_model.dart';
import 'package:fuego_bites/provider/datetime_provider.dart';
import 'package:fuego_bites/provider/service_provider.dart';
import 'package:fuego_bites/widget/datetime_widget.dart';
import 'package:fuego_bites/widget/textfield_widget.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class NewOrderModel extends ConsumerWidget {
  NewOrderModel({
    super.key,
  });

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();


  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final dateProv = ref.watch(dateProvider);

    return Container(
      height: MediaQuery.of(context).size.height * 0.70,
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

            TextFieldWidget(
              hintText: "Escribe el titulo",
              maxLine: 1,
              txtController: titleController,
            ),

            const Gap(12),

            const Text(
              'Descripción', 
              style: AppStyle.headingStyle
            ),
            
            const Gap(6),

            TextFieldWidget(
              hintText: "Escribe el detalle del pedido",
              maxLine: 5,
              txtController: descriptionController,
            ),

            const Gap(12),
            
            // FECHA ENTREGA
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DateTimeWidget(
                  titleText: "Fecha entrega",
                  valueText: dateProv,
                  icon: CupertinoIcons.calendar,
                  onTap:  () async {
                    final picked = await showDatePicker(
                      context: context, 
                      initialDate: DateTime.now(), 
                      firstDate: DateTime(2021), 
                      lastDate: DateTime(2025)
                    );

                    if (picked != null) {
                      final format = DateFormat.yMd();

                      ref.read(dateProvider.notifier).update((state) {
                        return format.format(picked);
                      });
                    }
                  }
                  
                )
              ]
            ),
            
            const Gap(12),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue.shade800,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                      ),
                      side: BorderSide(
                        color: Colors.blue.shade200
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14)
                    ),
                    child: const Text("Cancelar"),
                  )
                ),

                const Gap(20),

                Expanded(
                  child: ElevatedButton(
                    onPressed: (){
                      ref.read(serviceProvider).addOrder(OrderModel(
                          nombre: titleController.text, 
                          descripcion: titleController.text.toString(), 
                          fecha: DateTime.now().toIso8601String(), 
                          fechaEntrega: ref.read(dateProvider), 
                          activo: true, 
                          pagado: false
                        )
                      );

                      print('💾 guardado...');

                      titleController.clear();
                      descriptionController.clear();
                      Navigator.pop(context);

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade800,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14)
                    ),
                    child: const Text("Agregar"),
                  )
                ),
              ]
            ),
          ],
        ),
      ) 
    );
  }
}



