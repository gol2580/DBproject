<%--
  Created by IntelliJ IDEA.
  User: MASTER
  Date: 2022-05-17
  Time: 오후 7:42
  To change this template use File | Settings | File Templates.
--%>
<%--
  Created by IntelliJ IDEA.
  User: MASTER
  Date: 2022-05-17
  Time: 오후 7:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*"%>
<meta name="viewport" content="width=device-width,initial-scale=1.0"/>

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
            <th>닉네임</th>
            <th>서버</th>
            <th>레벨</td>
            <th>스텟</th>
            <th>포스</th>
            <th>삭제</th>
            <th>수정</th>
        </tr>
<%
    Connection con=null;
    Statement statement = null;
    ResultSet result = null;

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");

        String DRIVER = "jdbc:mysql://localhost:3306/dbtermproject";
        String USER = "root";
        String PW = "ROOTjieun123@";
        String QUERY = "select * from userchar ORDER BY server"; //실행할 query문

        con = DriverManager.getConnection(DRIVER,USER,PW);
        statement = con.createStatement();
        result = statement.executeQuery(QUERY);

        while (result.next()) {
%>

        <tr>
            <td><%= result.getString("NICKNAME") %></td>
            <td><%= result.getString("SERVER") %></td>
            <td><%= result.getInt("LEVEL") %></td>
            <td><%= result.getInt("STATUS") %></td>
            <td><%= result.getInt("ARCFORCE") %></td>
            <td>
                <a href="<%= request.getContextPath()%>/deleteChar.jsp?delName=<%= result.getString("NICKNAME")%>">
                    X
                </a>
            </td>
            <td>
                <a href="<%= request.getContextPath()%>/updateChar.jsp?updateName=<%= result.getString("NICKNAME")%>">
                    수정
                </a>
            </td>
        </tr>

<%  }
    }catch(SQLException e){
        e.printStackTrace();
        out.print("fail");
    } finally {
        if(result!=null) try{ result.close(); } catch(SQLException e) {e.printStackTrace();}
        if(statement!=null) try{ statement.close(); } catch(SQLException e) {e.printStackTrace();}
        if(con!=null) try{ con.close(); } catch(SQLException e) {e.printStackTrace();}
    }
%>
    </table>
</div>
</body>
</html>