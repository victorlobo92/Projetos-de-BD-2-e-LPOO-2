package com.lojaappweb.servlet;

//Importa todas as bibliotecas necessárias
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import com.lojaappweb.beans.Usuario;
import com.lojaappweb.utils.MyUtils;

//Define URL de acesso ao servlet
@WebServlet(urlPatterns = { "/minha-conta" })
public class MinhaContaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Construtor
    public MinhaContaServlet() {
        super();
    }

    // Sobrecarga
	// Método executado quando a página é acessada
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// Busca dados do usuário
    	Usuario loginedUser = MyUtils.validaUsuarioLogado(request, response);
    	if(loginedUser == null){
    		return;
    	}

    	// Busca dados de sessão
 	   	HttpSession session = request.getSession();

 	   	// Define variáveis a serem utilizadas na view
        request.setAttribute("user", loginedUser);
        request.setAttribute("mensagemSucesso", MyUtils.getMensagemSucesso(session));
        request.setAttribute("paginaAtual", "minha-conta");

        // Define qual arquivo .jsp deve ser utilizado ao acessar URL de acesso ao servlet (/minha-conta)
        RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/WEB-INF/views/minhaContaView.jsp");
        dispatcher.forward(request, response);
 
    }

    // Sobrecarga
	// Método executado quando um formulário é submetido da página para ela mesma
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
 	   // Chama método doGet()
        doGet(request, response);
    }
 
}