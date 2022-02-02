var fs = WScript.CreateObject("Scripting.FileSystemObject");
var args = WScript.Arguments;

try{
var pwn = args(0) || 0;
var pwlmn = args(1) || 0;
var pwlmx = args(2) || 0;
var file = args(3) || "passwords.txt";
var fo = fs.OpenTextFile(file, 2);
var pws = fs.OpenTextFile("symbols.txt", 1).ReadAll().split(",");
var str = "";

for(var i = 0; i < pwn; i++){
	for(var j = 0; j < random(pwlmn, pwlmx); j++){
		str += getRandEl(pws);
	}
	str += "\r\n";
}

writeToFile(fo, str);

}catch(e){
    WScript.Echo("Usage: get-pwlist <passwords number> <password minimal length> <password maximal length> <output file>");
}
function getRandEl(arr){
	return arr[Math.floor(Math.random()*arr.length)];
}

function writeToFile(fo, text){
	fo.Write(text);
}

function random(min, max){
      return Math.floor(Math.random()* (max - min)) + min;
}