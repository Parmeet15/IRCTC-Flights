

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="js/jquery-1.12.4.js" type="text/javascript"></script>
        <script src="js/bootstrap.js" type="text/javascript"></script>
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
         <link href="css/jquery_ui.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery.js" type="text/javascript"></script>
        <script src="js/jquery_ui.js" type="text/javascript"></script>
        <script>
            $(function () {
                $("#date").datepicker(
                        {
                            minDate: 0,
                            dateFormat: 'dd-mm-yy'
                        });
            });
        </script>
        <style>
            .jumbotron {
                padding: 0.5em 0.6em;
                h1 {
                    font-size: 2em;
                }
                p {
                    font-size: 1.2em;
                    .btn {
                        padding: 0.5em;
                    }
                }
            }
            .mydiv {

            }
            #map {
                height: 200px;
                width: 100%;
            }
            #map1 {
                height: 500px;
                width: 100%;
            }
        </style>
        <script async defer
                src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDqZCKBe0lyuQKZZ1hRh4_1OxekD6H1Qww">
        </script>
        <script>
            function  checklivestatus() {
                var trainno = document.getElementById("trainno").value;
                var date = document.getElementById("date").value;
                var live = "demo";
                if (document.getElementById("live").checked) {

                    live = "live";
                    // alert(live);

                } else {
                    live = "demo";
                    //  alert(live);
                }



                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function ()
                {
                    //  console.log(xmlhttp.readyState + " " + xmlhttp.status);
                    if (xmlhttp.readyState === 4 && xmlhttp.status === 200)
                    {

                        var res = xmlhttp.responseText.trim();

                        if (res.startsWith("Error"))
                        {

                        } else
                        {

                            var resjson = JSON.parse(res);

                            var rc = resjson.response_code;


//                            console.log(rc);
                            if (rc === 200)
                            {
                                traininfo(resjson);
                                tableview(resjson);


                            } else
                            {
                                checkrescode(rc);

                            }
                        }

                    }
                };
                xmlhttp.open("GET", "./APICheckLiveStatus?date=" + date + "&trainno=" + trainno, true);
                xmlhttp.send();
            }
            function  checkrescode(rc) {
                var lb = document.getElementById("Sres");

                switch (rc) {
                    case 200:
                        lb.innerHTML = "Train doesn’t run on the date queried.";
                        break;
                    case 210:
                        lb.innerHTML = "Train doesn’t run on the date queried.";
                        break;
                    case 211:
                        lb.innerHTML = "Train doesn’t have journey class queried.";
                        break;
                    case 220:
                        lb.innerHTML = "Flushed PNR.";
                        break;
                    case 221:
                        lb.innerHTML = "Invalid PNR.";
                        break;
                    case 230:
                        lb.innerHTML = "Date chosen for the query is not valid for the chosen parameters.";
                        break;
                    case 404:
                        lb.innerHTML = "Data couldn’t be loaded on our servers.No data available.";
                        break;
                    case 405:
                        lb.innerHTML = "Data couldn’t be loaded on our servers.Request couldn’t go through.";
                        break;
                    case 500:
                        lb.innerHTML = "Unauthorized API Key.";
                        break;
                    case 501:
                        lb.innerHTML = "Account Expired.";
                        break;
                    case 502:
                        lb.innerHTML = "Invalid arguments passed.";
                        break;

                    default:
                        lb.innerHTML = "code not found";
                }

            }
            function  traininfo(resjson) {
                document.getElementById("trainnumber").innerHTML = "Train number <b>:" + resjson.train.number + "</b>";
                document.getElementById("trainname").innerHTML = "Train name : <b>" + resjson.train.name + "</b>";
                document.getElementById("position").innerHTML = "Current postion :" + resjson.position;
                document.getElementById("station").innerHTML = "Current Station  :" + resjson.current_station.name;
                initMap(resjson.current_station);
                initMap1(resjson.route);
                tableview(resjson);

            }
            function  initMap(obj) {
                var uluru = {lat: obj.lat, lng: obj.lng};
                var map = new google.maps.Map(document.getElementById('map'), {
                    zoom: 12,
                    center: uluru
                  
                    
                });
//                var marker = new googl
//
//                var station = [];
//                for (var i = 0; i < route.length; i++)
//                    e.maps.Marker({
//                        position: uluru,
//                        animation: google.maps.Animation.BOUNCE,
//                        title: obj.name + "(" + obj.code + ")",
//                        map: map,
//                        icon: "./pics/train.png"
//
//                    });
//                var infowindow = new google.maps.InfoWindow({
//                    content: obj.name
//                });
//                infowindow.open(map, marker);
            }
            function  initMap1(route)

            {
                var station = [];
                for (var i = 0; i < route.length; i++)
                {
                     station1 = new google.maps.LatLng(route[i].station.lat, route[i].station.lng);
                    station.push(station1);
                   


                }

                var mapCanvas = document.getElementById('map1');
                var mapOptions = {center: station[(route.length) / 2], zoom: 8, mapTypeId: 'terrain'};
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
                    // title: obj.name + "(" + obj.code + ")",
                    map: map,
                    icon: "./pics/train.png"

                });
                var marker = new google.maps.Marker({
                    position: station[i-1],
                    animation: google.maps.Animation.BOUNCE,
                    //  title: obj.name + "(" + obj.code + ")",
                    map: map,
                    icon: "./pics/train.png"

                });

                flightPath.setMap(map);


            }

            function  tableview(resjson) {
                var ans = "";
                ans += "<table class='table table-hover table-striped'>";

                ans += "<thead class='bg-primary'>";
                ans += "<tr> <td>Sr. no.</td><td>Station name</td> <td>Sch. arrival</td> <td>sch. departure</td> <td>Distance</td></tr>";
                ans += "</thead>";

                ans += "<tbody>";
                var st = resjson.route;

                for (var i = 0; i < resjson.route.length; i++)
                {

                    ans += "<tr>";
                    ans += "<td>" + (i + 1) + "</td>";
                    ans += "<td>" + st[i].station.name + "</td>";
                    ans += "<td>" + st[i].scharr + "</td>";
                    ans += "<td>" + st[i].schdep + "</td>";
                    ans += "<td>" + st[i].distance + "</td>";
                    ans += "</tr>";

                }
                ans += "</tbody>";
                ans += "</table>";

                document.getElementById("routes").innerHTML = ans;

            }

        </script>


    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <div class="jumbotron">
                        <h1>Check live status</h1>
                    </div>
                    <form action="#" method="GET" class="form-inline">

                        <div class="form-group">
                            <label for="trainno">train number </label>
                            <input class="form-control" type="text" id="trainno" value="12715" name="trainno"  style="width: 200px"/>     <br>
                        </div>
                        <div class="form-group">
                            <label for="date">Date</label>
                            <input class="form-control" type="text" id="date" value="10-04-2018" name="date"  style="width: 200px"/>     <br>
                        </div>
                        <div class="form-group">

                            <input class="btn btn-success form-control" type="button" value="check" onclick="checklivestatus()"/>
                        </div  >

                        <div class="checkbox-inline">
                            <input type="checkbox" id="live" name="live"> live
                        </div>



                        <div> 
                            <label id="Sres" style='color: red'> </label>
                        </div>




                    </form>

                </div>
            </div>

            <div class="row">

                <div id="traininfo" class="col-sm-6 mydiv"   >
                    <br>
                    <label id="trainnumber">
                    </label>
                    <br>
                    <br>
                    <label id="trainname">
                    </label>
                    <br>
                    <br>
                    <label id="station">
                    </label>
                    <br>
                    <br>
                    <label style="color:red" id="position">
                    </label>


                </div>

                <div  class="col-sm-6 mydiv">
                    <div id="map"></div>


                </div>
            </div>

            <div class="row">
                <div class="col-sm-12 ">
                    <div id="map1"></div>
                </div>
            </div>
            <div id="routes">


            </div>

        </div>


    </body>
</html>
