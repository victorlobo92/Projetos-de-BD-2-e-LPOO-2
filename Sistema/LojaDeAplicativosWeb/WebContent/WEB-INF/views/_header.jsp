<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<nav class="navbar navbar-default navbar-static-top background-dark">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <img alt="Loja de Aplicativos" src="">
            </a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <c:choose>
                <c:when test="${loginedUser != null}">
                    <p class="navbar-text navbar-right">Olá, <b><a href="${pageContext.request.contextPath}/minha-conta" class="navbar-link">${loginedUser.nome}</a></b></p>
                </c:when>
                <c:otherwise>
                    <ul class="nav navbar-nav navbar-right">
                    	<li<c:if test="${paginaAtual eq 'login'}"> class="active"</c:if>><a href="${pageContext.request.contextPath}/login">Login</a></li>
            			<li<c:if test="${paginaAtual eq 'cadastre-se'}"> class="active"</c:if>><a href="${pageContext.request.contextPath}/cadastre-se">Cadastre-se</a></li>
                    </ul>
                </c:otherwise>
            </c:choose>
            <form id="pesquisa" class="navbar-form navbar-right" role="search" method="GET" action="${pageContext.request.contextPath}">
                <div class="form-group">
                    <input type="text" name="pesquisa" value="${pesquisa}" class="form-control pesquisa" placeholder="Digite sua pesquisa" required>
                </div>
                <a class="btn-pesquisa" href="javascript:;" onclick="document.getElementById('pesquisa').submit();"><i class="fa fa-search"></i></a>
            </form>
            <jsp:include page="_menu.jsp"></jsp:include>
        </div><!-- /.navbar-collapse -->
    </div>
</nav>