# dINI (iconf)
dINI is a INI file parser written in D.

dINI is only about 100~ lines of code.
"iconf" is the name of the library.

IConf is like ISys, IConf, "My Configuration".

## Examples

try before you buy! (0.00$ each..)

Basic Parsing

```d

import iconf;
import std.stdio;
void main() {
	INIParser myparser = new INIParser("i=1");
	string[string] keys = myparser.parse();
	writeln(keys["i"]); // 1
}

```

Add two config Numbers using `TypeMeter`

```d

import iconf;
import std.stdio;

void main() {
	INIParser ip = new INIParser("i=1\nb=2");
	TypeMeter typecatch = new TypeMeter(ip.parse());
	writeln(typecatch.isint("i") + typecatch.isint("b")); // 3
}

```

Handling multiple lines of code

```d

import iconf;
import std.stdio;

void main() {
	INIParser ip = new INIParser("hello=Hello, \nworld=World!");
	auto data = ip.parse();
	writeln(data["hello"]~data["world"]); // Hello, world!
}

```
File Parsing

`hello.ini`:

```ini

; prints hello world
ello=Hello, world!

```

```d

import std.stdio;
import iconf;

void main() {
	INIFile f = new INIFile("hello.ini");
	auto data = f.parse();
	writeln(data["ello"]); // Hello, world!
}

```
