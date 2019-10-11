<%-- 
    Document   : produto-grid
    Created on : 02/10/2019, 02:09:29
    Author     : HP
--%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="br.uff.dao.MySql"%>
<%
    // se n usuario n for adm retorna p ProdutosController
    if (!session.getAttribute("userRole").equals("1")) {
        response.sendRedirect("UserController");
    }
    // mostra se tiver msg
    if (session.getAttribute("msg") != null) {
        String msg = session.getAttribute("msg").toString();
        session.setAttribute("msg", null);
        out.println("<script>alert('" + msg + "');</script>");
    }
%>
<!-- Header -->
<jsp:include page="header.jsp">
    <jsp:param name="title" value="Grid de Produtos"/>
</jsp:include>
<table width="100%" border="1" cellspacing="10">
    <thead>
        <tr>
            <th colspan="4"><h2>Produtos</h2></th>
        </tr>
        <tr>
            <th>Opera��es</th>
            <th>Nome</th>
            <th>Pre�o</th>
            <th>Categoria</th>
        </tr>
    </thead>
    <tbody>
        <%
            MySql db = null;
            try {
                db = new MySql("test", "root", "");
                ResultSet ret = db.dbCarrega("SELECT p.id,p.name,p.price,c.category_name FROM products p left join vw_category c on (p.category_id=c.id)", null);
                while (ret.next()) {
        %>
        <tr>
            <th>
                <a href="ProdutoAdmController?sel=<%= ret.getString("ID")%>">Selecionar</a>             
            </th>
            <th><%= ret.getString("name")%></th>
            <th>R$<%= ret.getString("price")%></th>
            <th><%= ret.getString("category_name")%></th>
        </tr>
        <%
            }
        } catch (SQLException e) {
        %>
    <script>alert("Erro ao recuperar registros do banco: <%= e.getMessage()%>");</script>
    <%
        } finally {
            db.destroyDb();
        }
    %>
</tbody>
<tfoot>
    <tr>
        <th colspan="4">
            <a href="ProdutoAdmController?sel">Incluir</a>
        </th>
    </tr>
</tfoot>
</table>
<!-- Footer -->
<jsp:include page="footer.jsp"></jsp:include>