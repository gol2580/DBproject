<%--
  Created by IntelliJ IDEA.
  User: MASTER
  Date: 2022-05-18
  Time: 오전 1:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*"%>
<meta name="viewport" content="width=device-width,initial-scale=1.0"/>

<html>
<head>
    <title>Title</title>
</head>
<body>
<a href="index.jsp">홈</a>
<%
        Connection con=null;
        PreparedStatement statement = null;
        PreparedStatement statement1 = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String DRIVER = "jdbc:mysql://localhost:3306/dbtermproject";
            String USER = "root";
            String PW = "ROOTjieun123@";
            con = DriverManager.getConnection(DRIVER, USER, PW);

            String nickname=request.getParameter("delName");

            String DELQUERY="delete from userchar where NICKNAME=?"; //캐릭터 테이블에서 삭제
            statement = con.prepareStatement(DELQUERY);
            statement.setString(1,nickname);
            statement.executeUpdate();

            String DELEXQUERY = "delete from char_party_ex where nickname=?"; //파티여부 테이블에서 삭제
            statement1 = con.prepareStatement(DELEXQUERY);
            statement1.setString(1,nickname);
            statement1.executeUpdate();


        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if(statement!=null) try{ statement.close(); } catch(SQLException e) {e.printStackTrace();}
            if(con!=null) try{ con.close(); } catch(SQLException e) {e.printStackTrace();}
        }
%>
<script>
    location.replace("showChar.jsp");
</script>
</body>
</head>
</html>
