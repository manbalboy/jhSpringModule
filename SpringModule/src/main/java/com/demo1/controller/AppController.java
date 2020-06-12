package com.demo1.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.demo1.model.Pizza;



@Controller
public class AppController {

    @RequestMapping(value="/pizzavalley/{pizzaName}", method = RequestMethod.GET)
    public String getPizza(@PathVariable String pizzaName,Model model) {

        Pizza pizza = new Pizza(pizzaName);
        model.addAttribute("pizza", pizza);

        model.addAttribute("test", "tttt");

        return "pizza";

    }


    @RequestMapping(value = { "/context"}, method = RequestMethod.GET)
    public String homePage(ModelMap model) {
        return "pages/home";
    }

    @RequestMapping(value = { "/products"}, method = RequestMethod.GET)
    public String productsPage() {
        return "pages/products";
    }

    @RequestMapping(value = { "/contactus"}, method = RequestMethod.GET)
    public String contactUsPage(ModelMap model) {
        return "pages/contactus";
    }
    @RequestMapping(value = { "/main"}, method = RequestMethod.GET)
    public String main(ModelMap model) {
        return "pages/main";
    }
    @RequestMapping(value = { "/JhTestPage"}, method = RequestMethod.GET)
    public String JhTestPage(ModelMap model) {
        return "pages/JhTestPage";
    }

}
