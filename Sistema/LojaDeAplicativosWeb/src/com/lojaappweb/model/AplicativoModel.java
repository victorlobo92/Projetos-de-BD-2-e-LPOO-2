package com.lojaappweb.model;

//Importa todas as bibliotecas necessárias
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.lojaappweb.beans.Aplicativo;

public class AplicativoModel {
    public static List<Aplicativo> getAplicativosSimples(Connection conn) throws SQLException {
    	// Busca informações dos aplicativos na view vwAplicativosSimples
        String sql = "SELECT * FROM vwAplicativosSimples";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
 
        ResultSet rs = pstm.executeQuery();
        List<Aplicativo> list = new ArrayList<Aplicativo>();
        while (rs.next()) {
            int idAplicativo = rs.getInt("idAplicativo");
            String nome = rs.getString("aplicativo");
            int qtdDownloads = rs.getInt("qtdDownloads");
            String desenvolvedor = rs.getString("desenvolvedor");
            String categoria = rs.getString("categoria");
            
            Aplicativo aplicativo = new Aplicativo(nome, qtdDownloads);
            
            aplicativo.setIdAplicativo(idAplicativo);
            aplicativo.setDesenvolvedor(desenvolvedor);
            aplicativo.setCategoria(categoria);
            
            list.add(aplicativo);
        }
        return list;
    }
    
    public static List<Aplicativo> meusAplicativos(Connection conn, int idUsuario) throws SQLException {
    	// Busca informações dos aplicativos do usuário logado
    	String sql = "SELECT idAplicativo, aplicativo "
    			+ "FROM vwAplicativosUsuario "
    			+ "WHERE idUsuario = " + idUsuario;
    	
        PreparedStatement pstm = conn.prepareStatement(sql);
 
        ResultSet rs = pstm.executeQuery();
        List<Aplicativo> list = new ArrayList<Aplicativo>();
        while (rs.next()) {
            int idAplicativo = rs.getInt("idAplicativo");
            String nome = rs.getString("aplicativo");
            Aplicativo aplicativo = new Aplicativo();

            aplicativo.setIdAplicativo(idAplicativo);
            aplicativo.setNome(nome);
            
            list.add(aplicativo);
        }
    	return list;
    }
    
    public static List<Aplicativo> aplicativosDesenvolvidos(Connection conn, int idUsuario) throws SQLException {
    	// Busca informações dos aplicativos desenvolvidos pelo usuário logado
    	String sql = "SELECT idAplicativo, nome "
    			+ "FROM aplicativo "
    			+ "WHERE idDesenvolvedor = " + idUsuario;
    	
        PreparedStatement pstm = conn.prepareStatement(sql);
 
        ResultSet rs = pstm.executeQuery();
        List<Aplicativo> list = new ArrayList<Aplicativo>();
        while (rs.next()) {
            int idAplicativo = rs.getInt("idAplicativo");
            String nome = rs.getString("nome");
            Aplicativo aplicativo = new Aplicativo();

            aplicativo.setIdAplicativo(idAplicativo);
            aplicativo.setNome(nome);
            
            list.add(aplicativo);
        }
    	return list;
    }
    public static List<Aplicativo> pesquisaAplicativo(Connection conn, String pesquisa) throws SQLException {
    	// Busca aplicativos nome do aplicativo, nome do desenvolvedor ou categoria coincidem com o termo pesquisado
        String sql = "SELECT A.*, U.nome as desenvolvedor, C.categoria "
        		+ "FROM aplicativo as A "
        		+ "JOIN usuario as U "
        		+ "ON A.idDesenvolvedor = U.idUsuario "
        		+ "JOIN categoria as C "
        		+ "ON A.idCategoria = C.idCategoria "
        		+ "WHERE A.nome like '%" + pesquisa + "%' "
				+ "OR A.descricao like '%" + pesquisa + "%' "
				+ "OR U.nome like '%" + pesquisa + "%' "
				+ "OR C.categoria like '%" + pesquisa + "%'";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
 
        ResultSet rs = pstm.executeQuery();
        List<Aplicativo> list = new ArrayList<Aplicativo>();
        while (rs.next()) {
            int idAplicativo = rs.getInt("idAplicativo");
            String nome = rs.getString("nome");
            int qtdDownloads = rs.getInt("qtdDownloads");
            String desenvolvedor = rs.getString("desenvolvedor");
            String categoria = rs.getString("categoria");
            
            Aplicativo aplicativo = new Aplicativo(nome, qtdDownloads);
            
            aplicativo.setIdAplicativo(idAplicativo);
            aplicativo.setDesenvolvedor(desenvolvedor);
            aplicativo.setCategoria(categoria);
            
            list.add(aplicativo);
        }
        return list;
    }
 
    public static Aplicativo getDadosAplicativo(Connection conn, int idAplicativo) throws SQLException {
    	// Busca informações de um aplicativos específico
        String sql = "SELECT A.idDesenvolvedor, A.idCategoria, A.nome, A.descricao, A.qtdDownloads, A.dataHora, D.nome as desenvolvedor, C.categoria "
                + "FROM aplicativo A "
                + "INNER JOIN usuario as D "
                + "ON A.idDesenvolvedor = D.idUsuario "
                + "INNER JOIN categoria as C "
                + "ON A.idCategoria = C.idCategoria "
                + "WHERE A.idAplicativo=?";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
        pstm.setInt(1, idAplicativo);
 
        ResultSet rs = pstm.executeQuery();
 
        while (rs.next()) {
            int idDesenvolvedor = rs.getInt("idDesenvolvedor");
            int idCategoria= rs.getInt("idCategoria");
            String desenvolvedor = rs.getString("desenvolvedor");
            String categoria = rs.getString("categoria");
            String nome = rs.getString("nome");
            String descricao = rs.getString("descricao");
            int qtdDownloads = rs.getInt("qtdDownloads");
            String dataHora = rs.getString("dataHora");
            
            Aplicativo aplicativo = new Aplicativo(idDesenvolvedor, idCategoria, nome, descricao);
            aplicativo.setIdAplicativo(idAplicativo);
            aplicativo.setDesenvolvedor(desenvolvedor);
            aplicativo.setCategoria(categoria);
            aplicativo.setQtdDownloads(qtdDownloads);
            aplicativo.setDataHora(dataHora);
            return aplicativo;
        }
        return null;
    }
 
    public static void atualizarAplicativo(Connection conn, Aplicativo aplicativo) throws SQLException {
    	// Atualiza informações de um aplicativos específico
        String sql = "Update aplicativo set idCategoria = ?, nome = ?, descricao = ? where idAplicativo = ? ";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
 
        pstm.setInt(1, aplicativo.getIdCategoria());
        pstm.setString(2, aplicativo.getNome());
        pstm.setString(3, aplicativo.getDescricao());
        pstm.setInt(4, aplicativo.getIdAplicativo());
        pstm.executeUpdate();
    }
 
    public static void cadastrarAplicativo(Connection conn, Aplicativo aplicativo) throws SQLException {
    	// Cadastra novo aplicativo
        String sql = "Insert into aplicativo(idDesenvolvedor, idCategoria, nome, descricao, preco, desconto) values (?,?,?,?,?,?)";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
 
        pstm.setInt(1, aplicativo.getIdDesenvolvedor());
        pstm.setInt(2, aplicativo.getIdCategoria());
        pstm.setString(3, aplicativo.getNome());
        pstm.setString(4, aplicativo.getDescricao());
        pstm.setDouble(5, 0);
        pstm.setDouble(6, 0);
 
        pstm.executeUpdate();
    }
}
