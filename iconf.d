module iconf;

import std.stdio;
import std.conv;
import std.algorithm;
import std.string;
import std.array;

//fix 4: add doc

/***

The Base class for INIFile, And TypeMeter.

*/
class INIParser {
	private:
		string stat;
	public:
		/// Gets the string 
		/// INIParser ip = new INIParser(STAT);
		this(string st) {
			stat = st;
		}
		/**

		INIParser.parse() - Parses configuration into an associative array.
		data[i] = value

		*/
		string[string] parse() {
			string[] ln = stat.split("\n");
			string[string] assoc; // to hold values: call Parser("i=1").parse()["i"] -> 1
			//fix 2: remove unneccessary code
			foreach (string l; ln) {
				if (l.length < 0 || l == null) {
					break;
				}
				if (l.startsWith(";")) {
					continue;
				} else {
					try {
						string[] kvi = l.split("="); // 0: key 1: value
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

/// TypeMeter - Gives Types
/// 
/// It wraps around INIParser and gives types for INI config files.
class TypeMeter {
	private:
		string[string] inidata;
	public:
		/// Catches the INI Config Data.
		this(string[string] inidat) {
			inidata = inidat;
		}
		/// Is it an Integer?
		int isint(string key) {
			try {
				return to!int(inidata[key]);
			} catch ( Exception e ) {
				return -1;
			}
		}
		/// Is it a boolean?
		bool isbool(string key) {
			//fix1: Use the Wiki .ini specification rules
			try {
				if (inidata[key] == "yes") {
					return true;
				}
				else {
					return false;
				}
			} catch ( Exception e ) {
				return false;
			}
		}
		/// Is it a float?
		float isfloat(string key) {
			try {
				return to!float(inidata[key]);
			} catch ( Exception e ) {
				return -1;
			}
		}
		/// is it a  double
		double isdouble(string key) {
			try {
				return to!double(inidata[key]);
			} catch ( Exception e ) {
				return -1.0;
			}
		}

}

/**
INIFile - Wrapper around INIParser for files.
*/
class INIFile {
	/// The file name
	string filename;
public:
	/// gets information about the filename
	this(string f) {
		filename=f;
	}
	/// Parses the data into string[string]
	string[string] parse() {
		string parsestr = "";
		File f = File(filename, "r");
		while (!f.eof()) {
			string fin = f.readln();

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
