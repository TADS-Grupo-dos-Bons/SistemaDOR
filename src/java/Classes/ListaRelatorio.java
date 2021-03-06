/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Classes;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import static java.lang.System.out;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author marco.sanchotene
 */
@WebServlet(name = "ListaRelatorio", urlPatterns = {"/ListaRelatorio"})
public class ListaRelatorio extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            HttpSession sessionUsu = request.getSession();

            List<Historico> lsthistorico = new ArrayList();
            HistoricoDAO historicoDAO = new HistoricoDAO();

            String id = request.getParameter("idCliente");
//            if (pesquisa.trim().equals("")){
//                try {
//                    lstusuario = usuarioDAO.getLista(usuario,pesquisa);
//                } catch (SQLException ex) {
//                    Logger.getLogger(ListaUsuario.class.getName()).log(Level.SEVERE, null, ex);
//                }
//            }else{
            try {
                lsthistorico = historicoDAO.getListaById(id);
            } catch (SQLException ex) {
                Logger.getLogger(ListaCliente.class.getName()).log(Level.SEVERE, null, ex);
            }

//            }
            String sRet = "";
            /*for (Historico his : lsthistorico) {
                sRet += "<tr>\n"
                        + "				<td>" + his.getId() + "</td>\n"
                        + "				<td>" + his.getData() + "</td>\n"
                        + "				<td>" + his.getSt_historico()+ "</td>\n"
                        + "				<td>" + his.getId_empresa_usuario()+ "</td>\n"
                        + "			</tr>";
            }

            out.println(sRet);*/
        
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
