<%--
  Created by IntelliJ IDEA.
  User: MASTER
  Date: 2022-05-15
  Time: 오후 7:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@100;600&display=swap" rel="stylesheet">
<meta name="viewport" content="width=device-width,initial-scale=1.0"/>

<style type="text/css">
    <!--
    #avatar {
        position: absolute;
        left:83%;
        top:60%;
        width:183px;
        height:237px;
    }
    #list { width:300px;
        height:300px;
        position:absolute;
        left:50%;
        top:45%;
        margin-left:-150px;
        margin-top:-150px; }
    .items {
        font-size: 30px;
        font-weight: bold;
        text-align: center;
        font-family: 'IBM Plex Sans KR', sans-serif;
        color: #F58207;
    }
    li {
        list-style-type:none;
        padding:3px
    }
    #wrap{
        background-color: #FCEEDC;
        width:100%;
        height:100%;
        position:relative;
        }
    #homeicon{
        width: 83px;
        height: 77px;
        position: absolute;
        left: 2%;
        top: 2%;
    }
    -->
</style>

<html>
<head>
    <title>Title</title>
</head>
<body>
<div id="wrap">
    <a href="index.jsp"><img id="homeicon" src="homeIcon.png"/></a>
    <div id="list">
        <li>
            <a class="items" href="characterIn.jsp">캐릭터입력</a>
        </li>
        <li>
            <a class="items" href="showChar.jsp">캐릭터보기</a>
        </li>
        <li>
            <a class="items" href="specificationIn.jsp">스펙등록</a>
        </li>
        <li>
            <a class="items" href="doMatching.jsp">파티매칭</a>
        </li>
        <li>
            <a class="items" href="showParty.jsp">파티보기</a>
        </li>
        <li>
            <a class="items" href="serverNow.jsp">서버별현황</a>
        </li>
    </div>
    <img id="avatar" src="avatar1.png"/>
</div>
</body>
</html>