import std.stdio;
import iconf;

void main() {
	INIFile f = new INIFile("./hello.ini");
	auto data = f.parse();
	writeln(data["ello"]);
}
