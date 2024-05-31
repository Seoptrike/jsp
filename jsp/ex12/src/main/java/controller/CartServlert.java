package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.*;


@WebServlet(value= {"/cart/insert","/cart/list","/cart/list.json","/cart/delete","/cart/update","/favorite/insert","/favorite/delete"})
public class CartServlert extends HttpServlet {
	private static final long serialVersionUID = 1L;
    CartDAO dao = new CartDAO();
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		
		switch(request.getServletPath()) {
		case "/cart/list.json":
			Gson gson= new Gson();
			out.print(gson.toJson(dao.list(request.getParameter("uid"))));
			
			break;
		case "/cart/list":
			request.setAttribute("pageName", "/goods/cart.jsp");
			dis.forward(request, response);
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		switch(request.getServletPath()) {
		case "/cart/insert":
			CartVO vo = new CartVO();
			vo.setUid(request.getParameter("uid"));
			vo.setGid(request.getParameter("gid"));
			out.print(dao.insert(vo));
			break;
			
		case "/cart/delete":
			String gid=request.getParameter("gid");
			String uid=request.getParameter("uid");
			out.print(dao.delete(gid, uid));
			break;
			
		case "/cart/update":
			vo = new CartVO();
			vo.setQnt(Integer.parseInt(request.getParameter("qnt")));
			vo.setGid(request.getParameter("gid"));
			vo.setUid(request.getParameter("uid"));
			dao.update(vo);
			break;
			
		case "/favorite/insert":
			FavoriteDAO fdao = new FavoriteDAO();
			gid=request.getParameter("gid");
			uid=request.getParameter("uid");
			fdao.insert(uid, gid);
			break;
			
		case "/favorite/delete":
			fdao = new FavoriteDAO();
			gid=request.getParameter("gid");
			uid=request.getParameter("uid");
			fdao.delete(uid, gid);
			break;	
			
		}
	}

}
