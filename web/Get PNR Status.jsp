<%-- 
    Document   : Get PNR Stayus
    Created on : Apr 12, 2018, 2:55:30 AM
    Author     : Viney Kumar
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <script src="js/jquery-1.12.4.js" type="text/javascript"></script>
        <script src="js/bootstrap.js" type="text/javascript"></script>
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

        <title>JSP Page</title>
       
            <script>

                function get()
                {
                    var pnr = document.getElementById("pnr").value.trim();
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
                            if (rc ===200)
                            {
                               
                                pnrstatus(resjson);
                                pass(resjson);

                            }
                             else
                        {
                            checkrescode(rc);
                        }
                        }

                    };
                    xmlhttp.open("GET", "./GetPNR?pnr=" + pnr, true);
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
                        lb.innerHTML = "<i class='material-icons' style='font-size:36px'>mood_bad</i><h1>No Detials are available.</h1>";
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
                function pnrstatus(resjson)
                {
                    var ans = "";
                    ans += "<table class='table table-hover'>";

                    ans += "<thead class='bg-primary'>";
                    ans += "<tr>";
                    ans += "<td>" + resjson.from_station.name + "</td><td>-------></td><td>" + resjson.to_station.name + "</td></td>";
                    ans += "</tr>";
                    ans += "</thead>";

                    ans += "<tbody>";
                    ans += "<tr>";
                    ans += "<td>Train Name</td><td><td>" + resjson.train.name + "</td></td>";
                    ans += "</tr>";
                    ans += "<tr><td>Journey Class</td><td><td>" + resjson.journey_class.name + "</td></td></tr>";
                    ans += "<tr><td>Date of Journey</td><td><td>" + resjson.doj + "</td></td></tr>";


                    ans += "</tbody>";
                    ans += "</table>";

                    document.getElementById("mydiv1").innerHTML = ans;

                }

                function pass(resjson)

                {
                    var ans = "";
                    ans += "<table class='table table-hover'>";

                    ans += "<thead class='bg-primary'>";
                    ans += "<tr>";
                    ans += "<td>Passenger</td>";
                    ans += "<td>Detials</td><td></td><td></td><td></td>";
                   
                    ans += "</tr>";
                    ans += "</thead>";

                    ans += "<tbody>";


                    ans += "<tr>";
                    ans += "<td><span class='glyphicon glyphicon-star'style='color:blue'></span></td><td>TotalPassengers</td><td></td><td></td><td>" + resjson.total_passengers + "</td>";
                    ans += "</tr>";

                    for (var i = 0; i < resjson.total_passengers; i++)
                    {
                        ans += "<tr>";
                        ans += "<td>" + resjson.passengers[i].no + "</td>";

                        ans += "<td>Current Status</td><td>" + resjson.passengers[i].current_status + "</td>";
                        ans += "<td>Booking Status</td><td>" + resjson.passengers[i].booking_status + "</td>";
                        ans += "</tr>";
                    }

                    ans += "</tbody>";
                    ans += "</table>";

                    document.getElementById("mydiv2").innerHTML = ans;

                }





            </script>

        </head>
        <body>
            <div class="container">
                <div class="jumbotron">
                    <h1>GET PNR STATUS</h1>   
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        
                        <form class="form-inline" action="#" method="GET">
                            <div class="form-group">
                                <label class="text-success" for="pnr">Enter PNR Number</label>
                                <input type="text" placeholder="Enter PNR Number " class="form-control" id="pnr" name="pnr" />
                                    <button type="button" class=" btn btn-success btn-sm" onclick="get()">Check Detials</button>
                                </div>
                            </form>
                          

                        </div>
                        <div class="row"> 
                            <div class="col-sm-8" id="mydiv1">


                            </div>


                            <div class="col-sm-4" id="mydiv2">



                            </div>
                            <div id="Sres" style="color: red">
                                
                            </div>
                        </div> 
                    </div>
                  
                    </div>
            </body>
        </html>
