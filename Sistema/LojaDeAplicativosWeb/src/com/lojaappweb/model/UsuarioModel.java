package com.lojaappweb.model;

//Importa todas as bibliotecas necessárias
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.lojaappweb.beans.Usuario;
 
public class UsuarioModel {
 
    public static Usuario getDadosUsuario(Connection conn, String login, String senha) throws SQLException {
    	// Busca dados de usuário pelo login e senha
        String sql = "Select U.idUsuario, U.nome from usuario U " //
                + " where U.login = ? and U.senha = ?";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
        pstm.setString(1, login);
        pstm.setString(2, senha);
        ResultSet rs = pstm.executeQuery();
 
        if (rs.next()) {
            int idUsuario = rs.getInt("idUsuario");
            String nome = rs.getString("nome");
            Usuario user = new Usuario(login);
            user.setIdUsuario(idUsuario);
            user.setNome(nome);
            return user;
        }
        return null;
    }
 
    public static Usuario getDadosUsuario(Connection conn, String login) throws SQLException {
    	// Sobrecarga
    	// Busca dados de usuário pelo login e senha
        String sql = "Select U.idUsuario, U.nome from usuario U "//
                + " where U.login = ? ";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
        pstm.setString(1, login);
 
        ResultSet rs = pstm.executeQuery();
 
        if (rs.next()) {
            int idUsuario = rs.getInt("idUsuario");
            String nome = rs.getString("nome");
            Usuario user = new Usuario(login);
            user.setIdUsuario(idUsuario);
            user.setNome(nome);
            return user;
        }
        return null;
    }
 
    public static void atualizarSenha(Connection conn, int idUsuario, String senhaAntiga, String novaSenha) throws SQLException {
    	// Atualiza senha de usuário
        String sql = "Update usuario set senha = ? where idUsuario = ? AND senha = ?";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
 
        pstm.setString(1, novaSenha);
        pstm.setInt(2, idUsuario);
        pstm.setString(3, senhaAntiga);
        pstm.executeUpdate();
    }
 
    public static void cadastraUsuario(Connection conn, Usuario usuario) throws SQLException {
    	// Cadastra novo usuário
        String sql = "Insert into usuario(nome, login, senha) values (?,?,?)";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
 
        pstm.setString(1, usuario.getNome());
        pstm.setString(2, usuario.getLogin());
        pstm.setString(3, usuario.getSenha());
 
        pstm.executeUpdate();
    }
 
}