import 'package:scan/pages/result.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> with WidgetsBindingObserver {
  bool _isPermissionGranted = false;
  late final Future<void> _future;
  CameraController? _cameraController;
  final _textRecognizer = TextRecognizer();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    _future = _requestCameraPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    _stopCamera();
    _textRecognizer.close();
    super.dispose();
  }

  Future<void> _initCameraController(List<CameraDescription> cameras) async {
    if (_cameraController != null) {
      return;
    }

    CameraDescription? camera;
    for (var i = 0; i < cameras.length; i++) {
      final CameraDescription current = cameras[i];
      if (current.lensDirection == CameraLensDirection.back) {
        camera = current;
        break;
      }
    }

    if (camera != null) {
      _cameraSelected(camera);
    }
  }

  Future<void> _cameraSelected(CameraDescription camera) async {
    _cameraController =
        CameraController(camera, ResolutionPreset.max, enableAudio: false);
    await _cameraController?.initialize();

    if (!mounted) {
      return;
    }
    setState(() {});
  }

  Future<void> _scanImage(BuildContext context) async {
    if (_cameraController == null) {
      return;
    }
    final navigator = Navigator.of(context);
    try {
      showDialog(
        context: context,
        barrierDismissible: false, // Prevent tapping outside to dismiss
        builder: (BuildContext context) {
          return Dialog(
            child: IgnorePointer(
              ignoring: true, // Prevent user interaction
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text("Keep The Camera Steady ... "),
                  ],
                ),
              ),
            ),
          );
        },
      );

      final pictureFile = await _cameraController!.takePicture();
      final file = File(pictureFile.path);
      final inputImage = InputImage.fromFile(file);
      final recognizedText = await _textRecognizer.processImage(inputImage);

      await navigator.push(MaterialPageRoute(
          builder: (context) => ResultScreen(text: recognizedText.text)));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error scanning image')));
    } finally {
      Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
    }
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    setState(() {
      _isPermissionGranted = status == PermissionStatus.granted;
    });
  }

  void _startCamera() {
    if (_cameraController != null)
      _cameraSelected(_cameraController!.description);
  }

  void _stopCamera() {
    if (_cameraController != null) _cameraController!.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.paused) {
      _stopCamera();
    } else if (state == AppLifecycleState.resumed &&
        _cameraController != null &&
        _cameraController!.value.isInitialized) {
      _startCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          return Stack(
            children: [
              if (_isPermissionGranted)
                FutureBuilder(
                  future: availableCameras(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      _initCameraController(snapshot.data!);
                      return PageView(
                        children: [CameraPreview(_cameraController!)],
                      );
                    } else {
                      return Center(child: LinearProgressIndicator());
                    }
                  },
                ),
              Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  title: Text(
                    'Detecto',
                    style: TextStyle(color: Colors.white),
                  ),
                  centerTitle: true,
                ),
                backgroundColor:
                    _isPermissionGranted ? Colors.transparent : null,
                body: _isPermissionGranted
                    ? Column(
                        children: [
                          Expanded(child: Container()),
                          Container(
                            padding: const EdgeInsets.only(bottom: 150),
                            child: Center(
                              child: Ink(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.flip),
                                  onPressed: () => _scanImage(context),
                                  color: Colors.white,
                                  iconSize:
                                      36, // Adjust the icon size as needed
                                  splashRadius:
                                      28, // Adjust the splash radius as needed
                                  padding: const EdgeInsets.all(16),
                                  tooltip: 'Scan Image',
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    : Center(
                        child: Container(
                            padding: const EdgeInsets.only(left: 24, right: 24),
                            child: const Text(
                              'Camera permission denied',
                              textAlign: TextAlign.center,
                            )),
                      ),
              )
            ],
          );
        });
  }
}
