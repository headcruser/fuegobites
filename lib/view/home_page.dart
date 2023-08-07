import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuego_bites/common/show_model.dart';
import 'package:fuego_bites/provider/service_provider.dart';
import 'package:fuego_bites/widget/cardorder_widget.dart';
import 'package:gap/gap.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersData = ref.watch(fetchStreamProvider);
    final int totalOrders = (ordersData.value == null) 
                      ? 0 
                      :ordersData.value!.length;

    return Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            title: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.red.shade100,
                radius: 25,
                child: Image.asset(
                  'assets/fuego_bites_logo.png', 
                  fit: BoxFit.cover
                ),            
              ),
              
              title: Text(
                "Fuego Bites",
                style: TextStyle(
                  fontSize: 12, 
                  color: Colors.grey.shade400
                )
              ),

              subtitle: const Text(
                "Daniel Martinez",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                )
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const Gap(20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Pedidos",
                            style: TextStyle( 
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                            ),
                          ),
                          Text("Total $totalOrders",style: const TextStyle( color: Colors.grey)),
                        ],
                      ),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffd5e8fa),
                          foregroundColor: Colors.blue.shade800,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                          )
                        ),
                        onPressed: (){
                          showModalBottomSheet(
                            context: context, 
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)
                            ),
                            builder: (context) => NewOrderModel()
                          );
                        }, 
                        child: const Text("Nuevo pedido")
                      )
                    ],
                  ),

                  const Gap(20),

                  ListView.builder(
                    itemCount: totalOrders,
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                      return CardOrderListWidget(
                        getIndex: index,
                      );
                    }
                  ), 
                ]
              ),
            ),
            
          ),
        );
  }
}