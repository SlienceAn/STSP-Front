<%@ Page Title="" Language="VB" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="AutoMonitor.aspx.vb" Inherits="AutoMonitor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .tnAir {
            margin-bottom: 10px;
        }

        .breadcrumb > li > a {
            color: #fff;
        }

        iframe {
            height: 950px;
        }

        h3 {
            font-weight: bold;
        }

        .btnSty {
            margin: 0 10px;
            border-bottom: 2px solid #CCC;
            padding-bottom: 10px;
            padding-left:20px;
            padding-right:20px;
        }
        .x_title,.x_content {
        margin-left:15px;
        }
        @media (min-width: 992px) {
        }

        @media (max-width: 991px) {
            .btnSite {
                width: 130px;
                margin: 5px 5px;
            }

            .btnWTP {
                margin: 5px 5px;
            }

            .breadcrumb {
                padding: 10px 0 20px 0;
                border-bottom: 1px solid #CCC;
            }

            .x_panel {
                padding-top: 10px;
            }
        }

        @media (max-width: 1200px) {
            iframe {
                height: 1600px;
            }
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <ol class="breadcrumb">
        <!--現在位置導覽列-->
        <li class="breadcrumb-item"><a style="color: #6C6C6C;" href="#">首頁</a></li>
        <li class="breadcrumb-item active"><a href="#">自動連續監測</a></li>
    </ol>
    <div class="content-inside">
        <%--<div class="row clearfix">--%>
        <div class="col-md-3 column">
            <div class="Subtxt">
                <div class="subTitle">
                    <h3>自動連續監測</h3>
                </div>
            </div>
            <!--Subtxt-->
        </div>
        <div class="col-md-12 btnSty">
            <%--<div class="col-sm-9">--%>
            <div id="tn_Air" class="tnAir" runat="server">
                <a href="AutoMonitor.aspx?ST=Nankeshizhong#" class="btnSite btn btn-default btn-info btn-lg" role="button">南科實中測站</a>
                <a href="AutoMonitor.aspx?ST=Gong_29#" class="btnSite btn btn-default btn-info btn-lg" role="button">公29測站</a>
                <a href="AutoMonitor.aspx?ST=Gong_13#" class="btnSite btn btn-default btn-info btn-lg" role="button">公13測站</a>
                <a href="AutoMonitor.aspx?ST=Gong_19#" class="btnSite btn btn-default btn-info btn-lg" role="button">公19測站</a>
            </div>
            <div id="tn_Water" runat="server">
                <a href="AutoMonitor.aspx?ST=Tainan_waste_water&DP_NO=D01#" class="btnWTP btn btn-default btn-info btn-lg" role="button">台南污水廠_D01管道</a>
                <a href="AutoMonitor.aspx?ST=Tainan_waste_water&DP_NO=D02#" class="btnWTP btn btn-default btn-info btn-lg" role="button">台南污水廠_D02管道</a>
                <a href="AutoMonitor.aspx?ST=Kaohsiung_waste_water&DP_NO=D01#" class="btnWTP btn btn-default btn-info btn-lg" role="button">高雄污水廠_D01管道</a>
            </div> 
        </div> 
        <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">
                <div class="x_title">
                    <h3><%-- class="col-md-3"--%>
                        <asp:Label ID="StationName" runat="server" Text="南科實中測站"></asp:Label></h3>

                    <ul class="nav navbar-right panel_toolbox">
                        <li>
                            <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                        </li>
                        <li>
                            <a class="close-link"><i class="fa fa-close"></i></a>
                        </li>
                    </ul>
                    <div class="clearfix"></div>
                </div>

                <div class="x_content">
                    <div class="" role="tabpanel" data-example-id="togglable-tabs">
                        <asp:Label ID="StationOption" runat="server"></asp:Label>
                        <div id="myTabContent" class="tab-content">
                            <asp:Label ID="sdata" runat="server"></asp:Label>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%--</div>--%>
        <script>
            var mtitle = document.getElementById("ContentPlaceHolder1_StationName").innerHTML; // 紀錄TITLE
            function NewWindow(url, Title) { document.getElementById("ifs").src = url; }
            function maxframe() {
                var i = $("#max").find('i');
                if (i.hasClass('fa-compress')) {
                    $("#max").css("top", "20px");
                    $("#max").css("right", "10px");
                    i.removeClass("fa-compress");
                    i.addClass("fa-expand");
                    $("#ifs").css("position", "");
                    $("#ifs").css("height", "");
                    $("#ifs").contents().find("body").css("padding", "0");
                    $("body").css("overflow-y", "");
                    $("#wrapper").css("height", $("#wrapper").parent(".slimScrollDiv").height());

                    //$("#ifs").addClass('animated');
                    //$("#ifs").addClass('animated');
                } else {
                    $("#max").css("top", "-35px");
                    $("#max").css("right", "15px");
                    i.removeClass("fa-expand");
                    i.addClass("fa-compress");
                    $("#ifs").css("position", "fixed");
                    $("#ifs").css("top", 0);
                    $("#ifs").css("left", 0);
                    $("#ifs").css("height", "100%");
                    $("#ifs").contents().find("body").css("padding", "20");
                    $("#wrapper").css("height", "");
                    $("body").css("overflow-y", "hidden");

                }
            }

            function ChangePageTitle(t) {
                var title;
                title = mtitle + t;
                document.getElementById("ContentPlaceHolder1_StationName").innerHTML = title;
            }

        </script>

    </div>
</asp:Content>

