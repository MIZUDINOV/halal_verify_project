import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FloatingNavbar extends StatelessWidget {
  FloatingNavbar({super.key});
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: NavigationBar(
          destinations: <Widget>[
            NavigationDestination(
              icon: Icon(Symbols.dashboard),
              label: 'Главная',
            ),
            IconButton(
              iconSize: 55,
              tooltip: 'Сканировать',
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AiBarcodeScanner(
                      overlayConfig: const ScannerOverlayConfig(
                        animateOnSuccess: true,
                        animateOnError: true,
                      ),
                      validator: (BarcodeCapture value) =>
                          value.barcodes.isNotEmpty,
                      controller: MobileScannerController(
                        detectionSpeed: DetectionSpeed.normal,
                        detectionTimeoutMs: 500,
                      ),
                      onDetect: (BarcodeCapture capture) async {
                        final cxt = context;
                        final barcode = capture.barcodes.first.rawValue ?? "";
                        debugPrint("Barcode detected: ${barcode}");

                        Navigator.of(cxt).pop();

                        final product = await supabase.functions.invoke(
                          "get-product",
                          method: HttpMethod.get,
                          queryParameters: Map.from({"barcode": barcode}),
                        );

                        debugPrint("Product details: $product");

                        showDialog<String>(
                          context: cxt,
                          builder: (BuildContext context) => Dialog(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Отсканированный штрихкод:',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    capture.barcodes.first.rawValue ??
                                        'Неизвестно',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                  SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: Text('Закрыть'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
              icon: Icon(
                Symbols.barcode_scanner,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            NavigationDestination(
              icon: Icon(Symbols.history_2),
              label: 'История',
            ),
          ],
          elevation: 0,
        ),
      ),
    );
  }
}
