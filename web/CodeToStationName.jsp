<%-- 
    Document   : CodeToStationName
    Created on : 10 May, 2018, 10:08:01 AM
    Author     : pc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
        <script src="js/jquery-1.12.4.js" type="text/javascript"></script>
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
       
        <style>
            .in
            {
             display: inline-block;
             margin-left: 40px;
            }
        </style>
        <script>
          function sname()
          {
             var sn=document.getElementById("sn").value;
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
                            codetoname(resjson);
                        }
                        else
                        {
                             
                                checkrescode(rc);

                            
                        }
                        
                    }
                };
                xmlhttp.open("GET", "./CodeToStationName?sn=" + sn, true);
                xmlhttp.send();

          }function  checkrescode(rc) {
              
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
                        lb.innerHTML = "<h3>!No Code Is Available For Given Station</h3>";
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
            function codetoname(resjson)
            {
                var ans = "";
                ans += "<table class='table table-hover table-bordered'>";
              
                ans += "<thead class='bg-primary'>";
                ans += "<tr>";
                ans += "<td>Srno</td>";
                ans += "<td>Station Name </td>";
                ans+="<td>Arrival Time</td>";
                ans += "</tr>";
                ans += "</thead>";


                ans += "<tbody>";
                var st = resjson.stations;
                for (var i = 0; i < st.length; i++) {
                    ans += "<tr>";
                    ans += "<td>" + (i + 1) + "</td>";
                    ans += "<td>" + st[i].name+"("+st[i].code+ ")"+ "</td>";
                    ans += "<td><input type='button' value='SHOW ARRIVAL TIME' class='btn btn-success btn-sm' onclick='ARRIVAL("+st[i].number+")'/></td>";
//                    console.log(ans);
                    // break;

                    ans += "</tr>";
                }

                ans += "</tbody>";
                ans += "</table>";

                document.getElementById("sn1").innerHTML = ans;
            }
            function ARRIVAL(number)
            {
                window.location.href = "Trainarrival.jsp?s1="+number;
            }

        </script>
    </head>
    <body>
         <div class="container">
            <div class="jumbotron"><h1  style="color: palegreen"> Code To Station Name</h1></div>
            <div class="row">
                <div class="col-sm-6" id="d1">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label for="sn" style="margin-left:20px" class="in">Enter Station Code</label> 
                            <input type="text" class="form-control" id="sn"style="margin-left:20px"/>
                            <br>
                            <center><button type="button" onclick="sname()" class="btn btn-success btn-sm"  >GET DETIALS</button></center>

                        </div>
                    </form>
                    </div>
                <form class="form-horizontal">
                <div class="form-group">
                    
                    <div id="Sres" style="color:red" class="in"></div>
                <div id="sn1" class="col-sm-6"></div>
                
                </div>
                </form>
                </div>
            </div>
    </body>
</html>
