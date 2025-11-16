<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 25. 11. 13.
  Time: 오후 6:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.*" %>
<%@ page import="java.io.*" %>
<%@ page import="org.json.*" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>상세보기</title>


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
        }
        .info-label {
            font-weight: 600;
            color: #495057;
            width: 120px;
            display: inline-block;
        }
        .content-box {
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 5px;
            min-height: 200px;
            white-space: pre-wrap;
        }
    </style>
</head>
<body>
    <div class="container my-5">

        <div class="text-center mb-4">
            <h2 class="fw-bold">게시글 상세보기</h2>
        </div>

        <%
            String id = request.getParameter("id");//아이디의 파라미터 가져오기

            try{
                //해당하는 게시글 가져오기
                String apiUrl = "https://68db330123ebc87faa323a7c.mockapi.io/post/" + id;
                URL url = new URL(apiUrl);
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("GET");
                conn.setRequestProperty("Content-Type", "application/json");//요청

                BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                String inputLine;
                StringBuilder responseBuilder = new StringBuilder();//응답받기

                while ((inputLine = in.readLine()) != null) {
                    responseBuilder.append(inputLine);
                }
                in.close();

                JSONObject post = new JSONObject(responseBuilder.toString());

                String title = post.getString("title");
                String writer = post.getString("writer");
                String text = post.optString("text", "");
                int hit = post.getInt("hit");
                long createdDate = post.getLong("created_date");

                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
                String dateStr = sdf.format(new java.util.Date(createdDate * 1000L));

                // 조회수 증가 (PUT 요청)
                try {
                    String updateUrl = "https://68db330123ebc87faa323a7c.mockapi.io/post/" + id;
                    URL urlUpdate = new URL(updateUrl);
                    HttpURLConnection connUpdate = (HttpURLConnection) urlUpdate.openConnection();
                    connUpdate.setRequestMethod("PUT");
                    connUpdate.setRequestProperty("Content-Type", "application/json");
                    connUpdate.setDoOutput(true);

                    String jsonData = String.format("{\"hit\":%d}", hit + 1);
                    OutputStream os = connUpdate.getOutputStream();
                    os.write(jsonData.getBytes("UTF-8"));
                    os.flush();
                    os.close();

                    connUpdate.getResponseCode();
                    hit = hit + 1;
                }catch (Exception e) {
                    // 조회수 증가 실패해도 계속 진행
                }
        %>
        <div class="card">
            <div class="card-header">
                <h4 class="mb-0"><%= title %></h4>
            </div>
            <div class="card-body">
                <div class="info-row">
                    <span class="info-label">작성자:</span>
                    <span><%= writer %></span>
                </div>
                <div class="info-row">
                    <span class="info-label">작성일:</span>
                    <span><%= dateStr %></span>
                </div>
                <div class="info-row">
                    <span class="info-label">조회수:</span>
                    <span><%= hit %></span>
                </div>
            </div>
        </div>

        <div class="mt-3">
            <h5 class="fw-semibold mb-2">본문</h5>
            <div class="content-box">
                <%= text %>
            </div>
        </div>

        <div class="d-flex justify-content-between mt-4">
            <a href="list.jsp" class="btn btn-secondary">목록</a>
            <div>
                <a href="edit.jsp?id=<%= id %>" class="btn btn-primary">수정</a>
                <a href="delete_ok.jsp?id=<%= id %>"
                   class="btn btn-danger"
                   onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
            </div>
        </div>

        <%
        } catch (Exception e) {
        %>

        <div class="alert alert-danger" role="alert">
            ⚠️ 게시글을 불러오는데 실패했습니다: <%= e.getMessage() %>
        </div>
        <a href="list.jsp" class="btn btn-secondary">목록으로</a>
        <%
            }
        %>
    </div>
</body>
</html>
