import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class FileItem extends StatefulWidget {
  const FileItem({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  State<FileItem> createState() => _FileItemPage();
}

class _FileItemPage extends State<FileItem> {
  int downloadProgress = 0;

  bool isDownloadStarted = false;

  bool isDownloadFinish = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Visibility(
          visible: isDownloadStarted,
          child: CircularPercentIndicator(
            radius: 20.0,
            lineWidth: 3.0,
            percent: (downloadProgress / 100),
            center: Text(
              "$downloadProgress%",
              style: const TextStyle(fontSize: 12, color: Colors.blue),
            ),
            progressColor: Colors.blue,
          )),
      Visibility(
          visible: !isDownloadStarted,
          child: Container(
            width: 70,
            height: 70,
            color: Colors.white,
            child: Center(
              child: Center(
                child: IconButton(
                  icon: const Icon(
                    Icons.download_rounded,
                    size: 40,
                  ),
                  color: isDownloadFinish ? Colors.green : Colors.red,
                  onPressed: downloadFle,
                ),
              ),
            ),
          ))
    ]);
  }

  void downloadFle() async {
    isDownloadStarted = true;
    isDownloadFinish = false;

    setState(() {});
    FileDownloader.downloadFile(
      url: widget.url,
      onProgress: (fileName, progress) {
        setState(() {
          downloadProgress = progress.toInt();
          // downloadProgress = progress as int;
          print(downloadProgress);
        });
      },
      onDownloadCompleted: (path) {
        setState(() {
          downloadProgress = 0;
          isDownloadFinish = true;
          isDownloadStarted = false;
          print('trav');
        });
      },
    );
  }
}
