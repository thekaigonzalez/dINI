import iconf;
import std.stdio;
void main() {
	INIParser myparser = new INIParser("i = 1");
	string[string] keys = myparser.parse();
	writeln(keys["i"]);
}
