/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Classes;

import com.sun.glass.ui.Pixels.Format;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author allex
 */
public class UsuarioDAO {

    private String stmtUpdate = "update usuario set nome=?, usuario=?, senha=?, id_empresa=? where id=?";
    private String stmtSelect = "select * from usuario where st_usuario = 'A'";
    private String stmtInsert = "insert into usuario (nome,usuario,senha,id_empresa,st_usuario) values(?,?,?,?,?);";
    private String stmtCheckLogin = "select * from usuario where usuario =? and senha=?;";
    private String stmtSelectById = "select * from usuario where id =?";
    private String stmtDelete = "delete from usuario where id = ?";
    private String stmtUpdateExcluir = "update usuario set st_usuario = ? where id=?";
    
    public List<Usuario> getLista(Usuario user, String pesquisa) throws SQLException {
        com.mysql.jdbc.Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            con = (com.mysql.jdbc.Connection) ConnectionFactory.getConnection();
            if (!pesquisa.trim().equals("")) {

                stmtSelect = stmtSelect + "AND where nome LIKE ? ";
                stmt = con.prepareStatement(stmtSelect);
                stmt.setString(1, "%"+pesquisa+"%");

            }else{

                stmt = con.prepareStatement(stmtSelect);
            }
            rs = stmt.executeQuery();
            List<Usuario> lstusuario = new ArrayList();
           
            while (rs.next()) {
                // criando o objeto Usuario
                Usuario usuario = new Usuario();
                usuario.setId(rs.getInt("id"));
                usuario.setNome(rs.getString("nome"));
                usuario.setUsuario(rs.getString("usuario"));

                // adicionando o objeto à lista
                lstusuario.add(usuario);
            }
            return lstusuario;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                rs.close();
            } catch (Exception ex) {
                System.out.println("Erro ao fechar result set. Ex=" + ex.getMessage());
            };
            try {
                stmt.close();
            } catch (Exception ex) {
                System.out.println("Erro ao fechar stmt. Ex=" + ex.getMessage());
            };
            try {
                con.close();
            } catch (Exception ex) {
                System.out.println("Erro ao fechar conexão. Ex=" + ex.getMessage());
            };
        }

    }

    public void update(Usuario user) {
        com.mysql.jdbc.Connection con = null;
        PreparedStatement stmt = null;
        try {

            con = (com.mysql.jdbc.Connection) ConnectionFactory.getConnection();
            stmt = con.prepareStatement(stmtUpdate);
            stmt.setString(1, user.getNome());
            stmt.setString(2, user.getUsuario());
            stmt.setString(3, user.getSenha());            
            stmt.setInt(4, user.getId_empresa());
            stmt.setInt(5, user.getId());
            stmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                stmt.close();
            } catch (Exception ex) {
                System.out.println("Erro ao fechar stmt. Ex=" + ex.getMessage());
            };
            try {
                con.close();
            } catch (Exception ex) {
                System.out.println("Erro ao fechar conexão. Ex=" + ex.getMessage());
            };
        }
    }
    
    
        public void updateExcluir(Usuario user) {
        com.mysql.jdbc.Connection con = null;
        PreparedStatement stmt = null;
        try {

            con = (com.mysql.jdbc.Connection) ConnectionFactory.getConnection();
            stmt = con.prepareStatement(stmtUpdateExcluir);
            stmt.setString(1, user.getSt_usuario());
            stmt.setInt(2, user.getId());
            stmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                stmt.close();
            } catch (Exception ex) {
                System.out.println("Erro ao fechar stmt. Ex=" + ex.getMessage());
            };
            try {
                con.close();
            } catch (Exception ex) {
                System.out.println("Erro ao fechar conexão. Ex=" + ex.getMessage());
            };
        }
    }

    public void exclui(Usuario user) {
        com.mysql.jdbc.Connection con = null;
        PreparedStatement stmt = null;
        try {

            con = (com.mysql.jdbc.Connection) ConnectionFactory.getConnection();
            stmt = con.prepareStatement(stmtDelete);
            stmt.setInt(1, user.getId());
            stmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                stmt.close();
            } catch (Exception ex) {
                System.out.println("Erro ao fechar stmt. Ex=" + ex.getMessage());
            };
            try {
                con.close();
            } catch (Exception ex) {
                System.out.println("Erro ao fechar conexão. Ex=" + ex.getMessage());
            };
        }
    }

    public void insert(Usuario usuario) {
        Connection con = null;
        PreparedStatement stmt = null;
        int idObjeto = 0;
        try {
            con = ConnectionFactory.getConnection();
            stmt = con.prepareStatement(stmtInsert, Statement.RETURN_GENERATED_KEYS);

            stmt.setString(1, usuario.getNome());
            stmt.setString(2, usuario.getUsuario());
            stmt.setString(3, usuario.getSenha());
            stmt.setInt(4, usuario.getId_empresa());
            stmt.setString(5,usuario.getSt_usuario());
            stmt.execute();
            //Seta o id do sistema
            ResultSet rs = stmt.getGeneratedKeys();
            while (rs.next()) {
                idObjeto = rs.getInt(1);
            }

            usuario.setId(idObjeto);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                stmt.close();
            } catch (Exception ex) {
                System.out.println("Erro ao fechar stmt. Ex=" + ex.getMessage());
            };
            try {
                con.close();
            } catch (Exception ex) {
                System.out.println("Erro ao fechar conexão. Ex=" + ex.getMessage());
            };
        }
    }

    public Usuario getById(int id) throws ClassNotFoundException {
        Usuario usuario = new Usuario();
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            con = ConnectionFactory.getConnection();
            stmt = con.prepareStatement(stmtSelectById, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            while (rs.next()) {
                usuario.setId(rs.getInt("id"));
                usuario.setNome(rs.getString("nome"));
                usuario.setUsuario(rs.getString("usuario"));
                usuario.setSenha(rs.getString("senha"));
            }
            return usuario;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                stmt.close();
            } catch (Exception ex) {
                System.out.println("Erro ao fechar stmt. Ex=" + ex.getMessage());
            };
            try {
                con.close();
            } catch (Exception ex) {
                System.out.println("Erro ao fechar conexão. Ex=" + ex.getMessage());
            };
        }

    }

    public Usuario verificaLogin(String usu, String senha) throws ClassNotFoundException {
        Class.forName("com.mysql.jdbc.Driver");
        Usuario usuario = new Usuario();
        com.mysql.jdbc.Connection con = null;
        PreparedStatement stmt = null;

        ResultSet rs = null;
        try {
            con = (com.mysql.jdbc.Connection) ConnectionFactory.getConnection();

            stmt = con.prepareStatement(stmtCheckLogin, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, usu);
            stmt.setString(2, senha);
            rs = stmt.executeQuery();
            while (rs.next()) {
                usuario.setId(rs.getInt("id"));
                usuario.setNome(rs.getString("nome"));
                usuario.setUsuario(rs.getString("usuario"));
                usuario.setSenha(rs.getString("senha"));
                usuario.setId_empresa(rs.getInt("id_empresa"));

            }

            return usuario;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                stmt.close();
            } catch (Exception ex) {
                System.out.println("Erro ao fechar stmt. Ex=" + ex.getMessage());
            };
            try {
                con.close();
            } catch (Exception ex) {
                System.out.println("Erro ao fechar conexão. Ex=" + ex.getMessage());
            };
        }
    }

    List<Usuario> getLista(String string, String string0) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
