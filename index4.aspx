<%@ Page Title="" Language="C#" MasterPageFile="index.master" AutoEventWireup="true" CodeFile="index4.aspx.cs" Inherits="index_index4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <script>
        $(function () { $('html, body').animate({ scrollTop: 500 }, 1000); });
    </script>
     <script src="js/bootstrap.min.js"></script>
        <script>
            function showModal() {
                $('.bs-reply-modal-lg').modal('show');
            }
            function hideModal() {
                $('.bs-reply-modal-lg').modal('hide');
            }

    </script>
      <style type="text/css">
              .site {
                   left: 230px; top: 390px;
              }
              @media(max-width: 1024px) {
                  .site {
                      left: 190px; top: 350px;
                  }
              }
          </style>
     <img src="image/index/arrow-right.png" style="position: absolute;top: 275px; left: 48%;"/>
       
    	<div class="OneShot row">
											<div class="mapbox col-md-6">
												<div class="detailTitle row">
													測站位置圖
												</div>
												<div class="TwoShot">
												  <asp:Panel ID="Panel1" runat="server" class="map" style="background: url(image/index/Big_map_2.svg) no-repeat center;z-index: -3;background-size:100%;background-color:#D6FCFF;border-width:5px;border-color:#333333" >                      
                                                        <asp:Image ID="site1" runat="server" Style=" z-index: 0; position: relative;display:block"
                                                            ImageUrl="image/circle/circleMAP_blue_01.png" ToolTip="放流口"
                                                            title="1" data-trigger="hover" class="site" />
                                                          
                                                        </asp:Panel>
												</div>
											</div>
											<div class="col-md-6">
												<div class="detailTitle row">
													園區測站
													<div class="MonitoringData pull-right">
														<h5>數據發布時間：<asp:Literal ID="examtime" runat="server" Text="2018.04.09  08:00"></asp:Literal></h5>
													</div>
												</div>
												<div class="TwoShot">
													<div class="row">
														<div class="col-md-12">
															<div class="NankeWater" style="height:540px;overflow:auto;">
                                                              <div style="height:400px">
                                                               <p><asp:Image ID="sitebg1" runat="server"  ImageUrl="image/circle/circleMAP_blue_01.png"  style="margin-top:-5px;margin-right:10px;"/>測點：放流口<a href="http://einfo.stsp.gov.tw/FrontEnd/AutoMonitor.aspx?ST=Kaohsiung_waste_water&DP_NO=D01&ch=2#"><img src="image/index/trendPic.png" onmouseover="this.src='image/index/trendPic_W.png';" onfocus="this.src='image/index/trendPic_W.png';" onmouseout="this.src='image/index/trendPic.png';" /></a><span style="float:right">(黑線為標準值)</span></p>
                                                                <table style="margin:0px">
                                                                      <tr>
                                                                          <td style="font-size:10px;vertical-align:top;" >
                                                                         <span style="font-weight:bold">SS</span><br>
                                                                         <span >mg/L</span>
                                                                          </td>
                                                                          <td>
                                                                      <img src="image/line/StraightChart01.png" /> 

                                                                      <div style="position: relative; top: -40px;left:10px;width: 400px;float: left;">
                                                                       <asp:Literal ID="line1" runat="server"></asp:Literal> 
                                                                     </div>
                                                                        <div style="position: relative; top: -60px;left:360px;width:80px;margin:0px;right:0px;font-size:12px">
                                                                            <asp:Literal ID="val1" runat="server"></asp:Literal>
                                                                          </div>
                                                                          </td>
                                                                          <td>

                                                                          </td>

                                                                      </tr>
                                                                       <tr>
                                                                          <td style="font-size:10px;vertical-align:top;">
                                                                         <span style="font-weight:bold">COD</span><br>
                                                                         <span >mg/L</span>
                                                                          </td>
                                                                          <td>
                                                                        <img src="image/line/StraightChart02.png" /> 
                                                                      <div style="position: relative; top: -40px;left:10px;width: 400px;float: left;">
                                                                           <asp:Literal ID="line2" runat="server"></asp:Literal>
                                                                          </div>
                                                                                 <div style="position: relative; top: -60px;left:360px;width:80px;margin:0px;right:0px;font-size:12px">
                                                                            <asp:Literal ID="val2" runat="server"></asp:Literal>
                                                                          </div>
                                                                          </td>
                                                                          <td>

                                                                          </td>

                                                                      </tr>
                                                                          <tr>
                                                                          <td style="font-size:10px;vertical-align:top;">
                                                                         <span style="font-weight:bold">PH</span><br>
                                                                         <span ></span>
                                                                          </td>
                                                                          <td>
                                                                        <img src="image/line/StraightChart03.png" /> 
                                                                      <div style="position: relative; top: -40px;left:10px;width: 400px;float: left;">
                                                                           <asp:Literal ID="line3" runat="server"></asp:Literal>
                                                                          </div>
                                                                                   <div style="position: relative; top: -60px;left:360px;width:80px;margin:0px;right:0px;font-size:12px">
                                                                            <asp:Literal ID="val3" runat="server"></asp:Literal>
                                                                          </div>
                                                                          </td>
                                                                          <td>

                                                                          </td>

                                                                      </tr>

                                                                           <tr>
                                                                          <td style="font-size:10px;vertical-align:top;">
                                                                         <span style="font-weight:bold">水溫</span><br>
                                                                         <span >℃</span>
                                                                          </td>
                                                                          <td>
                                                                        <img src="image/line/StraightChart04.png" /> 
                                                                      <div style="position: relative; top: -40px;left:10px;width: 400px;float: left;">
                                                                           <asp:Literal ID="line4" runat="server"></asp:Literal>
                                                                          </div>
                                                                                   <div style="position: relative; top: -60px;left:360px;width:80px;margin:0px;right:0px;font-size:12px">
                                                                            <asp:Literal ID="val4" runat="server"></asp:Literal>
                                                                          </div>
                                                                          </td>
                                                                          <td>

                                                                          </td>

                                                                      </tr>


                                                                  </table>
                                                              
                                                                </div>
															    </div>														
														</div>														
													</div>

												</div><!--TwoShot-->
											</div>
										</div><!--OneShot-->
                                         <div class="littleShot pull-right">
															<ul>
																<li><a href="http://einfo.stsp.gov.tw/FrontEnd/AutoMonitor.aspx?ST=Kaohsiung_waste_water&DP_NO=D01#">查詳細監測資料＞＞</a></li>
															</ul>															
														</div><!--littleShot-->	
                                 	<div class="OneShot row">
											<div class="TwoShot">
												<div class="col-md-12">
															<div class="littleList">
																<ul>
																	<li>無資料時為設備維護(測站例行維護、儀器異常維修、監測數據不足)</li>
																	<li><a href="javascript:showModal()">免責聲明</a> (使用本網站數據請先詳閱)</li>
																	
																</ul>
															</div>															
												</div>												
											</div><!--TwoShot-->	
										</div><!--OneShot-->
               <div class="modal fade bs-reply-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
          
                      <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        
                         </div>
                     <div class="modal-body">
                        <div class="MainClass">
              <div role="form" class="form-horizontal">
              <div class="form-group">
              
                <div class="col-sm-8">
                  
                    <img src="img/statement.png" />

                </div>
            </div>
            </div>
            </div>
            </div>
            </div>
            </div>
          </div>
</asp:Content>

