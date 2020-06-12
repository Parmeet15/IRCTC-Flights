

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery-1.12.4.js" type="text/javascript"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>

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
        <style>
            #div1
            {
                height:300px;
                overflow-y: auto;
            }

            #map1
            {
                margin-top: 30px;
                width: 100%;
                height: 350px;
            }
        </style>
        <script>
            function detials()
            {
                var lt = document.getElementById("lt").value;
                var lg = document.getElementById("lg").value;
                var rd = document.getElementById("rd").value;

                if (lt == "" || lg == "" || rd == "")
                {
                    alert('Please fill required fields.....');
                    return;
                }


                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function ()
                {
                    if (xmlhttp.readyState === 4 && xmlhttp.status === 200)
                    {
                        var res = xmlhttp.responseText.trim();
//                        console.log(res);
                        var resjson = JSON.parse(res);
//                        console.log(resjson);
                        airport(resjson);
                        head(resjson);
                    }
                };
                xmlhttp.open("GET", "./AirportsWithinRadius?lt=" + lt + "&lg=" + lg + "&rd=" + rd, true);
                xmlhttp.send();
            }

            var st;
            function airport(resjson)
            {
                st = resjson.airports;
                initMap(st);
                var ans = "";
                ans += "<table class='table table-hover'>";
                ans += "<thead class='bg-primary'>";
                ans += "<tr>";
                ans += "<td>Srno</td>";
                ans += "<td>Name </td>";
                ans += "<td>Local Time</td>";
                ans += "<td>Active</td>";
                ans += "<td>Show Details</td>";
                ans += "</tr>";
                ans += "</thead>";
                ans += "<tbody>";
                for (var i = 0; i < st.length; i++) {
                    ans += "<tr>";
                    ans += "<td>" + (i + 1) + "</td>";
                    ans += "<td>" + st[i].name + "</td>";
                    ans += "<td>" + st[i].localTime + "</td>";
                    if (st[i].active)
                    {
                        ans += "<td>Acitve</td>";
                    } else
                    {
                        ans += "<td>InAcitve</td>";
                    }

                    ans += "<td><input type='button' value='Show Details' class='btn btn-block btn-primary' onclick='changeurl(" + i + ")'/></td>";
                    ans += "</tr>";
                }


                ans += "</tbody>";
                ans += "</table>";
                document.getElementById("div1").innerHTML = ans;
            }
            function head(resjson)
            {
                var ans = "";
                if (st.length > 0)
                {

                    ans += "<table class='table table-hover table-bordered'>";
                    ans += document.getElementById("war").innerHTML = "<center><h2><strong>Total" + st.length + "airports found in" + st[0].city + "</strong></h2></center>";
                    document.getElementById("war").style.display = 'block';
                } else
                {
                    ans += "<td>No Airports Found</td>";
                }
            }


            function changeurl(index)
            {
                window.location.href = 'GetAirportDetails.jsp?citycode=' + st[index].cityCode;
            }
            function  initMap(array) {

                if (array.length == 0)
                {
                    alert('No airport found');
                    return;
                }
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
                        icon: "./pics/images.png"
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
            }

        </script>
        <script async defer src="http://maps.googleapis.com/maps/api/js?key=AIzaSyBYeyVAf4D2xq1NPskOIUEsbISxGJbGwy8&libraries=places&v=3.exp"></script>        

    </head>

    <body onload="initialize()">
        <div class="container">

            <div class="row">
                <center><h2>AIRPORT WITH IN THE RADIUS</h2></center>
                <div class="col-sm-4">

                    <form  action="#" method="GET" class="form-horizontal">

                        <div class="form-group">
                            <input type="text" class="form-control" name="map_location" id="map_location" placeholder="Search Location" />
                        </div>
                        <div class="form-group"  id="map" style="width:100%;height:150px;border-radius: 10px"></div>
                        <div class="form-group">
                            <div class="col-sm-6">
                                <label for="lt">Latitude</label>
                                <input type="text" readonly="" class="form-control" id="lt" placeholder="74.8723" />
                            </div>
                            <div class="col-sm-6">
                                <label for="lg">Longitude</label>
                                <input type="text" readonly="" class="form-control" id="lg" placeholder="31.6340" />
                            </div>

                        </div> 
                        <div class="form-group">
                            <label for="rd">Select Radius in miles</label>
                            <input type="text" class="form-control" id="rd" readonly="" value="50 miles" placeholder="50 miles"/>
                        </div>
                        <button type="button"  class="btn btn-block btn-success " onclick="detials()">CHECK DETIALS </button>
                    </form>
                </div>

                <div class="col-sm-8" >

                    <div class="alert alert-info well-sm" style="display: none" id="war" >

                    </div>
                    <div id="div1"></div>


                </div>

            </div>
            <div class="row">
                <div id="map1"></div>
            </div>
        </div>

        <div id="mymodal" class="modal fade" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <div class="form-group">
                            <label id="lbname"></label>
                        </div>
                        <div class="modal-body" >
                            <h1 id="h1name"></h1>
                            <h1 id="h1status"></h1>
                            <hr>
                            <input type="button" class="btn btn-block btn-primary" value="View Full Details"/>
                            <input type="button" class="btn btn-block btn-primary" value="View Flight arrivals"/>
                            <input type="button" class="btn btn-block btn-primary" value="View Flight Departures"/>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class= "btn-lg btn-success " onclick="live()">GET LIVE STATUS</button>
                        </div>

                    </div>

                </div> 
            </div>
        </div>


    </body>
</html>
