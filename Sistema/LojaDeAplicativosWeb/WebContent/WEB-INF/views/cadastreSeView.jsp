<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Cadastre-se</title>
	<jsp:include page="styles.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="_header.jsp"></jsp:include>
	<section class="container">
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}">Home</a></li>
			<li class="active">Cadastre-se</li>
		</ol>
	</section>
	<section class="container">
		<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="page-header">
					<h1 class="text-center">Página de Cadastro de Usuário</h1>
				</div>
				<c:if test="${mensagemErro != null && mensagemErro != ''}">
					<div class="alert alert-danger alert-dismissible" role="alert">
				  		<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					  	<p>${mensagemErro}</p>
					</div>
				</c:if>
                <form class="form-horizontal" method="POST" action="${pageContext.request.contextPath}/cadastre-se">
                    <div class="form-group">
                        <label for="nome" class="col-sm-3 control-label">Nome</label>
                        <div class="col-sm-9">
                            <input type="text" name="nome" id="nome" value="${usuario.nome}" class="form-control" placeholder="Nome" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="login" class="col-sm-3 control-label">Login</label>
                        <div class="col-sm-9">
                            <input type="text" name="login" id="login" value="${usuario.login}" class="form-control" placeholder="Login" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="senha" class="col-sm-3 control-label">Senha</label>
                        <div class="col-sm-9">
                            <input type="password" name="senha" id="senha" class="form-control" placeholder="Senha" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="confirma-senha" class="col-sm-3 control-label">Confirmar Senha</label>
                        <div class="col-sm-9">
                            <input type="password" name="confirmaSenha" id="confirma-senha" class="form-control" placeholder="Confirmar Senha" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-3 col-sm-9">
                            <ul class="list-inline">
	                            <li><button type="submit" class="btn btn-dark">Cadastrar</button></li>
                            	<li><a class="btn btn-default" href="${pageContext.request.contextPath}/">Cancelar</a></li>
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