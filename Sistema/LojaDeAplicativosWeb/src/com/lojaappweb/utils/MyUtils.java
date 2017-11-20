package com.lojaappweb.utils;

//Importa todas as bibliotecas necessárias
import java.io.IOException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.sql.Connection;

import javax.servlet.ServletRequest;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lojaappweb.beans.Usuario;
 
public class MyUtils {
	// Define constantes
    public static final String ATT_NAME_CONNECTION = "ATTRIBUTE_FOR_CONNECTION";
    private static final String ATT_NAME_USER_NAME = "ATTRIBUTE_FOR_STORE_USER_NAME_IN_COOKIE";
 
    public static void storeConnection(ServletRequest request, Connection conn) {
        // Salva conexão no atributo de requisição (Informações salvas só existem durante requisições)
        request.setAttribute(ATT_NAME_CONNECTION, conn);
    }
 
    public static Connection getStoredConnection(ServletRequest request) {
    	// Busca o objeto de conexão que foi salvo em atributo de requisição
        Connection conn = (Connection) request.getAttribute(ATT_NAME_CONNECTION);
        return conn;
    }
 
    public static void storeLoginedUser(HttpSession session, Usuario loginedUser) {
    	// Salva informações de usuário em sessão
        // Pode ser acessado no JSP via ${loginedUser}
        session.setAttribute("loginedUser", loginedUser);
    }
    
    public static void deleteStoreLoginedUser(HttpSession session){
    	// Apaga informações de usuário da sessão 
    	if (session != null) {
    	    session.invalidate();
    	}
    }
 
    public static Usuario getLoginedUser(HttpSession session) {
    	// Busca informações de usuário salvas em sessão
    	Usuario loginedUser = (Usuario) session.getAttribute("loginedUser");
        return loginedUser;
    }
 
    public static void storeUserCookie(HttpServletResponse response, Usuario usuario) {
    	// Salva informações em Cookie
        Cookie cookieUserName = new Cookie(ATT_NAME_USER_NAME, usuario.getNome());
        // 1 dia (convertido em segundos)
        cookieUserName.setMaxAge(24 * 60 * 60);
        response.addCookie(cookieUserName);
    }
 
    public static String getUserNameInCookie(HttpServletRequest request) {
    	// Busca nome de usuário salvo em cookie
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (ATT_NAME_USER_NAME.equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }
 
    public static void deleteUserCookie(HttpServletResponse response) {
    	// Apaga cookie
        Cookie cookieUserName = new Cookie(ATT_NAME_USER_NAME, null);
        // 0 segundos (este cookie expira imediatamente)
        cookieUserName.setMaxAge(0);
        response.addCookie(cookieUserName);
    }
    
    public static Usuario validaUsuarioLogado(HttpServletRequest request, HttpServletResponse response) throws IOException {
    	// Valida se existe usuário logado e retorna suas informações
    	HttpSession session = request.getSession();
        Usuario loginedUser = getLoginedUser(session);
        if(loginedUser == null){
        	response.sendRedirect(request.getContextPath() + "/login");
        }
        return loginedUser;
    }
    
    public static String criptografarSenha(String senha){
    	// Criptografa senha em MD5
    	String senhaCript = null;

        try{
	    	MessageDigest md = MessageDigest.getInstance("MD5");
	    	md.reset();
	    	md.update(senha.getBytes());
	    	byte[] digest = md.digest();
	    	BigInteger bigInt = new BigInteger(1,digest);
	    	senhaCript = bigInt.toString(16);
	    	while(senhaCript.length() < 32 ){
	    		senhaCript = "0" + senhaCript;
    		}
	    	
        } catch(Exception e){}
        
        return senhaCript;
    }
    
    public static String getMensagemSucesso(HttpSession session){
    	// Busca mensagem de sucesso armazenada em sessão
		Object mensagemSucessoObj = session.getAttribute("mensagemSucesso");
		
		String mensagemSucesso = null;
		if(mensagemSucessoObj != null){
			mensagemSucesso = mensagemSucessoObj.toString();
			// Apaga mensagem da sessão
 	   		session.removeAttribute("mensagemSucesso");
 	   	}
		
		return mensagemSucesso;
    }
    
    public static String getMensagemErro(HttpSession session){
    	// Busca mensagem de erro armazenada em sessão
		Object mensagemErroObj = session.getAttribute("mensagemErro");
		
		String mensagemErro = null;
		if(mensagemErroObj != null){
			mensagemErro = mensagemErroObj.toString();
			// Apaga mensagem da sessão
 	    	session.removeAttribute("mensagemErro");
 	   	}
        
        return mensagemErro;
    }
}