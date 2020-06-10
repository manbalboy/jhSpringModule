package com.controller;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;
import static org.springframework.test.web.servlet.setup.MockMvcBuilders.webAppContextSetup;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.web.context.WebApplicationContext;

import com.config.AppConfig;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(classes = AppConfig.class)
public class DemoControllerTest {
	private MockMvc mockMvc;
	
	@Autowired
	protected WebApplicationContext wac;
	
	@Before
	public void setup() {
		this.mockMvc = webAppContextSetup(this.wac).alwaysExpect(status().isOk()).build();
	}
	
	@Test
	public void byPathGetHome() throws Exception {
		this.mockMvc.perform(get("/home.xml"))
		.andDo(print())
		.andExpect(view().name("home"));
		
		
	}
	
	
	@Test
	public void pizzavalley() throws Exception {
		this.mockMvc.perform(get("/pizzavalley/pizzavalley"))
		.andDo(print())
		.andExpect(view().name("pizza"));
		
		
	}
	
	@Test
	public void byPathGetLeaders() throws Exception {
		
//		System.out.println(this.mockMvc.);
		this.mockMvc.perform(get("/leaders"))
		.andExpect(view().name("leaders"))
		;
	}
}
