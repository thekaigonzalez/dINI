import iconf;
import std.stdio;

void main() {
	INIParser ip = new INIParser("i=1\nb=2");
	TypeMeter typecatch = new TypeMeter(ip.parse());
	writeln(typecatch.isint("i") + typecatch.isint("b"));
}
