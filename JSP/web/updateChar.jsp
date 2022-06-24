<%--
  Created by IntelliJ IDEA.
  User: MASTER
  Date: 2022-05-22
  Time: 오후 10:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style type="text/css">
    <!--
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
        left: 1%;
        top: 1%;
    }
    #formDiv{
        position: absolute;
        left: 45%;
        top:42%;
        width:420px;
        height:300px;
        margin-left:-210px;
        margin-top:-150px;
    }
    .formIn{
        padding: 15px;
        background-color: #FCEEDC;
        color: black;
        font-weight: bold;
        text-align: center;
    }
    #subBtn{
        position: relative;
    }
    #none{
        display: none;
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
    <form action="charUpdateExec.jsp" method="get" id="formDiv">
        <div id="none"><input name="updateName" value="<%= request.getParameter("updateName")%>"/></div>
        <div class="formIn"> 레벨 입력
            <input name="level" type="number" min="0" max="300"/>
        </div>
        <div class="formIn"> 주스텟 입력
            <input name="status" type="number" min="0" max="100000"/>
        </div>
        <div class="formIn"> 포스 입력
            <input name="force" type="number" min="0" max="1320"/>
        </div>
        <input type="submit"/>
    </form>
</div>
</body>
</html>
