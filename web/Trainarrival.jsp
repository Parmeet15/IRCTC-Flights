<%-- 
    Document   : Trainarrival
    Created on : Apr 17, 2018, 4:04:04 AM
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
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <title>JSP Page</title>
        <style>
            input[type=text] {
                border: 2px solid green;
                border-radius: 4px;
            }
            #mydiv1{
                height: 300px;
                overflow-y:auto;
            }
           

        </style>
       
        <script>
            function get()
            {
                var s1 = document.getElementById("s1").value;
                var hour = 2;

                var b2 = document.getElementById("b2").checked;
                if (b2)
                {
                    hour = 4;
                }


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
                            arrival(resjson);
                        } else
                        {
                            checkrescode(rc);

                        }
                    }
                };
                xmlhttp.open("GET", "./Trainarrival?s1=" + s1 + "&b1=" + hour, true);
                xmlhttp.send();

            }
            function  checkrescode(rc) {

                var lb = document.getElementById("Sres");

                switch (rc) {
                    case 404:
                        lb.innerHTML = "<i class='material-icons' style='font-size:36px'>mood_bad</i><h2>No Train Will Arrive in the Selected Window Time</h2>";
                        break;
                    case 405:
                        lb.innerHTML = "<i class='material-icons' style='font-size:36px'>mood_bad</i><h2>Data couldn’t be loaded on our servers.Request couldn’t go through.</h2>";
                        break;

                    case 500:
                        lb.innerHTML = "Unauthorized API Key.";
                        break;
                }
            }
            function arrival(resjson)
            {
                document.getElementById("totaltrains").innerHTML="<span class= 'glyphicon glyphicon-arrow-down'></span> Total " + resjson.total +
                        "Trains Arriving </h1>";
                var ans = "";
                ans += "<table class='table table-hover table-bordered'>";
                ans += "<caption>All Trains</caption>";

                ans += "<thead class='bg-primary'>";
                ans += "<tr>";
                ans += "<td>Srno</td>";
                ans += "<td>Train Name </td>";
                ans += "<td>Arrival Time</td>";
                ans += "<td>Departure Time</td>";
                ans += "<td>Delay Time</td>";
                ans += "<td>Live Status</td>";



                ans += "</tr>";
                ans += "</thead>";


                ans += "<tbody>";
                var st = resjson.trains;
                for (var i = 0; i < st.length; i++)
                {
                    ans += "<tr>";
                    ans += "<td>" + (i + 1) + "</td>";
                    ans += "<td>" + st[i].name + "</td>";
                    ans += "<td>" + st[i].actarr + "</td>";
                    ans += "<td>" + st[i].actdep + "</td>";
                    ans += "<td>" + st[i].delayarr + "</td>";
                    ans += "<td><input type='button' value='Live Status' class='btn btn-success' onclick='LiveStatus(" + st[i].number + ")'/></td>";
//                    console.log(ans);
                    //break;

                    ans += "</tr>";
                }
                ans += "</tbody>";
                ans += "</table>";
                document.getElementById("mydiv1").innerHTML = ans;
            }
            function LiveStatus(number)
            {
                //    console.log(number);
                window.location.href = "TrainLiveStatus.jsp?trainno=" + number;
            }


        </script>
    </head>
    <body>
        <div class="container div2" id="scroll">
            <div class="jumbotron">
                <h1>Train Arrival Detials</h1>
            </div>
            <div class="row">
                <div class="col-sm-4" id="d1">

                    <form class="form-inline">
                        <div class="form-group">
                            <label for="s1">Enter Source Station</label> 
                            <input type="text" class="form-control" id="s1" placeholder="ASR"/>
                        </div>  

                    </form>

                    <form class="form-inline">

                        <label>Select Window Time </label>       

                        <input type="radio" name="rbg" checked value="2 HRS" id="b1"> 2HRS  <input type="radio" name="rbg" value="4 HRS" id="b2" > 4HRS<br>


                    </form>

                    <button type="button" onclick="get()"  class=" btn btn-success btn-default">check</button>
                </div>

                <div id="Sres" style="color:darkred"></div>

                <div class="col-sm-8">
                    <h3 id="totaltrains" class="text-danger"></h3>
                    <div id="mydiv1">
                        
                    </div>
                </div>

            </div>
        </div>

    </body>
</html>
