<%-- 
    Document   : UserLogin
    Created on : Apr 9, 2018, 3:54:19 AM
    Author     : Viney Kumar
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
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <style>
            .imgcontainer {
                text-align: center;
                margin: 24px 0 12px 0;
            }
           
            form {
                border:13px solid #f1f1f1;
                width: 100%;
                height: 100%;
               

            }
            .inline
            {
                width: 100%;
                padding: 12px 20px;
                margin: 8px 0;
                display: inline-block;
                border: 1px solid #ccc;
                box-sizing: border-box;
            }


        </style>
        <script>
            function checkuserlogin()
            {
                var email = document.getElementById("email").value;
                var pass = document.getElementById("pass").value;



                var xml = new XMLHttpRequest();
                xml.onreadystatechange = function ()
                {
                    if (xml.readyState == 4 && xml.status == 200)
                    {
                        var res = xml.responseText.trim();
                        if (res == "success")
                        {
                            alert("success");
                            window.location.href = "MainHome.jsp";
                        } else
                        {
                            alert("invalid");
                            document.getElementById("l1").innerHTML = "INVALID PASSWORD";
                        }
                    }
                };

                xml.open("GET", "./CheckUserLogin?email=" + email + "&password=" + pass, true);
                xml.send();
            }

        </script>

    </head>

    <body>
        <h4 class="text-danger"><strong>Login Form</strong></h4>


        <form action="#" method="GET" class="form-horizontal" >
            <div class="imgcontainer">
                <img src="pics/user.jpg">
            </div>
            <div class="container" >
                <div class="form-group" >

                    <label for="email">Email</label><i class="material-icons" style="color:red">email</i>
                    <input type="text" placeholder="Enter Email" id="email" required class="inline">
                </div>
                <div class="form-group">
                    <label for="pass">Password</label><i class="material-icons" style="color:red"> vpn_key</i>

                    <input type="password" placeholder="Enter Password" id="pass" required class="inline">
                </div>

                <div class="form-group">
                    <button type="button" class="btn btn-success btn-block"  value="Login" onclick="checkuserlogin()">Login</button>
                    <h4 class="text-danger">
                        <input type="checkbox" checked="checked" id="remember"  > Remember me
                    </h4>
                    <label id="l1">
                    </label>

                </div>
            </div>
            <br>
            <br>
            <br>

            <br>

        </form> 


    </body>
</html>


