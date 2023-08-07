import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fuego_bites/provider/service_provider.dart';
import 'package:gap/gap.dart';

class CardOrderListWidget extends ConsumerWidget {
  const CardOrderListWidget({
    super.key,
    required this.getIndex,
  });

  final int getIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderData = ref.watch(fetchStreamProvider);

    return orderData.when(
        data: (orders) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    )),
                width: 20,
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: IconButton(
                          icon: const Icon(CupertinoIcons.delete),
                          onPressed: () => ref.read(serviceProvider).deleteOrder(orders[getIndex].docId)
                        ),
                        title: Text(
                          orders[getIndex].nombre,
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: orders[getIndex].pagado 
                              ? TextDecoration.lineThrough 
                              : null
                          )
                        ),
                        subtitle: Text(orders[getIndex].descripcion,style: TextStyle(
                          decoration: orders[getIndex].pagado 
                            ? TextDecoration.lineThrough 
                            : null
                        )),
                        trailing: Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            activeColor: Colors.blue.shade800,
                            shape: const CircleBorder(),
                            value: orders[getIndex].pagado,
                            onChanged: (value) {
                              ref.read(serviceProvider).updateOrder(orders[getIndex].docId, value);
                            },
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(0, -12),
                        child: Column(children: [
                          Divider(
                            thickness: 1.5,
                            color: Colors.grey.shade200,
                          ),
                          const Row(children: [
                            Text('Fecha Entrega'),
                            Gap(12),
                            Text('07/05/2023')
                          ])
                        ]),
                      )
                    ]),
              ))
            ]),
          );
        },
        error: (error, stackTrace) => Center(child: Text("error ${stackTrace.toString()}")),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
