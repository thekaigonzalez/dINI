# dINI (iconf): a fast, easy to use Configuration parser.

```d

import iconf;
import std.stdio;
void main() {
        INIParser myparser = new INIParser("i=1");
        string[string] keys = myparser.parse();
        writeln(keys["i"]);
}

```

dINI (originally named iconf) is a Config parser written in D.

It parses equal statements into an array of keys and values and junk, and allows comments.
It doesn't come with a file handler but files are super easy to parse.
