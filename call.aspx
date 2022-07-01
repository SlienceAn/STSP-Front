<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="call.aspx.cs" Inherits="index_call" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    	<ol class="breadcrumb"><!--現在位置導覽列-->
				  <li class="breadcrumb-item"><a href="index1.aspx">首頁</a></li>
				  <li class="breadcrumb-item active"><a href="#">客服中心</a></li>
        </ol>
       <div class="content-inside">
                <div class="Subtxt">
                    <div class="subTitle">
                        <h3>客服中心</h3>
                    </div>
                </div><!--Subtxt-->
             <div class="col-md-12" style="text-align:center">
           <img src="image/page/pic_02.png" />
                  </div>

           <div class="col-md-12" style="padding:10px" >
           <div class="col-md-6" style="text-align:center;" >
              <p style="color: #754c24 ; font-weight: bold; font-size: 20px">  客服專線Phone Number</p>
              <p style="font-weight: bold;" ><span style="padding-left:3em"></span>  南科管理局：(06)5051001 #2317<br>
                系統維護商：(07)331-2152</p>

           </div>
           <div class="col-md-6" style="text-align:center; border-left-style: solid;color: #754c24; font-weight: bold; font-size: 20px; border-left-width: 1px; border-left-color: #000000;"> 客服信箱 E-mail</p>
              <p style="font-weight: bold;" >  christina@jsene.com</p>
           </div>
            </div>

            <div class="col-md-12" style="font-weight: bold;text-align:center">
           <p>客服服務信箱：周一至周五09:00~17:00</p>
            </div>
       </div>
</asp:Content>

