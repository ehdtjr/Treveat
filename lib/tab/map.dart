import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter_app/review/review_view.dart';

void main() => runApp(MaterialApp(home: MapScreen()));

class MapScreen extends StatefulWidget {
  @override
  _MapWithMarkersState createState() => _MapWithMarkersState();
}

class _MapWithMarkersState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? _mapController;
  List<MyMarker> _markers = [];
  List<MyMarker> _filteredMarkers = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // API에서 데이터 가져오고 마커 생성
    loadMarkers();
  }

  Future<void> loadMarkers() async {
    // API 호출
    final apiKey = 'PmBLn80WCCllUdLedclwIysnCuD4s7oow6pTP9EwnLbhMU7Ow2K354qef62KFaLX';
    final apiUrl = 'https://busan-7beach.openapi.redtable.global/api/rstr?serviceKey=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      // JSON 데이터를 기반으로 MyMarker 객체를 생성합니다.
      for (var restaurant in jsonData['body']) {
        double lat = double.parse(restaurant['RSTR_LA']);
        double lng = double.parse(restaurant['RSTR_LO']);
        String name = restaurant['RSTR_NM'];
        String snippet = restaurant['RSTR_INTRCN_CONT'];

        MyMarker marker = MyMarker(
          id: MarkerId(name),
          name: name,
          position: LatLng(lat, lng),
          snippet: snippet,
        );

        _markers.add(marker);
      }

      // 모든 마커를 로드한 후, _filteredMarkers를 초기화합니다.
      _filteredMarkers = List.from(_markers);

      setState(() {});
    } else {
      throw Exception('Failed to load markers from API');
    }
  }

  void showMarkerInfo(MyMarker marker) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          // 해당 마커 정보를 표시하는 페이지를 반환합니다.
          return MarkerInfoPage(marker: marker);
        },
      ),
    );
  }

  void _search() {
    String searchKeyword = _searchController.text;
    String englishSearchKeyword = Intl.message(searchKeyword, name: 'searchKeyword');

    // 기존 마커 목록을 _filteredMarkers로 복사합니다.
    _filteredMarkers = List.from(_markers);

    // 검색어로 필터링된 마커 목록을 생성
    List<MyMarker> filteredMarkers = _filteredMarkers
        .where((marker) => marker.name.toLowerCase().contains(englishSearchKeyword.toLowerCase()))
        .toList();

    // 기존 마커 목록을 모두 비우고 검색 결과로 업데이트
    setState(() {
      _filteredMarkers.clear();
      _filteredMarkers.addAll(filteredMarkers);
    });

    // 검색한 위치로 지도 이동
    if (filteredMarkers.isNotEmpty && _mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(
          filteredMarkers[0].position,
          14.0,
        ),
      );
    }
  }

  void _moveToBusanCenter() {
    if (_mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(35.1796, 129.0756),
          14.0,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Treveat',
          style: TextStyle(color: Color(0xff69E2E3)),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(35.1796, 129.0756),
              zoom: 14.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              _mapController = controller;
            },
            markers: _filteredMarkers
                .map(
                  (marker) => Marker(
                markerId: marker.id,
                position: marker.position,
                infoWindow: InfoWindow(
                  title: marker.name,
                  snippet: marker.snippet,
                ),
                onTap: () {
                  // 마커를 탭했을 때 정보 페이지를 표시
                  showMarkerInfo(marker);
                },
              ),
            )
                .toSet(),
          ),
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onEditingComplete: _search,
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  _moveToBusanCenter();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 36,
                    ),
                    Text(
                      'Busan',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyMarker {
  final MarkerId id;
  final String name;
  final LatLng position;
  final String snippet;

  MyMarker({
    required this.id,
    required this.name,
    required this.position,
    required this.snippet,
  });
}

class MarkerInfoPage extends StatelessWidget {
  final MyMarker marker;

  MarkerInfoPage({required this.marker});

  Future<Map<String, dynamic>> fetchNaverRating() async {
    const apiKey = 'PmBLn80WCCllUdLedclwIysnCuD4s7oow6pTP9EwnLbhMU7Ow2K354qef62KFaLX';
    final apiUrl =
        'https://busan-7beach.openapi.redtable.global/api/rstr/qlt?serviceKey=$apiKey&RSTR_NM=${marker.name}';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load Naver rating from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(marker.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: FutureBuilder<Map<String, dynamic>>(
          future: fetchNaverRating(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // 평점 정보를 가져오는 동안 로딩 표시
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final naverRating = snapshot.data;
              final naverStarRating = naverRating?['NAVER_STAR_RATING'] ?? 0.0;
              final naverReviewCount = naverRating?['NAVER_REVIEW_COUNT'] ?? 0;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '가게 이름: ${marker.name}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '가게 소개: ${marker.snippet}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Row(
                    children: [
                      Text(
                        '네이버 평점: ',
                        style: TextStyle(fontSize: 16),
                      ),
                      Row(
                        children: List.generate(
                          5,
                              (index) => Icon(
                            Icons.star,
                            color: index < (naverStarRating ?? 0.0).ceil()
                                ? Colors.amber
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '네이버 리뷰 수: $naverReviewCount',
                    style: TextStyle(fontSize: 16),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReviewView(marker: marker), // ReviewView로 이동하고 marker 데이터를 전달
                        ),
                      );
                    },
                    child: Text('리뷰'),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}


class ReviewView extends StatelessWidget {
  final MyMarker marker;

  ReviewView({required this.marker}); // marker 데이터를 받는 생성자 추가

  @override
  Widget build(BuildContext context) {
    // ReviewView 페이지에서 리뷰를 표시하는 부분을 구현할 수 있습니다.
    // 이 부분은 ReviewView 페이지에 맞게 내용을 추가하세요.
    return Scaffold(
      appBar: AppBar(
        title: Text('리뷰'),
      ),
      body: Center(
        child: Text('리뷰 페이지로 이동합니다.'),
      ),
    );
  }
}