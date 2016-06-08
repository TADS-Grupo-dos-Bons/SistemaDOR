
package Classes;

import java.util.Date;


/**
 *
 * @author marco.sanchotene
 */
public class Historico {
    private int id;
    private Date dtInicio;
    private Date dtFim;
    private int id_cliente;
    private int id_usuario;
    private int id_empresa_usuario;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getDtInicio() {
        return dtInicio;
    }

    public void setDtInicio(Date dtInicio) {
        this.dtInicio = dtInicio;
    }

    public Date getDtFim() {
        return dtFim;
    }

    public void setDtFim(Date dtFim) {
        this.dtFim = dtFim;
    }

    public int getId_cliente() {
        return id_cliente;
    }

    public void setId_cliente(int id_cliente) {
        this.id_cliente = id_cliente;
    }

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public int getId_empresa_usuario() {
        return id_empresa_usuario;
    }

    public void setId_empresa_usuario(int id_empresa_usuario) {
        this.id_empresa_usuario = id_empresa_usuario;
    }

    
    
}
