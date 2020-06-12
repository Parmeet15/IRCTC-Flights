function add()
{
    var a = document.getElementById("t1").value;
    var b = document.getElementById("t2").value;

    if (a == "" || isNaN(a))
    {
        alert("Please enter A correctly");
    } else if (b == "" || isNaN(b))
    {
        alert("Please enter B correctly");
    } else
    {

        a = parseInt(a);
        b = parseInt(b);

        var c = a + b;

        document.getElementById("l1").innerHTML = c;
    }


}

function check()
{
    var phone = document.getElementById("phone").value;

    if (phone == "")
    {
        alert("phone number is empty");
    } else if (phone.length != 10)
    {
        alert("phone number is invalid");
    } else
    {
        alert('correct');
    }
}
