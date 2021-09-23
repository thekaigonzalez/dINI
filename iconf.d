module iconf;

import std.stdio;
import std.conv;
import std.algorithm;
import std.string;
import std.array;

class INIParser {
	private:
		string stat;
	public:
		this(string st) {
			stat = st;
		}
		string[string] parse() {
			string[] ln = stat.split("\n");
			string[string] assoc; // to hold values: call Parser("i=1").parse()["i"] -> 1
			string ph = "";
			foreach (string l; ln) {
				if (l.length < 0 || l == null) {
					break;
				}
				if (l.startsWith(";")) {
					continue;
				} else {
					try {
						string[] kvi = l.split("="); // 0: key 1: value
						string[] nkvi;
						if (kvi[0].endsWith(" ")) {
							kvi[0] = chop(kvi[0]);
						}
						//fix2: remove unneccessary code
						
						assoc[kvi[0]] = kvi[1];
					} catch ( Exception e ) {
						return [ "error": "Exception Occured.", "exception": to!string(e) ];
					}
				}
			}
			return assoc;
		}
}

class TypeMeter {
	private:
		string[string] inidata;
	public:
		this(string[string] inidat) {
			inidata = inidat;
		}
		int isint(string key) {
			try {
				return to!int(inidata[key]);
			} catch ( Exception e ) {
				return -1;
			}
		}
		bool isbool(string key) {
			//fix1: Use the Wiki .ini specification rules
			try {
				if (inidata[key] == "yes") {
					return true;
				} else {
					return false;
				}
			} catch ( Exception e ) {
				return false;
			}
		}
		float isfloat(string key) {
			try {
				return to!float(inidata[key]);
			} catch ( Exception e ) {
				return -1;
			}
		}
		double isdouble(string key) {
			try {
				return to!double(inidata[key]);
			} catch ( Exception e ) {
				return -1.0;
			}
		}

}

class INIFile {
	string filename;
	public:
	this(string f) {
		filename=f;
	}
		string[string] parse() {
			string parsestr = "";
			File f = File(filename, "r");
			while (!f.eof()) {
				string fin = f.readln();
				string ns;
				if (fin.startsWith(";")) {
					continue;
				}
				
				if (fin.length > 0 && fin != null && !fin.startsWith(" ")) {
					parsestr = parsestr~fin;
				}
			}
			

			f.close();
			return new INIParser(parsestr).parse();
		}
}
