<%-- 
    Document   : MainHome
    Created on : 12 May, 2018, 11:24:54 AM
    Author     : pc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>trains and flights</title>
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script>
            function home(ans)
            {
                window.location.href = "Home.jsp?ac=" + ans;

            }
            function home1(ans)
            {
                window.location.href = "Home1.jsp?ac=" + ans;

            }
        </script>
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
    </head>
    <body>

        <jsp:include page="headermainhome.jsp"/>
        <jsp:include page="slidermain.jsp"/>
        <section class="main__middle__container homepage">
            <div class="container">
                <div class="row">
                    <div class="col-sm-6">
                        <center>
                            <div class="imgcontainer">
                                <img src="pics/train2.jpg" onclick="home()">
                                <h3 class="text-center text-center">Trains</h3>

                            </div>
                        </center>
                    </div>
                    <div class="col-sm-6">
                        <center>
                            <div class="imgcontainer">
                                <img src="pics/airport2.jpg" onclick="home1()">
                                <h3 class="text-center text-center">Flights</h3>
                            </div>
                        </center>
                    </div>
                </div>
            </div>
        </section>
        <jsp:include page="footermain.jsp"/>
        <jsp:include page="scriptmain.jsp"/>
    </body>
</html>
