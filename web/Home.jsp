<%-- 
    Document   : UserHome
    Created on : Apr 9, 2018, 4:56:02 AM
    Author     : Viney Kumar
--%>
<%
    String email = (String) session.getAttribute("email");

//    if (email == null) {
//        response.sendRedirect("UserLogin.jsp");
//        return;
//    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Welcome to IRCTC</title>
        <script src="js/jquery-1.12.4.js" type="text/javascript"></script>
        <script src="js/bootstrap.js" type="text/javascript"></script>

        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Bootstrap -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href='http://fonts.googleapis.com/css?family=Dosis:200,300,400,500,600,700,800' rel='stylesheet' type='text/css'>
        <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,700,800' rel='stylesheet' type='text/css'>
        <link href="css/style.css" rel="stylesheet">
        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
                  <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
                  <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
                <![endif]-->
        <script>
            function changepassword()
            {
                var op = document.getElementById("op").value;
                var np = document.getElementById("np").value;
                var cp = document.getElementById("cp").value;


                if (np !== cp)
                {
                    document.getElementById("lbmessage").innerHTML = '<label style="color:red;">Password and Confirm password should be same</label>';
                    return;
                } else
                {
                    var xmlhttp = new XMLHttpRequest();
                    xmlhttp.onreadystatechange = function ()
                    {
                        if (xmlhttp.readyState === 4 && xmlhttp.status === 200)
                        {
                            var restext = xmlhttp.responseText.trim();
                            if (restext === "success")
                            {
                                document.getElementById("lbmessage").innerHTML = '<label style="color:green;">\n\
                Password Changed Successfully  </label>';
                                document.getElementById("op").value = "";
                                document.getElementById("np").value = "";
                                document.getElementById("cp").value = "";
                            } else
                            {
                                document.getElementById("lbmessage").innerHTML = '<label style="color:red;">\n\
                Old password is not correct ' + restext + '</label>';
                            }
                        }
                    };
                    xmlhttp.open("GET", "./Changepassword?op=" + op + "&np=" + np, true);
                    xmlhttp.send();
                }


            }
            function TrainFare(ans)
            {
                window.location.href = "TrainFare.jsp?tn=" + ans;
            }
            function Trainarrival(ans)
            {
                window.location.href = "Trainarrival.jsp?ta=" + ans;
            }
            function Trainlive(ans)
            {
                window.location.href = "TrainLiveStatus.jsp?ta=" + ans;
            }
            function Trainstation(ans)
            {
                window.location.href = "TrainBetweenStation.jsp?ts=" + ans;
            }
            function Traincancel(ans)
            {
                window.location.href = "GetAllCancelTrains.jsp?ct=" + ans;
            }
            function Trainpnr(ans)
            {
                window.location.href = "Get PNR Status.jsp?pn=" + ans;
            }
            function Trainres(ans)
            {
                window.location.href = "RescheduleTrain.jsp?res=" + ans;
            }
            function Trainnum(ans)
            {
                window.location.href = "TrainNumber.jsp?tn=" + ans;

            }
            function seatavail(ans)
            {
                window.location.href = "SeatAvailable.jsp?sa=" + ans;

            }
            function namtocode(ans)
            {
                window.location.href = "StationNameToCode.jsp?nc=" + ans;

            }
            function codetonam(ans)
            {
                window.location.href = "CodeToStationName.jsp?cn=" + ans;

            }
            function trainauto(ans)
            {
                window.location.href = "TrainAutoComplete.jsp?ac=" + ans;

            }
        </script>

    </head>
    <body>

        <h1>Welcome to IRCTC Home :<%= email%></h1>


        <jsp:include page="headerHome.jsp"/>
        <jsp:include page="slidermain.jsp"/>
        <section class="main__middle__container homepage">
            <button type="button" 
                    class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Change Password</button>

            <button type="button" 
                    class="btn btn-info btn-lg" onclick="TrainFare()">Check Train Fare</button>
            <button type="button" 
                    class="btn btn-info btn-lg" onclick="Trainarrival()"> Train Arrival Detials</button>
            <button type="button" 
                    class="btn btn-info btn-lg" onclick="Trainlive()"> Train Live Status</button>
            <button type="button" 
                    class="btn btn-info btn-lg" onclick="Trainstation()"> Train Between Station</button>
            <button type="button" 
                    class="btn btn-info btn-lg" onclick="Traincancel()"> Cancelled Trains</button>
            <button type="button" 
                    class="btn btn-info btn-lg" onclick="Trainpnr()"> PNR Status</button>
            <button type="button" 
                    class="btn btn-info btn-lg" onclick="Trainres()">Reschedule Trains</button>
            <button type="button" 
                    class="btn btn-info btn-lg" onclick="Trainnum()">Train Number</button>
            <button type="button" 
                    class="btn btn-info btn-lg" onclick="seatavail()">Seat Available</button> 
            <button type="button" 
                    class="btn btn-info btn-lg" onclick="namtocode()">StationNameToCode</button>
            <button type="button" 
                    class="btn btn-info btn-lg" onclick="codetonam()">CodeToStationName</button>
            <button type="button" 
                    class="btn btn-info btn-lg" onclick="trainauto()">TrainAutoComplete</button>

        </section>

        <jsp:include page="footermain.jsp"/>
        <jsp:include page="scriptmain.jsp"/>

        <!-- Modal -->
        <div id="myModal" class="modal fade" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">User Login</h4>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="form-group">
                                <label>Old Password</label>
                                <input type="password" class="form-control" id="op"/>
                            </div>

                            <div class="form-group">
                                <label>New Password</label>
                                <input type="password" class="form-control" id="np"/>
                            </div>
                            <div class="form-group">
                                <label>Confirm Password</label>
                                <input type="password" class="form-control" id="cp"/>
                            </div>

                            <input onclick="changepassword()" type="button" class="btn btn-success" value="Change Password" />
                            <div class="form-group" id="lbmessage">
                            </div>

                        </form>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>

            </div>
        </div>
    </body>
</html>