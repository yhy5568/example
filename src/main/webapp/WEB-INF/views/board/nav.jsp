<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style type="text/css">
	li {list-style: none; display:inline; padding: 6px;}
</style>
<ul>
	<li><a href="/" class="btn btn-secondary">HOME</a></li>
	<li><a href="/board/list" class="btn btn-info">목록</a></li>
	<li><a href="/board/writeView" class="btn btn-success">글 작성</a></li>
	<li><a href="/member/memberUpdateView" class="btn btn-warning">회원정보수정</a></li>
	<li><a href="/member/memberDeleteView" class="btn btn-warning">회원탈퇴</a></li>
	<li>
		<c:if test="${member != null}"><a href="/member/logout" class="btn btn-danger">로그아웃</a></c:if>
		<c:if test="${member == null}"><a href="/" class="btn btn-danger">로그인</a></c:if>
	</li>
	<li>
		<c:if test="${member != null}">
			<p><strong>${member.userId}</strong>님 안녕하세요.</p>
		</c:if>
	</li>
</ul>