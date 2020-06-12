<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String citycode = request.getParameter("citycode");
    if (citycode == null) {
        citycode = "";
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/jquery-1.12.4.js" type="text/javascript"></script>
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <script src="js/bootstrap.js" type="text/javascript"></script>
        <title>JSP Page</title>
        <style>

            .div2
            {

                border:solid #67b168;
                margin-bottom: 20px;
            }
            #map1 {
                height: 300px;
                width: 100%;
            }
        </style>
        <script>
            function detials()
            {
                var tn = document.getElementById("tn").value;
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function ()
                {
                    if (xmlhttp.readyState === 4 && xmlhttp.status === 200)
                    {
                        var res = xmlhttp.responseText.trim();
                        console.log(res);
                        var resjson = JSON.parse(res);
//                        console.log(resjson);
                        airport(resjson);
                        head(resjson);

                    }
                };
                xmlhttp.open("GET", "./GetAirportDetials?tn=" + tn, true);
                xmlhttp.send();

            }

            var st;
            function airport(resjson)
            {
                st = resjson.airports;


                var ans = "";
                ans += "<table class='table table-hover'>";
                ans += "<thead class='bg-primary'>";
                ans += "<tr>";
                ans += "<td>Srno.</td>";
                ans += "<td>Name</td>";
                ans += "<td>City</td>";
                ans += "<td>LocalTime</td>";
                ans += "<td>Active</td>";
                ans += "<td>Show on Map</td>";
                ans += "</tr>";
                ans += "</thead>";
                ans += "<tbody>";
                 if (st.length == 0)
                {
                    alert('No airport found');
                    return;
                }
                for (var i = 0; i < st.length; i++) {
                    ans += "<tr>";
                    ans += "<td>"+(i+1)+"</td>";
                    ans += "<td>"+st[i].name+"</td>";
                    ans += "<td>"+st[i].city+"</td>";
                    ans += "<td>"+st[i].localTime+"</td>";
                
               if (st[i].active!==false)
                {
                    ans += "<td>Yes</td>";
                } else
                {
                    ans += "<td>No</td>";
                }
                
                ans += "<td><input type='button' value='Show On Map' class='btn btn-success' \n\
        onclick='initMap(" + i + ")'/></td>";
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
                    //  ans += "<td>Total " + st.length + " airports found in " + st[0].city + "</td>";
                    // ans += document.getElementById("war").innerHTML = "<center><h2><strong>Airport Found in :</strong>" + st[0].city + "</h2></center>";

                } else
                {
                    ans += "<td>No Airports Found</td>";
                }
            }

            function  initMap(index) {
                var obj = st[index];
                var uluru = {lat: obj.latitude, lng: obj.longitude};
                var map = new google.maps.Map(document.getElementById('map1'), {
                    zoom: 12,
                    center: uluru
                });

                var marker = new google.maps.Marker({
                    position: uluru,
                    map: map,
                    animation: google.maps.Animation.BOUNCE,
                    title: obj.name + "(" + obj.iata + "," + obj.icao + ")",
                    icon: "./pics/123.jpg"
                });
            }
        </script>
        <script async defer
                src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDqZCKBe0lyuQKZZ1hRh4_1OxekD6H1Qww">
        </script>
    <body>

        <div class="container">

            <div class="row">

                <div class="col-sm-4">
                    <div class="jumbotron">
                        <center><h2>AIRPORT DETIALS</h2></center>
                    </div>   

                    <form class="form-inline">

                        <div class="form-group">

                            <label for="tn">Enter City Code </label>
                            <input type="text" id="tn" value="<%=citycode%>" value="ATQ"/>
                            <div class="form-group">

                                <input class="btn btn-success form-control" type="button" value="CHECK" onclick="detials()"/>

                            </div>
                        </div>

                    </form>
                </div>
                <div class="col-sm-8" >

                    <div class="alert alert-info well-sm" style="display: none" id="war" >

                    </div>
                    <div id="div1"></div>
                    <div id="map1"></div>

                </div>
            </div>
        </div>

    </body>
</html>
