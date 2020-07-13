<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form"  uri="http://www.springframework.org/tags/form" %>
<html>
	<head>
		<meta charset="UTF-8">
		<!-- 합쳐지고 최소화된 최신 CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<!-- 부가적인 테마 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
		
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		
		<script src="http://malsup.github.com/jquery.form.js"></script> 
	 
	 	<title>게시판</title>
	</head>
	<body>
		<div class="container">
			<header>
				<h1> 게시판</h1>
			</header>
			<hr />
			 
			<div>
				<%@include file="nav.jsp" %>
			</div>
			
			<form id="excelUploadForm" name="excelUploadForm" enctype="multipart/form-data" method="post" action= "/board/excelUploadAjax">
				<div class="contents">
					
					<dl class="vm_name">
						<dt class="down w90">첨부 파일</dt>
							<dd><input id="excelFile" type="file" name="excelFile" /></dd>
						</dl>        
					</div>
					<div style="color: red;">※ 첨부파일은 xlsx파일 한개만 등록 가능합니다. ※</div>
				
				<div class="bottom">
				  <button type="button" class="fileAdd_btn btn btn-primary" id="addExcelImpoartBtn" onclick="check()" ><span>추가</span></button>
				  <a href="<c:url value='excelDown' />" class="btn btn-primary pull-right">Excel File Download</a>
				</div>
			</form>
		
		<script type="text/javascript">
			
			function check() {

				var file = $("#excelFile").val();

				if (file == "" || file == null) {
					alert("파일을 선택해주세요.");

					return false;
				} else if (!checkFileType(file)) {
					alert("엑셀 파일만 업로드 가능합니다.");

					return false;
				}

				if (confirm("업로드 하시겠습니까?")) {

					var options = {
						success : function(data) {
							console.log("data ::: " + data);
							alert("모든 데이터가 업로드 되었습니다.");
							location.href = '/board/list'

						},
						type : "POST"
					};

					$("#excelUploadForm").ajaxSubmit(options);
				}
			}

			function checkFileType(filePath) {
				var fileFormat = filePath.split(".");

				if (fileFormat.indexOf("xls") > -1
						|| fileFormat.indexOf("xlsx") > -1) {
					return true;
				} else {
					return false;
				}
			}
		
		</script>
		
		<section id="container">
				<form role="form" method="get">
					<table class="table table-hover">
						<thead>
							<tr>
								<th style="text-align: center;">번호</th>
								<th style="text-align: center;">제목</th>
								<th style="text-align: center;">작성자</th>
								<th style="text-align: center;">등록일</th>
								<th style="text-align: center;">조회수</th>
							</tr>
						</thead>
						
						<c:forEach items="${list}" var = "list">
							<tr style="text-align: center;">
								<td><c:out value="${list.bno}" /></td>
								<td>
									<a href="/board/readView?bno=${list.bno}&page=${scri.page}&perPageNum=${scri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}"><c:out value="${list.title}" /></a>
								</td>
								<td><c:out value="${list.writer}" /></td>
								<td><fmt:formatDate value="${list.regdate}" pattern="yyyy-MM-dd"/></td>
								<td><c:out value="${list.hit}" /></td>
							</tr>
						</c:forEach>
						
					</table>
					<div class="search row">
						<div class="col-xs-2 col-sm-2">
							<select name="searchType" class="form-control" style="text-align-last: center;">
								<option value="n"<c:out value="${scri.searchType == null ? 'selected' : ''}"/>>-----</option>
								<option value="t"<c:out value="${scri.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
								<option value="c"<c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>내용</option>
								<option value="w"<c:out value="${scri.searchType eq 'w' ? 'selected' : ''}"/>>작성자</option>
								<option value="tc"<c:out value="${scri.searchType eq 'tc' ? 'selected' : ''}"/>>제목+내용</option>
							</select>
						</div>
						 
						<div class="col-xs-10 col-sm-10">
							<div class="input-group">
								<input type="text" name="keyword" id="keywordInput" value="${scri.keyword}" class="form-control"/>
								<span class="input-group-btn">
									<button id="searchBtn" type="button" class="btn btn-default">검색</button> 	
								</span>
							</div>
						</div>
						 
						<script>
							 $(function(){
								 $('#searchBtn').click(function() {
									 self.location = "list" + '${pageMaker.makeQuery(1)}' + "&searchType=" + $("select option:selected").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val());
								 });
							 });   
						</script>
					</div>
					<div class="text-center">
						<ul class="pagination">
							<c:if test="${pageMaker.prev}">
								<li><a href="list${pageMaker.makeSearch(pageMaker.startPage - 1)}">이전</a></li>
							</c:if> 
							
							<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
								<li <c:out value="${pageMaker.cri.page == idx ? 'class=info' : ''}" />>
								<a href="list${pageMaker.makeSearch(idx)}">${idx}</a></li>
							</c:forEach>
							
							<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
								<li><a href="list${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a></li>
							</c:if> 
						</ul>
					</div>
				</form>
			</section>



		<h4>메일 보내기</h4>
		<form action="${pageContext.request.contextPath}/mail/mailSending"
			method="post">
			<div align="center">
				<!-- 받는 사람 이메일 -->
				<input type="text" name="tomail" size="120" style="width: 100%"
					placeholder="상대의 이메일" class="form-control">
			</div>
			<div align="center">
				<!-- 제목 -->
				<input type="text" name="title" size="120" style="width: 100%"
					placeholder="제목을 입력해주세요" class="form-control">
			</div>
			<p>
			<div align="center">
				<!-- 내용 -->
				<textarea name="content" cols="120" rows="12"
					style="width: 100%; resize: none" placeholder="내용"
					class="form-control"></textarea>
			</div>
			<p>
			<div align="center">
				<input type="submit" value="메일 보내기" class="btn btn-success">
			</div>
		</form>
	</div>
	</body>
</html>