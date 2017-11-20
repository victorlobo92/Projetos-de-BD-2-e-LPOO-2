package com.lojaappweb.servlet;

//Importa todas as bibliotecas necessárias
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;

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
@WebServlet(urlPatterns = { "/home"})
public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

   	// Construtor
   	public HomeServlet() {
	   	super();
   	}

   	// Sobrecarga
	// Método executado quando a página é acessada
   	@Override
   	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    // Busca dados de sessão
	   	HttpSession session = request.getSession();

	   	// Busca mensagem de sucesso armazenada em sessão
	   	String mensagemSucesso = MyUtils.getMensagemSucesso(session);
	   	// Define variáveis a serem utilizadas na view
	   	request.setAttribute("mensagemSucesso", mensagemSucesso);

	   	// Busca dados do usuário
	   	Usuario loginedUser = MyUtils.getLoginedUser(session);

	   	// Busca dados de conexão com o BD
	   	Connection conn = MyUtils.getStoredConnection(request);
        // Inicializa variáveis de erro, aplicativos comprados e aplicativos desenvolvidos 
	   	String mensagemErro = null;
	   	ArrayList<Integer>
       		aplicativosCompradosIds = new ArrayList<Integer>(),
    		aplicativosDesenvolvidosIds = new ArrayList<Integer>();
	   	if(loginedUser != null){
	   		// Busca idUsuario do usuário logado
	        int idUsuario = loginedUser.getIdUsuario();
	        try {
	        	// Busca aplicativos comprados pelo usuário logado
	        	List<Aplicativo> aplicativosComprados = AplicativoModel.meusAplicativos(conn, idUsuario);
	        	// Busca aplicativos desenvolvidos pelo usuário logado
	        	List<Aplicativo> aplicativosDesenvolvidos = AplicativoModel.aplicativosDesenvolvidos(conn, idUsuario);
	            for (Aplicativo appComprado : aplicativosComprados) {
	            	// Cria lista com IDs dos aplicativos comprados pelo usuário logado
	            	aplicativosCompradosIds.add(appComprado.getIdAplicativo());
	            }
	            for (Aplicativo appDesenvolvido : aplicativosDesenvolvidos) {
	            	// Cria lista com IDs dos aplicativos desenvolvidos pelo usuário logado
	            	aplicativosDesenvolvidosIds.add(appDesenvolvido.getIdAplicativo());
	            }
	        } catch (SQLException e) {
	        	// Define mensagem de erro para comandos SQL com erro
	            e.printStackTrace();
	            mensagemErro = e.getMessage();
	        }
	   	}
	   	// Inicializa variável list
	   	List<Aplicativo> list = null;
        // Captura valor da variável pesquisa enviadas à página
	   	String pesquisa = (String) request.getParameter("pesquisa");
	   	if(pesquisa != null && pesquisa != ""){
	   		// Se houver pesquisa realizada, define variável a ser utilizada na view
	   		request.setAttribute("pesquisa", pesquisa);
	   		try {
	   			// Busca lista de aplicativos baseados na pesquisa realizada
	   			list = AplicativoModel.pesquisaAplicativo(conn, pesquisa);
	   		} catch (SQLException e) {
	        	// Define mensagem de erro para comandos SQL com erro
	   			e.printStackTrace();
	   			mensagemErro = e.getMessage();
	   		}
	   	}
	   	else{
	   		try {
	   			list = AplicativoModel.getAplicativosSimples(conn);
	   		} catch (SQLException e) {
	        	// Define mensagem de erro para comandos SQL com erro
	   			e.printStackTrace();
	   			mensagemErro = e.getMessage();
	   		}
	   	}
	   	// Busca mensagem de erro armazenada em sessão
	   	mensagemErro = MyUtils.getMensagemErro(session);
	   	// Define variáveis a serem utilizadas na view
	   	request.setAttribute("mensagemErro", mensagemErro);
	   	request.setAttribute("aplicativos", list);
	   	request.setAttribute("aplicativosComprados", aplicativosCompradosIds);
	   	request.setAttribute("aplicativosDesenvolvidos", aplicativosDesenvolvidosIds);
	   	request.setAttribute("paginaAtual", "home");

        // Define qual arquivo .jsp deve ser utilizado ao acessar URL de acesso ao servlet (/home)
	   	RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/WEB-INF/views/homeView.jsp");
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