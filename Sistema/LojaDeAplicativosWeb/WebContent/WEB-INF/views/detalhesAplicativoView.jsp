<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Detalhes Aplicativo</title>
	<jsp:include page="styles.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="_header.jsp"></jsp:include>
	<section class="container">
		<ol class="breadcrumb">
			<li><a href="${pageContext.request.contextPath}">Home</a></li>
			<c:if test="${origin == 'meus-aplicativos'}"><li><a href="${pageContext.request.contextPath}/meus-aplicativos">Meus Aplicativos</a></li></c:if>
			<li class="active">Detalhes Aplicativo</li>
		</ol>
	</section>
	<section class="container">
		<div class="row">
			<div class="col-md-8 col-md-offset-2">
				<div class="page-header">
					<h1 class="text-center">Detalhes Aplicativo</h1>
				</div>
				<c:if test="${mensagemErro != null && mensagemErro != ''}">
					<div class="alert alert-danger alert-dismissible" role="alert">
				  		<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					  	<p>${mensagemErro}</p>
					</div>
				</c:if>
				<div class="form-horizontal">
					<div class="form-group">
			            <label class="col-sm-3 control-label">Data de publicação</label>
			            <div class="col-sm-9">
			                <input type="text" value="${aplicativo.dataHora}" class="form-control" readonly />
			            </div>
			        </div>
					<div class="form-group">
			            <label class="col-sm-3 control-label">Desenvolvedor</label>
			            <div class="col-sm-9">
			                <input type="text" value="${aplicativo.desenvolvedor}" class="form-control" readonly />
			            </div>
			        </div>
					<div class="form-group">
			            <label class="col-sm-3 control-label">Categoria</label>
			            <div class="col-sm-9">
			                <input type="text" value="${aplicativo.categoria}" class="form-control" readonly />
			            </div>
			        </div>
					<div class="form-group">
			            <label class="col-sm-3 control-label">Nome</label>
			            <div class="col-sm-9">
			                <input type="text" value="${aplicativo.nome}" class="form-control" readonly />
			            </div>
			        </div>
					<div class="form-group">
			            <label class="col-sm-3 control-label">Descrição</label>
			            <div class="col-sm-9">
			                <textarea class="form-control" rows="4" readonly>${aplicativo.descricao}</textarea>
			            </div>
			        </div>
	                <div class="form-group">
	                    <div class="col-sm-offset-3 col-sm-9">
	                    	<ul class="list-inline">
	                    		<li><a class="btn btn-default" href="${referrer}">Voltar</a></li>
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