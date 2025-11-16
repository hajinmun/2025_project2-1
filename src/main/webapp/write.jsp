<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 25. 11. 13.
  Time: 오후 6:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>새 글 작성</title>

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
        <h2 class="fw-bold">새 글 작성</h2>
    </div>

    <div class="card">
        <div class="card-body">
            <form action="write_ok.jsp" method="post">

                <div class="mb-3">
                    <label for="title" class="form-label fw-semibold">
                        제목 <span class="text-danger">*</span>
                    </label>
                    <input type="text" class="form-control" id="title" name="title"
                           required placeholder="제목 입력">
                </div>

                <div class="mb-3">
                    <label for="writer" class="form-label fw-semibold">
                        작성자 <span class="text-danger">*</span>
                    </label>
                    <input type="text" class="form-control" id="writer" name="writer"
                           required placeholder="작성자 입력">
                </div>

                <div class="mb-3">
                    <label for="text" class="form-label fw-semibold">
                        본문
                    </label>
                    <textarea class="form-control" id="text" name="text" rows="4"></textarea>
                </div>

                <div class="d-flex justify-content-center gap-2 mt-4">
                    <button type="submit" class="btn btn-success px-4">등록</button>
                    <button type="button" class="btn btn-secondary px-4"
                            onclick="location.href='list.jsp'">취소</button>
                </div>
            </form>
        </div>
    </div>

</div>
</body>
</html>
