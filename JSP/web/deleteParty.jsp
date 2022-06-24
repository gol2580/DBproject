<%--
  Created by IntelliJ IDEA.
  User: MASTER
  Date: 2022-05-20
  Time: 오후 9:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    Connection con=null;
    PreparedStatement statement = null;
    PreparedStatement statement2 = null;
    PreparedStatement statement3 = null;
    String bossName="";
    ResultSet res1= null; ResultSet res2=null;

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
    try {
        String LEADERNAME = request.getParameter("leaderName");

        //삭제할 파티의 보스 이름 얻기
        String GETBOSS = "select bossName from partytest where leaderNickName=?";
        statement3 = con.prepareStatement(GETBOSS);
        statement3.setString(1, LEADERNAME);
        res1 = statement3.executeQuery();
        res1.next();
        bossName = res1.getString("bossName");

        //partytest 테이블에서 삭제하기
        String DELPARTY = "delete from partytest where leaderNickName=?";
        statement = con.prepareStatement(DELPARTY);
        statement.setString(1, LEADERNAME);
        statement.executeUpdate();

        //char_party_ex 테이블 수정하기 : 해당 애트리뷰트 값 "0"으로 바꿈
        String[] DELEX = {
                "UPDATE char_party_ex SET party_L=\"0\" WHERE party_L=?",
                "UPDATE char_party_ex SET party_De=\"0\" WHERE party_De=?",
                "UPDATE char_party_ex SET party_Du=\"0\" WHERE party_Du=?",
                "UPDATE char_party_ex SET party_W=\"0\" WHERE party_W=?",
                "UPDATE char_party_ex SET party_H=\"0\" WHERE party_H=?",
        };

        switch (bossName) {
            case "루시드":
                statement2 = con.prepareStatement(DELEX[0]);
                break;
            case "데미안":
                statement2 = con.prepareStatement(DELEX[1]);
                break;
            case "듄켈":
                statement2 = con.prepareStatement(DELEX[2]);
                break;
            case "윌":
                statement2 = con.prepareStatement(DELEX[3]);
                break;
            case "힐라":
                statement2 = con.prepareStatement(DELEX[4]);
                break;

        }
        statement2.setString(1, LEADERNAME);
        statement2.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if(res1!=null) try{ res1.close(); } catch(SQLException e) {e.printStackTrace();}
        if(res2!=null) try{ res2.close(); } catch(SQLException e) {e.printStackTrace();}
        if(statement!=null) try{statement.close();} catch (SQLException e) {e.printStackTrace();}
        if(statement2!=null) try{statement2.close();} catch (SQLException e) {e.printStackTrace();}
        if(statement3!=null) try{statement3.close();} catch (SQLException e) {e.printStackTrace();}
        if(con!=null) try{ con.close(); } catch(SQLException e) {e.printStackTrace();}
    }
%>
<script>
    alert("파티를 해체했습니다");
    history.go(-1);
</script>
</body>
</html>
