/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.uff.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

/**
 *
 * @author HP
 */
@WebServlet(name = "UserController", urlPatterns = {"/UserController"})
public class UserController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // pega sessao
            HttpSession session = request.getSession();

            // recupera acao solicitada se existir
            String action = request.getParameter("action");

            // verifica acoes
            if ("grava".equals(action)) {
                // grava alteracoes
                request.setAttribute("msg", "Usuário gravado com sucesso!");
            } else if ("logout".equals(action)) {
                // invalida sessao
                session.invalidate();
                request.setAttribute("msg", "Usuário deslogado com sucesso!");
            } else if ("login".equals(action)) {
                // pega variaveis
                String email = request.getParameter("email");
                String password = request.getParameter("password");

                // valida login se estiver ok, executa a parte de lembrar login e seta userID se login for validos
                // define variavel de sessao do userId como o Id do usuario q se logou
                session.setAttribute("userId", "1");

                // seta cookie se solicitar para lembrar login
                if (request.getParameter("remember") != null) {
                    int durMes = 2592000;
                    Cookie ckEmail = new Cookie("loginEmail", email);
                    ckEmail.setMaxAge(durMes);
                    response.addCookie(ckEmail);
                    Cookie ckPassword = new Cookie("loginPassword", password);
                    ckPassword.setMaxAge(durMes);
                    response.addCookie(ckPassword);
                }
            }

            String redirect;
            // recupera redirect
            if (request.getAttribute("redirect") != null) {
                redirect = (String) request.getAttribute("redirect");
            } else if (request.getParameter("redirect") != null) {
                redirect = request.getParameter("redirect");
            } else {
                redirect = null;
            }

            try {
                // se tem usuario logado manda p conta caso contrario p login
                if (session.getAttribute("userId") != null) {
                    // define redirect se n foi passado
                    if (redirect == null) {
                        redirect = "conta.jsp";
                    } else {
                        response.sendRedirect(redirect);
                    }
                } else {
                    request.setAttribute("redirect", redirect);
                    redirect = "login.jsp";
                }
            } catch (Exception ex) {
                request.setAttribute("redirect", redirect);
                redirect = "login.jsp";
            }

            request.getRequestDispatcher(redirect).forward(request, response);
        } catch (Exception ex) {
            response.sendRedirect("UserController");
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
