<%--
  Created by IntelliJ IDEA.
  User: MASTER
  Date: 2022-05-20
  Time: 오후 4:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Vector"%>
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
    #table{
        position: absolute;
        left: 10%;
        top:6%;
        width:80%;
    }
    th{
        border-bottom: 1px solid #ccc;
        padding: 5px;
        background-color: #F58207;
        color: #FCEEDC;
        font-weight: bold;
        text-align: center;
    }
    td{
        text-align: center;
        border-bottom: 1px solid #ccc;
        padding: 3px;
        font-weight: bold;
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
    <table id="table">
        <tr>
            <th>파티장</th>
            <th>보스</th>
            <th>서버</th>
            <th>파티원</th>
            <th>삭제</th>
        </tr>
    <%
        Connection con=null;
        PreparedStatement[] prestatArr = new PreparedStatement[2];
        ResultSet result=null; ResultSet result2 = null;
        String bossName=""; String server="";
        Vector<String> leaderVec = new Vector<String>();
        Vector<String> bossVec = new Vector<String>();
        Vector<String> serverVec = new Vector<String>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String DRIVER = "jdbc:mysql://localhost:3306/dbtermproject";
            String USER = "root";
            String PW = "ROOTjieun123@";

            con = DriverManager.getConnection(DRIVER, USER, PW);
        } catch(SQLException e) {
            e.printStackTrace();
        }
    %>
    <%
        try{
            String GETPARTY="select * from partytest";
            prestatArr[0] = con.prepareStatement(GETPARTY);
            result=prestatArr[0].executeQuery();


            while(result.next()) {
                leaderVec.add(result.getString("leaderNickname"));
                bossVec.add(result.getString("bossNaMe"));
                serverVec.add(result.getString("server"));
            }

            String[] GETPARTYUSR={
                    "SELECT p.leaderNickname, p.bossNaMe, p.server, c.nickname FROM partytest p, char_party_ex c WHERE p.leaderNickName=c.party_L",
                    "SELECT p.leaderNickname, p.bossNaMe, p.server, c.nickname FROM partytest p, char_party_ex c WHERE p.leaderNickName=c.party_De",
                    "SELECT p.leaderNickname, p.bossNaMe, p.server, c.nickname FROM partytest p, char_party_ex c WHERE p.leaderNickName=c.party_Du",
                    "SELECT p.leaderNickname, p.bossNaMe, p.server, c.nickname FROM partytest p, char_party_ex c WHERE p.leaderNickName=c.party_W",
                    "SELECT p.leaderNickname, p.bossNaMe, p.server, c.nickname FROM partytest p, char_party_ex c WHERE p.leaderNickName=c.party_H",
            };

            for(int i=0;i<leaderVec.size();i++) {  //partytest의 모든 튜플에 대해
                switch(bossVec.get(i)) {
                    case "루시드" :
                        prestatArr[1] = con.prepareStatement(GETPARTYUSR[0]);
                        break;
                    case "데미안" :
                        prestatArr[1] = con.prepareStatement(GETPARTYUSR[1]);
                        break;
                    case "듄켈" :
                        prestatArr[1] = con.prepareStatement(GETPARTYUSR[2]);
                        break;
                    case "윌" :
                        prestatArr[1] = con.prepareStatement(GETPARTYUSR[3]);
                        break;
                    case "힐라" :
                        prestatArr[1] = con.prepareStatement(GETPARTYUSR[4]);
                        break;
                }

                result2=prestatArr[1].executeQuery();
                result2.next();


    %>
    <tr>
        <td><%= result2.getString("leaderNickName") %></td>
        <td><%= result2.getString("bossName") %></td>
        <td><%= result2.getString("server") %></td>
        <td><a href="showPartyExec.jsp?leaderName=<%= result2.getString("leaderNickName")%>">보기</a></td>
        <td><a href="deleteParty.jsp?leaderName=<%= result2.getString("leaderNickName")%>">X</a> </td>
    </tr>
    <%

    }
    }
    catch(Exception e) {
        e.printStackTrace();
    } finally {
        if(result!=null) try{ result.close(); } catch(SQLException e) {e.printStackTrace();}
        for(int i=0;i<2;i++) {
            if(prestatArr[i]!=null) try{prestatArr[i].close();} catch (SQLException e) {e.printStackTrace();}
        }
        if(con!=null) try{ con.close(); } catch(SQLException e) {e.printStackTrace();}
    }
    %>
    </table>
</div>
</body>
</html>