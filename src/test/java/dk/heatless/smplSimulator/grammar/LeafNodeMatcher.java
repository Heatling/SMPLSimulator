package dk.heatless.smplSimulator.grammar;

import static org.testng.Assert.*;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.TerminalNodeImpl;

public class LeafNodeMatcher implements NodeMatcher{
	
//Fields
	private String value;
	
//Constructors
	
	public LeafNodeMatcher(String value){
		this.value = value;
	}
	
	
//Methods
	
	public void assertMatching(ParseTree ctx){
		if(ctx instanceof TerminalNodeImpl){
			assertEquals(ctx.getText(), value);
		}else if(ctx.getChildCount() == 1){
			assertMatching(ctx.getChild(0));
		}else{
			StringBuilder message = new StringBuilder();
			message.append("Expected leaf node [");
			message.append(value);
			message.append("] but got children ");
			
			for(int i = 0; i<ctx.getChildCount(); i++){
				message.append("[");
				message.append(ctx.getChild(i).getText());
				message.append("]");
			}
			fail(message.toString());
		}
	}
	
	@Override
	public StringBuilder expecting(StringBuilder into){
		into.append("[" + value + "]");
		return into;
	}
	
	@Override
	public StringBuilder expectingClean(StringBuilder into){
		into.append( value);
		return into;
	}
	
}
