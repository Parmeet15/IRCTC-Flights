<%-- 
    Document   : SeatAvaliable
    Created on : Apr 13, 2018, 10:57:59 PM
    Author     : Viney Kumar
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/jquery-1.12.4.js" type="text/javascript"></script>
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <script src="js/bootstrap.js" type="text/javascript"></script>
        <link href="css/jquery_ui.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery.js" type="text/javascript"></script>
        <script src="js/jquery_ui.js" type="text/javascript"></script>

        <title>JSP Page</title>
        <style>
            .div3
            {
                height: 500px;
                overflow-y: auto;
            }

            .quota1
            {
                margin:0;
            }
            .div2
            {
                margin-top: 20px;
                padding-top: 20px;
                border :solid green ;
                height: 100%;
                margin-bottom: 50px;

            }
            .oneline
            {

                margin-left:50px;
                display: inline-table;
                height: 200px;
                overflow-y: auto;



            }


        </style>
        <script>

            $(function () {
                $("#dt").datepicker(
                        {
                            minDate: 0,
                            dateFormat: 'dd-mm-yy'
                        });
            });

            function seat()
            {

                var trainname = document.getElementById("trainname").value;
                var sstation = document.getElementById("sstation").value;
                var dstation = document.getElementById("dstation").value;
                var dt = document.getElementById("dt").value;
                var classcode = document.getElementById("classcode").value;
                var quotacode = document.getElementById("quotacode").value;
                var xmlhttp = new XMLHttpRequest();

                xmlhttp.onreadystatechange = function ()
                {
                    if (xmlhttp.readyState === 4 && xmlhttp.status === 200)
                    {
                        var res = xmlhttp.responseText.trim();
                        console.log(res);
                        var resjson = JSON.parse(res);
                        var rc = resjson.response_code;
                        if (rc === 200)
                        {
                            head(resjson);
                            avail(resjson);
                            list(resjson);
                            dayslist(resjson);
                            quota(resjson);

                        } else
                        {
                            checkrescode(rc);
                        }
                    }
                };

                xmlhttp.open("GET", "./SeatAvailable?trainname=" + trainname + "&sstation=" + sstation + "&dstation=" + dstation + "&dt=" + dt + "&classcode=" + classcode + "&quotacode=" + quotacode, true);

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
                        lb.innerHTML = "<h1>Detials are Not Available ! </h1>";
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


            function head(resjson)

            {
                var ans = "";
                var nm = resjson.train;
                ans += "<table class='table table-hover'>";
                ans += document.getElementById("k2").innerHTML = "<center><h2>" + nm.name + "(" + nm.number + ")" + "</h2></center>";
                document.getElementById("k2").style.display = 'block';
            }
            function avail(resjson)
            {
                var ans = "";

                ans += "<table class='table table-hover'>";
                ans += "<thead class='bg-primary'>";
                ans += "<tr>";
                ans += "<td >" + resjson.from_station.name + "</td>" + "<td>-----></td>" + "<td>" + resjson.to_station.name + "</td>";
                ans += "</tr>";
                ans += "</thead>";
                ans += "<tr>";
                ans += "<td><td><center><h3 class='text-danger'>Seat Available List</h3></center></td></td>";
                ans += "</tr>";
                ans += "<thead class='bg-primary'>";
                ans += "<tr>";
                ans += "<td>Srno.</td>";
                ans += "<td>Date </td>";
                ans += "<td>Status</td>";
                ans += "</tr>";
                ans += "</thead>";
                ans += "<tbody>";
                var st = resjson.availability;

                for (var i = 0; i < st.length; i++) {
                    ans += "<tr>";
                    ans += "<td>" + (i + 1) + "</td>";
                    ans += "<td>" + st[i].date + "</td>";
                    ans += "<td>" + st[i].status + "</td>";
                    ans += "</tr>";
                }

                ans += "</tbody>";
                ans += "</table>";

                document.getElementById("d1").innerHTML = ans;
            }

            function list(resjson)
            {
                var ans = "";


                ans += "<tr>";

                ans += "<td><td><center><h3 class='text-danger'>class List</h3></center></td></td>";
                ans += "</tr>";
                ans += "<table class='table table-hover'>";
                ans += "<thead class='bg-primary'>";

                ans += "<tr>";
                ans += "<td>Srno<td><td></td></td></td>";
                ans += "<td> Name </td>";
                ans += "<td><td>Available</td></td><td></td>";
                ans += "</tr>";
                ans += "</thead>";
                ans += "<tbody>";
                var st = resjson.train.classes;

                for (var i = 0; i < st.length; i++) {
                    ans += "<tr>";
                    ans += "<td>" + (i + 1) + "</td>";
                    ans += "<td><td><td>" + st[i].name + "</td></td></td>";
                    ans += "<td></td><td>" + st[i].available + "</td><td></td>";
                    ans += "</tr>";
                }


                ans += "</tbody>";
                ans += "</table>";

                document.getElementById("d2").innerHTML = ans;
            }

            function dayslist(resjson)
            {
                var ans = "";


                ans += "<tr>";

                ans += "<td><td><center><h3 class='text-danger'><td><td>Days List </td></td></h3></center></td></td>";
                ans += "</tr>";
                ans += "<center>";
                ans += "<table class='table table-hover'>";
                ans += "<thead class='bg-primary'>";

                ans += "<tr>";
                ans += "<td><td> Srno.</td></td>";
                ans += "<td><td><td>Days </td></td> </td>";
                ans += "<td><td> Run</td></td>";

                ans += "</tr>";
                ans += "</thead>";
                ans += "<tbody>";
                var dy = resjson.train.days;

                for (var i = 0; i < dy.length; i++) {
                    ans += "<tr>";
                    ans += "<td><td>" + (i + 1) + "</td></td>";
                    ans += "<td><td><td>" + dy[i].code + "</td></td></td>";
                    ans += "<td><td>" + dy[i].runs + "</td></td>";
                    ans += "</tr>";
                }
                ans += "</center>";
                ans += "<tbody>";
                ans += "</table>";

                document.getElementById("d3").innerHTML = ans;

            }



            function quota(resjson)
            {
                var ans = "";
                ans += document.getElementById("war").innerHTML = "<center><h2><strong>Quota Name:</strong>" + resjson.quota.name + "</h2></center>";
                ans += document.getElementById("jour").innerHTML = "<center><h2><strong>Journey Class:</strong>" + resjson.journey_class.name + "</h2></center>";
                document.getElementById("war").style.display = 'block';
                document.getElementById("jour").style.display = 'block';
            }


        </script>
    </head>
    <body>


        <div class="container">

            <div class="row">

                <div class="col-sm-5 div2">
                    <div class="well">
                        <center><h2>SEAT AVAILABLE DETIALS</h2></center>
                    </div>   

                    <form class="form-horizontal" action="#" method="GET">
                        <center>  
                            <div class="form-group">

                                <label for="trainname">Enter Train Number</label> 
                                <input type="text" class="form-control" id="trainname" style="width:300px;height: 30px"  />
                            </div>
                            <div class="form-group">
                                <label for="sstation">Enter Source Station</label> 
                                <input type="text" class="form-control" id="sstation" style="width:300px;height: 30px"  />
                            </div>
                            <div class="form-group">

                                <label for="dstation">Enter Destination Station</label> 
                                <input type="text" class="form-control" id="dstation" style="width:300px;height: 30px" />
                            </div>
                            <div class="form-group">

                                <label for="dt">Enter Date</label>
                                <input type="text" class="form-control" id="dt" style="width:300px;height: 30px" />
                            </div>
                            <div class="form-group">

                                <label for="classcode">Class Code</label> 

                                <select id="classcode" class="form-control" style="width:300px;height: 30px">
                                    <option selected="selected"> 1A</option> 
                                    <option>2A</option>
                                    <option>FC</option>
                                    <option>3A</option>
                                </select>
                            </div>
                            <div class="form-group">

                                <label for="quotacode">Quota Code</label>
                                <select id="quotacode" class="form-control" style="width:300px;height: 30px">
                                    <option selected="selected"> PT</option> 
                                    <option>LD</option>
                                    <option>HO</option>
                                    <option>GN</option>
                                </select>
                            </div>
                            <div class="form-group">

                                <button type="button" onclick="seat()" class="btn btn-success btn-sm" >Check Detials</button>

                            </div>
                        </center>

                    </form>


                </div>

                <div class="col-sm-7 div3" >
                    <div class="well-lg alert alert-info" id="k2" style="display:none">

                    </div>


                    <div  id="d1">
                    </div>  
                    <div id="Sres"  style="color:red">
                    </div>
                    <div class="oneline" id="d2">

                    </div>

                    <div class="oneline" id="d3">

                    </div>

                    <div class="alert alert-danger well-sm quota1" style="display: none" id="war" >

                    </div>
                    <div class="alert alert-danger well-sm quota1" style="display: none" id="jour" >
                    </div>
                </div>
            </div> 


        </div> 
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>

    </body>
</html>
