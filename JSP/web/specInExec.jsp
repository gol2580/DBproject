<%--
  Created by IntelliJ IDEA.
  User: MASTER
  Date: 2022-05-16
  Time: 오후 7:34
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

        String leaderNickname = null; String server = null; String bossName=null;
        int numOfChar=0; int level = 0; int stat = 0; int force = 0;

        leaderNickname = new String(request.getParameter("leaderNickname"));
        server = new String(request.getParameter("selectServer"));
        bossName = new String(request.getParameter("selectBoss"));
        numOfChar=Integer.parseInt(request.getParameter("numOfChar"));
        level = Integer.parseInt(request.getParameter("minLevel"));
        stat = Integer.parseInt(request.getParameter("minStatus"));
        force=Integer.parseInt(request.getParameter("minForce"));

        String INSQUERY = "insert into specification values (?,?,?,?,?,?,?)";

        statement = con.prepareStatement(INSQUERY);

        statement.setString(1,leaderNickname);
        statement.setString(2,bossName);
        statement.setInt(3,numOfChar);
        statement.setString(4,server);
        statement.setInt(5,level);
        statement.setInt(6,stat);
        statement.setInt(7,force);

        int result=statement.executeUpdate();
    } catch (SQLIntegrityConstraintViolationException ie) {
%>
<script>
    alert("이미 모집 중입니다.");
    history.go(-1);
</script>
<%
    } catch(NullPointerException ne) {
        ne.printStackTrace();
%>
    <script>
        alert("빈 칸 없이 정보를 모두 입력해주세요.");
        history.go(-1);
    </script>
<%
    }
    catch(NumberFormatException nue) {
        nue.printStackTrace();
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
    alert("파티 모집이 등록되었습니다.")
    history.go(-1);
</script>
</body>
</html>

