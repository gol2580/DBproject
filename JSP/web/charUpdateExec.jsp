<%--
  Created by IntelliJ IDEA.
  User: MASTER
  Date: 2022-05-22
  Time: 오후 11:01
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
        String NICKNAME="";
        int LEVEL = 0; int STAT = 0; int ARCFORCE = 0;

        NICKNAME=request.getParameter("updateName");
        LEVEL = Integer.parseInt(request.getParameter("level"));
        STAT = Integer.parseInt(request.getParameter("status"));
        ARCFORCE=Integer.parseInt(request.getParameter("force"));


        String UPDATEQUERY = "UPDATE userchar " +
                "SET LEVEL=?, STATUS=?, ARCFORCE=? "+
                "WHERE NICKNAME=?";


        statement = con.prepareStatement(UPDATEQUERY);
        statement.setInt(1,LEVEL);
        statement.setInt(2,STAT);
        statement.setInt(3,ARCFORCE);
        statement.setString(4,NICKNAME);

        statement.executeUpdate();

    }
catch(NullPointerException ne) {
%>
<script>
    alert("빈 칸 없이 정보를 모두 입력해주세요.");
    history.go(-1);
</script>
<%
}
catch(NumberFormatException nue) {
%>
<script>
    alert("빈 칸 없이 정보를 모두 입력해주세요.");
    history.go(-1);
</script>
<%
    }
    catch (Exception e) {
        e.printStackTrace();
    } finally {
        if(statement!=null) try{ statement.close(); } catch(SQLException e) {e.printStackTrace();}
        if(con!=null) try{ con.close(); } catch(SQLException e) {e.printStackTrace();}
    }
%>
<script>
    alert("캐릭터가 등록되었습니다.")
    history.go(-1);
</script>
</body>
</html>