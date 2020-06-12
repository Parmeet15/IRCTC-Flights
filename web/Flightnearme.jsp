
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery-1.12.4.js" type="text/javascript"></script>
        <script src="js/myscript.js" type="text/javascript"></script>



        <title>JSP Page</title>
        <script>
            var lat1, lng1;
            function initialize()
            {
                var markers = [];
                var map = new google.maps.Map(document.getElementById('map'), {
                    mapTypeId: google.maps.MapTypeId.ROADMAP,
                    zoom: 15
                });
                var defaultBounds = new google.maps.LatLngBounds(
                        new google.maps.LatLng(31.6340, 74.8723),
                        new google.maps.LatLng(31.5604, 75.0290));
                map.fitBounds(defaultBounds);
                // Create the search box and link it to the UI element.
                var input = document.getElementById('map_location');
                var searchBox = new google.maps.places.SearchBox(input);
                // Listen for the event fired when the user selects an item from the
                // pick list. Retrieve the matching places for that item.
                google.maps.event.addListener(searchBox, 'places_changed', function () {
                    var places = searchBox.getPlaces();
                    for (var i = 0; marker; i++) {
                        marker = markers[i];
                        marker.setMap(null);
                    }
                    // For each place, get the icon, place name, and location.
                    markers = [];
                    var bounds = new google.maps.LatLngBounds();
                    for (var i = 0, place; place = places[i]; i++) {
                        var image = {
                            url: place.icon,
                            size: new google.maps.Size(71, 71),
                            origin: new google.maps.Point(0, 0),
                            anchor: new google.maps.Point(17, 34),
                            scaledSize: new google.maps.Size(50, 50)
                        };
                        // Create a marker for each place.
                        var marker = new google.maps.Marker({
                            map: map,
                            icon: image,
                            title: place.name,
                            position: place.geometry.location
                        });
                        markers.push(marker);
                        var mylati = place.geometry.location.lat();
                        var mylnongi = place.geometry.location.lng();
                        document.getElementById("lt").value = mylati;
                        document.getElementById("lg").value = mylnongi;
                        bounds.extend(place.geometry.location);
                        lat1 = place.geometry.location.lat();
                        lng1 = place.geometry.location.lng();
                    }
                    map.fitBounds(bounds);
                    var defaultBounds1 = new google.maps.LatLngBounds(
                            new google.maps.LatLng(lat1 - 0.5, lng1 - 0.5),
                            new google.maps.LatLng(lat1 + 0.5, lng1 + 0.5));
                    map.fitBounds(defaultBounds1);
                });

            }
        </script>
        <script>
            function detials()
            {
                var lt = document.getElementById("lt").value;
                var lg = document.getElementById("lg").value;
                var rd = document.getElementById("rd").value;
               

                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function ()
                {
                    if (xmlhttp.readyState === 4 && xmlhttp.status === 200)
                    {
                        var res = xmlhttp.responseText.trim();
                        var resjson = JSON.parse(res);

                        if (resjson.hasOwnProperty("flightPositions"))
                        {
                            airport(resjson);
                            table(resjson);
                        } else
                        {
                            document.getElementById("resmessage").innerHTML = resjson;
                        }

                    }
                };
                xmlhttp.open("GET", "./Flightnearme?lt=" + lt + "&lg=" + lg + "&rd=" + rd, true);
                xmlhttp.send();
            }
           function table(resjson)
            {
                var st = resjson.flightPositions; 
                 var ans = "";
                ans += "<table class='table table-hover'>";
                ans += "<thead class='bg-primary '>";
                ans += "<tr>";
                ans += "<td>Srno.</td>";
                  ans += "<td>FlightId</td>";
                   ans += "<td>CallSign</td>";
                   ans+="<td>Tail Number</td>";
                   ans+="<td>Track</td>";
                    ans += "</tr>";
                ans+="</thead>";
                  ans += "<tbody>";
                for (var i = 0; i < st.length; i++)
                {
                    ans += "<tr>";
                    ans += "<td>" + (i + 1) + "</td>";
                    ans += "<td>" + st[i].flightId + "</td>";
                    ans += "<td>" + st[i].callsign+ "</td>";
                     ans += "<td>" + st[i].tailNumber+ "</td>";
                     
                     ans+="<td> <input type='button' value='Track Flight' class='btn btn-success' onclick='flighttrack("+st[i].flightId+")'/> </td>";
                     ans+="</tr>";
                 }
                ans += "</tbody>";
                ans += "</table>";

                
            
                document.getElementById("div2").innerHTML = ans;
            }
          function  flighttrack(flightId)
          {
              window.location.href="TrackFlight.jsp?flightid="+flightId;
          }
            
            function airport(resjson)
            {
                var st = resjson.flightPositions;
                initMap(st);
            }
            function  initMap(flightpositions) {
                 if (flightpositions.length == 0)
                {
                    alert('No Flight found');
                    return;
                }
                var array = [];
                for (var i = 0; i < flightpositions.length; i++)
                {
                    var obj = flightpositions[i].positions[0];
                    array.push({latitude: obj.lat, longitude: obj.lon});
                }
//                console.log(flightpositions.length);
                var js = array[0];
                var lat = js.latitude;
                var lng = js.longitude;
                var location = new google.maps.LatLng(lat, lng);
                var map = new google.maps.Map(document.getElementById('map1'), {
                    zoom: 7,
                    center: location
                });
                for (var i = 0; i < array.length; i++)
                {
                    var js = array[i];
                    var lat = js.latitude;
                    var lng = js.longitude;
                    var location = new google.maps.LatLng(lat, lng);
                    var marker = new google.maps.Marker({
                        position: location,
                        map: map,
                        icon: "./pics/radii.png"
                    });
                    var infowindow = new google.maps.InfoWindow({
                        content: 'Latitude: ' + location.lat() + '<br>Longitude: ' + location.lng()
                    });

                    marker.setMap(map);
                    marker.tag = i;
                    marker.addListener('click', function (e) {
                        infowindow.open(map, marker);
                    });
                }

            }

            function myMap(lat, lng) {
                var mapCanvas = document.getElementById("map");
                var myCenter = new google.maps.LatLng(lat, lng);
                var mapOptions = {center: myCenter, zoom: 15};
                var map = new google.maps.Map(mapCanvas, mapOptions);
                var marker = new google.maps.Marker({
                    position: myCenter,
                    animation: google.maps.Animation.BOUNCE
                });
                marker.setMap(map);
                function myMap(lat, lng) {
                    var mapCanvas = document.getElementById("map");
                    var myCenter = new google.maps.LatLng(lat, lng);
                    var mapOptions = {center: myCenter, zoom: 15};
                    var map = new google.maps.Map(mapCanvas, mapOptions);
                    var marker = new google.maps.Marker({
                        position: myCenter,
                        animation: google.maps.Animation.BOUNCE
                    });
                    marker.setMap(map);
                }

            }

        </script>
        <script async defer src="http://maps.googleapis.com/maps/api/js?key=AIzaSyBYeyVAf4D2xq1NPskOIUEsbISxGJbGwy8&libraries=places&v=3.exp"></script>        


        <style>
            #map1
            {
                width: 100%;
                height: 350px;
            }
            #div2
            {
                height: 350px;
                overflow-y: auto;
            }
           
        </style>

    </head>
    <body onload="initialize()">

        <div class="container">

            <div class="row">
                <center><h2>FLIGHTS NEAR ME</h2></center>
                <div class="col-sm-4">

                    <form  action="#" method="GET" class="form-horizontal">

                        <div class="form-group">
                            <input type="text" class="form-control" name="map_location" id="map_location" placeholder="Search Location" />
                        </div>
                        <div class="form-group"  id="map" style="width:100%;height:150px;border-radius: 10px"></div>
                        <div class="form-group">
                            <div class="col-sm-6">
                                <label for="lt">Latitude</label>
                                <input type="text" readonly="" class="form-control" id="lt" placeholder="31.6340" />
                            </div>
                            <div class="col-sm-6">
                                <label for="lg">Longitude</label>
                                <input type="text" readonly="" class="form-control" id="lg" placeholder="74.8723" />
                            </div>

                        </div> 
                        <div class="form-group">
                            <label for="rd">Select Radius in miles</label>
                            <input readonly="" type="text" class="form-control" id="rd" placeholder="50 miles"/>
                        </div>
                        <button type="button"  class="btn btn-block btn-success " onclick="detials()">CHECK DETIALS </button>
                    </form>
                </div>

                
                <div class="col-sm-8" >

                    <div class="alert alert-info well-sm" style="display: none" id="war" >

                    </div>
                    <div id="div1">
                        <div id="map1"></div>
                        <div id="resmessage"></div>
                        

                    </div>
                    <div  id="div2">
                          </div>
                    

                </div>

            </div>

        </div>


    </body>
</html>
