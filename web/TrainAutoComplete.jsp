<%-- 
    Document   : TrainAutoComplete
    Created on : Apr 18, 2018, 11:16:52 PM
    Author     : Viney Kumar
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/jquery-1.12.4.js" type="text/javascript"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

        <title>JSP Page</title>
        <style>
            .mydiv
            { 
                margin-right:70px;
                display: inline-table;
            }
            #pb{
                display: none;
            }
            #n1
            {
                height: 400px;
                overflow-y: auto;
            }
            #war
            {
                margin-top: 20px;
            }
        </style>
        <script>
            var isrunning = false;
            function auto()
            {
                var pn = document.getElementById("pn").value.trim();
                //console.log(isrunning);
                if (pn.length <= 2)
                {
                    return;
                } else
                {
                    if (isrunning)
                    {
                        return;
                    }
                    var xmlhttp = new XMLHttpRequest();
                    xmlhttp.onreadystatechange = function ()
                    {
                        if (xmlhttp.readyState === 4 && xmlhttp.status === 200)
                        {
                            var res = xmlhttp.responseText.trim();
                            console.log(res);
                            if (res !== "" && !res.startsWith("Error"))
                            {
                                var resjson = JSON.parse(res);
                                var rc = resjson.response_code;
                                if (rc === 200)
                                {
                                    autocomp(resjson);
                                    prog(res);
                                    // days(resjson);
                                }
                            } else
                            {
                                isrunning = false;
                                alert(res);

                            }

                        }
                    };
                    xmlhttp.open("GET", "./TrainAutoComplete?pn=" + pn, true);
                    xmlhttp.send();
                    isrunning = true;
                }
            }
            function prog(res)
            {

                var elem = document.getElementById("bar");
                var width = 70;
                var id = setInterval(frame, 10);
                function frame() {
                    if (width >= 100) {
                        clearInterval(id);
                    } else {
                        width++;
                        elem.style.width = width + '%';
                        elem.innerHTML = width * 1 + '%';
                    }
                }


                document.getElementById("pb").style.display = 'block';



            }
            function autocomp(resjson)
            {
                isrunning = false;
                var ans = "";
                ans += "<table class='table table-hover table-bordered table-striped'>";
                ans += "<tbody>";
                var st = resjson.trains;
                for (var i = 0; i < st.length; i++) {
                    ans += "<tr>";
                    ans += "<td>" + st[i].name + "  ( " + st[i].number + " ) </td>";
                    ans += "<td><input type='button' value='Details' class='btn btn-success btn-sm' onclick='showdetails(" + JSON.stringify(st[i]) + ")'/></td>";
                    ans += "</tr>";
                }

                ans += "</tbody>";
                ans += "</table>";

                document.getElementById("n1").innerHTML = ans;


            }


            function showdetails(obj)
            {
                head(obj);
                // console.log(obj);
                var ans = "";

                ans += "<table class='table table-hover table-bordered table-striped'>";

                ans += "<thead class='bg-primary'>";
                ans += "<tr>";
                ans += "<td>Srno</td>";
                ans += "<td>Classes Name </td>";
                ans += "<td>Available</td>";
                ans += "</tr>";
                ans += "</thead>";


                ans += "<tbody>";
                var st = obj.classes;
                for (var i = 0; i < st.length; i++) {
                    ans += "<tr>";
                    ans += "<td>" + (i + 1) + "</td>";
                    ans += "<td>" + st[i].name + "</td>";
                    if (st[i].available)
                    {
                        ans += "<td>Yes</td>";
                    } else
                    {
                        ans += "<td>NO</td>";
                    }


                    ans += "</tr>";
                }

                ans += "</tbody>";
                ans += "</table>";
                days(obj);
                document.getElementById("pn1").innerHTML = ans;

            }
            function head(obj)
            {
                var ans = "";
                ans += document.getElementById("war").innerHTML = "<h1 class='text-info'><strong>" + obj.name + "(" + obj.number + ")" +"<i class='material-icons'style='font-size:70px;color:blue'>train</i></strong></h1>";
                document.getElementById("war").style.display = 'block';
            }

            function days(obj)
            {
                var ans = "";
                ans += "<table class='table table-hover table-bordered table-striped'>";

                ans += "<thead class='bg-primary'>";
                ans += "<tr>";
                ans += "<td>Srno</td>";
                ans += "<td>Days</td>";
                ans += "<td>Run</td>";

                ans += "</tr>";
                ans += "</thead>";
                ans+="<tbody>";
                var st = obj.days;
                for (var i = 0; i < st.length; i++) {
                    ans += "<tr>";
                    ans += "<td> " + (i + 1) + "</td>";
                    ans += "<td>" + st[i].code + "</td>";
                    ans += "<td>" + st[i].runs + "</td>";


                    ans += "</tr>";
                }

                ans += "</tbody>";
                ans += "</table>";

                document.getElementById("pn2").innerHTML = ans;
            }

        </script>
    </head>
    <body>

        <div class="container">
            <div class="row">
                <div class="col-sm-4" >
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label for="pn">Enter Train Partial Name/Number </label> 
                            <input type="text" onkeyup="auto()" class="form-control" id="pn"/>
                        </div>
                    </form>

                    <br>
                    <div class="progress" id="pb">
                        <div  id="bar"class="progress-bar progress-bar-danger progress-bar-striped active" style="width:70% "  >
                            70% complete
                        </div>
                    </div>



                    <div  id="n1"> 
                    </div>


                </div>
                <div  class="col-sm-8 ">
                    <div class="alert alert-info well-sm quota1" style="display: none" id="war" >
                    </div>
                    <div id="pn1" class="mydiv">

                        </div>
                        <div id="pn2" class="mydiv">

                        </div>
                </div>

                
                    
                        
                    




                </div>
            </div>
        
    </body>
</html>
