<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NewsShow.aspx.cs" Inherits="FrontEnd_NewsShow" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>最新消息</title>
    <style>
        html, body {
            width:100%;
            height:100%;
            margin:0;
        }
    </style>
</head>
<body style="background-image:url('img/banner2.png');">
    <div style="width:100%;height:100%;">
        <div style ="text-align :center;font-family:'Microsoft JhengHei';font-size:30px;font-weight:900;">        
            <asp:Label ID="labTitle" runat="server" ></asp:Label>
        </div>
        <div style ="text-align :right;font-family:'Microsoft JhengHei';font-size:20px;font-weight:900;width:99%;margin-right:1%">
            刊出日期:<asp:Label ID="labDt" runat="server" ></asp:Label>
        </div>
        <div style ="text-align :left;font-family:'Microsoft JhengHei';font-size:25px;width:95%;margin-left:2.5%">
           <asp:Label ID="labContent" runat="server" ></asp:Label>
        </div>
    </div>
</body>
</html>
