<%-- 
    Document   : GetScheduleDept
    Created on : May 2, 2018, 3:02:31 AM
    Author     : Viney Kumar
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery-1.12.4.js" type="text/javascript"></script>
        <script src="js/myscript.js" type="text/javascript"></script>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        
        
        <title>JSP Page</title>
        <style>
            #mdiv1
            {
                padding-top: 10px;
                height: 500px;
                overflow-y: auto;
            }
            #hed{
                margin-left: 50px;
            }
        </style>
        <script>
         function detial()
            {
                var cc = document.getElementById("cc").value;
                var dt = document.getElementById("dt").value;
                var hd = document.getElementById("hd").value;
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function ()
                {
                    if (xmlhttp.readyState === 4 && xmlhttp.status === 200)
                    {
                        var res = xmlhttp.responseText.trim();
                            var resjson = JSON.parse(res);
//                        console.log(resjson);
                        arrival(resjson);

                    }
                };
                xmlhttp.open("GET", "./GetScheduleDept?cc=" + cc + "&dt=" + dt + "&hd=" + hd, true);
                xmlhttp.send();
            }
            function arrival(resjson)
            {
                var st = "";
                st = resjson.scheduledFlights;

                var ans = "";
                ans += "<table class='table table-hover'>";
                ans += "<thead class='bg-primary'>";
                ans += "<tr>";
                ans += "<td>Srno.</td>";
                ans += "<td>TO</td>";
                ans += "<td>From</td>";
                ans += "<td>Arrival Time</td>";
                ans += "<td>Departure Time</td>";
                ans += "<td>Stops</td>";

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
                    ans += "<td>" + (i + 1) + "</td>";
                   
                    ans += "<td>" + st[i].arrivalAirportFsCode + "</td>";
                    ans += "<td>" + st[i].departureAirportFsCode + "</td>";

                    ans += "<td>" + st[i].arrivalTime + "</td>";
                    ans += "<td>" + st[i].departureTime + "</td>";
                    if (st[i].stops !== 0)

                    {
                        ans += "<td>" + st[i].stops + " Stop</td>";
                    } else
                    {
                        ans += "<td>No Stop</td>";
                    }
                        ans += "</tr>";
                }
                ans += "</tbody>";
                ans += "</table>";
                document.getElementById("mdiv1").innerHTML = ans;
            }
        </script>

    </head>
    <body>
        <div class="container">

            <div class="row">
                <div class="jumbotron" id="hed">
                    <h2 class=" text-success"><strong> SCHEDULE OF DEPARTURE FLIGHTS  <i class="material-icons" style="font-size:50px;color:green">flight_takeoff</i></strong></h2>
                </div>

               
                <div class="col-sm-4">
                    

                    <form  action="#" method="GET" class="form-horizontal">


                        <div class="form-group">

                            <label for="cc">Enter City Code</label>
                            <input type="text"  class="form-control" id="cc" placeholder="ATQ" />
                        </div> 

                        <div class="form-group">
                            <label for="dt">Enter Date</label>
                            <input type="text"  class="form-control" id="dt" placeholder="YYYY/MM/DD" />
                        </div>
                        <div class="form-group">
                            <label for="hd">Hours of day</label>
                            <select id="hd" class="form-control" >
                                <option selected="selected"> 0</option>
                                <option> 1</option>
                                <option> 2</option>
                                <option>3</option>
                                <option>4</option>
                                <option>5</option>
                                <option>6</option>
                                <option>7</option>
                                <option>8</option>
                                <option>9</option>
                                <option>10</option>
                                <option>11</option>
                                <option>12</option>
                                <option>13</option>
                                <option>14</option>
                                <option>15</option>
                                <option>16</option>
                                <option>17</option>
                                <option>18</option>
                                <option>19</option>
                                <option>20</option>
                                <option>21</option>
                                <option>22</option>
                                <option>23</option>

                            </select>
                        </div>
                        <div class="form-group">
                            <input type="button" class="btn btn-success btn-block " value="GET SCHEDULE OF FLIGHTS" onclick="detial()"/>
                        </div>
                </div>       
                <div class="col-sm-8">
                    <div id="mdiv1"></div>
                </div>
            </div>
        </div>


    </body>
</html>
