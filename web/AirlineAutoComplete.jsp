

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
        <script>
            function auto1()
            {
                var sa = document.getElementById("sa").value;
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function ()
                {
                    if (xmlhttp.readyState === 4 && xmlhttp.status === 200)
                    {
                        var res = xmlhttp.responseText.trim();
                        if (res !== "" && !res.startsWith("Error"))
                        {
                            var resjson = JSON.parse(res);
                            autocomp(resjson);
                        }
                    }
                };
                xmlhttp.open("GET", "./FetchAirline?sa=" + sa, true);
                xmlhttp.send();
            }
            var st;
            function  autocomp(resjson)
            {
                var ans = "";
                st = resjson.ans;
                ans += "<table class='table table-hover table-bordered table-striped'>";
                ans += "<tbody>";
                for (var i = 0; i < st.length; i++) {
                    ans += "<tr onclick='setdata(" + i + ")'>";
                    ans += "<td>" + st[i].name + "  ( " + st[i].iata + " )`</td>";
                    ans += "</tr>";
                }
                ans += "</tbody>";
                ans += "</table>";
                document.getElementById("rr").innerHTML = ans;
            }
            function setdata(i)
            {
                document.getElementById("sa").value = st[i].name + " " + st[i].iata;
                document.getElementById("rr").innerHTML = "";

            }
        </script>
        <jsp:include page="headerfiles.jsp"/>
    </head>
    <body>
        <jsp:include page="headermainhome.jsp"/>
        <div class="container">
            <div class="row">
                <div class="col-sm-4">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label for="sa">Search Airline </label> 
                            <input type="text" onkeyup="auto1()" class="form-control" id="sa"/>
                            <div id="rr"></div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
<jsp:include page="footermain.jsp"/>

    </body>
</html>
