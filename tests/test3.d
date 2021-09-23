import iconf;
import std.stdio;

void main() {
	INIParser ip = new INIParser("hello=Hello, \nworld=World!");
	auto data = ip.parse();
	writeln(data["hello"]~data["world"]);
}
