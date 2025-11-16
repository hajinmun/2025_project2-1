<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.*" %>
<%@ page import="java.io.*" %>
<%@ page import="org.json.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판</title>

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

    <!-- 제목 -->
    <div class="text-center">
        <h2 class="fw-bold">게시판</h2>
    </div>

    <%
        try {
            // API 호출
            String apiUrl = "https://68db330123ebc87faa323a7c.mockapi.io/post";
            URL url = new URL(apiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-Type", "application/json");

            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String inputLine;
            StringBuilder responseBuilder = new StringBuilder();

            while ((inputLine = in.readLine()) != null) {
                responseBuilder.append(inputLine);
            }
            in.close();

            JSONArray posts = new JSONArray(responseBuilder.toString());
    %>

    <div>
        <div class="card-body">

            <!-- 테이블 -->
            <table class="table table-bordered table-hover align-middle text-center">
                <thead class="table-warning">
                <tr>
                    <th style="width: 60px;">ID</th>
                    <th>제목</th>
                    <th style="width: 120px;">작성자</th>
                    <th style="width: 130px;">작성일</th>
                    <th style="width: 70px;">조회</th>
                    <th style="width: 150px;">관리</th>
                </tr>
                </thead>

                <tbody>
                <%
                    for (int i = posts.length() - 1; i >= 0; i--) {
                        JSONObject post = posts.getJSONObject(i);
                        String id = post.getString("id");
                        String title = post.getString("title");
                        String writer = post.getString("writer");
                        int hit = post.getInt("hit");
                        long createdDate = post.getLong("created_date");

                        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
                        String dateStr = sdf.format(new java.util.Date(createdDate * 1000L));
                %>

                <tr>
                    <td><%= id %></td>
                    <td>
                        <a href="view.jsp?id=<%= id %>" class="fw-semibold text-dark">
                            <%= title %>
                        </a>
                    </td>
                    <td><%= writer %></td>
                    <td><%= dateStr %></td>
                    <td><%= hit %></td>
                    <td>
                        <a href="edit.html?id=<%= id %>" class="btn btn-primary btn-sm">수정</a>
                        <a href="delete_ok.jsp?id=<%= id %>"
                           class="btn btn-danger btn-sm"
                           onclick="return confirm('정말 삭제하시겠습니까?');">
                            삭제
                        </a>
                    </td>
                </tr>

                <%
                    }
                %>
                </tbody>
            </table>

            <!-- 글쓰기 버튼 -->
            <div class="text-end mt-3">
                <a href="write.jsp" class="btn btn-success px-4">+ 글쓰기</a>
            </div>

        </div>
    </div>

    <%
        } catch (IOException e) {
            throw new RuntimeException(e);
        } catch (JSONException e) {
            throw new RuntimeException(e);
        }
    %>

</div>
</body>
</html>
