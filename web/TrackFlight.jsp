
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String flightid = request.getParameter("flightid");
    if (flightid == null) {
        flightid = "";
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery-1.12.4.js" type="text/javascript"></script>
        <script src="js/myscript.js" type="text/javascript"></script>


        <title>JSP Page</title>
        <script>

          function trackflight()
            {
                var tn = document.getElementById("tn").value;
                console.log(tn);
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function ()
                {
                    if (xmlhttp.readyState === 4 && xmlhttp.status === 200)
                    {
                        var res = xmlhttp.responseText.trim();
                        console.log(res);
                        var resjson = JSON.parse(res);
//                        console.log(resjson);

                        flight(resjson);
                        //  airport(resjson);
                    }

                };
                xmlhttp.open("GET", "./TrackFlight?tn=<%=flightid%>", true);
                xmlhttp.send();

            }

            function flight(resjson)
            {
                var st = resjson.flightTrack;
                console.log(st);
                document.getElementById("fd").innerHTML = st.flightId;
                document.getElementById("fs").innerHTML = st.carrierFsCode;
                document.getElementById("fn").innerHTML = st.flightNumber;
                document.getElementById("to").innerHTML = st.departureAirportFsCode;
                document.getElementById("from").innerHTML = st.arrivalAirportFsCode;
                showmap(st.positions);
            }

            function  showmap(positions) {


                var source = positions[0];
                var dest = positions[positions.length - 1];

                var station = [];

                var station1 = new google.maps.LatLng(source.lat, source.lon);
                station.push(station1);
                station1 = new google.maps.LatLng(dest.lat, dest.lon);
                station.push(station1);




                var mapCanvas = document.getElementById('map');
                var mapOptions = {center: station[0], zoom: 7, mapTypeId: 'terrain'};
                var map = new google.maps.Map(mapCanvas, mapOptions);



                var flightPath = new google.maps.Polyline({
                    path: station,
                    geodesic: true,
                    strokeColor: '#ff0000',
                    strokeOpacity: 1.0,
                    strokeWeight: 2
                });

                var marker = new google.maps.Marker({
                    position: station[0],
                    animation: google.maps.Animation.BOUNCE,
                    title: "Source : "+source.date + "(Speed " + source.speedMph + ")",
                    map: map,
                    icon: "./pics/air.png"

                });
                var marker = new google.maps.Marker({
                    position: station[1],
                    animation: google.maps.Animation.BOUNCE, 
                    title: "Destination : "+dest.date + "(Speed " + dest.speedMph + ")",
                    map: map,
                    icon: "./pics/air.png"
                });
                flightPath.setMap(map);


            }
        </script>
        <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDqZCKBe0lyuQKZZ1hRh4_1OxekD6H1Qww">
        </script>
        <style>
            #map
            {
                width:100%;
                height:500px;
            }
        </style>
    </head>

    <body onload="trackflight()">
        <div class="container">
            <div class="row">
                <h3 class="jumbotron text-capitalize text-center text-info">Track Flight</h3>
                <div class="col-sm-6 bg-danger">
                    <div id="tn" value="<%=flightid%>"></div>
                    <div class="form-group">
                        <label for="fd">Flight Id</label>
                        <h5 id="fd" ></h5>
                    </div>   
                    <div class="form-group">  
                        <label for="fs">Carrier FS Code</label>
                        <h5 id="fs" ></h5>
                    </div>
                    <div class="form-group">  
                        <label for="fn">Flight Number</label>
                        <h5 id="fn" ></h5>
                    </div>
                    <div class="form-group">  
                        <h3 id="to" style="display: inline"></h3>                    
                        <h3 id="from" style="display: inline"></h3>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div id="map">
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
