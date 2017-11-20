<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Meus Aplicativos</title>
	<jsp:include page="styles.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="_header.jsp"></jsp:include>
	<section class="container">
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}">Home</a></li>
			<li class="active">Meus Aplicativos</li>
		</ol>
	</section>
	<section class="container">
		<div class="page-header">
			<h1 class="text-center">Meus Aplicativos</h1>
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
		<div class="row">
			<div class="col-md-6">
				<h2>Aplicativos Comprados</h2>
				<c:choose>
					<c:when
						test="${aplicativosComprados != null && !aplicativosComprados.isEmpty()}">
						<table class="table table-hover text-center">
							<thead>
								<tr>
									<th class="text-center">Código</th>
									<th class="text-center">Nome</th>
									<th class="text-center">Detalhes</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${aplicativosComprados}" var="aplicativo">
									<tr class="success">
										<td>${aplicativo.idAplicativo}</td>
										<td>${aplicativo.nome}</td>
										<td>
											<a href="${pageContext.request.contextPath}/detalhes-aplicativo?idAplicativo=${aplicativo.idAplicativo}">
												<i class="fa fa-file-text-o" aria-hidden="true" title="Ver mais detalhes"></i>
											</a>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</c:when>
					<c:otherwise>
						<div class="alert alert-warning alert-dismissible" role="alert">
					  		<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						  	<p>Você ainda não comprou nenhum aplicativo.</p>
						</div>
						<p><a class="btn btn-dark" href="${pageContext.request.contextPath}">Clique aqui para ver a lista de aplicativos disponíveis na loja.</a></p>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="col-md-6">
				<div class="clearfix">
					<h2 class="pull-left">Publicados por mim</h2>
					<a class="btn btn-dark pull-right" href="${pageContext.request.contextPath}/cadastra-aplicativo">Cadastrar Aplicativo</a>
				</div>
				<c:choose>
					<c:when
						test="${aplicativosDesenvolvidos != null && !aplicativosDesenvolvidos.isEmpty()}">
						<table class="table table-hover text-center">
							<thead>
								<tr>
									<th class="text-center">Código</th>
									<th class="text-center">Nome</th>
									<th class="text-center">Detalhes</th>
									<th class="text-center">Editar</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${aplicativosDesenvolvidos}" var="desenvolvido">
									<tr class="info">
										<td>${desenvolvido.idAplicativo}</td>
										<td>${desenvolvido.nome}</td>
										<td>
											<a href="${pageContext.request.contextPath}/detalhes-aplicativo?idAplicativo=${desenvolvido.idAplicativo}">
												<i class="fa fa-file-text-o" aria-hidden="true" title="Ver mais detalhes"></i>
											</a>
										</td>
										<td>
											<a href="${pageContext.request.contextPath}/edita-aplicativo?idAplicativo=${desenvolvido.idAplicativo}">
												<i class="fa fa-pencil" aria-hidden="true" title="Editar aplicativo"></i>
											</a>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</c:when>
					<c:otherwise>
						<div class="alert alert-warning alert-dismissible" role="alert">
					  		<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						  	<p>Você ainda não publicou nenhum aplicativo.</p>
						</div>
						<p><a class="btn btn-dark" href="${pageContext.request.contextPath}/cadastra-aplicativo">Publique seu primeiro aplicativo</a></p>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</section>
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>