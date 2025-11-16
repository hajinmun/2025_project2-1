<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 25. 11. 13.
  Time: 오후 6:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.*" %>
<%@ page import="java.io.*" %>
<html>
<head>
    <title>삭제 완료</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            background-color: white;
        }
        a {
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="container my-5">

        <%
            String id = request.getParameter("id");

            try {
                // MockAPI에 DELETE 요청
                String apiUrl = "https://68db330123ebc87faa323a7c.mockapi.io/post/" + id;
                URL url = new URL(apiUrl);
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("DELETE");
                conn.setRequestProperty("Content-Type", "application/json");

                // 응답 확인
                int responseCode = conn.getResponseCode();

                if (responseCode == 200) {
                    // 삭제 성공
        %>

        <div class="text-center mb-4">
            <h2 class="fw-bold text-danger">삭제 완료</h2>
        </div>

        <div class="alert alert-warning" role="alert">
            게시글이 삭제되었습니다
        </div>

        <div class="text-center mt-4">
            <a href="list.jsp" class="btn btn-primary px-4">목록으로</a>
        </div>

        <%
            } else {
                throw new Exception("API 응답 코드: " + responseCode);
            }
        } catch (Exception e) {
        %>

        <div class="text-center mb-4">
            <h2 class="fw-bold text-danger">오류 발생</h2>
        </div>

        <div class="alert alert-danger" role="alert">
            삭제 중 오류가 발생했습니다: <%= e.getMessage() %>
        </div>

        <div class="text-center mt-4">
            <a href="list.jsp" class="btn btn-primary">목록으로</a>
        </div>

        <%
            }
        %>

    </div>
</body>
</html>
