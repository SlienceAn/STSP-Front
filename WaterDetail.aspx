<%@ Page Title="" Language="VB" MasterPageFile="index.master" AutoEventWireup="true" CodeFile="WaterDetail.aspx.vb" Inherits="WaterDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <%--meta http-equiv="refresh" content="20" /--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <script>
        $(function () { $('html, body').animate({ scrollTop: 500 }, 1000); });

        $(function(){$("input#tab1:first").attr("checked",true)});
        $(function(){$("li.box:last").css({"background-color":"#7c4f00","color":"white"})});
        $(function(){$("a#client").attr("href","AQI_Detail.aspx")});
        $(function(){$("a#consultant:first").css("color","white")});

    </script>
      <asp:Panel ID="Panel2" runat="server" >

              <div class="panel-group" id="panel-981091">
                <div class="panel panel-default">
                  <div class="panel-heading">
                     <a class="panel-title" data-toggle="collapse" data-parent="#panel-981091" href="#panel-element-443760"><div class="detailTitle row"> 臺南污水廠----詳細監測數據
                        <div class="MonitoringData pull-right">
                          <h5>監測資料時間：<asp:Literal ID="examtime" runat="server" Text="2018.04.09  08:00"></asp:Literal></h5>
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
                                             <h2 style="margin-top: 0; font-family: '微軟正黑體'; font-size: 22px; margin-bottom: 10px;"><i class="fa fa-leaf"></i><asp:Label ID="StationD01" runat="server"></asp:Label></asp:Label></h2>
                                            <ul class="nav navbar-right panel_toolbox">
                                              <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                                            </ul>
                                            <div class="clearfix"></div>
                                          </div >
                                          <div class="x_content">
                                              <small><asp:Label ID="tTotalD01" runat="server"></asp:Label></small>
                                              <asp:Label ID="tParameterD01" runat="server"></asp:Label>
                                          </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-sm-12 col-xs-12">
                                        <div class="x_panel">
                                          <div class="x_title">
                                             <h2 style="margin-top: 0; font-family: '微軟正黑體'; font-size: 22px; margin-bottom: 10px;"><i class="fa fa-leaf"></i></i><asp:Label ID="StationD02" runat="server"></asp:Label></h2>
                                            <ul class="nav navbar-right panel_toolbox">
                                              <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                                            </ul>
                                            <div class="clearfix"></div>
                                          </div >
                                          <div class="x_content">
                                              <small><asp:Label ID="tTotalD02" runat="server"></asp:Label></small>
                                              <asp:Label ID="tParameterD02" runat="server"></asp:Label>
                                          </div>
                                        </div>
                                    </div>
                                  </div>
                                  <div class="row"><p><h2> </h2></p><p><h2></h2></p>
                                    <div class="col-md-6 col-sm-12 col-xs-12">
                                        <div class="x_panel">
                                          <div class="x_title">
                                             <h2 style="margin-top: 0; font-family: '微軟正黑體'; font-size: 22px; margin-bottom: 10px;"><i class="fa fa-leaf"></i></i><asp:Label ID="StationT01" runat="server"></asp:Label></h2>
                                            <ul class="nav navbar-right panel_toolbox">
                                              <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                                            </ul>
                                            <div class="clearfix"></div>
                                          </div>
                                          <div class="x_content">
                                              <small><asp:Label ID="tTotalT01" runat="server"></asp:Label></small>
                                              <asp:Label ID="tParameterT01" runat="server"></asp:Label>
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
                     <a class="panel-title" data-toggle="collapse" data-parent="#panel-981091" href="#panel-element-403351"> <div class="detailTitle row">
                        高雄污水廠----詳細監測數據
                        <div class="MonitoringData pull-right">
                          <h5>監測資料時間：<asp:Literal ID="examtime2" runat="server" Text="2018.04.09  08:00"></asp:Literal></h5>
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
                              </div><!--TwoShot-->
                            </div>
                        </div><!--OneShot row-->
                  </div>
                </div>
              </div>
            </div>
 
      </asp:Panel>
</asp:Content>
