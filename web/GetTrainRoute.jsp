<
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery-1.12.4.js" type="text/javascript"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>




        <title>JSP Page</title>
        <style>

        </style>
        <script>
            function route()
            {

                var tr = document.getElementById("tr").value;


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

                            detial(resjson);
                            date(resjson);
                            list(resjson);
                            train(resjson);

                        }

                    }

                };
                xmlhttp.open("GET", "./GetTrainRoute?tr=" + tr, true);
                xmlhttp.send();


            }
            function train(resjson)
            {
                var ans = "";
                ans += document.getElementById("trainname").innerHTML = "<h1>"+resjson.train.name+"</h1>";

                document.getElementById("trainname").style.display = 'block';
            }
            function detial(resjson) {

                var ans = "";
                ans += "<table class='table table-hover table-bordered'>";

                ans += "<thead class='bg-primary'>";
                ans += "<tr>";

                ans += "<td>Route</td>";
                ans += "<td>Station</td>";
                ans += "<td>Arrival</td>";
                ans += "<td>Departure</td>";
                ans += "<td>Stay</td>";
                ans += "<td>Day</td>";
                ans += "<td>Distance</td>";


                ans += "</tr>";
                ans += "</thead>";


                ans += "<tbody>";
                var st = resjson.route;
                for (var i = 0; i < st.length; i++) {
                    ans += "<tr>";
                    ans += "<td>" + (i + 1) + "</td>";
                    ans += "<td>" + st[i].station.name + "</td>";
                    ans += "<td>" + st[i].scharr + "</td>";
                    ans += "<td>" + st[i].schdep + "</td>";
                    ans += "<td>" + st[i].halt + "</td>";
                    ans += "<td>" + st[i].day + "</td>";
                    ans += "<td>" + st[i].distance + "</td>";
                    ans += "</tr>";
                }

                ans += "</tbody>";
                ans += "</table>";

                document.getElementById("mydiv4").innerHTML = ans;

            }
            function date(resjson)
            {
                var ans = "";
                ans += "<table class='table table-hover table-bordered'>";

                ans += "<thead class='bg-primary'>";
                ans += "<tr>";
                ans += "<td>Srno.</td>";
                ans += "<td>Day</td>";
                ans += "<td>Available</td>";
                ans += "</tr>";
                ans += "</thead>";

                ans += "<tbody>";
                var st = resjson.train.days;
                for (var i = 0; i < st.length; i++) {
                    ans += "<tr>";
                    ans += "<td>" + (i + 1) + "</td>";
                    ans += "<td>" + st[i].code + "</td>";
                    ans += "<td>" + st[i].runs + "</td>";

                    ans += "</tr>";
                }

                ans += "</tbody>";
                ans += "</table>";

                document.getElementById("mydiv4").innerHTML = ans;


            }

            function list(resjson)

            {
                var ans = "";
                ans += "<table class='table table-hover table-bordered'>";

                ans += "<thead class='bg-primary'>";
                ans += "<tr>";
                ans += "<td>Srno.</td>";
                ans += "<td>Classes</td>";
                ans += "<td>Available</td>";
                ans += "</tr>";
                ans += "</thead>";

                ans += "<tbody>";
                var st = resjson.train.classes;
                for (var i = 0; i < st.length; i++) {
                    ans += "<tr>";
                    ans += "<td>" + (i + 1) + "</td>";
                    ans += "<td>" + st[i].code + "</td>";
                    ans += "<td>" + st[i].available + "</td>";

                    ans += "</tr>";
                }

                ans += "</tbody>";
                ans += "</table>";

                document.getElementById("mydiv5").innerHTML = ans;
            }

        </script>
    </head>
    <body>
        <div class="container">

            <div class="row">
                <div class="jumbotron">

                    <h1>GET TRAIN DETIALS</h1>

                </div>
                <form class="form-horizontal"
                      <label for="tr">Enter Train Number</label>
                    <input type="text"  id="tr" class="form-control"/> 

                    <input type="button"  value="check detials" onclick="route()" class=" btn btn-success" /> 






                    <div class="col-sm-3 mydiv1" id="mydiv4">
                        <div class=" alert alert-success" style="display: none" id="trainname">

                        </div>

                    </div>
                    <div class="col-sm-3 mydiv2" id="mydiv5">

                    </div>
                    
            </div>
        </div>       


    </body>
</html>
