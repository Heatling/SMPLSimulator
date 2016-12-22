package dk.heatless.smplSimulator.grammar;

import static dk.heatless.smplSimulator.grammar.GrammarTestUtilities.getParserForInput;

import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.TokenStream;
import org.antlr.v4.runtime.tree.ParseTree;

public class GrammarTestUtilities {
	
	public static SMPLParser getParserForInput(String input){
		CharStream text = new ANTLRInputStream(input);
		SMPLLexer lex = new SMPLLexer(text);
		TokenStream tokens = new CommonTokenStream(lex);
		
		return new SMPLParser(tokens);
	}
	
	
	public static String contextToString(ParseTree ctx){
		StringBuilder b = new StringBuilder();
				
		contextToString(ctx, b);
		
		return b.toString();
	}
	
	public static void contextToString(ParseTree ctx, StringBuilder into){
		
		
		if(ctx.getChildCount() == 0){
			into.append("[");
			into.append(ctx.getText());
			into.append("]");
		}else if(ctx.getChildCount() == 1){
			contextToString(ctx.getChild(0), into);
		
		}else{
			into.append("[");
			for(int i = 0; i<ctx.getChildCount(); i++){
				contextToString(ctx.getChild(i), into);
			}
			into.append("]");
		}
		
	}

	public static NodeMatcher leaf(String leafValue){
		return new LeafNodeMatcher(leafValue);
	}
	
	public static NodeMatcher compound(Object...matchers){
		NodeMatcher[] m = new NodeMatcher[matchers.length];
		
		for(int i = 0; i < m.length; i++){
			if(matchers[i] instanceof String){
				m[i] = leaf((String) matchers[i]);
			}else{
				m[i] = (NodeMatcher) matchers[i];
			}
		}
		
		return new CompoundNodeMatcher(m);
	}

	public static void assertMatchingExpression(NodeMatcher matcher){
		SMPLParser p = getParserForInput(matcher.expectingClean(new StringBuilder()).toString());
		matcher.assertMatching(p.expression());
	}
}
