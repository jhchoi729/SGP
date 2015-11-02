<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
var check=false;
</script>
<c:choose>
<c:when test="${check==null}"></c:when>
<c:when test="${check==true}">
<script>
check=true;
</script>
</c:when>
<c:when test="${check==false}">
<script>
alert('인증에 실패하였습니다 다시한번 시도해주세요');
</script>
</c:when>
<c:when test="${check==null}"></c:when>
</c:choose>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	var re_id = /^[a-z0-9]{5,20}$/; // 아이디 검사식
	var re_pw = /^[a-z0-9]{5,20}$/; // 비밀번호 검사식
	var re_mail = /^([\w\.-]+)@([a-z\d\.-]+)\.([a-z\.]{2,6})$/; //
	var pwdCheck = false;
	var idCheck = false;
	var nickCheck = false
	$(jqueryOk);
	function jqueryOk() {
		$('#check').click(function() {
			if (re_mail.test($('input[name=email]').val()) == true) {

				$.ajax({
					type : "post",
					url : "send",
					dataType : "json",
					data : {
						"email" : $('input[name=email]').val()
					},
					success : function(json) {
						if (json.ok) {
							alert('메일전송에 성공했습니다. 메일을 통해 인증을 확인해주세요');
						} else
							alert('전송 실패');
					},
					error : function(err) {
						alert("에러");
					}
				});
			} else {
				alert('사용가능한 이메일이 아닙니다');
			}

		});

		$('#idCheck').click(function() {
			$.ajax({
				type : "post",
				url : "idCheck",
				dataType : "json",
				data : {
					"email" : $('input[name=id]').val()
				},
				success : function(json) {
					if (json.ok) {
						idCheck = true;
						alert('사용가능한 ID입니다');
					} else
						alert('중복된 ID입니다');
				},
				error : function(err) {
					alert("에러");
				}
			});

		});
		$('#nickCheck').click(function() {
			$.ajax({
				type : "post",
				url : "nickCheck",
				dataType : "json",
				data : {
					"email" : $('input[name=nick]').val()
				},
				success : function(json) {
					if (json.ok) {
						nickCheck = true;
						alert('사용가능한 닉네임입니다');
					} else
						alert('중복된 닉네임입니다');
				},
				error : function(err) {
					alert("에러");
				}
			});

		});

		$('#regist').click(function() {
			if (check && idCheck && pwdCheck && nickCheck) {
				$.ajax({
					type : "post",
					url : "regist",
					dataType : "json",
					data : $('#meminfo').serialize(),
					success : function(json) {
						if (json.ok) {
							alert('등록에 성공했습니다');
						} else
							alert('등록 실패');
					},
					error : function(err) {
						alert("에러");
					}
				});
			} else {
				if (!check) {
					alert('이메일 인증 이후에 등록하실수 있습니다 ');
				} else if (!idCheck) {
					alert('id중복 검사를 해주셔야 합니다 ');
				} else if (!nickCheck) {
					alert('닉네임중복 검사를 해주셔야 합니다 ');
				} else if (!pwdCheck) {
					alert('패스워드 유효성 검사를 해주시기 바랍니다 ');
				}
			}

		});

		/* if (!check) {
			$('.afterCheck').attr("readonly", "readonly");
			$('.afterCheck').click(function() {
				alert('인증 이후에 사용 가능하십니다');

			});
		} */
		$('#pwd')
				.on(
						'keydown',
						function() {
							if (re_pw.test($('#pwd').val()) != true) {
								$('pwdTest').empty();
								$('pwdText').css('color', 'red');
								$('pwdText')
										.text(
												'비밀번호는 영문자와 숫자의 혼합구성으로 5자 이상 20자 이하로 입력해 주셔야 합니다');
							} else {
								$('pwdTest').empty();
								$('pwdText').css('color', 'black');
								$('pwdText').text('사용가능한 패스워드 입니다');
							}

						});

		$('#pwdCheck').on('keydown', function() {
			if ($('#pwd').val() != $('#pwdCheck').val()) {
				$('pwdTest').empty();
				$('pwdTest').css('color', 'red');
				$('pwdTest').text('입력한 패스워드와 일치하지않습니다.');
			} else {
				pwdCheck = true;
				$('pwdTest').css('color', 'black');
				$('pwdTest').text('입력하신 패스워드와 일치합니다');
			}

		})

	}
</script>

</head>
<body>

	<form id="meminfo" method="post">
		<table>
			<tr>
				<td>email :</td>
				<td><input type="text" name="email" value="${email}"></td>
				<td><button id="check" type="button">인증하기</button></td>
			</tr>
			<tr>
				<td>name :</td>
				<td><input class="afterCheck" id="name" type="text" name="name"></td>

			</tr>
			<tr>
				<td>nick :</td>
				<td><input class="afterCheck" id="nick" type="text" name="nick"></td>
				<td><button id="nickCheck">인증하기</button></td>
			</tr>
			<tr>
				<td>id :</td>
				<td><input class="afterCheck" id="id" type="text" name="id"></td>
				<td><button id="idCheck">인증하기</button></td>
			</tr>
			<tr>
				<td>pwd :</td>
				<td><input class="afterCheck" id="pwd" type="text" name="pwd"></td>
				<td><div id="pwdText"></div></td>
			</tr>
			<tr>
				<td>pwd 확인:</td>
				<td><input class="afterCheck" id="pwdCheck" type="text"
					name="pwdCheck"></td>
				<td><div id="checkText"></div></td>
			</tr>
			<tr>
				<td></td>
				<td><button id="regist" type="button">등록하기</button></td>
			</tr>
		</table>

	</form>

</body>
</html>