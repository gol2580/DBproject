<%--
  Created by IntelliJ IDEA.
  User: MASTER
  Date: 2022-05-21
  Time: 오후 5:37
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
<a href="index.jsp">홈</a>
<div id="wrap">
    <a href="index.jsp"><img id="homeicon" src="homeIcon.png"/></a>
    <table id="table">
        <tr>
            <th>파티원</th>
            <th>보스</th>
            <th>서버</th>
            <th>레벨</th>
            <th>스텟</th>
            <th>서버</th>
        </tr>
    <%
        Connection con=null;
        PreparedStatement[] prestatArr = new PreparedStatement[2];
        ResultSet result=null; ResultSet result2 = null;
        String bossName=""; String leaderName="";

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
            //bossName 얻기
            leaderName=request.getParameter("leaderName");
            String GETBOSS="SELECT p.bossName " +
                    "FROM partytest p " +
                    "WHERE p.leaderNickName=?;";
            prestatArr[0] = con.prepareStatement(GETBOSS);
            prestatArr[0].setString(1,leaderName);
            result=prestatArr[0].executeQuery();
            if(result.next()) bossName=result.getString("bossName");

            String[] GETPARTYUSR={
                    "SELECT c.nickname, p.bossNaMe, p.server, u.level, u.status, u.arcforce " +
                            " FROM partytest p, char_party_ex c, userChar u " +
                            "WHERE c.party_L=? AND c.nickname=u.nickname AND p.leadernickname=?",
                    "SELECT c.nickname, p.bossNaMe, p.server, u.level, u.status, u.arcforce " +
                            " FROM partytest p, char_party_ex c, userChar u " +
                            "WHERE c.party_De=? AND c.nickname=u.nickname AND p.leadernickname=?",
                    "SELECT c.nickname, p.bossNaMe, p.server, u.level, u.status, u.arcforce " +
                            " FROM partytest p, char_party_ex c, userChar u " +
                            "WHERE c.party_Du=? AND c.nickname=u.nickname AND p.leadernickname=?",
                    "SELECT c.nickname, p.bossNaMe, p.server, u.level, u.status, u.arcforce " +
                            " FROM partytest p, char_party_ex c, userChar u " +
                            "WHERE c.party_W=? AND c.nickname=u.nickname AND p.leadernickname=?",
                    "SELECT c.nickname, p.bossNaMe, p.server, u.level, u.status, u.arcforce " +
                            " FROM partytest p, char_party_ex c, userChar u " +
                            "WHERE c.party_H=? AND c.nickname=u.nickname AND p.leadernickname=?"
            };


            switch(bossName) {
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

            prestatArr[1].setString(1,leaderName);
            prestatArr[1].setString(2,leaderName);
            result2=prestatArr[1].executeQuery();
            while(result2.next()) {


    %>
        <tr>
            <td><%= result2.getString("nickname") %></td>
            <td><%= result2.getString("bossName") %></td>
            <td><%= result2.getString("server") %></td>
            <td><%= result2.getInt("level") %></td>
            <td><%= result2.getInt("status") %></td>
            <td><%= result2.getInt("ARCFORCE") %></td>
        </tr>
    <%          }


    }
    catch(Exception e) {
        e.printStackTrace();
    } finally {
        if(result!=null) try{ result.close(); } catch(SQLException e) {e.printStackTrace();}
        if(result2!=null) try{ result2.close(); } catch(SQLException e) {e.printStackTrace();}
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
