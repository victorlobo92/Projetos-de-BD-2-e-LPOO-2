package com.lojaappweb.servlet;

//Importa todas as bibliotecas necessárias
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lojaappweb.beans.Aplicativo;
import com.lojaappweb.beans.Usuario;
import com.lojaappweb.model.AplicativoModel;
import com.lojaappweb.utils.MyUtils;

//Define URL de acesso ao servlet
@WebServlet(urlPatterns = { "/meus-aplicativos" })
public class MeusAplicativoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Construtor
    public MeusAplicativoServlet() {
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

    	// Busca dados de conexão com o BD
        Connection conn = MyUtils.getStoredConnection(request);
        // Inicializa variáveis de erro, aplicativos comprados e aplicativos desenvolvidos 
        String mensagemErro = null;
        List<Aplicativo> aplicativosComprados = null;
        List<Aplicativo> aplicativosDesenvolvidos = null;
        if(loginedUser != null){
	   		// Busca idUsuario do usuário logado
	        int idUsuario = loginedUser.getIdUsuario();
	        try {
	        	// Busca aplicativos comprados pelo usuário logado
	        	aplicativosComprados = AplicativoModel.meusAplicativos(conn, idUsuario);
	        	// Busca aplicativos desenvolvidos pelo usuário logado
	        	aplicativosDesenvolvidos = AplicativoModel.aplicativosDesenvolvidos(conn, idUsuario);
	        } catch (SQLException e) {
	        	// Define mensagem de erro para comandos SQL com erro
	            e.printStackTrace();
	            mensagemErro = e.getMessage();
	        }
        }
 	   	// Define variáveis a serem utilizadas na view
        request.setAttribute("mensagemErro", mensagemErro);
        request.setAttribute("aplicativosComprados", aplicativosComprados);
        request.setAttribute("aplicativosDesenvolvidos", aplicativosDesenvolvidos);
 	   	request.setAttribute("mensagemSucesso", MyUtils.getMensagemSucesso(session));
        request.setAttribute("paginaAtual", "meus-aplicativos");

        // Define qual arquivo .jsp deve ser utilizado ao acessar URL de acesso ao servlet (/meus-aplicativos)
        RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/WEB-INF/views/meusAplicativosView.jsp");
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