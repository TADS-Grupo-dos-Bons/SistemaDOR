/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ws;

import Classes.Cliente;
import Classes.ClienteDAO;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.Produces;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PUT;
import javax.ws.rs.core.MediaType;

/**
 * REST Web Service
 *
 * @author Junior
 */
@Path("inativar")
public class InativarResource {

    @Context
    private UriInfo context;

    /**
     * Creates a new instance of InativarResource
     */
    public InativarResource() {
    }
    
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public void postJson(Cliente cliente) {
        
        ClienteDAO ClienteDAO = new ClienteDAO();
        ClienteDAO.inativarWS(cliente);
    }

    /**
     * Retrieves representation of an instance of ws.InativarResource
     * @return an instance of java.lang.String
     */
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public String getJson() {
        //TODO return proper representation object
        throw new UnsupportedOperationException();
    }

    /**
     * PUT method for updating or creating an instance of InativarResource
     * @param content representation for the resource
     */
    @PUT
    @Consumes(MediaType.APPLICATION_JSON)
    public void putJson(String content) {
    }
}
