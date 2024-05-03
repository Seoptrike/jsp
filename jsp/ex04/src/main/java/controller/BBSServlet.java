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

import model.BBSDAOImpl;
import model.BBSVO;


@WebServlet(value= {"/bbs/total","/bbs/list.json","/bbs/list","/bbs/insert","/bbs/read","/bbs/delete","/bbs/update"})
public class BBSServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	BBSDAOImpl dao = new BBSDAOImpl();
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		switch(request.getServletPath()){
		case "/bbs/update":
			String bid= request.getParameter("bid");
			BBSVO bbs=dao.read(Integer.parseInt(bid));
			request.setAttribute("bbs", bbs);
			request.setAttribute("pageName", "/bbs/update.jsp");
			dis.forward(request, response);
			break;
		
		case "/bbs/insert":
			request.setAttribute("pageName", "/bbs/insert.jsp");
			dis.forward(request, response);
			break;
		
		case "/bbs/read" :
		bid = request.getParameter("bid");
		System.out.println("bid................"+bid);
		BBSVO vo=dao.read(Integer.parseInt(bid));
		request.setAttribute("bbs", vo);			
		request.setAttribute("pageName", "/bbs/read.jsp");
		dis.forward(request, response);			
		break;
		
		case "/bbs/list.json":
			String query = request.getParameter("query")!=null? 
					request.getParameter("query") :"" ;
			String key = request.getParameter("key") !=null ? request.getParameter("key") : "title";
			int page = request.getParameter("page")!=null ? Integer.parseInt(request.getParameter("page")):1 ;
			int size = request.getParameter("size")!=null ? Integer.parseInt(request.getParameter("size")):10 ;
			Gson gson= new Gson();
			out.print(gson.toJson(dao.list(query,key,page,size)));
			//System.out.println(dao.list());
			break;
		
		case "/bbs/list":
			request.setAttribute("pageName", "/bbs/list.jsp");
			dis.forward(request, response);
			break;
			
		case "/bbs/total":
			query = request.getParameter("query")!=null? 
					request.getParameter("query") :"" ;
			key = request.getParameter("key") !=null ? request.getParameter("key") : "title";
			out.print(dao.total(query,key));
			    break;
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		switch(request.getServletPath()) {
		case "/bbs/delete":
			String bid= request.getParameter("bid");
			dao.delete(Integer.parseInt(bid));
			break;
			
		case "/bbs/insert":
			BBSVO vo=new BBSVO();
			vo.setWriter(request.getParameter("writer"));
			vo.setTitle(request.getParameter("title"));
			vo.setContents(request.getParameter("contents"));
			System.out.println(vo.toString());
			dao.insert(vo);
			response.sendRedirect("/bbs/list");
			break;
			
		case "/bbs/update":
			vo=new BBSVO();
			vo.setBid(Integer.parseInt(request.getParameter("bid")));
			vo.setTitle(request.getParameter("title"));
			vo.setContents(request.getParameter("contents"));
			System.out.println(vo.toString());
			dao.update(vo);
			response.sendRedirect("/bbs/list");
			break;
		}
	}

}
