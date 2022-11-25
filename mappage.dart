import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/core.errors.dart';
import 'package:here_sdk/gestures.dart';
import 'package:here_sdk/mapview.dart';
import 'package:here_sdk/routing.dart';
import 'package:yana/pages/pin.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late HereMapController hereMapController;
  static GeoCoordinates sourceLocation = GeoCoordinates(28.4506, 77.5842);
  static GeoCoordinates destinationLocation = GeoCoordinates(28.5245, 77.1855);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Show Route',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: const HereMap(
        onMapCreated: _onMapCreated,
      ),
    );
  }
}

MapImage mapImage =
    MapImage.withFilePathAndWidthAndHeight("assets/markers.jpg", 60, 60);
late HereMapController hereMapController;
LocationIndicator locationIndicator = LocationIndicator();

void addRoute(GeoCoordinates sourceLocation, GeoCoordinates destinationLocation,
    HereMapController hereMapController) {
  RoutingEngine routingEngine = RoutingEngine();
  Waypoint startWaypoint = Waypoint.withDefaults(sourceLocation);
  Waypoint endWaypoint = Waypoint.withDefaults(destinationLocation);
  List<Waypoint> wayPoints = [startWaypoint, endWaypoint];

  routingEngine.calculateCarRoute(wayPoints, CarOptions.withDefaults(),
      (error, routing) {
    if (error == null) {
      var route = routing!.first;
      GeoPolyline routeGeoPolyline = route.geometry;
      double widthInPixels = 20;
      var mPolyline = MapPolyline(routeGeoPolyline, widthInPixels, Colors.blue);
      hereMapController.mapScene.addMapPolyline(mPolyline);
    }
    ;
  });
}

void _addMapMarker(
    GeoCoordinates geoCoordinates, HereMapController hereMapController) {
  int imageWidth = 60;
  int imageHeight = 60;
  MapImage mapImage = MapImage.withFilePathAndWidthAndHeight(
      "assets/markers.jpg", imageWidth, imageHeight);
  MapMarker mapMarker = MapMarker(geoCoordinates, mapImage);
  hereMapController.mapScene.addMapMarker(mapMarker);
}

void _handlePickedMapMarkerClusters(PickMapItemsResult pickMapItemsResult) {
  List<MapMarkerClusterGrouping> groupingList =
      pickMapItemsResult.clusteredMarkers;
  if (groupingList.length == 0) {
    return;
  }

  MapMarkerClusterGrouping topmostGrouping = groupingList.first;
  int clusterSize = topmostGrouping.markers.length;
  if (clusterSize == 0) {
    // This cluster does not contain any MapMarker items.
    return;
  }
  if (clusterSize == 1) {
    // _showDialog("Map marker picked",
    //     "This MapMarker belongs to a cluster.  Metadata: " + _getClusterMetadata(topmostGrouping.markers.first));
    print('Map marker picked');
  } else {
    String metadata = "";
    topmostGrouping.markers.forEach((element) {
      metadata += _getClusterMetadata(element);
      metadata += " ";
    });
    int totalSize = topmostGrouping.parent.markers.length;
    // _showDialog(
    //     "Map marker cluster picked",
    //     "Number of contained markers in this cluster: $clusterSize." +
    //         "Contained Metadata: " +
    //         metadata +
    //         ". " +
    //         "Total number of markers in this MapMarkerCluster: $totalSize.");
  }
}

String _getClusterMetadata(MapMarker mapMarker) {
  Metadata? metadata = mapMarker.metadata;
  String message = "No metadata.";
  if (metadata != null) {
    String? string = metadata.getString("key_cluster");
    if (string != null) {
      message = string;
    }
  }
  return message;
}

void _setTapGestureHandler() {
  hereMapController.gestures.tapListener = TapListener((Point2D touchPoint) {
    _pickMapMarker(touchPoint);
  });
}

void _addLocationIndicator(GeoCoordinates geoCoordinates,
    LocationIndicatorIndicatorStyle indicatorStyle) {
  LocationIndicator locationIndicator = LocationIndicator();
  locationIndicator.locationIndicatorStyle = indicatorStyle;
  Location location = Location.withCoordinates(geoCoordinates);
  location.time = DateTime.now();

  locationIndicator.updateLocation(location);
  hereMapController.addLifecycleListener(locationIndicator);
}

void _pickMapMarker(Point2D touchPoint) {
  // You can also use a larger area to include multiple carto POIs.
  Rectangle2D rectangle2D = new Rectangle2D(touchPoint, new Size2D(1, 1));
  hereMapController.pickMapContent(rectangle2D, (pickMapContentResult) {
    if (pickMapContentResult == null) {
      // Pick operation failed.
      return;
    }

    List<PickPoiResult> cartoPOIList = pickMapContentResult.pois;
    int listSize = cartoPOIList.length;
    if (listSize == 0) {
      return;
    }

    PickPoiResult topmostCartoPOI = cartoPOIList.first;
    var name = topmostCartoPOI.name;
    var lat = topmostCartoPOI.coordinates.latitude;
    var lon = topmostCartoPOI.coordinates.longitude;
  });
}

// void _onMapCreated(HereMapController hereMapController) {
//   hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay,
//       (MapError? error) {
//     if (error == null) {
//       // _mapItemsExample = MapItemsExample(_showDialog, hereMapController);
//       // _mapObjectsExample = MapObjectsExample(hereMapController);
//       // _mapViewPinsExample = MapViewPinsExample(hereMapController);
//       _addMapMarker(GeoCoordinates(28.5245, 77.1855), hereMapController);
//     } else {
//       print("Map scene not loaded. MapError: " + error.toString());
//     }
//   });
// }

void _onMapCreated(HereMapController hereMapController) {
  hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay,
      (MapError? error) {
    if (error != null) {
      print('Map scene not loaded. MapError: ${error.toString()}');
      return;
    }

    const double distanceToEarthInMeters = 8000;
    MapMeasure mapMeasureZoom =
        MapMeasure(MapMeasureKind.distance, distanceToEarthInMeters);
    hereMapController.camera
        .lookAtPointWithMeasure(_MapPageState.sourceLocation, mapMeasureZoom);
    addRoute(GeoCoordinates(28.4506, 77.5842), GeoCoordinates(28.5245, 77.1855),
        hereMapController);
    // _addMapMarker(GeoCoordinates(28.5245, 77.1855), hereMapController);
  });
}
