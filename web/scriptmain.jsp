 <p class="text-center copyright">&copy; Copyright ABC Company. All Rights Reserved.</p>
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) --> 
        <script type="text/javascript" src="js/jquery.min.js"></script> 
        <!-- Include all compiled plugins (below), or include individual files as needed --> 
        <script src="js/bootstrap.min.js"></script> 
        <script type="text/javascript">

                    $('.carousel').carousel({
                        interval: 3500, // in milliseconds
                        pause: 'none' // set to 'true' to pause slider on mouse hover
                    });

        </script>
        <script type="text/javascript">
            $("a.submenu").click(function () {
                $(".menuBar").slideToggle("normal", function () {
        // Animation complete.
                });
            });
            $("ul li.dropdown a").click(function () {
                $("ul li.dropdown ul").slideToggle("normal", function () {
        // Animation complete.
                });
                $('ul li.dropdown').toggleClass('current');
            });
        </script>