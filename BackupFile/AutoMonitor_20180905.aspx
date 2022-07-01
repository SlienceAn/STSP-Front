<%@ Page Title="" Language="VB" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="AutoMonitor.aspx.vb" Inherits="AutoMonitor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    	<ol class="breadcrumb"><!--現在位置導覽列-->
				  <li class="breadcrumb-item"><a href="#">首頁</a></li>
				  <li class="breadcrumb-item active"><a href="#">自動連續監測</a></li>
        </ol>          
      <div class="content-inside">
        	<div class="row clearfix">
              <div class="col-md-3 column">
                  <div class="Subtxt">
                      <div class="subTitle">
                          <h3>自動連續監測</h3>
                      </div>
                    </div><!--Subtxt-->               
                </div> 
                <div class="row clearfix"><p></p><p></p><p></p>          
              <div class="col-md-8 column">
                  <div class="Subtxt">
                      <a href = "AutoMonitor.aspx?ST=Nankeshizhong#" class="btn btn-default btn-info btn-lg" role="button" >南科實中測站</a>
                      <a href = "AutoMonitor.aspx?ST=Gong_29#" class="btn btn-default btn-info btn-lg" role="button" >公29測站</a>
                      <a href = "AutoMonitor.aspx?ST=Gong_13#" class="btn btn-default btn-info btn-lg" role="button" >公13測站</a>
                      <a href = "AutoMonitor.aspx?ST=Gong_19#" class="btn btn-default btn-info btn-lg" role="button" >公19測站</a> 
                    </div>  </div>             
              </div>
                <div class="">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                          <div class="x_panel">
                            <div class="x_title">
                              <h2><asp:Label ID="StationName" runat="server" ></asp:Label></h2>
          
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
                                     <asp:Label ID="sdata" runat="server" ></asp:Label>
   
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                   </div>
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
                      document.getElementById("ContentPlaceHolder1_StationName").innerHTML = title;  }
          
              </script>

  </div>

</asp:Content>

