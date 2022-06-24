<%--
  Created by IntelliJ IDEA.
  User: MASTER
  Date: 2022-05-19
  Time: 오전 1:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Vector"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    Connection con=null;
    PreparedStatement[] prestatArr = new PreparedStatement[4];
    ResultSet resultBossName = null;
    ResultSet exResult=null;
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

        //파티의 대상 보스, 모집 인원 얻어내기
        String leaderName = request.getParameter("leaderName");
        String GETBOSS = "select s.bossName, s.numOfChar from specification s where leaderName=?";

        prestatArr[0] = con.prepareStatement(GETBOSS);
        prestatArr[0].setString(1, leaderName);
        resultBossName = prestatArr[0].executeQuery();
        resultBossName.next();
        String bossName = resultBossName.getString("bossName"); //전달받은 리더의 파티의 대상 보스를 얻어냄
        int numOfChar = resultBossName.getInt("numOfChar"); //모집인원




        //해당 보스 파티가 없는 + 구인조건을 만족하는 char의 nickname 벡터에 저장
        String EXUPDATEQUERY = "select e.nickname " +
                "from ( select *" +
                "from userchar u, specification s " +
                "where u.server = s.SSERVER " +
                "AND s.leaderName=? " +
                "AND u.STATUS >= s.minStatus " +
                "AND u.LEVEL >= s.minLevel " +
                "AND u.ARCFORCE >=s.minForce ) a, char_party_ex e " +
                "where e.nickname=a.nickname ";
        String[] IFNULL ={
                "AND e.party_L=\"0\"  LIMIT ?",
                "AND e.party_De=\"0\"  LIMIT ?",
                "AND e.party_Du=\"0\"  LIMIT ?",
                "AND e.party_W=\"0\"  LIMIT ?",
                "AND e.party_H=\"0\"  LIMIT ?",
        };
        switch(bossName) {
            case "루시드" :
                EXUPDATEQUERY+=IFNULL[0];
                break;
            case "데미안" :
                EXUPDATEQUERY+=IFNULL[1];
                break;
            case "듄켈" :
                EXUPDATEQUERY+=IFNULL[2];
                break;
            case "윌" :
                EXUPDATEQUERY+=IFNULL[3];
                break;
            case "힐라" :
                EXUPDATEQUERY+=IFNULL[4];
                break;
        }

        System.out.println(EXUPDATEQUERY);
        Vector<String> charName = new Vector<String>();
        prestatArr[1] = con.prepareStatement(EXUPDATEQUERY);
        prestatArr[1].setString(1, leaderName);
        prestatArr[1].setInt(2,numOfChar);
        System.out.println(prestatArr[1]);
        exResult = prestatArr[1].executeQuery();
        //만족하는 캐릭터 이름 벡터에 저장
        while (exResult.next()) {
            charName.add(exResult.getString("nickname"));
        }

        if(charName.size()==0) {
%>
            <script>
                alert("조건에 맞는 캐릭터가 없습니다.");
                history.go(-2);
            </script>
<%
        }

        //case문에 사용하기 위한 보스별 query문배열
        String[] EXUPDATEQUERYARR = {
                "update char_party_ex set party_L=? where nickname=?;",
                "update char_party_ex set party_De=? where nickname=?;",
                "update char_party_ex set party_Du=? where nickname=?;",
                "update char_party_ex set party_W=? where nickname=?;",
                "update char_party_ex set party_H=? where nickname=?;"
        };

        //대상 캐릭터의 개수만큼 반복
        for (int i = 0; i < charName.size(); i++) {

            switch (bossName) {
                case "루시드":
                    prestatArr[2] = con.prepareStatement(EXUPDATEQUERYARR[0]);
                    break;
                case "데미안":
                    prestatArr[2] = con.prepareStatement(EXUPDATEQUERYARR[1]);
                    break;
                case "듄켈":
                    prestatArr[2] = con.prepareStatement(EXUPDATEQUERYARR[2]);
                    break;
                case "윌":
                    prestatArr[2] = con.prepareStatement(EXUPDATEQUERYARR[3]);
                    break;
                case "힐라":
                    prestatArr[2] = con.prepareStatement(EXUPDATEQUERYARR[4]);
                    break;
            }
            prestatArr[2].setString(1,leaderName);
            prestatArr[2].setString(2, charName.get(i));
            prestatArr[2].executeUpdate();
            /*결과닉네임의 개수만큼
    결과닉네임=ex.nickname인 튜플의
    해당 보스(위에서 얻음 bossName에 케이스문 사용) 튜플을 업데이트
             */
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if(resultBossName!=null) try{ resultBossName.close(); } catch(SQLException e) {e.printStackTrace();}
        if(exResult!=null) try{ exResult.close(); } catch(SQLException e) {e.printStackTrace();}
        for(int i=0;i<3;i++) {
            if(prestatArr[i]!=null) try{prestatArr[i].close();} catch (SQLException e) {e.printStackTrace();}
        }
        if(con!=null) try{ con.close(); } catch(SQLException e) {e.printStackTrace();}
    }
%>

<script>
    location.replace(href="<%= request.getContextPath()%>/matchingExec.jsp?leaderName=<%= request.getParameter("leaderName")%>");
</script>
</body>
</html>
