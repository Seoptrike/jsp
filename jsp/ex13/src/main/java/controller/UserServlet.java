package controller;

import java.io.IOException;
import java.io.PrintWriter;
import model.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;


@WebServlet(value= {"/user/login" ,"/user/logout" ,"/admin/order/list","/admin/order/list.json","/admin/order/update"})
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	UserDAO dao = new UserDAO();
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		HttpSession session=request.getSession();
		PrintWriter out = response.getWriter(); 
		switch(request.getServletPath()) {
		case "/user/login" :
			request.setAttribute("pageName", "/user/login.jsp");
			dis.forward(request, response);
			break;
		case "/user/logout":
			session.invalidate();
			response.sendRedirect("/");
			break;
		case "/admin/order/list" :
			request.setAttribute("pageName", "/admin/order.jsp");
			dis.forward(request, response);
			break;	
			
		case "/admin/order/list.json" :
			Gson gson= new Gson();
			QueryVO query= new QueryVO();
			OrderDAO odao = new OrderDAO();
			query.setKey(request.getParameter("key"));
			query.setWord(request.getParameter("word"));
			query.setPage(Integer.parseInt(request.getParameter("page")));
			query.setSize(Integer.parseInt(request.getParameter("size")));
			out.print(gson.toJson(odao.list(query)));
			break;		
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		HttpSession session=request.getSession();
		switch(request.getServletPath()) {
			case "/user/login" :
				String uid = request.getParameter("uid");
				String upass = request.getParameter("upass");
				UserVO vo = dao.read(uid);
				int result=0;
				if(vo.getUid()!=null) {
					if(vo.getUpass().equals(upass)){
						session.setAttribute("uid", uid);
						session.setAttribute("user", vo);
						result=1;
					}else{
						result=2;
					}
				}
			out.print(result);
				break;
			
			case "/admin/order/update":
				OrderDAO odao = new OrderDAO();
				String pid=request.getParameter("pid");
				int status = Integer.parseInt(request.getParameter("status"));
				odao.update(pid, status);
				break;
		}
	}
}
