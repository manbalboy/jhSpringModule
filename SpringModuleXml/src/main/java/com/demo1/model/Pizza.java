package com.demo1.model;
import java.util.ArrayList;
import java.util.List;


public class Pizza {

    private String name;

    private String flavor;

    private List<String> toppings = new ArrayList<String>();

    public Pizza(){

    }

    public Pizza(String name){
        this.name = name;
        this.flavor = "spicy";
        this.toppings.add("Cheese");
        this.toppings.add("bakon");
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setFlavor(String flavor) {
        this.flavor = flavor;
    }

    public String getFlavor() {
        return flavor;
    }

    public List<String> getToppings() {
        return toppings;
    }

    public void setToppings(List<String> toppings) {
        this.toppings = toppings;
    }

}
