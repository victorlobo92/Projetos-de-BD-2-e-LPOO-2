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

import com.lojaappweb.beans.Aplicativo;
import com.lojaappweb.model.AplicativoModel;
import com.lojaappweb.utils.MyUtils;

//Define URL de acesso ao servlet
@WebServlet(urlPatterns = { "/detalhes-aplicativo"})
public class DetalhesAplicativoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// Construtor
	public DetalhesAplicativoServlet() {
		super();
	}

	// Sobrecarga
	// Método executado quando a página é acessada
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Busca url de origem
		String referrer = (request.getHeader("referer") != null)? request.getHeader("referer") : request.getContextPath();
		// Busca final da url com objetivo de identificar se origem é meus-aplicativos (16 caracteres)
		String origin = referrer.substring(referrer.length() - 16);

		// Busca dados de conexão com o BD
		Connection conn = MyUtils.getStoredConnection(request);

		// Captura valores das variáveis enviadas à página
		String idAplicativoStr = (String) request.getParameter("idAplicativo");
		// Inicializa variáveis locais
		int idAplicativo = 0;

		try {
			// Converte variáveis enviadas à página
			idAplicativo = Integer.parseInt(idAplicativoStr);
		} catch (Exception e) {}

		// Inicializa variável de erro 
		String mensagemErro = null;
		try {
			// Busca dados do aplicativo pelo idAplicativo 
			Aplicativo aplicativo = AplicativoModel.getDadosAplicativo(conn, idAplicativo);

			// Define variáveis a serem utilizadas na view
			request.setAttribute("mensagemErro", mensagemErro);
			request.setAttribute("aplicativo", aplicativo);
			request.setAttribute("referrer", referrer);
			request.setAttribute("origin", origin);
		} catch (SQLException e) {
			// Define mensagem de erro para comandos SQL com erro
            e.printStackTrace();
            mensagemErro = e.getMessage();
		}

		// Define qual arquivo .jsp deve ser utilizado ao acessar URL de acesso ao servlet (/detalhes-aplicativo)
		RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/WEB-INF/views/detalhesAplicativoView.jsp");
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