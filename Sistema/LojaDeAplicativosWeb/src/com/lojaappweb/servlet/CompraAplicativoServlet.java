package com.lojaappweb.servlet;

//Importa todas as bibliotecas necessárias
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lojaappweb.beans.Aplicativo;
import com.lojaappweb.beans.Usuario;
import com.lojaappweb.model.CompraModel;
import com.lojaappweb.model.AplicativoModel;
import com.lojaappweb.utils.MyUtils;

//Define URL de acesso ao servlet
@WebServlet(urlPatterns = { "/compra-aplicativo" })
public class CompraAplicativoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Construtor
    public CompraAplicativoServlet() {
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
        
        int idAplicativo = 0, idUsuario = 0;

        // Instancia classe aplicativo
        Aplicativo aplicativo = new Aplicativo();
        
        try {
        	// Converte variáveis enviadas à página
        	idAplicativo = Integer.parseInt(idAplicativoStr);
        	aplicativo = AplicativoModel.getDadosAplicativo(conn, idAplicativo);
        } catch (Exception e) {
        }
        // Inicializa variável de erro 
        String mensagemErro = null;

        if(loginedUser != null){
        	// Se houver usuário salvo em sessão, captura seu idUsuario
	        idUsuario = loginedUser.getIdUsuario();
        }
        try {
        	// Realiza compra de aplicativo
          CompraModel.compraAplicativo(conn, idAplicativo, idUsuario);
        } catch (SQLException e) {
        	// Define mensagem de erro para comandos SQL com erro
            e.printStackTrace();
            mensagemErro = e.getMessage();
        }

 	   	// Define variáveis a serem utilizadas na view
        request.setAttribute("aplicativo", aplicativo);
        
    	// Busca dados de sessão
    	HttpSession session = request.getSession();
    	
        // Caso alguma mensagem de erro for definida, redireciona para página home
        if (mensagemErro != null) {
     	   	// Define variáveis a serem utilizadas na view
	        session.setAttribute("mensagemErro", mensagemErro);
        	// Redireciona para página home
        	response.sendRedirect(request.getContextPath());
        }
        // Caso não haja erros, define mensagem de sucesso e redireciona para página meus-aplicativos 
        else {
        	// Define mensagem de sucesso
            String mensagemSucesso = "Aplicativo adicionado à sua lista.";
        	session.setAttribute("mensagemSucesso", mensagemSucesso);
        	// Redireciona para página meus-aplicativos
            response.sendRedirect(request.getContextPath() + "/meus-aplicativos");
        }
    }
 
}