<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Edita Aplicativo</title>
	<jsp:include page="styles.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="_header.jsp"></jsp:include>
	<section class="container">
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}">Home</a></li>
			<li><a href="${pageContext.request.contextPath}/meus-aplicativos">Meus Aplicativos</a></li>
			<li class="active">Edita Aplicativo</li>
		</ol>
	</section>
	<section class="container">
		<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="page-header">
					<h1 class="text-center">Editar Aplicativo</h1>
				</div>
				<c:if test="${mensagemErro != null && mensagemErro != ''}">
					<div class="alert alert-danger alert-dismissible" role="alert">
				  		<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					  	<p>${mensagemErro}</p>
					</div>
				</c:if>
				<c:if test="${not empty aplicativo}">
					<form class="form-horizontal" method="POST" action="${pageContext.request.contextPath}/edita-aplicativo">
						<div class="form-group">
	                        <label for="codigo" class="col-sm-3 control-label">Código</label>
	                        <div class="col-sm-9">
	                        	<input type="hidden" name="idAplicativo" value="${aplicativo.idAplicativo}" />
	                            <input type="text" name="codigo" id="codigo" value="${aplicativo.idAplicativo}" class="form-control" placeholder="Código" disabled />
	                        </div>
	                    </div>
						<div class="form-group">
	                        <label for="desenvolvedor" class="col-sm-3 control-label">Desenvolvedor</label>
	                        <div class="col-sm-9">
	                            <input type="text" id="desenvolvedor" value="${aplicativo.desenvolvedor}" class="form-control" placeholder="Desenvolvedor" disabled />
	                        </div>
	                    </div>
	                    <div class="form-group">
	                        <label for="categoria" class="col-sm-3 control-label">Categoria</label>
	                        <div class="col-sm-9">
								<select name="idCategoria" id="categoria" class="form-control" required>
									<c:forEach items="${listaCategorias}" var="categoria">
										<option value="${categoria.idCategoria}"
											<c:if test="${categoria.idCategoria == aplicativo.idCategoria}">selected</c:if>>${categoria.categoria}</option>
									</c:forEach>
								</select>
	                        </div>
	                    </div>
	                    <div class="form-group">
	                        <label for="nome" class="col-sm-3 control-label">Nome</label>
	                        <div class="col-sm-9">
	                            <input type="text" name="nome" id="nome" value="${aplicativo.nome}" class="form-control" placeholder="Nome" required>
	                        </div>
	                    </div>
	                    <div class="form-group">
	                        <label for="descricao" class="col-sm-3 control-label">Descrição</label>
	                        <div class="col-sm-9">
	                            <textarea name="descricao" id="descricao" class="form-control" placeholder="Descrição" rows="4" required>${aplicativo.descricao}</textarea>
	                        </div>
	                    </div>
	                    <div class="form-group">
	                        <div class="col-sm-offset-3 col-sm-9">
	                            <ul class="list-inline">
		                            <li><button type="submit" class="btn btn-dark">Salvar</button></li>
	                            	<li><a class="btn btn-default" href="${pageContext.request.contextPath}/meus-aplicativos">Cancelar</a></li>
	                           	</ul>
	                        </div>
	                    </div>
					</form>
				</c:if>
			</div>
		</div>
	</section>
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>