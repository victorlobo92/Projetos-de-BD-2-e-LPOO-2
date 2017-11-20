package com.lojaappweb.filter;

//Importa todas as bibliotecas necessárias
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
 
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
 
import com.lojaappweb.beans.Usuario;
import com.lojaappweb.model.UsuarioModel;
import com.lojaappweb.utils.MyUtils;
 
@WebFilter(filterName = "cookieFilter", urlPatterns = { "/*" })
public class CookieFilter implements Filter {
 
	// Construtor
    public CookieFilter() {
    }
 
    // Sobrecarga
    @Override
    public void init(FilterConfig fConfig) throws ServletException {
 
    }

    // Sobrecarga
    @Override
    public void destroy() {
 
    }

    // Sobrecarga
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession();
 
        Usuario userInSession = MyUtils.getLoginedUser(session);
        if (userInSession != null) {
            session.setAttribute("COOKIE_CHECKED", "CHECKED");
            chain.doFilter(request, response);
            return;
        }
 
        // Conexão criada no JDBCFilter.
        Connection conn = MyUtils.getStoredConnection(request);
 
        String checked = (String) session.getAttribute("COOKIE_CHECKED");
        if (checked == null && conn != null) {
            String nome = MyUtils.getUserNameInCookie(req);
            try {
                Usuario user = UsuarioModel.getDadosUsuario(conn, nome);
                MyUtils.storeLoginedUser(session, user);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            session.setAttribute("COOKIE_CHECKED", "CHECKED");
        }
 
        chain.doFilter(request, response);
    }
 
}