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

@WebServlet(value= {"/cou/list","/cou/list.json","/cou/total","/cou/insert","/cou/code"})
public class CouServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	CouDAOImpl dao = new CouDAOImpl();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out= response.getWriter();
		RequestDispatcher dis= request.getRequestDispatcher("/home.jsp");
		
		switch(request.getServletPath()) {
		case "/cou/list":
			request.setAttribute("pageName", "/cou/list.jsp");
			dis.forward(request, response);
			break;
		
		case "/cou/list.json": //테스트 /cou/list.json?key=lname&word=리&page=1&size=2
			QueryVO vo = new QueryVO();
			vo.setKey(request.getParameter("key"));
			vo.setWord(request.getParameter("word"));
			vo.setPage(Integer.parseInt(request.getParameter("page")));
			vo.setSize(Integer.parseInt(request.getParameter("size")));
			Gson gson =new Gson();
			out.print(gson.toJson(dao.list(vo)));
			break;
		case "/cou/total": //테스트 /cou/total?key=lname&word=리
			vo=new QueryVO();
			vo.setKey(request.getParameter("key"));
			vo.setWord(request.getParameter("word"));
			out.print(dao.total(vo));
			break;
			
		case "/cou/insert":
			vo=new QueryVO();
			vo.setKey(request.getParameter("key1"));
			request.setAttribute("code", dao.getCode(vo));
			request.setAttribute("pageName","/cou/insert.jsp" );
			dis.forward(request, response);
			break;
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		PrintWriter out=response.getWriter();
		switch(request.getServletPath()) {
			case "/cou/insert":
				CouVO vo= new CouVO();
				vo.setLcode(request.getParameter("lcode"));
				vo.setLname(request.getParameter("lname"));
				vo.setHours(Integer.parseInt(request.getParameter("hours")));
				vo.setRoom(request.getParameter("room"));
				vo.setInstructor(request.getParameter("instructor"));
				vo.setCapacity(Integer.parseInt(request.getParameter("capacity")));
				vo.setDept(request.getParameter("dept"));
				dao.insert(vo);
				response.sendRedirect("/cou/list");
				break;
		}
	}

}
