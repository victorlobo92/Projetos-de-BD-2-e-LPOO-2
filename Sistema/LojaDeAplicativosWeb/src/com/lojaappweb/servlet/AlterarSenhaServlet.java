package com.lojaappweb.servlet;

// Importa todas as bibliotecas necessárias
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

// Define URL de acesso ao servlet
@WebServlet(urlPatterns = { "/alterar-senha" })
public class AlterarSenhaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
 
    // Construtor
    public AlterarSenhaServlet() {
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
 	   	HttpSession session = request.getSession();
	   
 	   	// Busca mensagem de erro armazenada em sessão
 	   	String mensagemErro = MyUtils.getMensagemErro(session);

 	   	// Define variáveis a serem utilizadas na view
        request.setAttribute("idUsuario", loginedUser.getIdUsuario());
        request.setAttribute("mensagemErro", mensagemErro);
    	
        // Define qual arquivo .jsp deve ser utilizado ao acessar URL de acesso ao servlet (/alterar-senha)
        RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/WEB-INF/views/alterarSenhaView.jsp");
        dispatcher.forward(request, response);
    }
 
    // Sobrecarga
	// Método executado quando um formulário é submetido da página para ela mesma
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// Busca dados do usuário
    	Usuario loginedUser = MyUtils.validaUsuarioLogado(request, response); 
    	if(loginedUser == null){
    		return;
    	}
    	// Busca dados de sessão
    	HttpSession session = request.getSession();
    	// Busca dados de conexão com o BD
        Connection conn = MyUtils.getStoredConnection(request);
 
        // Captura valores das variáveis enviadas à página
        String senhaAntiga = (String) request.getParameter("senhaAntiga");
        String novaSenha = (String) request.getParameter("novaSenha");
        String confirmaNovaSenha = (String) request.getParameter("confirmaNovaSenha");

        // Inicializa variável de erro 
        String mensagemErro = null;
        // Valida se os valores de novaSenha e confirmaNovaSenha são idênticos
        if(!novaSenha.equals(confirmaNovaSenha)){
        	// Define mensagem de erro quando os valores de novaSenha e confirmaNovaSenha não forem idênticos
        	mensagemErro = "Senhas não conferem. Digite a mesma senha nos campos \"Nova Senha\" e \"Confirmar nova senha\".";
            session.setAttribute("mensagemErro", mensagemErro);
        }
        // Valida se novaSenha é nula
        else if(novaSenha == null || novaSenha == ""){
        	// Define mensagem de erro quando novaSenha for nula
        	mensagemErro = "Senhas não pode ser nula.";
            session.setAttribute("mensagemErro", mensagemErro);
        }
        // Altera senha
        else{
        	try {
        		// Criptografa senha antiga e nova senha informadas
        		String senhaAntigaCript = MyUtils.criptografarSenha(senhaAntiga);
        		String novaSenhaCript = MyUtils.criptografarSenha(novaSenha);
        		// Busca usuário com login salvo em sessão e senha antiga informada
        		Usuario dadosUsuario = UsuarioModel.getDadosUsuario(conn, loginedUser.getLogin(), senhaAntigaCript);
        		// Encontrando algum usuário, altera a senha
        		if(dadosUsuario != null){
        			// Altera senha de usuário
        			UsuarioModel.atualizarSenha(conn, loginedUser.getIdUsuario(), senhaAntigaCript, novaSenhaCript);
        		}
        		// Não encontrando usuário, define mensagem de erro
        		else{
        			// Define mensagem de erro
                    mensagemErro = "Senha incorreta! Informe sua senha atual no campo \"Senha antiga\".";
                	session.setAttribute("mensagemErro", mensagemErro);
        		}
	        } catch (SQLException e) {
	        	// Define mensagem de erro para comandos SQL com erro
	            e.printStackTrace();
	            mensagemErro = e.getMessage();
	        }
        }
 
        // Caso alguma mensagem de erro for definida, mantem-se na página de alteração de senha
        if (mensagemErro != null) {
        	response.sendRedirect(request.getContextPath() + "/alterar-senha");
        }
        // Caso não haja erros, define mensagem de sucesso e redireciona para página minha-conta
        else {
        	// Define mensagem de sucesso
            String mensagemSucesso = "Senha alterada com sucesso!";
        	session.setAttribute("mensagemSucesso", mensagemSucesso);
        	// Redireciona para página minha-conta
            response.sendRedirect(request.getContextPath() + "/minha-conta");
        }
    }
}