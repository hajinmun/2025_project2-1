<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.*" %>
<%@ page import="java.io.*" %>
<%@ page import="org.json.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판</title>
    <style></style>
</head>
<body>
<div class="container">
    <h1>게시판</h1>
    <%
        try {
            //mockapi호출
            String apiUrl = "https://68db330123ebc87faa323a7c.mockapi.io/post";
            URL url = new URL(apiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-Type", "application/json");

            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String inputLine;
            StringBuilder response = new StringBuilder();

            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            // JSON 파싱
            JSONArray posts = new JSONArray(response.toString());
    %>
    <table>
        <thead>
        <tr>
            <th style="width: 60px;">id</th>
            <th>title</th>
            <th style="width: 100px;">writer</th>
            <th style="width: 100px;">menu</th>
            <th style="width: 100px;">created_date</th>
            <th style="width: 80px;">hit</th>
            <th style="width: 140px;">menu</th>
        </tr>
        </thead>

        <tbody>
        <%
            //mockapi데이터 가져오기, 역순 정렬
            for(int i = posts.length() - 1; i>=0; i--){
                JSONObject post = posts.getJSONObject(i);
                String id = post.getString("id");
                String title = post.getString("title");
                String writer = post.getString("writer");
                String menu = post.optString("menu", "일반");
                int hit = post.getInt("hit");
                long createdDate = post.getLong("created_date");

                //날짜변환
                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
                String dateStr = sdf.format(new java.util.Date(createdDate * 1000L));
        %>
        <tr>
            <td><%= id %></td>
            <td>
                <a href="view.jsp?id=<%= id %>"><%= title %></a>
            </td>
            <td><%= writer %></td>
            <td><%= menu %></td>
            <td><%= dateStr %></td>
            <td><%= hit %></td>
            <td>
                <a href="edit.html?id=<%= id %>" class="btn btn-edit">수정</a>
                <a href="delete_ok.jsp?id=<%= id %>"
                   class="btn btn-delete"
                   onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>

    <div class="button-container">
        <a href="write.html" class="btn">add</a>
    </div>
</div>
</body>
</html>