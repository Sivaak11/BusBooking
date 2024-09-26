package com.vast.web;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.log4j.Logger;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

import com.vast.dao.DbBusDao;
import com.vast.dao.IBusDao;

/**
 * Servlet implementation class BusActionServlet
 */
@WebServlet("/BusActionServlet")
public class BusActionServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	static Logger logger = Logger.getLogger("vast");

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public BusActionServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	public void init() {
		IBusDao dao = DbBusDao.getDaoInstance();
		logger.debug("instance created");
		Map<String, String> actionMap = readUriMappings();
		logger.debug("action map readed uri");
		getServletContext().setAttribute("mappings", actionMap);
		Map<String, Action> map = new HashMap<String, Action>();
		getServletContext().setAttribute("instanceMap", map);
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String path = request.getServletPath();
		logger.debug(path);
		Map<String, String> actionMap = (Map<String, String>) getServletContext().getAttribute("mappings");
		Map<String, Action> map = (Map<String, Action>) getServletContext().getAttribute("instanceMap");
		String view = null;
		if (actionMap.containsKey(path)) {
			String cls = actionMap.get(path);
			logger.debug(cls);
			createInstanceIfNotExists(map, cls);

			Action action = map.get(cls);
			view = action.execute(request, response);
			RequestDispatcher rd = request.getRequestDispatcher(view);
			rd.forward(request, response);
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

	private Map<String, String> readUriMappings() {
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		Map<String, String> eventMap = new HashMap<String, String>();
		logger.debug("eventMap created");
		try {
			DocumentBuilder db = dbf.newDocumentBuilder();
			InputStream in = getServletContext().getResourceAsStream("WEB-INF/action.xml");
			Document doc = db.parse(in);

			NodeList nlist = doc.getElementsByTagName("action");
			for (int i = 0; i < nlist.getLength(); i++) {

				String uri = nlist.item(i).getAttributes().getNamedItem("uri").getTextContent();
				String cls = nlist.item(i).getAttributes().getNamedItem("class").getTextContent();
				eventMap.put(uri, cls);
				logger.debug(cls + " class name");
			}
		} catch (Exception e) {

		}
		return eventMap;
	}

	private void createInstanceIfNotExists(Map<String, Action> instanceMap, String cls) {
		if (!instanceMap.containsKey(cls)) {
			try {
				Class clazz = Class.forName(cls);
				Action obj = (Action) clazz.newInstance();
				instanceMap.put(cls, obj);

			} catch (ClassNotFoundException | InstantiationException | IllegalAccessException e) {
				logger.error(e.getMessage());
			}
		}
		logger.info("instance created");
	}

}
