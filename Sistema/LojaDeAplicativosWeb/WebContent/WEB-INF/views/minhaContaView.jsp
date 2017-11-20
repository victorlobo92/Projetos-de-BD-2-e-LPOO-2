<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Minha Conta</title>
	<jsp:include page="styles.jsp"></jsp:include>
</head>
<body>

	<jsp:include page="_header.jsp"></jsp:include>
	<section class="container">
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}">Home</a></li>
			<li class="active">Minha Conta</li>
		</ol>
	</section>
	<section class="container">
		<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="page-header">
					<h1 class="text-center">Minha Conta</h1>
				</div>
				<c:if test="${mensagemSucesso != null && mensagemSucesso != ''}">
					<div class="alert alert-success alert-dismissible" role="alert">
				  		<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					  	<p><c:out value="${mensagemSucesso}" /></p>
					</div>
				</c:if>
				<div class="form-horizontal">
					<div class="form-group">
                        <label for="nome" class="col-sm-2 control-label">Nome</label>
                        <div class="col-sm-10">
                            <input type="text" name="nome" id="nome" value="${user.nome}" class="form-control" disabled />
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="login" class="col-sm-2 control-label">Login</label>
                        <div class="col-sm-10">
                            <input type="text" name="login" id="login" value="${user.login}" class="form-control" disabled />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <ul class="list-inline">
	                            <li><a class="btn btn-dark" href="${pageContext.request.contextPath}/alterar-senha">Alterar Senha</a></li>
                           	</ul>
                        </div>
                    </div>
                </div>
			</div>
		</div>
	</section>
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>