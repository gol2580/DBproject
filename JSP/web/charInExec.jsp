<%--
  Created by IntelliJ IDEA.
  User: MASTER
  Date: 2022-05-16
  Time: 오후 7:07
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
            String NICKNAME = null; String SERVER = null;
            int LEVEL = 0; int STAT = 0; int ARCFORCE = 0;


            NICKNAME = new String(request.getParameter("nickname"));
            SERVER = new String(request.getParameter("selectServer"));
            LEVEL = Integer.parseInt(request.getParameter("level"));
            STAT = Integer.parseInt(request.getParameter("status"));
            ARCFORCE=Integer.parseInt(request.getParameter("force"));


            String INSQUERY = "insert into userchar values (?,?,?,?,?)";
            String EXINSQUERY = "insert into char_party_ex (nickname) values (?);"; //char_party_ex도 함께 삽입!

            statement = con.prepareStatement(INSQUERY);
            statement.setString(1,NICKNAME);
            statement.setString(2,SERVER);
            statement.setInt(3,LEVEL);
            statement.setInt(4,STAT);
            statement.setInt(5,ARCFORCE);

            statement2 = con.prepareStatement(EXINSQUERY);
            statement2.setString(1,NICKNAME);

            statement.executeUpdate();
            statement2.executeUpdate();

        } catch (SQLIntegrityConstraintViolationException ie) {
%>
            <script>
                alert("이미 존재하는 캐릭터입니다.");
                history.go(-1);
            </script>
<%
        } catch(NullPointerException ne) {
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
        if(statement2!=null) try{ statement2.close(); } catch(SQLException e) {e.printStackTrace();}
         if(con!=null) try{ con.close(); } catch(SQLException e) {e.printStackTrace();}
         }
        %>
<script>
    alert("캐릭터가 등록되었습니다.")
    history.go(-1);
</script>
</body>
</html>
