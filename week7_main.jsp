<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Vector" %>

<%
    request.setCharacterEncoding("utf-8");

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/stageus", "cono", "1234");

    String sql = "SELECT * FROM account";
    PreparedStatement query = connect.prepareStatement(sql);

    ResultSet result = query.executeQuery();

    // 값 정제

    // 안타깝게도 ResultSet은 2차원 배열 형태를 제공하지 않음
    // 특이하게 result.next()를 사용하여 row 한 줄씩 체크해야 함
    // java에선 DB로부터 온 값을 이렇게밖에 사용할 수 없음

    // JSP의 배열은 기본적으로 이렇게 사용함
    // js처럼 동적으로 크기를 지정하지 못하며, 고정 크기를 지정해야 함
    // js와 같은 list를 사용하는 방법으로 vector와 arrayList가 있음

    String[][] data = new String[10][2];  
    int index = 0;
    while(result.next()) {
        data[index][0] = result.getString(1);
        data[index][1] = result.getString(2);
        index++;
    }
%>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>

    <script>
        // data는 jsp변수로, js 반복문 내의 변수로 접근할 수 없음
        // 따라서 아래와 같이 jsp와 함께 사용하는 스파게티 코딩으로만 가능함
        // 또한, 고정 사이즈의 배열이기에 문제가 발생함
        <%for (int i=0; i < data.length; i++) {%>
            console.log("<%=data[i][0]%>", "<%=data[i][1]%>")
        <%}%>
    </script>

</body>