<%--
  Created by IntelliJ IDEA.
  User: MASTER
  Date: 2022-05-16
  Time: 오후 6:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*"%>

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
            <th>서버</th>
            <th>캐릭터 수</th>
            <th>루시드 파티 수</th>
            <th>데미안 파티 수</th>
            <th>듄켈 파티 수</th>
            <th>윌 파티 수</th>
            <th>힐라 파티 수</th>
        </tr>
<%
    Connection con=null;
    PreparedStatement[] prestatArr = new PreparedStatement[18];
    PreparedStatement prestat7=null;
    ResultSet result=null;

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

        String[] QUERY={
                "UPDATE servernow SET numOfCharacter = ( select count(*) from  userchar where server=\"루나\") WHERE servername=\"루나\";",
                "UPDATE servernow SET numOfParty_L = (  select count(*) from  partytest where server=\"루나\" AND bossName=\"루시드\")  WHERE servername=\"루나\";",
                "UPDATE servernow SET numOfParty_De = (  select count(*) from  partytest where server=\"루나\" AND bossName=\"데미안\")  WHERE servername=\"루나\"",
                "UPDATE servernow SET numOfParty_Du = (  select count(*) from  partytest where server=\"루나\" AND bossName=\"듄켈\")  WHERE servername=\"루나\"",
                "UPDATE servernow SET numOfParty_W = (  select count(*) from  partytest where server=\"루나\" AND bossName=\"윌\")  WHERE servername=\"루나\"",
                "UPDATE servernow SET numOfParty_H = (  select count(*) from  partytest where server=\"루나\" AND bossName=\"힐라\")  WHERE servername=\"루나\"",
                "UPDATE servernow SET numOfCharacter = ( select count(*) from  userchar where server=\"스카니아\") WHERE servername=\"스카니아\";",
                "UPDATE servernow SET numOfParty_L = (  select count(*) from  partytest where server=\"스카니아\" AND bossName=\"루시드\")  WHERE servername=\"스카니아\";",
                "UPDATE servernow SET numOfParty_De = (  select count(*) from  partytest where server=\"스카니아\" AND bossName=\"데미안\")  WHERE servername=\"스카니아\"",
                "UPDATE servernow SET numOfParty_Du = (  select count(*) from  partytest where server=\"스카니아\" AND bossName=\"듄켈\")  WHERE servername=\"스카니아\"",
                "UPDATE servernow SET numOfParty_W = (  select count(*) from  partytest where server=\"스카니아\" AND bossName=\"윌\")  WHERE servername=\"스카니아\"",
                "UPDATE servernow SET numOfParty_H = (  select count(*) from  partytest where server=\"스카니아\" AND bossName=\"힐라\")  WHERE servername=\"스카니아\"",
                "UPDATE servernow SET numOfCharacter = ( select count(*) from  userchar where server=\"엘리시움\") WHERE servername=\"엘리시움\";",
                "UPDATE servernow SET numOfParty_L = (  select count(*) from  partytest where server=\"엘리시움\" AND bossName=\"루시드\")  WHERE servername=\"엘리시움\";",
                "UPDATE servernow SET numOfParty_De = (  select count(*) from  partytest where server=\"엘리시움\" AND bossName=\"데미안\")  WHERE servername=\"엘리시움\"",
                "UPDATE servernow SET numOfParty_Du = (  select count(*) from  partytest where server=\"엘리시움\" AND bossName=\"듄켈\")  WHERE servername=\"엘리시움\"",
                "UPDATE servernow SET numOfParty_W = (  select count(*) from  partytest where server=\"엘리시움\" AND bossName=\"윌\")  WHERE servername=\"엘리시움\"",
                "UPDATE servernow SET numOfParty_H = (  select count(*) from  partytest where server=\"엘리시움\" AND bossName=\"힐라\")  WHERE servername=\"엘리시움\""
        } ;
        String SELECTQUERY = "select * from servernow";


        for(int i=0;i<18;i++) { //최신 상태로 업데이트
            prestatArr[i] = con.prepareStatement(QUERY[i]);
            prestatArr[i].executeUpdate();
        }

        prestat7 = con.prepareStatement(SELECTQUERY);
        result = prestat7.executeQuery();

        while (result.next()) {
%>

    <tr>
        <td><%= result.getString("servername") %></td>
        <td><%= result.getString("numOfCharacter") %></td>
        <td><%= result.getString("numOfParty_L") %></td>
        <td><%= result.getString("numOfParty_De") %></td>
        <td><%= result.getInt("numOfParty_Du") %></td>
        <td><%= result.getInt("numOfParty_W") %></td>
        <td><%= result.getInt("numOfParty_H") %></td>
    </tr>
        <%      }
        }catch(SQLException e){
                e.printStackTrace();
                out.print("fail");
        } finally {
                if(result!=null) try{ result.close(); } catch(SQLException e) {e.printStackTrace();}
                for(int i=0;i<18;i++) {
                    if(prestatArr[i]!=null) try{prestatArr[i].close();} catch (SQLException e) {e.printStackTrace();}
                }
                if(prestat7!=null) try{ prestat7.close(); } catch(SQLException e) {e.printStackTrace();}
                if(con!=null) try{ con.close(); } catch(SQLException e) {e.printStackTrace();}

        }


%>

</body>
</html>
