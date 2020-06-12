<%-- 
    Document   : Home1
    Created on : 12 May, 2018, 11:27:43 AM
    Author     : pc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery-1.12.4.js" type="text/javascript"></script>
        <script src="js/bootstrap.js" type="text/javascript"></script>
        <script>
            function code()
            {

                var ec = document.getElementById("ec");

                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function ()
                {
                    if (xmlhttp.readyState === 4 && xmlhttp.status === 200)
                    {
                        var res = xmlhttp.responseText.trim();
                        var resjson = JSON.parse(res);
//                        console.log(resjson);
                        iata(resjson);


                    }
                };
                xmlhttp.open("GET", "./Home?&ec=" + ec, true);
                xmlhttp.send();
            }

            function iata(resjson)
            {
                var st = resjson.airlines;
                for (var i = 0; i < st.length; i++)
                {
                    document.getElementById("name").innerHTML = "<h2>Name:" + st[i].name + "</h2>";
                    document.getElementById("iata").innerHTML = "<h2>IATA:" + st[i].iata + "</h2>";
                    document.getElementById("icao").innerHTML = "<h2>ICAO:" + st[i].icao + "</h2>";
                    document.getElementById("pn").innerHTML = "<h2>Phone Number:" + st[i].phoneNumber + "</h2>";
                    if (st[i].active)
                    {
                        document.getElementById("ac").innerHTML = "<h2>Active:Yes</h2>";
                    } else
                    {
                        document.getElementById("ac").innerHTML = "<h2>Active:No</h2>";
                    }
                }
            }
            </script>
        <script>
            function code1()
            {

                var ec1 = document.getElementById("ec1");

                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function ()
                {
                    if (xmlhttp.readyState === 4 && xmlhttp.status === 200)
                    {
                        var res = xmlhttp.responseText.trim();
                        var resjson = JSON.parse(res);
                        // console.log(resjson);
                        icao(resjson);


                    }
                };
                xmlhttp.open("GET", "./Home1?&ec1=" + ec1, true);
                xmlhttp.send();
            }

            function icao(resjson)
            {
                var st = resjson.airlines;
                for (var i = 0; i < st.length; i++)
                {
                    document.getElementById("name1").innerHTML = "<h2>Name:" + st[i].name + "</h2>";
                    document.getElementById("iata1").innerHTML = "<h2>IATA:" + st[i].iata + "</h2>";
                    document.getElementById("icao1").innerHTML = "<h2>ICAO:" + st[i].icao + "</h2>";
                    document.getElementById("pn1").innerHTML = "<h2>Phone Number:" + st[i].phoneNumber + "</h2>";
                    if (st[i].active)
                    {
                        document.getElementById("ac1").innerHTML = "<h2>Active:Yes</h2>";
                    } else
                    {
                        document.getElementById("ac1").innerHTML = "<h2>Active:No</h2>";
                    }
                }
            }


        </script>
        <script>

             function radii(ans)
            {
                window.location.href = "AirportsWithinRadius.jsp?tn=" + ans;
            }
            function detial(ans)
            {
                window.location.href = "GetAirportDetails.jsp?ta=" + ans;
            }
            function arriving(ans)
            {
                window.location.href = "GetAirportArrivals.jsp?ta=" + ans;
            }
            
            function depart(ans)
            {
                window.location.href = "GetAirportDeparture.jsp?ts=" + ans;
            }
            function airauto(ans)
            {
                window.location.href = "AirlineAutoComplete.jsp?ct=" + ans;
            }
            function near(ans)
            {
                window.location.href = "Flightnearme.jsp?pn=" + ans;
            }
             function scharr(ans)
            {
                window.location.href = "GetScheduleArrival.jsp?ar=" + ans;
            }
              function schdept(ans)
            {
                window.location.href = "GetScheduleDept.jsp?dt=" + ans;
            }
        </script>
    </head>
    <body>
       
        <button type="button" 
                class="btn btn-info btn-lg" onclick="radii()">Get Airport within Radius</button>
        <button type="button" 
                class="btn btn-info btn-lg" onclick="detial()">Get Airport Details</button>
        <button type="button" 
                class="btn btn-info btn-lg" onclick="arriving()"> Get flight arriving at airports </button>
        <button type="button" 
                class="btn btn-info btn-lg" onclick="depart()"> Get flight departing from airports </button>
        <button type="button" 
                class="btn btn-info btn-lg" onclick="airauto()">Airline Auto complete</button>
        <button type="button" 
                class="btn btn-info btn-lg" onclick="near()"> Flight near by</button>
        <button type="button" 
                class="btn btn-info btn-lg" onclick="scharr()">Schedule of Arrival Flights</button>
        <button type="button" 
                class="btn btn-info btn-lg" onclick="schdept()">Schedule of Departure Flights</button>
        
        <button type="button" 
                class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Get Detials By IATA</button>
        <button type="button" 
                class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal1">Get Detials By ICAO</button>   
        <div id="myModal" class="modal fade" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h1 class="modal-title" > CHECK DETIALS BY IATA</h1>
                    </div>
                    <div class="modal-body">
                        <form action="#"  method="GET">
                            <div class="form-group">
                                <label for="ec">Enter Code</label>
                                <input type="text" class="form-control" id="ec"/>
                            </div>



                            <input type="button" class="btn btn-success" value="GET DETIALS"  onclick="code()" />
                        </form>
                        <div id="name">

                        </div>

                        <div id="iata">

                        </div>
                        <div id="icao">

                        </div>
                        <div id="pn"></div>
                        <div id="ac"></div>

                    </div>
                    <div class="modal-footer">


                    </div>
                </div>
                </div>
        </div>

        <div id="myModal1" class="modal fade" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h1 class="modal-title" > CHECK DETIALS BY ICAO</h1>
                    </div>
                    <div class="modal-body">
                        <form action="#"  method="GET">
                            <div class="form-group">
                                <label for="ec1">Enter Code</label>
                                <input type="text" class="form-control" id="ec1"/>
                            </div>



                            <input type="button" class="btn btn-success" value="GET DETIALS"  onclick="code1()" />
                        </form>
                        <div id="name1">

                        </div>

                        <div id="iata1">

                        </div>
                        <div id="icao1">

                        </div>
                        <div id="pn1"></div>
                        <div id="ac1"></div>

                    </div>
                    <div class="modal-footer">


                    </div>
                </div>

            </div>
        </div>

    </body>
</html>
