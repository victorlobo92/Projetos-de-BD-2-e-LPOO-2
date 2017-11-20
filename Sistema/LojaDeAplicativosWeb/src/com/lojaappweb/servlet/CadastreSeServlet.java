package com.lojaappweb.servlet;

//Importa todas as bibliotecas necessárias
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lojaappweb.beans.Usuario;
import com.lojaappweb.model.UsuarioModel;
import com.lojaappweb.utils.MyUtils;

//Define URL de acesso ao servlet
@WebServlet(urlPatterns = { "/cadastre-se" })
public class CadastreSeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

 // Define URL de acesso ao servlet
    public CadastreSeServlet() {
        super();
    }

    // Sobrecarga
	// Método executado quando a página é acessada
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
 	   	// Define variáveis a serem utilizadas na view
    	request.setAttribute("paginaAtual", "cadastre-se");
        // Define qual arquivo .jsp deve ser utilizado ao acessar URL de acesso ao servlet (/cadastre-se)
    	RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/WEB-INF/views/cadastreSeView.jsp");
        dispatcher.forward(request, response);
    }

    // Sobrecarga
	// Método executado quando um formulário é submetido da página para ela mesma
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// Busca dados de conexão com o BD
        Connection conn = MyUtils.getStoredConnection(request);

        // Captura valores das variáveis enviadas à página
        String nome = (String) request.getParameter("nome");
        String login = (String) request.getParameter("login");
        String senha = (String) request.getParameter("senha");
        String confirmaSenha = (String) request.getParameter("confirmaSenha");

        // Inicializa variável de erro 
        String mensagemErro = null;
        
        // Instancia classe Usuario passando parâmetros nome e login
        Usuario usuarioNovo = new Usuario(nome, login);

        // Valida se os valores de senha e confirmaSenha são idênticos
        if(!senha.equals(confirmaSenha)){
        	// Define mensagem de erro quando os valores de senha e confirmaSenha não forem idênticos
        	mensagemErro = "Senhas não conferem.";
        }
        // Valida se senha é nula
        else if(senha == null || senha == ""){
        	// Define mensagem de erro quando senha for nula
        	mensagemErro = "Senhas não pode ser nula.";
        }
        else{
        	// Inicializa classe Usuario
            Usuario usuario = null;
            try{
            	// Busca dados de usuário com base em login
            	usuario = UsuarioModel.getDadosUsuario(conn, login);
            } catch(SQLException e){
	        	// Define mensagem de erro para comandos SQL com erro
            	e.printStackTrace();
                mensagemErro = e.getMessage();
            }
	        if(usuario != null){
	        	// Se encontrar usuário com login informado, define mensagem de erro
	        	mensagemErro = "Já existe um usuário com este login cadastrado no sistema! Utilize outro login.";
	        }
	        else{
	        	// Se não encontrar usuário com login informado, criptografa senha e prossegue com cadastro
	        	String senhaCript = MyUtils.criptografarSenha(senha);
	        	
	        	// Incrementa objeto usuarioNovo informando nova senha criptografada
	        	usuarioNovo.setSenha(senhaCript);
		        try {
		        	// Cadastra usuário no BD
		        	UsuarioModel.cadastraUsuario(conn, usuarioNovo);
		        } catch (SQLException e) {
		        	// Define mensagem de erro para comandos SQL com erro
		            e.printStackTrace();
		            mensagemErro = e.getMessage();
		        }
	        }
        }

 	   	// Define variáveis a serem utilizadas na view
        request.setAttribute("mensagemErro", mensagemErro);
        request.setAttribute("usuario", usuarioNovo);

        // Caso alguma mensagem de erro for definida, mantem-se na página de cadastro de usuário
        if (mensagemErro != null) {
            // Define qual arquivo .jsp deve ser utilizado ao acessar URL de acesso ao servlet (/cadastre-se)
            RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/WEB-INF/views/cadastreSeView.jsp");
            dispatcher.forward(request, response);
        }
        // Caso não haja erros, define mensagem de sucesso e redireciona para página login
        else {
        	// Busca dados de sessão
        	HttpSession session = request.getSession();
        	// Define mensagem de sucesso
            String mensagemSucesso = "Usuário cadastrado com sucesso! Efetue o login para começar a usar o sistema.";
        	session.setAttribute("mensagemSucesso", mensagemSucesso);
        	// Redireciona para página login
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }
 
}