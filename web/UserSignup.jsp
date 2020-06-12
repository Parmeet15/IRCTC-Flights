
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            #form1
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

            function go()
            {
                var ans = "";
                var formdata = new FormData();
                var controls = document.getElementById("form1").elements;
                var flag = 0;
                for (var i = 0; i < controls.length; i++)
                {
                    if (controls[i].name === "" || controls[i].name === null)
                    {
                        flag = 1;
                        break;
                    }
                    if (controls[i].type === "file")
                    {
                        if (controls[i].files.length !== 0)
                        {
                            ans = ans + controls[i].name + ": " + controls[i].files[0].name + "\n";
                            formdata.append(controls[i].name, controls[i].files[0]);
                        } else
                        {
                            flag = 2;
                            break;
                        }
                    } else    // for other input types  text,password,select
                    {
                        formdata.append(controls[i].name, controls[i].value);
                    }
                }

                if (flag === 1)
                {
                    alert("CHECK: --> Give name attribute to all controls in form");
                } else if (flag === 2)
                {
                    alert("CHECK: --> Select Files for file controls");
                } else
                {
                    var xhr = new XMLHttpRequest();
                    xhr.open("POST", "./UserSignup", true);
                    //for response receiving
                    xhr.onreadystatechange = function ()
                    {
                        if (xhr.readyState === 4 && xhr.status === 200)
                        {
                            var res = xhr.responseText.trim();
                            if (res === 'success')
                            {
                                alert('SignUp Successfully');
                            } else
                            {
                                alert('Email Address is already taken');
                            }
                        }
                    };
                    xhr.send(formdata);
                }
            }

            function readandpreview(fileobj, imageid)
            {
                var firstfile = fileobj.files[0];
                var reader = new FileReader();
                reader.onload = (function (f)
                {
                    return function read(e)
                    {
                        document.getElementById(imageid).src = e.target.result;
                    };
                })(firstfile);

                reader.readAsDataURL(firstfile);
            }


        </script>
    </head>
    <body>
    <center><h1 class="text-danger">IRCTC</h1></center>
    <form action="./UserSignup"  method= "POST" enctype="multipart/form-data" >
        <div class="container" id="form1">
            <div class="form-group" >
                <label>Enter Email  </label>
                <input type="email" name="email" required  placeholder="enter email"/>
            </div>

            <div class="form-group" >
                <label>Enter Password </label>
                <input type="password" name="pass" required placeholder="enter password"/>
            </div>

            <div class="form-group" >
                <label>Confirm Password </label>
                <input type="text" name="cpass" placeholder=" Confirm password"/>
            </div>
            <div class="form-group" >
                <label>Security Question</label>
                <input type="text" name="sec-ques" />
            </div>
            <div class="form-group" >
                <label>Security Answer </label>
                <input type="text" name="sec-ans"/>
            </div>
            <div class="form-group" >
                <label>Contact Number  </label>
                <input type="text" name="number"/>
            </div>

            <div class="form-group" >
                <label>  Username </label>
                <input type="text" name="uname"/>
            </div>
            <div class="form-group" >
                <label>  Photo   </label>
                <img src="pics/123.jpeg" id="im1" style="width:100px;height:100px">
                <input type="file" name="f1" required onchange="readandpreview(this, 'im1')"/>  
            </div>
            <div class="form-group">
             <input type="button" value="Signup" onclick="go()"/>
            </div>
        </div>
    </form>
   
</body>
</html>
