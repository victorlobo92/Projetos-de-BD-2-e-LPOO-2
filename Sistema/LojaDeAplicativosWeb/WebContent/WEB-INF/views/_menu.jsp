<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<ul class="nav navbar-nav navbar-right">
    <li<c:if test="${paginaAtual eq 'home'}"> class="active"</c:if>>
        <a href="${pageContext.request.contextPath}/">Loja</a>
    </li>
    <c:if test="${loginedUser.nome != null}">
     	<li<c:if test="${paginaAtual eq 'meus-aplicativos'}"> class="active"</c:if>><a href="${pageContext.request.contextPath}/meus-aplicativos">Meus Aplicativos</a></li>
     	<li<c:if test="${paginaAtual eq 'minha-conta'}"> class="active"</c:if>><a href="${pageContext.request.contextPath}/minha-conta">Minha Conta</a></li>
        <li><a href="${pageContext.request.contextPath}/logout">Sair</a></li>
    </c:if>
</ul>