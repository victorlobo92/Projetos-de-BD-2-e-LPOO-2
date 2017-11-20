<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Aplicativos</title>
	<jsp:include page="styles.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="_header.jsp"></jsp:include>
	<section class="container">
		<ol class="breadcrumb">
			<li class="active">Home</li>
		</ol>
	</section>
	<section class="container">
		<div class="page-header">
			<h1 class="text-center">Aplicativos</h1>
		</div>
		<c:if test="${pesquisa != null && pesquisa != ''}">
			<blockquote class="warning">
				<p>Sua pesquisa: <span class="label label-default"><c:out value="${pesquisa}" /></span></p>
			</blockquote>
		</c:if>
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
	
		<table class="table table-striped table-hover text-center">
			<thead>
				<tr>
					<th class="text-center">Código</th>
					<th class="text-center">Nome</th>
					<th class="text-center">Quantidade de Downloads</th>
					<th class="text-center">Desenvolvedor</th>
					<th class="text-center">Categoria</th>
					<th class="text-center">Detalhes</th>
					<c:if test="${loginedUser.nome != null}">
						<th class="text-center">Comprar</th>
					</c:if>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${aplicativos}" var="aplicativo">
					<tr<c:if test="${aplicativosComprados.contains(aplicativo.idAplicativo)}"> class="success"</c:if><c:if test="${aplicativosDesenvolvidos.contains(aplicativo.idAplicativo)}"> class="info"</c:if>>
						<td>${aplicativo.idAplicativo}</td>
						<td class="nomeAplicativo"><c:out value="${aplicativo.nome}" /></td>
						<td>${aplicativo.qtdDownloads}</td>
						<td class="nomeDesenvolvedor">${aplicativo.desenvolvedor}</td>
						<td class="nomeCategoria">${aplicativo.categoria}</td>
						<td class="text-center">
							<a href="${pageContext.request.contextPath}/detalhes-aplicativo?idAplicativo=${aplicativo.idAplicativo}">
								<i class="fa fa-file-text-o" aria-hidden="true" title="Ver mais detalhes"></i>
							</a>
						</td>
						<c:if test="${loginedUser.nome != null}">
							<td class="text-center">
								<c:choose>
									<c:when test="${!aplicativosComprados.contains(aplicativo.idAplicativo) && !aplicativosDesenvolvidos.contains(aplicativo.idAplicativo)}">
										<a href="${pageContext.request.contextPath}/compra-aplicativo?idAplicativo=${aplicativo.idAplicativo}">
											<i class="fa fa-usd" aria-hidden="true" title="Comprar"></i>
										</a>
									</c:when>
									<c:otherwise>
										<i class="fa fa-check text-success" aria-hidden="true" title="Aplicativo já adquirido"></i>
									</c:otherwise>
								</c:choose>
							</td>
						</c:if>
					
				</c:forEach>
			</tbody>
		</table>
	</section>

	<jsp:include page="_footer.jsp"></jsp:include>
	<script>
		String.prototype.splice = function(idx, rem, str) {
		    return this.slice(0, idx) + str + this.slice(idx + Math.abs(rem));
		};

    	var pesquisa = '<c:out value="${pesquisa}" />';
		
    	var nomeAplicativo = document.getElementsByClassName("nomeAplicativo");
    	for (var i = 0; i < nomeAplicativo.length; i++) {
    		var nomeAplicativoStr = nomeAplicativo[i].innerHTML;
        	
        	var indexNomeAplicativo = nomeAplicativoStr.search(new RegExp(pesquisa, "i"));
        	if(indexNomeAplicativo >= 0){
        		nomeAplicativoStr = nomeAplicativoStr.splice(indexNomeAplicativo + pesquisa.length, 0, "</span>");
        		nomeAplicativoStr = nomeAplicativoStr.splice(indexNomeAplicativo, 0, "<span style=\"background-color: yellow;\">");
    	    	document.getElementsByClassName("nomeAplicativo")[i].innerHTML = nomeAplicativoStr;
        	}
    	}
    	
    	var nomeDesenvolvedor = document.getElementsByClassName("nomeDesenvolvedor");
    	for (var i = 0; i < nomeDesenvolvedor.length; i++) {
    		var nomeDesenvolvedorStr = nomeDesenvolvedor[i].innerHTML;
        	
        	var indexNomeDesenvolvedor = nomeDesenvolvedorStr.search(new RegExp(pesquisa, "i"));
        	if(indexNomeDesenvolvedor >= 0){
        		nomeDesenvolvedorStr = nomeDesenvolvedorStr.splice(indexNomeDesenvolvedor + pesquisa.length, 0, "</span>");
        		nomeDesenvolvedorStr = nomeDesenvolvedorStr.splice(indexNomeDesenvolvedor, 0, "<span style=\"background-color: yellow;\">");
    	    	document.getElementsByClassName("nomeDesenvolvedor")[i].innerHTML = nomeDesenvolvedorStr;
        	}
    	}
    	
    	var nomeCategoria = document.getElementsByClassName("nomeCategoria");
    	for (var i = 0; i < nomeCategoria.length; i++) {
    		var nomeCategoriaStr = nomeCategoria[i].innerHTML;

        	var indexNomeCategoria = nomeCategoriaStr.search(new RegExp(pesquisa, "i"));
        	if(indexNomeCategoria >= 0){
        		nomeCategoriaStr = nomeCategoriaStr.splice(indexNomeCategoria + pesquisa.length, 0, "</span>");
        		nomeCategoriaStr = nomeCategoriaStr.splice(indexNomeCategoria, 0, "<span style=\"background-color: yellow;\">");
    	    	document.getElementsByClassName("nomeCategoria")[i].innerHTML = nomeCategoriaStr;
        	}
    	}
    </script>
</body>
</html>