<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="downloadfile.aspx.cs" Inherits="index_Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
       <link href="css/CTSP_Login_Page.css" rel="stylesheet" type="text/css" />
    <link href="css/CTSP_Login_Style.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
        .dividstyle
        {
            z-index: 5;
            position: absolute;
            top:25%;left:35%;
            border: 1px solid #C0C0C0;
            border-bottom-color:#666;
            border-right-color:#666;
            background-color: #FFF; 
            padding:5px;text-align:center;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
      <div class="content container">
       	<ol class="breadcrumb"><!--現在位置導覽列-->
              <li><a href="index5.aspx">首頁</a></li>
              <li><a href="downloadfile.aspx">環境微振監測結果</a></li>
              <a href="index1.aspx" class="btn btn-success pull-right">回上一頁</a>
            </ol>

		<div class="content-inside">
              <div class="Subtxt">
                    <div class="subTitle">
                        <h3>環境微振監測結果</h3>
                    </div>
                </div><!--Subtxt-->
            <table class="table table-bordered table-condensed" style=" width:90%">
                <tr style="background-color:#5bc0de">
                    <td>內容</td>
                    <td>下載</td>
                </tr>
                <tr >
                    <td>104-105年台南園區環境微振監測結果</td>
                    <td><a href="pdf/104-105年南科環境微振監測結果.pdf" target="_blank">下載</a></td>
                </tr>
                   <tr >
                    <td>106-107年台南園區環境微振監測結果</td>
                    <td><a href="pdf/106-107年台南園區環境微振監測結果.pdf" target="_blank">下載</a></td>
                </tr>
                   <tr >
                    <td>108年台南園區環境微振監測結果</td>
                    <td><a href="pdf/108年台南園區環境微振監測結果.pdf" target="_blank">下載</a></td>
                </tr>
                </table>
             <%--  <p style="margin-left:1em"><a href="pdf/104-105年南科環境微振監測結果.pdf" target="_blank">104-105年南科環境微振監測結果</a></p>
               <p style="margin-left:1em"><a href="pdf/106-107年台南園區環境微振監測結果.pdf" target="_blank">106-107年台南園區環境微振監測結果</a></p>
               <p style="margin-left:1em"><a href="pdf/108年台南園區環境微振監測結果.pdf" target="_blank">108年台南園區環境微振監測結果</a></p>--%>


              </div>
            </div>

</asp:Content>

