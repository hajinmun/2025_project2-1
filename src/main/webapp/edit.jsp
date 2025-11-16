<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.net.*" %>
<%@ page import="java.io.*" %>
<%@ page import="org.json.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>수정</title>

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

        <div class="text-center mb-4">
            <h2 class="fw-bold">게시글 수정</h2>
        </div>

        <%
            String id = request.getParameter("id");

            try {
                // API 호출 - 기존 데이터 가져오기
                String apiUrl = "https://68db330123ebc87faa323a7c.mockapi.io/post/" + id;
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

                JSONObject post = new JSONObject(responseBuilder.toString());

                String title = post.getString("title");
                String writer = post.getString("writer");
                String text = post.optString("text", "");
        %>

        <div class="card">
            <div class="card-body">
                <form action="edit_ok.jsp" method="post">
                    <input type="hidden" name="id" value="<%= id %>"><!--id를 받아와 수정(id: 요소 식별 위한 것, name: 폼데이터 서버로 전송할 때 사용)-->

                    <div class="mb-3">
                        <label for="title" class="form-label fw-semibold">
                            제목 <span class="text-danger">*</span>
                        </label>
                        <input type="text" class="form-control" id="title" name="title"
                               value="<%= title %>" required placeholder="제목 입력">
                    </div>

                    <div class="mb-3">
                        <label for="writer" class="form-label fw-semibold">
                            작성자 <span class="text-danger">*</span>
                        </label>
                        <input type="text" class="form-control" id="writer" name="writer"
                               value="<%= writer %>" required placeholder="작성자 입력">
                    </div>

                    <div class="mb-3">
                        <label for="text" class="form-label fw-semibold">
                            글
                        </label>
                        <textarea class="form-control" id="text" name="text" rows="10"><%= text %></textarea>
                    </div>

                    <div class="d-flex justify-content-center gap-2 mt-4">
                        <button type="submit" class="btn btn-primary px-4">수정</button>
                        <button type="button" class="btn btn-secondary px-4"
                                onclick="location.href='view.jsp?id=<%= id %>'">취소</button>
                    </div>
                </form>
            </div>
        </div>

        <%
        } catch (Exception e) {
        %>
        <div class="alert alert-danger" role="alert">
            게시글을 불러오는데 실패했습니다: <%= e.getMessage() %>
        </div>
        <a href="list.jsp" class="btn btn-secondary">목록으로</a>
        <%
            }
        %>

    </div>
</body>
</html>