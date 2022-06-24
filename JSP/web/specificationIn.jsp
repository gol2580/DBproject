<%--
  Created by IntelliJ IDEA.
  User: MASTER
  Date: 2022-05-16
  Time: 오후 6:33
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
    -->
</style>

<html>
<head>
    <title>Title</title>
</head>
<body>
<div id="wrap">
    <a href="index.jsp"><img id="homeicon" src="homeIcon.png"/></a>
    <form action="specInExec.jsp" method="get" id="formDiv">
        <div class="formIn">파티장 닉네임 입력
            <input name="leaderNickname" type="text"/>
        </div>
        <div class="formIn">보스 선택
            <input name="selectBoss" type="radio" value="루시드"/>루시드
            <input name="selectBoss" type="radio" value="데미안"/>데미안
            <input name="selectBoss" type="radio" value="듄켈"/>듄켈
            <input name="selectBoss" type="radio" value="윌"/>윌
            <input name="selectBoss" type="radio" value="힐라"/>힐라

        </div>
        <div class="formIn">파티원 수
            <input name="numOfChar" type="number" min="1" max="3"/>
        </div>
        <div class="formIn"> 서버 선택
            <input name="selectServer" type="radio" value="루나"/>루나
            <input name="selectServer" type="radio" value="스카니아"/>스카니아
            <input name="selectServer" type="radio" value="엘리시움"/>엘리시움
        </div>
        <div class="formIn"> 레벨 입력
            <input name="minLevel" type="number" min="0" max="300"/>
        </div>
        <div class="formIn"> 주스텟 입력
            <input name="minStatus" type="number" min="0" max="100000"/>
        </div>
        <div class="formIn"> 포스 입력
            <input name="minForce" type="number" min="0" max="1320"/>
        </div>
        <input type="submit" id="subBtn"/>
    </form>
</div>
</body>
</html>
