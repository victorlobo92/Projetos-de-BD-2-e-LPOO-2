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
import com.lojaappweb.beans.Categoria;
import com.lojaappweb.beans.Usuario;
import com.lojaappweb.model.AplicativoModel;
import com.lojaappweb.model.CategoriaModel;
import com.lojaappweb.utils.MyUtils;

//Define URL de acesso ao servlet
@WebServlet(urlPatterns = { "/edita-aplicativo" })
public class EditaAplicativoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Construtor
    public EditaAplicativoServlet() {
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

        // Captura valores das variáveis enviadas à página
        String idAplicativoStr = (String) request.getParameter("idAplicativo");

        // Inicializa variáveis locais
        int idAplicativo = 0;
        
        try {
        	// Converte variáveis enviadas à página
            idAplicativo = Integer.parseInt(idAplicativoStr);
        } catch (Exception e) {
        }
        
        // Instancia classe Aplicativo
        Aplicativo aplicativo = null;

        // Inicializa variável de erro 
        String mensagemErro = null;
 
        try {
        	// Busca dados do aplicativo pelo idAplicativo
            aplicativo = AplicativoModel.getDadosAplicativo(conn, idAplicativo);
        } catch (SQLException e) {
        	// Define mensagem de erro para comandos SQL com erro
            e.printStackTrace();
            mensagemErro = e.getMessage();
        }
        

        List<Categoria> listaCategorias = null;
        try{
            // Busca lista de categorias cadastradas no BD
        	listaCategorias = CategoriaModel.listaCategorias(conn);
        } catch(SQLException e){
        	// Define mensagem de erro para comandos SQL com erro
        	e.printStackTrace();
            mensagemErro = e.getMessage();
        }

        /* Caso alguma não existir aplicativo com idAplicativo informado cadastrado no BD ou o desenvolvedor do aplicativo
        ** não for o usuário logado, redireciona para página meus-aplicativos */
        if (aplicativo == null || aplicativo.getIdDesenvolvedor() != loginedUser.getIdUsuario()) {
        	// Redireciona para página meus-aplicativos
            response.sendRedirect(request.getContextPath() + "/meus-aplicativos");
            return;
        }

 	   	// Define variáveis a serem utilizadas na view
        request.setAttribute("mensagemErro", mensagemErro);
        request.setAttribute("aplicativo", aplicativo);
        request.setAttribute("listaCategorias", listaCategorias);

        // Define qual arquivo .jsp deve ser utilizado ao acessar URL de acesso ao servlet (/edita-aplicativo)
        RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/WEB-INF/views/editaAplicativoView.jsp");
        dispatcher.forward(request, response);
    }

    // Sobrecarga
	// Método executado quando um formulário é submetido da página para ela mesma
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// Busca dados de conexão com o BD
        Connection conn = MyUtils.getStoredConnection(request);

        // Captura valores das variáveis enviadas à página
        String idAplicativoStr = (String) request.getParameter("idAplicativo");
        String idCategoriaStr = (String) request.getParameter("idCategoria");
        String nome = (String) request.getParameter("nome");
        String descricao = (String) request.getParameter("descricao");

        // Inicializa variáveis locais
        int idAplicativo = 0, idDesenvolvedor = 0, idCategoria = 0;
        
        try {
        	// Converte variáveis enviadas à página
            idAplicativo = Integer.parseInt(idAplicativoStr);
            idCategoria = Integer.parseInt(idCategoriaStr);
        } catch (Exception e) {}

        // Instancia classe Aplicativo passando valores idDesenvolvedor, idCategoria, nome e descricao
        Aplicativo aplicativo = new Aplicativo(idDesenvolvedor, idCategoria, nome, descricao);
        // Define idAplicativo do objeto aplicativo
        aplicativo.setIdAplicativo(idAplicativo);

        // Inicializa variável de erro 
        String mensagemErro = null;
 
        try {
        	// Atualiza aplicativo
            AplicativoModel.atualizarAplicativo(conn, aplicativo);
        } catch (SQLException e) {
        	// Define mensagem de erro para comandos SQL com erro
            e.printStackTrace();
            mensagemErro = e.getMessage();
        }
 	   	// Define variáveis a serem utilizadas na view
        request.setAttribute("mensagemErro", mensagemErro);
        request.setAttribute("aplicativo", aplicativo);

        // Caso alguma mensagem de erro for definida, mantem-se na página de edição de aplicativo
        if (mensagemErro != null) {
            // Define qual arquivo .jsp deve ser utilizado ao acessar URL de acesso ao servlet (/edita-aplicativo)
            RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/WEB-INF/views/editaAplicativoView.jsp");
            dispatcher.forward(request, response);
        }
        // Caso não haja erros, define mensagem de sucesso e redireciona para página meus-aplicativos
        else {
        	// Busca dados de sessão
        	HttpSession session = request.getSession();
        	// Define mensagem de sucesso
            String mensagemSucesso = "Aplicativo alterado com sucesso.";
        	session.setAttribute("mensagemSucesso", mensagemSucesso);
        	// Redireciona para página home
            response.sendRedirect(request.getContextPath() + "/meus-aplicativos");
        }
    }
}