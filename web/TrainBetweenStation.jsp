<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/jquery-1.12.4.js" type="text/javascript"></script>
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link href="css/jquery_ui.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery.js" type="text/javascript"></script>
        <script src="js/jquery_ui.js" type="text/javascript"></script>
        <title>JSP Page</title>
        <style>
            #her
            {
                margin-left: 10px;
                color: red;
            }
        </style>

        <script>

            $(function () {
                $("#date").datepicker(
                        {
                            minDate: 0,
                            dateFormat: 'dd-mm-yy'
                        });
            });
            function get()
            {
                var ss = document.getElementById("ss").value;
                var dt = document.getElementById("dt").value;
                var date = document.getElementById("date").value;
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function ()
                {
                    if (xmlhttp.readyState === 4 && xmlhttp.status === 200)
                    {
                        var res = xmlhttp.responseText.trim();
                        console.log(res);
                        var resjson = JSON.parse(res);
                        console.log(resjson);
                        // document.getElementById("res").innerHTML = resjson;
                        var rc = resjson.response_code;
                        if (rc === 200)
                        {
                            station(resjson);
                        } else
                        {
                            checkrescode(rc);
                        }
                    }
                };
                xmlhttp.open("GET", "./TrainBetweenStation?ss=" + ss + "&dt=" + dt + "&date=" + date, true);
                xmlhttp.send();

            }
            function  checkrescode(rc)
            {

                var lb = document.getElementById("Sres");
                switch (rc) {
                    case 404:
                        lb.innerHTML = "<i class='material-icons' style='font-size:36px '>mood_bad</i><h2>No Train is Available Between This Station</h2>";
                        break;
                    case 405:
                        lb.innerHTML = "<i class='material-icons' style='font-size:36px'>mood_bad</i><h2>Data couldn’t be loaded on our servers.Request couldn’t go through.</h2>";
                        break;

                    case 500:
                        lb.innerHTML = "Unauthorized API Key.";
                        break;
                }
            }
            function station(resjson)
            {

                var ans = "";
                ans += "<table class='table table-hover table-bordered'>";
                ans += "<caption><h1 id='her'>" + resjson.total + " Trains Found<i class='material-icons'style='font-size:70px;color:red'>train</i></h1></caption>";

                ans += "<thead class='bg-primary'>";
                ans += "<tr>";
                ans += "<td>Srno</td>";
                ans += "<td>Train Name </td>";
                ans += "<td>Departure Time</td>";
                ans += "<td>Arrival Time</td>";
                ans += "<td>Travel Time</td>";
                ans += "<td>Live Status</td>";
                var st = resjson.trains;

                ans += "</tr>";
                ans += "</thead>";


                ans += "<tbody>";

                for (var i = 0; i < st.length; i++) {
                    ans += "<tr>";
                    ans += "<td>" + (i + 1) + "</td>";
                    ans += "<td>" + st[i].name + "</td>";
                    ans += "<td>" + st[i].src_departure_time + "</td>";
                    ans += "<td>" + st[i].dest_arrival_time + "</td>";
                    ans += "<td>" + st[i].travel_time + "</td>";
                    ans += "<td><input type='button' value='Live Status' class='btn btn-success' onclick='LiveStatus(" + st[i].number + ")'/></td>";
//                    console.log(ans);
                    // break;

                    ans += "</tr>";
                }

                ans += "</tbody>";
                ans += "</table>";

                document.getElementById("mydiv1").innerHTML = ans;
            }

            function LiveStatus(number)
            {
                console.log(number);
                window.location.href = "TrainLiveStatus.jsp?trainno=" + number;
            }


        </script>
    </head>
    <body>
        <div class="container">
            <div class="jumbotron">
                <h2 style=" align-content: center ; color:green">Train Between Station</h2>
            </div>
            <form class="form-horizontal">
                <div class="row">

                    <div class="col-sm-6 " >

                        <div class="form-group">
                            <label for="ss">Enter Source Station</label> 
                            <input type="text" class="form-control" id="ss" style="width:300px;height: 30px"/>
                        </div>

                        <div class="form-group">
                            <label for="dt">Enter Destination Station </label>
                            <input type="text" class="form-control" id="dt" style="width:300px;height: 30px"/>
                        </div>


                        <div class="form-group">
                            <label for="date">Enter Date </label>
                            <input type="text" class="form-control" id="date" placeholder="DD-MM-YYYY" style="width:300px;height: 30px"/>
                        </div>
                        <div class="form-group">
                            <button type="button" onclick="get()"  class="btn-success btn-sm">check</button>
                        </div>
                    </div>

                    <div class="col-sm-6" id="mydiv1">

                    </div>
                    <div  style="color: red" id="Sres">
                    </div>


                </div>
            </form>
        </div>


    </body>
</html>
