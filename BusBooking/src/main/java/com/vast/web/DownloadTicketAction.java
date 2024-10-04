package com.vast.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.io.PrintWriter;

//@WebServlet("/DownloadTicketServlet")
public class DownloadTicketAction implements Action {
    
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        // Retrieve ticket parameters from the request
        String name = request.getParameter("name");
        String age = request.getParameter("age");
        String mobile = request.getParameter("mobile");
        String address = request.getParameter("address");
        String paymentMethod = request.getParameter("payment-method");
        String busNumber = request.getParameter("busNumber");
        String seatNumber = request.getParameter("seatNumber");

        response.setContentType("text/plain");
        response.setHeader("Content-Disposition", "attachment; filename=ticket.txt");

        String ticketContent = "Passenger Name: " + name + "\n" +
                               "Age: " + age + "\n" +
                               "Mobile Number: " + mobile + "\n" +
                               "Address: " + address + "\n" +
                               "Payment Method: " + paymentMethod + "\n" +
                               "Bus Number: " + busNumber + "\n" +
                               "Seat Number: " + seatNumber;

        try (PrintWriter out = response.getWriter()) {
            out.println(ticketContent);
        } catch (IOException e) {
            e.printStackTrace();
        }

        return "ticket.jsp";
    }
}