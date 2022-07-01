<%@ Page Title="" Language="VB" MasterPageFile="index.master" AutoEventWireup="true" CodeFile="AQI_Detail.aspx.vb" Inherits="AQI_Detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <%--meta http-equiv="refresh" content="20" /--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <script>
        $(function () { $('html, body').animate({ scrollTop: 500 }, 1000); });

        $(function(){$("input#tab1:first").attr("checked",true)});
        $(function(){$("li.box:first").css({"background-color":"#7c4f00","color":"white"})});
        $(function(){$("a#client:first").css("color","white")});
        $(function(){$("a#consultant").attr("href","WaterDetail.aspx")});
    </script>
      <asp:Panel ID="Panel2" runat="server" >

              <div class="panel-group" id="panel-981091">
                <div class="panel panel-default">
                  <div class="panel-heading">
                     <a class="panel-title" data-toggle="collapse" data-parent="#panel-981091" href="#panel-element-443760"><div class="detailTitle row"> 園區測站----詳細監測數據
                        <div class="MonitoringData pull-right">
                          <h5>數據發佈時間：<asp:Literal ID="examtime" runat="server" Text="2018.04.09  08:00"></asp:Literal></h5>
                        </div>
                      </div></a>
                  </div>
                  <div id="panel-element-443760" class="panel-collapse collapse in">
                    <div class="panel-body">
                        <div class="OneShot row">
                            <div class="col-md-12">
                              <div class="TwoShot">
                                <div class="row">
                                    <div class="col-md-6 col-sm-12 col-xs-12">
                                        <div class="x_panel">
                                          <div class="x_title" >
                                             <h2 style="margin-top: 0; font-family: '微軟正黑體'; font-size: 22px; margin-bottom: 10px;"><i class="fa fa-leaf"></i><asp:Label ID="StationA01" runat="server"></asp:Label></asp:Label></h2>
                                            <ul class="nav navbar-right panel_toolbox">
                                              <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                                            </ul>
                                            <div class="clearfix"></div>
                                          </div >
                                          <div class="x_content">
                                              <small><asp:Label ID="tTotalA01" runat="server"></asp:Label></small>
                                              <asp:Label ID="tParameterA01" runat="server"></asp:Label>
                                          </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-sm-12 col-xs-12">
                                        <div class="x_panel">
                                          <div class="x_title">
                                             <h2 style="margin-top: 0; font-family: '微軟正黑體'; font-size: 22px; margin-bottom: 10px;"><i class="fa fa-leaf"></i></i><asp:Label ID="StationA02" runat="server"></asp:Label></h2>
                                            <ul class="nav navbar-right panel_toolbox">
                                              <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                                            </ul>
                                            <div class="clearfix"></div>
                                          </div >
                                          <div class="x_content">
                                              <small><asp:Label ID="tTotalA02" runat="server"></asp:Label></small>
                                              <asp:Label ID="tParameterA02" runat="server"></asp:Label>
                                          </div>
                                        </div>
                                    </div>
                                  </div>
                                  <div class="row"><p><h2> </h2></p><p><h2></h2></p>
                                    <div class="col-md-6 col-sm-12 col-xs-12">
                                        <div class="x_panel">
                                          <div class="x_title">
                                             <h2 style="margin-top: 0; font-family: '微軟正黑體'; font-size: 22px; margin-bottom: 10px;"><i class="fa fa-leaf"></i></i><asp:Label ID="StationA03" runat="server"></asp:Label></h2>
                                            <ul class="nav navbar-right panel_toolbox">
                                              <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                                            </ul>
                                            <div class="clearfix"></div>
                                          </div>
                                          <div class="x_content">
                                              <small><asp:Label ID="tTotalA03" runat="server"></asp:Label></small>
                                              <asp:Label ID="tParameterA03" runat="server"></asp:Label>
                                          </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-sm-12 col-xs-12">
                                        <div class="x_panel">
                                          <div class="x_title">
                                             <h2 style="margin-top: 0; font-family: '微軟正黑體'; font-size: 22px; margin-bottom: 10px;"><i class="fa fa-leaf"></i></i><asp:Label ID="StationA04" runat="server"></asp:Label></h2>
                                            <ul class="nav navbar-right panel_toolbox">
                                              <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                                            </ul>
                                            <div class="clearfix"></div>
                                          </div>
                                          <div class="x_content">
                                              <small><asp:Label ID="tTotalA04" runat="server"></asp:Label></small>
                                              <asp:Label ID="tParameterA04" runat="server"></asp:Label>
                                          </div>
                                        </div>
                                    </div>
                                
                                </div>												
                              </div><!--TwoShot-->
                            </div>
                        </div><!--OneShot row-->
                    </div>
                  </div>
                </div>
                <div class="panel panel-default">
                  <div class="panel-heading">
                     <a class="panel-title" data-toggle="collapse" data-parent="#panel-981091" href="#panel-element-403351">                              <div class="detailTitle row">
                        環保署測站----詳細監測數據
                        <div class="MonitoringData pull-right">
                          <h5>數據發佈時間：<asp:Literal ID="examtime2" runat="server" Text="2018.04.09  08:00"></asp:Literal></h5>
                        </div>
              </div></a>
                  </div>
                  <div id="panel-element-403351" class="panel-collapse collapse">
                    <div class="panel-body">
                        <div class="OneShot row">
                            <div class="col-md-12">

                              <div class="TwoShot">
                                        <div class="row">
                                            <div class="col-md-6 col-sm-12 col-xs-12">
                                                <div class="x_panel">
                                                  <div class="x_title">
                                                     <h2 style="margin-top: 0; font-family: '微軟正黑體'; font-size: 22px; margin-bottom: 10px;"><i class="fa fa-leaf"></i></i><asp:Label ID="Station1" runat="server"></asp:Label></h2>
                                                    <ul class="nav navbar-right panel_toolbox">
                                                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                                                    </ul>
                                                    <div class="clearfix"></div>
                                                  </div>
                                                  <div class="x_content">
                                                      <small><asp:Label ID="tTotal1" runat="server"></asp:Label></small>
                                                      <asp:Label ID="tParameter1" runat="server"></asp:Label>
                                                  </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 col-sm-12 col-xs-12">
                                                <div class="x_panel">
                                                  <div class="x_title">
                                                     <h2 style="margin-top: 0; font-family: '微軟正黑體'; font-size: 22px; margin-bottom: 10px;"><i class="fa fa-leaf"></i></i><asp:Label ID="Station2" runat="server"></asp:Label></h2>
                                                    <ul class="nav navbar-right panel_toolbox">
                                                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                                                    </ul>
                                                    <div class="clearfix"></div>
                                                  </div>
                                                  <div class="x_content">
                                                      <small><asp:Label ID="tTotal2" runat="server"></asp:Label></small>
                                                      <asp:Label ID="tParameter2" runat="server"></asp:Label>
                                                  </div>
                                                </div>
                                            </div>
                                          </div>
                                          <div class="row"><p><h2> </h2></p><p><h2></h2></p>
                                            <div class="col-md-6 col-sm-12 col-xs-12">
                                                <div class="x_panel">
                                                  <div class="x_title">
                                                     <h2 style="margin-top: 0; font-family: '微軟正黑體'; font-size: 22px; margin-bottom: 10px;"><i class="fa fa-leaf"></i></i><asp:Label ID="Station3" runat="server"></asp:Label></h2>
                                                    <ul class="nav navbar-right panel_toolbox">
                                                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                                                    </ul>
                                                    <div class="clearfix"></div>
                                                  </div>
                                                  <div class="x_content">
                                                      <small><asp:Label ID="tTotal3" runat="server"></asp:Label></small>
                                                      <asp:Label ID="tParameter3" runat="server"></asp:Label>
                                                  </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 col-sm-12 col-xs-12">
                                                <div class="x_panel">
                                                  <div class="x_title">
                                                     <h2 style="margin-top: 0; font-family: '微軟正黑體'; font-size: 22px; margin-bottom: 10px;"><i class="fa fa-leaf"></i></i><asp:Label ID="Station4" runat="server"></asp:Label></h2>
                                                    <ul class="nav navbar-right panel_toolbox">
                                                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                                                    </ul>
                                                    <div class="clearfix"></div>
                                                  </div>
                                                  <div class="x_content">
                                                      <small><asp:Label ID="tTotal4" runat="server"></asp:Label></small>
                                                      <asp:Label ID="tParameter4" runat="server"></asp:Label>
                                                  </div>
                                                </div>
                                            </div>
                                            <div class="TwoShot">
                                          <div class="row"></div><p><h2> </h2></p><p><h2></h2></p>
                                          <div class="littleList">
                                            <ul>
                                              <li>無資料時為設備維護(測站例行維護、儀器異常維修、監測數據不足)</li>
                                              <li><a href="javascript:showModal()">免責聲明</a>(使用本網站數據請先詳閱)</li>
                                              <li>AQI(空氣品質)圖示說明<br><img src="image/index/PIC02.PNG"></li>
                                            </ul>
                                          </div></div>													
                                        </div>
                                                                    </div>												
                              </div><!--TwoShot-->
                            </div>
                        </div><!--OneShot row-->
                  </div>
                </div>
              </div>
            </div>
 
      </asp:Panel>
</asp:Content>
