<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Login</title>
	<jsp:include page="styles.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="_header.jsp"></jsp:include>
	<section class="container">
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}">Home</a></li>
			<li class="active">Login</li>
		</ol>
	</section>
	<section class="container">
		<div class="row">
			<div class="col-md-4 col-md-offset-4">
				<div class="page-header">
					<h1 class="text-center">Página de Login</h1>
				</div>
				<c:if test="${mensagemSucesso != null && mensagemSucesso != ''}">
					<div class="alert alert-success alert-dismissible" role="alert">
				  		<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					  	<p><c:out value="${mensagemSucesso}" /></p>
					</div>
				</c:if>
				<c:if test="${mensagemErro != null && mensagemErro != ''}">
					<div class="alert alert-danger alert-dismissible" role="alert">
				  		<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					  	<p>${mensagemErro}</p>
					</div>
				</c:if>
                <form class="form-horizontal" method="POST" action="${pageContext.request.contextPath}/login">
                    <div class="form-group">
                        <label for="login" class="col-sm-2 control-label">Login</label>
                        <div class="col-sm-10">
                            <input type="text" name="login" id="login" value="${login}" class="form-control" placeholder="Login" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="senha" class="col-sm-2 control-label">Senha</label>
                        <div class="col-sm-10">
                            <input type="password" name="senha" id="senha" class="form-control" placeholder="Senha" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="rememberMe" value="Y"> Lembrar de mim
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                        	<ul class="list-inline">
	                            <li><button type="submit" class="btn btn-dark">Entrar</button></li>
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