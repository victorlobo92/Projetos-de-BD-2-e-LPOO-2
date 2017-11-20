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
			<li><a href="${pageContext.request.contextPath}/minha-conta">Minha Conta</a></li>
			<li class="active">Alterar Senha</li>
		</ol>
	</section>
	<section class="container">
		<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="page-header">
					<h1 class="text-center">Alterar Senha</h1>
				</div>
				<c:if test="${mensagemErro != null && mensagemErro != ''}">
					<div class="alert alert-danger alert-dismissible" role="alert">
				  		<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					  	<p>${mensagemErro}</p>
					</div>
				</c:if>
				<form class="form-horizontal" method="POST" action="${pageContext.request.contextPath}/alterar-senha">
					<input type="hidden" name="idUsuario" value="${loginedUser.idUsuario}" />
					<div class="form-group">
                        <label for="senha-antiga" class="col-sm-4 control-label">Senha antiga</label>
                        <div class="col-sm-8">
                            <input type="password" name="senhaAntiga" id="senha-antiga" class="form-control" placeholder="Senha antiga" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="nova-senha" class="col-sm-4 control-label">Nova senha</label>
                        <div class="col-sm-8">
                            <input type="password" name="novaSenha" id="nova-senha" class="form-control" placeholder="Nova senha" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="confirma-nova-senha" class="col-sm-4 control-label">Confirmar nova senha</label>
                        <div class="col-sm-8">
                            <input type="password" name="confirmaNovaSenha" id="confirma-nova-senha" class="form-control" placeholder="Confirmar nova senha" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-4 col-sm-8">
                            <ul class="list-inline">
	                            <li><button type="submit" class="btn btn-dark">Alterar</button></li>
                            	<li><a class="btn btn-default" href="${pageContext.request.contextPath}/minha-conta">Cancelar</a></li>
                           	</ul>
                        </div>
                    </div>
				</form>
			</div>
		</div>
	</section>
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>