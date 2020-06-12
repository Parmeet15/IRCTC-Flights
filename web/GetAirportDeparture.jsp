<%-- 
    Document   : GetAirportDeparture
    Created on : May 1, 2018, 6:30:56 AM
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
         <link href="css/jquery_ui.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery.js" type="text/javascript"></script>
        <script src="js/jquery_ui.js" type="text/javascript"></script>




        <title>JSP Page</title>
        <script>
              $(function () {
                $("#dt").datepicker(
                        {
                            minDate: 0,
                            dateFormat: 'yy/mm/dd'
                        });
            });
            function detial()
            {
                var cc = document.getElementById("cc").value;
                var dt = document.getElementById("dt").value;
                var hd = document.getElementById("hd").value;
                var nh = document.getElementById("nh").value;
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function ()
                {
                    if (xmlhttp.readyState === 4 && xmlhttp.status === 200)
                    {
                        var res = xmlhttp.responseText.trim();
                        //  console.log(res);
                        var resjson = JSON.parse(res);
//                        console.log(resjson);
                        flight(resjson);
                        //head(resjson);
                    }
                };
                xmlhttp.open("GET", "./GetAirportDeparture?cc=" + cc + "&dt=" + dt + "&hd=" + hd + "&nh=" + nh, true);
                xmlhttp.send();
            }


            function flight(resjson)
            {
                var st = "";
                st = resjson.appendix.airlines;

                var ans = "";
                ans += "<table class='table table-hover'>";
                ans += "<thead class='bg-primary'>";
                ans += "<tr>";
                ans += "<td>Srno.</td>";
                ans += "<td>Airline Name </td>";
                ans += "<td><td>IATA</td></td>";
                ans += "<td><td>ICAO</td></td>";
                ans += "<td>Phone Number</td>";

                ans += "</tr>";
                ans += "</thead>";
                ans += "<tbody>"; if (st.length == 0)
                {
                    alert('No airport found');
                    return;
                }
                for (var i = 0; i < st.length; i++) {
                    ans += "<tr>";
                    ans += "<td>" + (i + 1) + "</td>";
                    ans += "<td>" + st[i].name + "</td>";
                    ans += "<td><td>" + st[i].iata + "</td></td>";
                    ans += "<td><td>" + st[i].icao + "</td></td>";
                    if (st[i].phoneNumber)
                    {
                        ans += "<td>" + st[i].phoneNumber + "</td>";
                    } else
                    {
                        ans += "<td>Not Available</td>";
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

                <div class="col-sm-4">

                    <form  action="#" method="GET" class="form-horizontal">


                        <div class="form-group">

                            <label for="cc">Enter City Code</label>
                            <input type="text"  class="form-control" id="cc" placeholder="ATQ" />
                        </div> 

                        <div class="form-group">
                            <label for="dt">Enter Date</label>
                            <input type="text" class="form-control" id="dt" placeholder="YYYY/MM/DD" />
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
                            <label for="nh">Number of Hours</label>
                            <select id="nh" class="form-control" >
                                <option selected="selected"> 1</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                                <option>5</option>
                                <option>6</option>
                            </select>

                        </div>


                        <input type="button" class="btn btn-success btn-block " value="GET FLIGHTS" onclick="detial()"/>
                    </form>
                </div>

                <div class="col-sm-8">
                    <div id="mdiv1"></div>
                </div>
            </div>
        </div>

    </body>
</html>
