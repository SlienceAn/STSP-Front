﻿<%@ Page Language="VB" AutoEventWireup="false" CodeFile="breadcrumb_station.aspx.vb" Inherits="breadcrumb_station" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <title>Gentelella Alela! | </title>
    <%--link href="./vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet"/ --%>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.5/css/bootstrap.min.css" integrity="sha256-MfvZlkHCEqatNoGiOXveE8FIwMzZg4W85qfrfIFBfYc=" crossorigin="anonymous" />
	<%-- link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha256-NJWeQ+bs82iAeoT5Ktmqbi3NXwxcHlfaVejzJI2dklU=" crossorigin="anonymous" / --%>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha256-eZrrJcwDc/3uDhsdt61sL2oOBY362qM3lon1gyExkL0=" crossorigin="anonymous" />
	<%-- script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha256-C8oQVJ33cKtnkARnmeWp6SDChkU+u7KvsNMFUzkkUzk=" crossorigin="anonymous"></script -->    
	<!-- ink href="./vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet"/ -->
    <link href="../backend/build/css/custom_station.css" rel="stylesheet"/>
    <%-- script src="./vendors/jquery/dist/jquery.min.js"></script --%>
	<script src="https://code.jquery.com/jquery-2.1.1.min.js" integrity="sha256-h0cGsrExGgcZtSZ/fRz4AwV+Nn6Urh/3v3jFRQ0w9dQ=" crossorigin="anonymous"></script>
    <script src="https://code.highcharts.com/stock/highstock.js"></script>
    <script src="https://code.highcharts.com/stock/modules/exporting.js"></script>
    <%-- script src="./vendors/bootstrap/dist/js/bootstrap.min.js"></script --%>
	<%-- script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha256-C8oQVJ33cKtnkARnmeWp6SDChkU+u7KvsNMFUzkkUzk=" crossorigin="anonymous"></script --%>
    <%-- script src="./vendors/fastclick/lib/fastclick.js"></script --%>
	<link href="../backend/vendors/nprogress/nprogress.css" rel="stylesheet"/>
    <script src="../backend/vendors/nprogress/nprogress.js"></script>
    <script src="../backend/vendors/Chart.js/dist/Chart.min.js"></script>
    <script src="../backend/vendors/jquery-sparkline/dist/jquery.sparkline.min.js"></script>
    <%-- script src="./vendors/Flot/jquery.flot.js"></script --%>
    <%-- script src="./vendors/Flot/jquery.flot.pie.js"></script --%>
    <%--script src="./vendors/Flot/jquery.flot.time.js"></script --%>
    <%--script src="./vendors/Flot/jquery.flot.stack.js"></script --%>
    <%--script src="./vendors/Flot/jquery.flot.resize.js"></script --%>
    <%--script src="./vendors/flot.orderbars/js/jquery.flot.orderBars.js"></script --%>
    <%--script src="./vendors/flot-spline/js/jquery.flot.spline.min.js"></script --%>
    <%--script src="./vendors/flot.curvedlines/curvedLines.js"></script --%>
    <script src="../backend/vendors/DateJS/build/date.js"></script>
    <script src="../backend/vendors/moment/min/moment.min.js"></script>
	<link href="../backend/vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet"/>
    <script src="../backend/vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
    <script src="../backend/build/js/custom.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jQuery-slimScroll/1.3.8/jquery.slimscroll.min.js" integrity="sha256-qE/6vdSYzQu9lgosKxhFplETvWvqAAlmAuR+yPh/0SI=" crossorigin="anonymous"></script>
	<!--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fancybox/3.3.1/jquery.fancybox.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fancybox/3.3.1/jquery.fancybox.min.js"></script> Old FancyBox-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/fancyapps/fancybox@3.5.7/dist/jquery.fancybox.min.css" />
    <script src="https://cdn.jsdelivr.net/gh/fancyapps/fancybox@3.5.7/dist/jquery.fancybox.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" integrity="sha256-rByPlHULObEjJ6XQxW/flG2r+22R5dKiAoef+aXWfik=" crossorigin="anonymous" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.js" integrity="sha256-T0Vest3yCU7pafRw9r+settMBX6JkKN06dqBnpQ8d30=" crossorigin="anonymous"></script>
    <!-- Modify By Copan 2019/05/22 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flexslider/2.7.2/flexslider.min.css"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/flexslider/2.7.2/jquery.flexslider.min.js"></script>
    <style type="text/css">
        .flexslider{
            margin-bottom: 0px;
            }
            .flex-caption {
            margin-bottom: 0px;
            padding-left: 20px; 
            padding-top: 5px; 
            padding-bottom: 5px; 
            left: 0;
            bottom: 0;
            background:#f5f5f5;
            color: rgba(35,82,124);
            font-size: 16;
            line-height: 18px;
            font-family: 微軟正黑體;
            }
            .fancybox-caption__body{
            font-size: 30px
            }
    </style>
    <!-- Modify By Copan 2019/05/22 -->
</head>
<body>
    <form id="form1" runat="server">


        <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="row">

                <div class="col-md-5 col-sm-12 col-xs-12">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2 style="margin-top: 0; font-family: '微軟正黑體'; font-size: 20px; margin-bottom: 10px;"><i class="icon fa fa-leaf"></i>測站監測項目</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li class="col-link"><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <small>
                                <asp:Label ID="tTotal" runat="server"></asp:Label></small>
                            <asp:Label ID="tParameter" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>
                <div class="col-md-7 col-sm-12 col-xs-12">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2 style="margin-top: 0px; font-family: '微軟正黑體'; font-size: 20px; margin-bottom: 15px;"><i class="icon fa fa-map-marker"></i>位置圖</h2>
                            <ul  class="nav navbar-right panel_toolbox">
                                <li  class="col-link"><a  class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div style="margin-top: 15px;" class="x_content">
                            <div class='google-map' id='map1' style="height: 615px; margin-top: 5px;"></div>
                            <asp:Label ID="gMap" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="row">

                <div class="col-md-7 col-sm-12 col-xs-12">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2 style="margin-top: 10px; font-family: '微軟正黑體'; font-size: 20px; margin-bottom: 10px;"><i class="icon fa fa-file-image-o"></i>測站環境照片</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li class="col-link"><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <asp:Label ID="gImg" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>

            </div>
        </div>





    </form>

    <!-- <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAtP_rd9wzhFEECafrkN8LJEwKceCTtUK0&callback=initMap" async="async" defer="defer"></script> -->
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAC46YcgD1yW9UdA3C-vARKrw_rKh7WWgA&callback=initMap" async="async" defer="defer"></script>

    <script>
        // Modify By Copan 2019/05/22
        $(function () {
            $('.flexslider').flexslider({
            animationSpeed: 500,
            });
        });
    </script>




</body>
</html>
