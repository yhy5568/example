<%@page import="org.jsoup.nodes.Element"%>
<%@page import="org.jsoup.select.Elements"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>

<html>
<head>

<title>Home</title>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta name="description" content="" />
<meta name="keywords" content="" />
<!--[if lte IE 8]><script src="css/ie/html5shiv.js"></script><![endif]-->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">

<!-- <script src="/resources/js/jquery.min.js"></script> -->
<script src="/resources/js/jquery.dropotron.min.js"></script>
<script src="/resources/js/skel.min.js"></script>
<!-- <script src="/resources/js/skel-layers.min.js"></script> -->
<script src="/resources/js/init.js"></script>
<link rel="stylesheet" href="/resources/css/skel.css" />
<link rel="stylesheet" href="/resources/css/style.css" />
<link rel="stylesheet" href="/resources/css/style-wide.css" />
<!--[if lte IE 8]><link rel="stylesheet" href="css/ie/v8.css" /><![endif]-->
<%
	Document doc;

	Elements elements;

	Element element;

	Elements lis1;
	Elements lis2;
%>
<style type="text/css">
	.state_desc {
		padding: 18px 0 13px;
		float: right;
	}
	
	.state_desc li {
		display: inline-block;
		font-family: "돋움", Dotum, Helvetica, sans-serif;
		font-size: 12px;
		color: white;
		margin-right: 17px;
		letter-spacing: -0.8px;
	}
	
	li {
		display: list-item;
		text-align: -webkit-match-parent;
	}
	
	.state_desc .state1:before {
		background-color: #6f8dd9;
	}
	
	.state_desc .state3:before {
		background-color: #80d882;
	}
	
	.state_desc .state4:before {
		background-color: #c0c0c0;
	}
	
	.state_desc li:before {
		content: '';
		display: inline-block;
		width: 11px;
		height: 11px;
		margin: 1px 5px 0 0;
		vertical-align: center;
	}
</style>

</head>
<script type="text/javascript">
	$(document).ready(function() {
		$("#logoutBtn").on("click", function() {
			location.href = "member/logout";
		})
		$("#registerBtn").on("click", function() {
			location.href = "member/register";
		})
		$("#memberUpdateBtn").on("click", function() {
			location.href = "member/memberUpdateView";
		})

	})
</script>
<body>
	<!-- Wrapper -->
	<div class="wrapper style1">
		<form class="form-horizontal" name='homeForm' method="post"	action="/member/login">
			<c:if test="${member == null}">
				<table>
					<colgroup>
						<col width="30%"/>
						<col width="70%"/>
					</colgroup>
					<tr height="100px" ><td></td>
						<td style="vertical-align: middle;">
							<div class="form-group">
								<div class="col-sm-4">
									<label for="userId" class="col-sm-3 control-label" style="color: white;">I D</label>
									<div class="col-sm-8">
										<input type="text" class="form-control" id="userId" name="userId" placeholder="I D">
									</div>
								</div>
								<div class="col-sm-4">
									<label for="userPass" class="col-sm-3 control-label" style="color: white;">Password</label>
									<div class="col-sm-8">
										<input type="password" class="form-control" id="userPass" name="userPass" placeholder="Password">
									</div>
								</div>
								<!-- <div class="form-group">
								<div class="col-sm-offset-2 col-sm-10">
									<div class="checkbox">
										<label> <input type="checkbox"> Remember me	</label>
									</div>
								</div>
							</div> -->
								<div class="col-sm-3" >
									<button type="submit" class="btn btn-primary">Sign in</button>
									<button id="registerBtn" type="button" class="btn btn-secondary">Sign up</button>
								</div>
							</div>
						</td>
					</tr>
				</table>
			</c:if>
			<c:if test="${member != null }">
				<div class="form-group" style="margin-right: 110px;">
					<div style="float: right;">
						<p style="color: white; float: right;">${member.userId}님 환영합니다.</p>
						<br><br><br> 
						<a href="/board/list" class="btn btn-info">게시판</a>
						<button id="memberUpdateBtn" type="button" class="btn btn-warning">회원정보수정</button>
						<button id="logoutBtn" type="button" class="btn btn-danger">로그아웃</button>
					</div>
				</div>
			</c:if>
			<c:if test="${msg == false}">
				<p style="color: red; margin-left: 80px; margin-top: 35px;">로그인 실패! 아이디와 비밀번호 확인해주세요.</p>
			</c:if>
		</form>
		<!-- Extra -->
		<div id="extra">
			<div class="container">
				<div class="row">
					<div class="col">
						<div id="banner" style="margin-bottom: -10px">
							<section>
								<p>이 시각 많이 본 해외축구 뉴스</p>
							</section>
						</div>
						<div class="box">
							<table class="table table-hover" id="tb" style="text-align: center; width: 480px; font-size: 14px; margin-top: -48px; margin-bottom: -48px; margin-left: -10px; border: 1px solid white">
								<%
									doc = Jsoup.connect("https://sports.news.naver.com/wfootball/index.nhn").get();

									elements = doc.select("div.home_news");

									element = elements.get(0);

									lis1 = element.select("li");
									lis2 = element.select("a");
									for (Element e : lis1) {
										for (int i = 0; i < 2; i++) {
											if (i == 1) {
												out.print("<td><a href='https://sports.news.naver.com" + e.select("a").attr("href") + "' target='_blank'>" + e.select("a").text() + "'</a></td>");
											} else {
												out.print("<tr><td>" + e.select("span.number").text() + "</td>");
											}
										}
										out.print("</tr>");
									}
								%>
							</table>
						</div>
					</div>
					
					<%
						doc = Jsoup.connect("https://www.msn.com/ko-kr/sports/soccer/premier-league/standings").get();

						elements = doc.select("table.tableview.soccerfullstandings.standing");

						element = elements.get(0);

						lis1 = element.select("th");
						lis2 = element.select("tbody");
					%>

					<div class="col">
						<div id="banner" style="margin-bottom: -10px">
							<p>EPL 실시간 순위</p>
						</div>
						<!-- Main -->
						<div id="main" style="margin-left: 30px">
							<!-- Content -->
							<table class="table table-hover" id="tb" style="text-align: center; border: 1px solid white; background-color: white; font-size: 13px;">
								<tr>
									<%
										for (Element e : lis1) {
											out.print("<th>" + e.select("th").get(0).text() + "</th>");
										}
									%>
								</tr>
								<%
									for (Element e : lis2) {
										out.print("<tr style='background: #6f8dd9;'>");//1번째줄
										int cnt = 0;
										for (int i = 0; i < 220; i++) {
											if (cnt % 11 == 1) {
												out.print("");
												cnt++;
											} else {
												out.print("<td>" + e.select("td").get(i).text() + "</td>");
												cnt++;
												if (cnt % 11 == 0 && cnt != 0) {
													if (cnt >= 11 * 17) {
														out.print("</tr><tr style='background: #c0c0c0;'>");//18~마지막줄
													} else if (cnt <= 11 * 3) {
														out.print("</tr><tr style='background: #6f8dd9;'>");//2~4줄
													} else if (cnt == 11 * 4) {
														out.print("</tr><tr style='background: #80d882'>");//5번째줄
													} else {
														out.print("</tr><tr>");
													}
												}

											}

										}
									}
								%>
							</table>
							<div class="state_desc">
								<ul>
									<li class="state1">챔피언스 리그 직행</li>
									<li class="state3">유로파 리그</li>
									<li class="state4">강등 직행</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Footer -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
	<script	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	<script	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
</body>
</html>