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
@WebServlet(urlPatterns = { "/login" })
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Construtor
    public LoginServlet() {
        super();
    }

    // Sobrecarga
	// Método executado quando a página é acessada
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// Busca dados de sessão
    	HttpSession session = request.getSession();
 	   	// Define variáveis a serem utilizadas na view
    	request.setAttribute("mensagemSucesso", MyUtils.getMensagemSucesso(session));
        request.setAttribute("paginaAtual", "login");

        // Define qual arquivo .jsp deve ser utilizado ao acessar URL de acesso ao servlet (/login)
        RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/WEB-INF/views/loginView.jsp");
        dispatcher.forward(request, response);
    }

    // Sobrecarga
	// Método executado quando um formulário é submetido da página para ela mesma
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Captura valores das variáveis enviadas à página
        String login = request.getParameter("login");
        String senha = request.getParameter("senha");
        String rememberMeStr = request.getParameter("rememberMe");
        boolean remember = "Y".equals(rememberMeStr);
 
        // Instancia classe Usuario
        Usuario usuario = null;
        // Inicializa variáveis de erro
        String mensagemErro = null;
 
        if (login == null || senha == null || login.length() == 0 || senha.length() == 0) {
        	// Se login ou senha não forem informados, incrementa variáveis de erro
            mensagemErro = "Informe usuário e senha.";
        } else {
        	// Se login e senha forem informados, executa este trecho de código
        	// Busca dados de conexão com o BD
            Connection conn = MyUtils.getStoredConnection(request);
            try {
        		// Criptografa senha informada
            	String senhaCript = MyUtils.criptografarSenha(senha);
        		// Busca usuário com login e senha informados
                usuario = UsuarioModel.getDadosUsuario(conn, login, senhaCript);

                if (usuario == null) {
                	// Se não encontrar usuário, incrementa variáveis de erro
                    mensagemErro = "Usuário ou senha inválidos!";
                }
            } catch (SQLException e) {
            	// Define mensagem de erro para comandos SQL com erro
                e.printStackTrace();
                mensagemErro = e.getMessage();
            }
        }
        // Caso alguma mensagem de erro for definida, mantem-se na página de login
        if (mensagemErro != null) {
     	   	// Define variáveis a serem utilizadas na view
            request.setAttribute("mensagemErro", mensagemErro);
            request.setAttribute("login", login);

            // Define qual arquivo .jsp deve ser utilizado ao acessar URL de acesso ao servlet (/login)
            RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/WEB-INF/views/loginView.jsp");
            dispatcher.forward(request, response);
        }
        // Caso não haja erros, define mensagem de sucesso e redireciona para página meus-aplicativos
        else {
        	// Busca dados de sessão
            HttpSession session = request.getSession();
            // Salva dados de usuário em sessão
            MyUtils.storeLoginedUser(session, usuario);
 
            // Se usuário marcar "Lembrar de mim"
            if (remember) {
            	// Salva cookies de usuário
                MyUtils.storeUserCookie(response, usuario);
            }
            // Se usuário não marcar "Lembrar de mim"
            else {
            	// Apaga cookies de usuário salvos na memória
                MyUtils.deleteUserCookie(response);
            }

        	// Redireciona para página meus-aplicativos
            response.sendRedirect(request.getContextPath() + "/meus-aplicativos");
        }
    }
}