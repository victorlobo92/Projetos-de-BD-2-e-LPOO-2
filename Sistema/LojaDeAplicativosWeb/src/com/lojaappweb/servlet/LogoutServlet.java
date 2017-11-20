package com.lojaappweb.servlet;

//Importa todas as bibliotecas necessárias
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lojaappweb.utils.MyUtils;

//Define URL de acesso ao servlet
@WebServlet(urlPatterns = { "/logout" })
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Construtor
    public LogoutServlet() {
        super();
    }

    // Sobrecarga
	// Método executado quando a página é acessada
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// Busca dados de sessão
        HttpSession session = request.getSession();
        // Apaga dados de usuário salvos em sessão
        MyUtils.deleteStoreLoginedUser(session);
    	// Redireciona para página login
        response.sendRedirect(request.getContextPath() + "/login");
    }
}