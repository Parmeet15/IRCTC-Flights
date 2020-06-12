
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/jquery-1.12.4.js" type="text/javascript"></script>
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <title>JSP Page</title>
        <script async defer
                src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDqZCKBe0lyuQKZZ1hRh4_1OxekD6H1Qww">
        </script>
        <style>
            #map
            {
                width:100%;
                height:500px;
                

            }
            #routes{
                padding: 20px;
                height:500px;
                overflow-y: auto;
            }
            #CC{
                margin-top: 5px;
                margin-left: 10px; 
            }
            #pd
            {
                margin-left: 10px;
            }
                       #d1
            {
                padding: 10px;
            }
            #alt{
                margin-top:10px;
            }
           
        </style>
        <script>
            function cancel()
            {
                var date = document.getElementById("date").value;
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function ()
                {
                    if (xmlhttp.readyState === 4 && xmlhttp.status === 200)
                    {
                        var res = xmlhttp.responseText.trim();
                          console.log(res);
                        var resjson = JSON.parse(res);
                        //                               document.getElementById("resp").innerHTML = resjson;
                        var rc = resjson.response_code;
                        if (rc === 200)
                        {
                            alert(resjson);
                            traincancel(resjson);
                        }
                    }
                };
                xmlhttp.open("GET", "./GetAllCancelTrains?date=" + date, true);
                xmlhttp.send();

            }
            function alert(resjson)
            {
                document.getElementById("alt").innerHTML="<center><h1 class='text-success'>Total " + resjson.total + " Trains found.</h1></center>";
                document.getElementById("alt").style.display='block';
            }
            function traincancel(resjson)
            {
                var ans = "";
                ans += "<table class='table table-hover table-bordered'>";
               

                ans += "<thead class='bg-primary'>";
               ans += "<tr>";
                ans += "<td>Srno</td>";
                ans += "<td>Train Name </td>";
                ans += "<td>Type</td>";
                ans += "<td>Start Time</td>";
                ans += "<td>Map</td>";



                ans += "</tr>";
                ans += "</thead>";


                ans += "<tbody>";
                var st = resjson.trains;
                for (var i = 0; i < st.length; i++) {
                    ans += "<tr>";
                    ans += "<td>" + (i + 1) + "</td>";
                    ans += "<td>" + st[i].name + "</td>";
                    ans += "<td>" + st[i].type + "</td>";
                    ans += "<td>" + st[i].start_time + "</td>";

                    ans += "<td><input type='button' value='SHOW MAP' class='btn btn-success btn-sm' onclick='showmap(" + JSON.stringify(st[i]) + ")'/></td>";
//                    console.log(ans);
                    // break;

                    ans += "</tr>";
                }

                ans += "</tbody>";
                ans += "</table>";

                document.getElementById("routes").innerHTML = ans;
            }



            function  showmap(train) {


                var station = [];

                station1 = new google.maps.LatLng(train.source.lat, train.source.lng);
                station.push(station1);
                station1 = new google.maps.LatLng(train.dest.lat, train.dest.lng);
                station.push(station1);




                var mapCanvas = document.getElementById('map');
                var mapOptions = {center: station[0], zoom: 10, mapTypeId: 'terrain'};
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
                    position: station[1],
                    animation: google.maps.Animation.BOUNCE,
                    //  title: obj.name + "(" + obj.code + ")",
                    map: map,
                    icon: "./pics/train.png"

                });
                flightPath.setMap(map);


            }


        </script>
    </head>
    <body>

        <div class="container">
            <div class="row">
                
                <div class="col-sm-6" id="d1">
                    <div class="jumbotron">
                        <h2 class="text-primary"><strong>Cancelled Trains Detial</strong></h2>
                    </div>
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label for="date">Pick Date</label> 
                            <input type="text" class="form-control" id="date" placeholder="DD-MM-YYYY" style="width:300px;height:30px " name="date"/>
                        </div>
                        <div class="form-group">
                            <button type="button" onclick="cancel()" class="btn btn-info"  id="CC">  CHECK CANCELLED TRAINS</button>

                        </div>
                   </form>

                    <div id="map">
                    </div>
                </div>
                <div class="col-sm-6 ">
                    <div class="alert alert-info" id="alt" style="display: none">
                        
                    </div>
                    <div id="routes">



                </div>

            </div>
        </div>
        </div>

    </body>
</html>
