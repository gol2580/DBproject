<%--
  Created by IntelliJ IDEA.
  User: MASTER
  Date: 2022-05-20
  Time: 오후 2:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
//성사된 파티를 저장하는 partytest 테이블을 업데이트 함
//spec테이블의 leaderName, bossName, sserver  ->  partytest의 leaderNickname, bossName, server : insert
    <%
    Connection con=null;
    PreparedStatement[] prestatArr = new PreparedStatement[2];
    ResultSet result=null;
    String bossName=""; String server="";
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
        //spec테이블의 leaderName, bossName, sserver 얻기
        String leaderNickname = request.getParameter("leaderName");
        String GETPARTYQUERY = "select bossName, sserver from specification where leaderName =?";

        prestatArr[0] = con.prepareStatement(GETPARTYQUERY);
        prestatArr[0].setString(1, leaderNickname);
        result = prestatArr[0].executeQuery();

        while (result.next()) {
            bossName = result.getString("bossName");
            server = result.getString("sserver");
        }


        //partytest의 leaderNickname, bossName, server에 insert
        String INSQUERY = "insert into partytest values(?,?,?)";

        prestatArr[1] = con.prepareStatement(INSQUERY);
        prestatArr[1].setString(1, leaderNickname);
        prestatArr[1].setString(2, bossName);
        prestatArr[1].setString(3, server);

        prestatArr[1].executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if(result!=null) try{ result.close(); } catch(SQLException e) {e.printStackTrace();}
        for(int i=0;i<2;i++) {
            if(prestatArr[i]!=null) try{prestatArr[i].close();} catch (SQLException e) {e.printStackTrace();}
        }
        if(con!=null) try{ con.close(); } catch(SQLException e) {e.printStackTrace();}
    }
%>
<script>
    alert("파티 구성이 완료되었습니다.");
    history.go(-2);
</script>

</body>
</html>
