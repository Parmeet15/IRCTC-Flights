<%-- 
    Document   : RescheduleTrain
    Created on : Apr 19, 2018, 11:21:46 PM
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
        <link href="css/jquery_ui.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery.js" type="text/javascript"></script>
        <script src="js/jquery_ui.js" type="text/javascript"></script>

        <title>JSP Page</title>
        <style>
            #r1{
                height:500px;
                overflow-y: auto
                   
            }
            #jb
            {
              padding-left:50px;
              margin-top: 40px;
            }
             #bt
             {
                 margin-left: 40px;
             }
             #dt{
                 width:200px;
                 height: 40px;
             }
              .mdiv
              {
                  padding: 30px;
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

            function reschd()
            {
                
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
                        //                               document.getElementById("resp").innerHTML = resjson;
                        var rc = resjson.response_code;
                        if (rc === 200)
                        {
                            head(resjson);
                            fun(resjson);
                        }
                        else
                            {
                                checkrescode(rc);

                            }
                    }
                };
                xmlhttp.open("GET", "./RescheduleTrain?date=" + date, true);
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
                        lb.innerHTML = "!No Detials are Available";
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
                document.getElementById("al").innerHTML="<h2><strong>RESCHDULE TRAIN DETIALS</strong></h2>";
                 document.getElementById("al").style.display = 'block';

            }
            function fun(resjson)
            {
                var ans = "";
                  var st = resjson.trains;
                ans += "<table class='table table-hover table-bordered table-striped'>";
                
                ans +="<thead class='bg-primary ' >";
                ans+="<tr>";
                ans+="<td>Srno</td>";
                ans+="<td>Train Name </td><td>Train Number</td><td>Reschedule Date</td><td>Reschedule Time</td></tr>";
        ans+="</thead>";
 
                

                ans += "<tbody>";
                var st = resjson.trains;
                for (var i = 0; i < st.length; i++) {
                    ans += "<tr>";
                    ans += "<td>" + (i + 1) + "</td>";
                    ans += "<td>" + st[i].name + "</td>";
                    ans += "<td>" + st[i].number + "</td>";
                    ans += "<td>" + st[i].rescheduled_date + "</td>";
                    ans += "<td>" + st[i].rescheduled_time + "</td>";
                    // ans += "<td><input type='button' value='SHOW MAP' class='btn btn-success btn-sm' onclick='showmap(" + JSON.stringify(st[i]) + ")'/></td>";
//                    console.log(ans);
                    // break;

                    ans += "</tr>";
                }

                ans += "</tbody>";
                ans += "</table>";

                document.getElementById("r1").innerHTML = ans;
            }


        </script>

    </head>
    <body>

        <div class="container">           
            <div class="row">

                <div class="col-sm-6">
                    <div class="jumbotron" id="jb">
                       
                        <h2><strong> Reschedule Train Detials</strong></h2>
                        
                    </div>
                    <form class="form-inline" action="#" method="GET">
                        <div class="form-group">
                            <label  class=" text-info " for="date"><strong>Enter Date</strong></label> 
                            <input type="text" class="form-control" id="date" placeholder="DD-MM-YYYY" name="date"/>
                        </div>
                        <div class="form-group">

                            <button type="button" onclick="reschd()" class="btn btn-info btn-sm" id="bt" >CHECK DETIALS <span class="glyphicon glyphicon-arrow-right"></span></button>

                        </div>
                    </form>


                </div>
                <div class="col-sm-6 mdiv" >
                    <div id="Sres" style="color: red"></div>
                    <div  class="  alert alert-info text-warning " style="display:none" id="al"></div>
                    <div id="m1"></div>
                    <div id="r1"></div>
                     

                </div>

            </div>
        </div>

    </body>
</html>
