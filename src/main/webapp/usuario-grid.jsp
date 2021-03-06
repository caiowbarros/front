<%-- 
    Document   : produto-grid
    Created on : 02/10/2019, 02:09:29
    Author     : HP
--%>
<%@page import="java.util.ArrayList"%>
<%
    // se n tiver um usuario logado retorna p userController
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("UserController");
    }
    // mostra se tiver msg
    if (session.getAttribute("msg") != null) {
        String msg = session.getAttribute("msg").toString();
        session.setAttribute("msg", null);
        out.println("<script>alert('" + msg + "');</script>");
    }

    ArrayList<ArrayList<String>> grid = null;
    if (request.getAttribute("usuarios") != null) {
        grid = (ArrayList<ArrayList<String>>) request.getAttribute("usuarios");
    }
%>
<!-- Header -->
<jsp:include page="header.jsp">
    <jsp:param name="title" value="Minha Conta"/>
</jsp:include>

<h2 class="meus-pedidos">Minha Conta</h2>
<div class="main-user-container">
    
    <div class="left-user-container">
        <div class="left-row">
            <p style="font-weight: bold;"><%= (session.getAttribute("userRole").equals("1") ? "Lista de Cadastros" : "Meus Dados")%></p>
        </div>
        <%
            for (int i = 0; i < grid.size(); i++) {
        %>
        <div class="left-row">
            <p style="padding-bottom: 5px;"><%= grid.get(i).get(1)%></p>
            <div class="editar-row">
                <p><%= grid.get(i).get(2)%></p>
                <a href="UserController?sel=<%= grid.get(i).get(0)%>">Editar</a>
            </div>
        </div>
        <%
            }
        %>
    </div>
    
    <div class="right-user-container">
        <div class="right-row">
            <div class="user-info">
                <div class="user-info-middle" onclick="location.href='EnderecoController';">
                    <i class="fas fa-map-marker-alt"></i>
                    <p>Lista de Endere�os</p>
                </div>
            </div>
            <div class="user-info">
                <div class="user-info-middle" onclick="location.href='ProdutosController?esp=favoritos';">
                    <i class="fas fa-heart"></i>
                    <p>Favoritos</p>
                </div>
            </div>
            <div class="user-info">
                <div class="user-info-middle" onclick="location.href='CompraController?historico';">
                    <i class="fas fa-shopping-bag"></i>
                    <p>Hist�rico de Pedidos</p>
                </div>
            </div>
        </div>
        <div class="right-row">
            <!-- SE ROLE_ID DO USUARIO FOR ADM ENTAO MOSTRA CADASTRO DE PRODUTOS -->
            <% if (session.getAttribute("userRole").equals("1")) { %>
            <div class="user-info">
                <div class="user-info-middle" onclick="location.href='ProdutoAdmController';">
                    <i class="fas fa-barcode"></i>
                    <p>Cadastro de Produtos</p>
                </div>
            </div>
            <%
                }
            %>
            <div class="user-info">
                <div class="user-info-middle" onclick="Logout()">
                    <i class="fas fa-sign-out-alt"></i>
                    <p>
                        <form method="post" action="UserController">
                            <button onclick="return confirm('Tem certeza que deseja fazer o LOGOUT?');false;" type="submit" id="logout-btn" name="action" value="logout" formnovalidate>Logout</button>
                        </form>
                    </p>
                </div>
                <script>
                function Logout() {
                    document.getElementById("logout-btn").click();
                }
                </script>
            </div>
        </div>
    </div>
        
</div>
        
<!-- Footer -->
<jsp:include page="footer.jsp"></jsp:include>