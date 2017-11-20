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

import java.util.List;

import com.lojaappweb.beans.Aplicativo;
import com.lojaappweb.beans.Usuario;
import com.lojaappweb.beans.Categoria;
import com.lojaappweb.model.AplicativoModel;
import com.lojaappweb.model.CategoriaModel;
import com.lojaappweb.utils.MyUtils;

//Define URL de acesso ao servlet
@WebServlet(urlPatterns = { "/cadastra-aplicativo" })
public class CadastraAplicativoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Construtor
    public CadastraAplicativoServlet() {
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

    	// Busca dados de conexão com o BD
        Connection conn = MyUtils.getStoredConnection(request);

        // Inicializa variável de erro 
        String mensagemErro = null;
        List<Categoria> listaCategorias = null;
        try{
            // Busca lista de categorias cadastradas no BD
        	listaCategorias = CategoriaModel.listaCategorias(conn);
        } catch(SQLException e){
        	// Define mensagem de erro para comandos SQL com erro
        	e.printStackTrace();
            mensagemErro = e.getMessage();
        }

 	   	// Define variáveis a serem utilizadas na view
        request.setAttribute("mensagemErro", mensagemErro);
        request.setAttribute("loginedUser", loginedUser);
        request.setAttribute("listaCategorias", listaCategorias);

        // Define qual arquivo .jsp deve ser utilizado ao acessar URL de acesso ao servlet (/cadastra-aplicativo)
        RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/WEB-INF/views/cadastraAplicativoView.jsp");
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
    	// Busca dados de conexão com o BD
        Connection conn = MyUtils.getStoredConnection(request);

        // Captura valores das variáveis enviadas à página
        String idCategoriaStr = (String) request.getParameter("idCategoria");
        String nome = (String) request.getParameter("nome");
        String descricao = (String) request.getParameter("descricao");
        
        // Inicializa variáveis locais
        int idDesenvolvedor = loginedUser.getIdUsuario(), idCategoria = 0;
        
        try {
        	// Converte variáveis enviadas à página
          idCategoria = Integer.parseInt(idCategoriaStr);
        } catch (Exception e) {
        }
        // Instancia classe Aplicativo passando valores idDesenvolvedor, idCategoria, nome e descricao
        Aplicativo aplicativo = new Aplicativo(idDesenvolvedor, idCategoria, nome, descricao);

        // Inicializa variável de erro 
        String mensagemErro = null;
        try {
        	// Cadastra aplicativo
          AplicativoModel.cadastrarAplicativo(conn, aplicativo);
        } catch (SQLException e) {
        	// Define mensagem de erro para comandos SQL com erro
            e.printStackTrace();
            mensagemErro = e.getMessage();
        }

 	   	// Define variáveis a serem utilizadas na view
        request.setAttribute("mensagemErro", mensagemErro);

        // Caso alguma mensagem de erro for definida, mantem-se na página de cadastro de aplicativo
        if (mensagemErro != null) {
            // Define qual arquivo .jsp deve ser utilizado ao acessar URL de acesso ao servlet (/cadastra-aplicativo)
            RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/WEB-INF/views/cadastraAplicativoView.jsp");
            dispatcher.forward(request, response);
        }
        // Caso não haja erros, define mensagem de sucesso e redireciona para página home
        else {
        	// Busca dados de sessão
        	HttpSession session = request.getSession();
        	// Define mensagem de sucesso
            String mensagemSucesso = "Aplicativo cadastrado com sucesso.";
        	session.setAttribute("mensagemSucesso", mensagemSucesso);
        	// Redireciona para página home
            response.sendRedirect(request.getContextPath() + "/");
        }
    }
 
}