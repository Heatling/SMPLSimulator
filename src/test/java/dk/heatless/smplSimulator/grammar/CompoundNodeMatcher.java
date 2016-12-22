package dk.heatless.smplSimulator.grammar;

import org.antlr.v4.runtime.tree.ParseTree;

import static dk.heatless.smplSimulator.grammar.GrammarTestUtilities.*;
import static org.testng.Assert.*;

public class CompoundNodeMatcher implements NodeMatcher{

//Fields
	NodeMatcher[] children;
	
//Constructors
	
	public CompoundNodeMatcher(NodeMatcher...children) {
		this.children = children;
	}
	

	
	
//Methods
	
	
	@Override
	public void assertMatching(ParseTree ctx) {
		int childrenExpected = children.length;
		int childrenActual = ctx.getChildCount();
		
		int expectedMatch = 0;
		
		//For each actual node
		actual:
		for(int i = 0 ; i< childrenActual; i++){
			
			//Try as few of the remaining expected as possible
			for(int j = expectedMatch + 1; j<=childrenExpected; j++){
				NodeMatcher[] expectedGroup = new NodeMatcher[j-expectedMatch];
				for(int k = 0; k<expectedGroup.length; k++){
					expectedGroup[k] = children[expectedMatch + k]; 
				}
				NodeMatcher g = (expectedGroup.length== 1)? expectedGroup[0]: compound(expectedGroup);
				try{
					g.assertMatching(ctx.getChild(i));
					//actual node matched expected set
					expectedMatch = j;
					continue actual;
				}catch(AssertionError err){
					//Actual node did not match set, try a bigger group.
				}
			}
			//No expected matched the actual
			StringBuilder b = new StringBuilder();
			b.append("Expected ");
			expecting(b);
			b.append(" but got ");
			contextToString(ctx, b);
			fail(b.toString());
		}
	}




	@Override
	public StringBuilder expecting(StringBuilder into) {
		into.append("[");
		for(int  i = 0; i<children.length; i++){
			children[i].expecting(into);
		}
		into.append("]");
		return into;
	}

	@Override
	public StringBuilder expectingClean(StringBuilder into) {
		for(int  i = 0; i<children.length; i++){
			children[i].expectingClean(into);
			into.append(' ');
		}
		return into;
	}

}
