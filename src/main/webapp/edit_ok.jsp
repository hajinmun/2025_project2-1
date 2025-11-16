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
    <title>수정 완료</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            background-color: white;
        }
        a {
            text-decoration: none;
        }
        .info-row {
            padding: 12px;
            border-bottom: 1px solid #dee2e6;
            display: flex;
        }
        .info-row:last-child {
            border-bottom: none;
        }
        .info-label {
            font-weight: 600;
            color: #495057;
            width: 120px;
        }
        .info-value {
            flex: 1;
            color: #212529;
        }
    </style>
</head>
<body>
    <div class="container my-5">

        <%
            request.setCharacterEncoding("UTF-8");

            String id = request.getParameter("id");
            String title = request.getParameter("title");
            String writer = request.getParameter("writer");
            String text = request.getParameter("text");

            try {
                // MockAPI에 PUT 요청
                String apiUrl = "https://68db330123ebc87faa323a7c.mockapi.io/post/" + id;
                URL url = new URL(apiUrl);
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("PUT");
                conn.setRequestProperty("Content-Type", "application/json");
                conn.setDoOutput(true);

                // JSON 데이터 생성
                String jsonData = String.format(
                        "{\"title\":\"%s\",\"writer\":\"%s\",\"text\":\"%s\"}",
                        title.replace("\"", "\\\""),
                        writer.replace("\"", "\\\""),
                        text != null ? text.replace("\"", "\\\"").replace("\n", "\\n") : ""
                );

                // 데이터 전송
                OutputStream os = conn.getOutputStream();
                os.write(jsonData.getBytes("UTF-8"));
                os.flush();
                os.close();

                // 응답 확인
                int responseCode = conn.getResponseCode();

                if (responseCode == 200) {
                    // 성공
        %>

        <div class="text-center mb-4">
            <h2 class="fw-bold text-primary">수정 완료</h2>
        </div>

        <div class="alert alert-warning" role="alert">
            게시글이 수정되었습니다
        </div>

        <div class="card">
            <div class="card-header">
                <h5 class="mb-0">수정 내용</h5>
            </div>
            <div class="card-body">
                <div class="info-row">
                    <div class="info-label">제목:</div>
                    <div class="info-value"><%= title %></div>
                </div>
                <div class="info-row">
                    <div class="info-label">작성자:</div>
                    <div class="info-value"><%= writer %></div>
                </div>
                <div class="info-row">
                    <div class="info-label">본문:</div>
                    <div class="info-value" style="white-space: pre-wrap;"><%= text != null ? text : "" %></div>
                </div>
            </div>
        </div>

        <div class="d-flex justify-content-center gap-2 mt-4">
            <a href="view.jsp?id=<%= id %>" class="btn btn-primary px-4">상세보기</a>
            <a href="list.jsp" class="btn btn-secondary px-4">목록으로</a>
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
            수정 중 오류가 발생했습니다: <%= e.getMessage() %>
        </div>

        <div class="text-center mt-4">
            <a href="edit.jsp?id=<%= request.getParameter("id") %>" class="btn btn-secondary">다시 시도</a>
            <a href="list.jsp" class="btn btn-primary">목록으로</a>
        </div>

        <%
            }
        %>

    </div>

<html>
<head>
    <title>Title</title>
</head>
<body>
</body>
</html>
