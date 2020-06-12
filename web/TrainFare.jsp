<%-- 
    Document   : TrainFare
    Created on : Apr 20, 2018, 12:56:40 AM
    Author     : Viney Kumar
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/jquery-1.12.4.js" type="text/javascript"></script>
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="css/jquery_ui.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery.js" type="text/javascript"></script>
        <script src="js/jquery_ui.js" type="text/javascript"></script>
        <title>JSP Page</title>
        <style>

         
            .div2
            {
                margin-top: 20px;
                height: 100%;
                border:solid green;
                margin-bottom: 50px;

            }
            .oneline
            {
                display: inline-table;
                margin-left: 40px;
                margin-right: 20px;

            }
            .div3
            {
                height: 600px;
                overflow-y: auto;


            }
            #frm
            {
                margin-left: 20px;   
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
            function fare()
            {
                var tn = document.getElementById("tn").value;
                var st = document.getElementById("st").value;
                var det = document.getElementById("det").value;
                var ap = document.getElementById("ap").value;
                var dt = document.getElementById("dt").value;
                var qt = document.getElementById("qt").value;
                var cc = document.getElementById("cc").value;
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function ()
                {
                    if (xmlhttp.readyState === 4 && xmlhttp.status === 200)
                    {
                        var res = xmlhttp.responseText.trim();
                        console.log(res);
                        var resjson = JSON.parse(res);
                        //console.log(resjson);
                        var rc = resjson.response_code;
                        if (rc === 200)

                        {
                            trainfare(resjson);
                            head(resjson);
                            days(resjson);
                            quota(resjson);
                        } else
                        {
                            checkrescode(rc);
                        }

                    }
                };

                xmlhttp.open("GET", "./TrainFare?tn=" + tn + "&st=" + st + "&det=" + det + "&ap=" + ap + "&dt=" + dt + "&qt=" + qt + "&cc=" + cc, true);
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
                        lb.innerHTML = "<h1>Train Fare are Not Available ! <span class='fa fa-money' style='font-size:48px;color:red'></span></h1>";
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


            function quota(resjson)
            {
                var ans = "";
                ans += document.getElementById("war").innerHTML = "<center><h2><strong>Quota Name:</strong>" + resjson.quota.name + "</h2></center>";
                ans += document.getElementById("jour").innerHTML = "<center><h2><strong>Journey Class:</strong>" + resjson.journey_class.name + "</h2></center>";
                document.getElementById("war").style.display = 'block';
                document.getElementById("jour").style.display = 'block';
            }
            function trainfare(resjson)
            {
                var ans = "";
                ans += "<table class='table table-hover'>";
                ans += "<caption><h3><center>Train Fare :Rs " + resjson.fare + "<center><h3></caption>";

                ans += "<thead class='bg-primary'>";
                ans += "<tr>";
                ans += "<td>" + resjson.from_station.name + "</td><td>-----></td><td>" + resjson.to_station.name + "</td>";
                ans += "</tr>";
                ans += "<tr>";
                ans += "<td>Srno</td>";
                ans += "<td>Train Name </td>";
                ans += "<td>Available</td>";
                ans += "</tr>";
                ans += "</thead>";


                ans += "<tbody>";
                var st = resjson.train.classes;

                for (var i = 0; i < st.length; i++) {
                    ans += "<tr>";
                    ans += "<td>" + (i + 1) + "</td>";
                    ans += "<td>" + st[i].name + "</td>";
                    ans += "<td>" + st[i].available + "</td>";
                    ans += "</tr>";
                }


                ans += "</tbody>";
                ans += "</table>";

                document.getElementById("d1").innerHTML = ans;
            }
            function head(resjson)

            {
                var ans = "";
                var nm = resjson.train;
                ans += "<table class='table table-hover table-bordered'>";
                ans += document.getElementById("k2").innerHTML = "<center><h2>" + nm.name + "</h2></center>";
                document.getElementById("k2").style.display = 'block';
            }

            function days(resjson)
            {
                var ans = "";
                ans += "<table class='table table-hover'>";


                ans += "<thead class='bg-primary'>";
                ans += "<tr>";
                ans += "<td></td>";
                ans += "<td >Days List</td>";
                ans += "<td></td>";
                ans += "<td></td>";
                ans += "</tr>";
                ans += "<tr>";
                ans += "<td>Days </td>";
                ans += "<td><td>Run</td></td>";
                ans += "<td></td>";
                ans += "</tr>";
                ans += "</thead>";
                ans += "<tbody>";
                var dy = resjson.train.days;

                for (var i = 0; i < dy.length; i++) {
                    ans += "<tr>";
                    //ans += "<td>" + (i + 1) + "</td>";
                    ans += "<td>" + dy[i].code + "</td>";
                    ans += "<td><td>" + dy[i].runs + "</td></td>";
                    ans += "</tr>";
                }
                ans += "<tbody>";
                ans += "</table>";

                document.getElementById("d2").innerHTML = ans;

            }
        </script>
        <link href="css/jquery_ui.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery.js" type="text/javascript"></script>
        <script src="js/jquery_ui.js" type="text/javascript"></script>
        <script>
            $(function () {
                $("#dt").datepicker(
                        {
                            minDate: 0,
                            dateFormat: 'dd-mm-yy'
                        });
            });
        </script>
    </head>

    <body>
        <div class="container">

            <div class="row">

                <div class="col-sm-6 div2">
                    <div class="alert alert-success ">

                        <h2><strong> TRAIN FARE DETIALS</strong></h2> 

                    </div>   

                    <form class="form-horizontal" action="#" method="GET"id="frm">

                        <div class="form-group">

                            <label for="tn">Enter Train Number</label> 
                            <input type="text" class="form-control" id="tn" style="width:300px;height: 30px"  />
                        </div>
                        <div class="form-group">
                            <label for="st">Enter Source Station</label> 
                            <input type="text" class="form-control" id="st" style="width:300px;height: 30px"  />
                        </div>
                        <div class="form-group">
                            <label for="det">Enter Destination Station</label> 
                            <input type="text" class="form-control" id="det" style="width:300px;height: 30px" />
                        </div>
                        <div class="form-group">
                            <label for="ap">Age of the Passenger</label> 
                            <input type="text" class="form-control" id="ap" style="width:300px;height: 30px" />
                        </div>
                        <div class="form-group">
                            <label for="dt"> Enter Date</label> 
                            <input type="text" class="form-control" id="dt" style="width:300px;height: 30px" />
                        </div>
                        <div class="form-group">
                            <label for="cc"> Class Code</label> 
                            <select id="cc" class="form-control" style="width:300px;height: 30px">
                                <option selected="selected" value="1A"> 1A</option>
                                <option value="2A">2A</option>
                                <option value="FC">FC</option>
                                <option value="3A">3A</option>
                                <option value="CC">CC</option>
                                <option value="SL">SL</option>
                                <option value="2S">2S</option>
                            </select>

                        </div>
                        <div class="form-group">
                            <label for="qt">Quota Code</label>
                            <select id="qt" class="form-control" style="width:300px;height: 30px">
                                <option selected="selected">GN</option>
                                <option value="LD">LD</option>
                                <option value="HO">HO</option>
                                <option value="DF">DF</option>
                                <option value="PT">PT</option>

                            </select>
                        </div>
                        <div class="form-group">
                            <button type="button" onclick="fare()" class="btn btn-success btn-sm" >CHECK FARE</button>
                        </div>





                    </form>



                </div>

                <div class="col-sm-6" >
                    <div class="jumbotron" id="k2" style="display:none">

                    </div>
                    <div class="alert alert-info well-sm" style="display: none" id="war" >

                    </div>
                    <div class="alert alert-info well-sm" style="display: none" id="jour" >
                    </div>
                    <div class="oneline" id="d1">

                    </div>
                    <div class="oneline" id="d2">

                    </div>

                    <div id="Sres"  style="color:red">
                    </div>
                </div>


            </div> 


        </div>



    </body>
</html>
