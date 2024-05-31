package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.*;


@WebServlet(value= {"/cart/insert","/cart/list","/cart/list.json","/cart/delete","/cart/update","/favorite/insert","/favorite/delete","/pur/insert","/order/insert","/order/list","/pur/list.json","/order/list.json"})
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
		case "/order/list":
			request.setAttribute("pageName", "/user/order.jsp");
			dis.forward(request, response);
			break;
		case "/pur/list.json":
			gson= new Gson();
			OrderDAO odao= new OrderDAO();
			out.print(gson.toJson(odao.list(request.getParameter("uid"))));
			break;	
		case "/order/list.json":
			gson= new Gson();
			odao= new OrderDAO();
			out.print(gson.toJson(odao.olist(request.getParameter("pid"))));
			break;	
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		OrderDAO odao= new OrderDAO();
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
			
		case "/pur/insert": //주문자 정보 등록
			UUID uuid = UUID.randomUUID();
			String pid = uuid.toString().substring(0,13);
			PurchaseVO pvo= new PurchaseVO();
			pvo.setPid(pid);
			pvo.setUid(request.getParameter("uid"));
			pvo.setUname(request.getParameter("rname"));
			pvo.setPhone(request.getParameter("rphone"));
			pvo.setRaddress1(request.getParameter("raddress1"));
			pvo.setRaddress2(request.getParameter("raddress2"));
			pvo.setSum( Integer.parseInt(request.getParameter("sum")));
			//System.out.println(pvo.toString());
			out.print(pid);
			odao.insert(pvo);
			break;
			
		case "/order/insert": //주문상품 정보 등록
			OrderVO ovo= new OrderVO();
			ovo.setPid(request.getParameter("pid"));
			ovo.setGid(request.getParameter("gid"));
			ovo.setPrice(Integer.parseInt(request.getParameter("price")));
			ovo.setQnt(Integer.parseInt(request.getParameter("qnt")));
			odao.insert(ovo);
			//System.out.println(ovo.toString());
			break;
		}
	}

}
