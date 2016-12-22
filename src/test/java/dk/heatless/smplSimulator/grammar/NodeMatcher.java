package dk.heatless.smplSimulator.grammar;

import org.antlr.v4.runtime.tree.ParseTree;

public interface NodeMatcher {
	
	public void assertMatching(ParseTree ctx);
	
	public StringBuilder expecting(StringBuilder into);
	
	public StringBuilder expectingClean(StringBuilder into);
}
