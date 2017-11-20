package com.lojaappweb.filter;

//Importa todas as bibliotecas necessárias
import java.io.IOException;
import java.sql.Connection;
import java.util.Collection;
import java.util.Map;
 
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
 
import com.lojaappweb.conn.ConnectionUtils;
import com.lojaappweb.utils.MyUtils;
 
@WebFilter(filterName = "jdbcFilter", urlPatterns = { "/*" })
public class JDBCFilter implements Filter {
 
    public JDBCFilter() {
    }

    // Sobrecarga
    @Override
    public void init(FilterConfig fConfig) throws ServletException {
 
    }

    // Sobrecarga
    @Override
    public void destroy() {
 
    }
 
    // Verifica se o alvo da requisição é um servlet
    private boolean needJDBC(HttpServletRequest request) {
        System.out.println("JDBC Filter");
        String servletPath = request.getServletPath();
        String pathInfo = request.getPathInfo();
        String urlPattern = servletPath;
        if (pathInfo != null) {
            urlPattern = servletPath + "/*";
        }
 
        Map<String, ? extends ServletRegistration> servletRegistrations = request.getServletContext().getServletRegistrations();
 
        // Coleção de todos os servlets no Webapp.
        Collection<? extends ServletRegistration> values = servletRegistrations.values();
        for (ServletRegistration sr : values) {
            Collection<String> mappings = sr.getMappings();
            if (mappings.contains(urlPattern)) {
                return true;
            }
        }
        return false;
    }

    // Sobrecarga
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
 
        HttpServletRequest req = (HttpServletRequest) request;
 
        // Só abre conexões para requisições especiais.
        // (Por exemplo, o caminho para o servlet, JSP, ...)
        // Evita abrir conexões para requisições comuns.
        // (Por exemplo: imagens, css, javascript, ...)
        if (this.needJDBC(req)) {
            System.out.println("Open Connection for: " + req.getServletPath());
            Connection conn = null;
            try {
                // Cria uma conexão.
                conn = ConnectionUtils.getConnection();
                // Define auto commit para false.
                conn.setAutoCommit(false);
 
                // Guarda objeto de conexão em atributo de requisição.
                MyUtils.storeConnection(request, conn);
 
                // Permite requisição ir adiante
                // (Vai para o próximo filtro ou alvo)
                chain.doFilter(request, response);
 
                // Invoca o método commit() para completar a transação com o BD.
                conn.commit();
            } catch (Exception e) {
                e.printStackTrace();
                ConnectionUtils.rollbackQuietly(conn);
                throw new ServletException();
            } finally {
                ConnectionUtils.closeQuietly(conn);
            }
        }
        // Com requisições comuns (images, css, html, ..) não precisa abrir a conexão.
        else {
            // Permite requisição ir adiante
            // (Vai para o próximo filtro ou alvo)
            chain.doFilter(request, response);
        }
 
    }
 
}