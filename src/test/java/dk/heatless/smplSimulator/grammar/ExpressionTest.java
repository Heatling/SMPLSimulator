package dk.heatless.smplSimulator.grammar;

import org.testng.annotations.Test;

import static dk.heatless.smplSimulator.grammar.GrammarTestUtilities.*;



public class ExpressionTest {
	
	@Test
	public void integerConstantExpression(){
		assertMatchingExpression(leaf("1"));
	}
	
	@Test
	public void variableExpression(){
		
		assertMatchingExpression(leaf("x"));
	}
	
	@Test
	public void floatContantExpression(){
		assertMatchingExpression(leaf("1.0"));
	}
	
	@Test
	public void charExpression(){
		assertMatchingExpression(leaf("'c'"));
	}
	
	@Test
	public void stringExpression(){
		assertMatchingExpression(leaf("\"some string\""));
	}
	
	@Test
	public void tupleExpression(){
		assertMatchingExpression(compound("<|","x", ",", "1", "|>"));
	}
		
	@Test
	public void plusLeftAssociative(){
		assertMatchingExpression(compound(compound("1", "+", "2"),"+", "3"));
		
	}
	
	@Test
	public void plusPrecedesBitAND(){
		assertMatchingExpression(compound("1", "&&",compound("2","+", "3")));
		
	}
	
	@Test
	public void useExpression(){
		assertMatchingExpression(compound("x", ",", "->", "x"));
	}
	
}
