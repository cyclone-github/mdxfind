Latest mdxfind binary hosted on hashes.org before going offline.

Search for MD5x values from a file
use:  mdxfind [options] [list of text files] < input hash
The text file stdin is special, and may be used if -f is
supplied, to read candidate passwords from stdin
-a      Do email address munging
-b      Expand each word into unicode, best effort
-c      Replace each special char (<>&, etc) with XML equivalents
-d      De-duplicate wordlists, best effort
-e      Extended search for truncated hashes
-p      Print source (filename) of found plaintexts
-q      Internal iteration counts for SHA1MD5x, and others
-g      Rotate calculated hashes to attempt match to input hash
-s      File to read salts from
-u      File to read Userid/Usernames from
-k      File to read suffixes from
-n      Number of digits to append to passwords
-i      The number of iterations for each hash
-t      The number of threads to run
-f      file to read hashes from, else stdin
-l      Append CR/LF/CRLF and print in hex
-r      File to read rules from (concatenated)
-R      File to read rules from (dot-product form)
-v      Do not mark salts as found.
-w      Number of lines to skip from first wordlist
-y      Enable directory recursion for wordlists
-z      Enable debugging information/hash results
-Z      Enable histogram of rule hits
