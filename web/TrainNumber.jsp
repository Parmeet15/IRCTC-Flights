
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery-1.12.4.js" type="text/javascript"></script>
        <script src="js/bootstrap.js" type="text/javascript"></script>      
        <title>JSP Page</title>
        <style>
            .in{
                display: inline-table;
                margin-left: 20px;

            }
            .modal-content
            {
                background-color:#faebcc
            }

        </style>
        <script>
            function detial()
            {

                var trainnumber = document.getElementById("trainnumber").value;
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
                            trainnam(resjson);
                            trainnum(resjson);
                            traincl(resjson);
                        } else
                        {

                            checkrescode(rc);
                        }
                    }

                };

                xmlhttp.open("GET", "./TrainNumber?trainnumber=" + trainnumber, true);
                xmlhttp.send();

            }
            function  checkrescode(rc) {
                var lb = document.getElementById("Sres");

                switch (rc) {
                    
                    case 404:
                        lb.innerHTML = "<h2>Train Number:"+document.getElementById("trainnumber").value+" Detials are not Available</h2>";
                        break;
                         case 500:
                        lb.innerHTML = "Unauthorized API Key.";
                        break;
                }
            }
            function trainnam(resjson)
            {
                var ans = "";
                ans += document.getElementById("name").innerHTML = "<h1 class='text-primary'>" + resjson.train.name + "</h1>";
            }


            function trainnum(resjson)
            {
                var ans = "";
                ans += "<table class='table  table-hover table-bordered'>";
                ans += "<thead class='bg-primary'>";
                ans += "<tr>";
                ans += "<td>Srno.</td>";
                ans += "<td>Day</td>";
                ans += "<td>Run</td>";
                ans += "</tr>";
                ans += "</thead>";

                ans += "<tbody>";
                var st = resjson.train.days;
                for (var i = 0; i < st.length; i++)
                {
                    ans += "<tr>";
                    ans += "<td>" + (i + 1) + "</td>";
                    ans += "<td>" + st[i].code + "</td>";
                    ans += "<td>" + st[i].runs + "</td>";
                    ans += "</tr>";
                }
                ans += "</tbody>";
                ans += "</table>";
                document.getElementById("days").innerHTML = ans;
            }


            function live(number)
            {
                window.location.href = "TrainLiveStatus.jsp?trainno=" + number;

            }
            function traincl(resjson)
            {
                var ans = "";
                ans += "<table class='table  table-hover table-bordered'>";
                ans += "<thead class='bg-primary'>";
                ans += "<tr>";
                ans += "<td>code</td>";
                ans += "<td>Classes Available</td>";
                ans += "<td>Name</td>";
                ans += "</tr>";
                ans += "</thead>";
                ans += "<tbody>";
                var st = resjson.train.classes;
                for (var i = 0; i < st.length; i++)
                {
                    ans += "<tr>";
                    ans += "<td>" + st[i].code + "</td>";
                    ans += "<td>" + st[i].available + "</td>";
                    ans += "<td>" + st[i].name + "</td>";
                    ans += "</tr>";
                }
                ans += "</tbody>";
                ans += "</table>";
                document.getElementById("avail").innerHTML = ans;
            }

        </script>
    </head>  
    <body>
        <form>
            <button type="button"class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Train Name/Number</button>
        </form>
        <!-- Modal -->
        <div id="myModal" class="modal fade" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <div class="form-group">
                            <label for="trainnumber">Enter Train NUMBER</label>
                            <input type="text" class="form-control " id="trainnumber"/>
                        </div>
                        <center><button type="button" class="btn-lg btn-success" onclick="detial()">GET DETIALS</button></center>


                        <div class="modal-body" >
                            <div id="Sres" style="color:indianred">
                            </div> 
                            <div id="name">
                            </div>

                            <div id="days" class="in">     
                            </div>
                            <div id="avail" class="in"></div>


                        </div>
                        <div class="modal-footer">
                            <center><button type="button" class= "btn-lg btn-success " onclick="live()">GET LIVE STATUS</button></center>
                        </div>

                    </div>

                </div> 
            </div>
        </div>


    </body>
</html>
