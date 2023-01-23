#MD5x52 cde99ff55abfc0c699115c7c277ad742:7777
#MD5x52 cde99ff55abfc0c699115c7c277ad742:7777
#MD5x52 de32330dce7f3d26f6646b98d6d6cb1b:nepal
#MD5x52 e4c62e0cca1147f00ed0b119a4412b6c:musicguy
#MD5x52 fec2672f9387b85407939d33d8d106c2:spider
#MD5x52 fec2672f9387b85407939d33d8d106c2:spider
#SHA256x01 ...
#and the reversed versions
#MD5x01 99fc288bed7238d16d567aa5b3ccd4f5:password becomes
#rMD5x01...

while ($f = shift) {
    $f =~ s/.txt//;
    push(@names,$f);
}

$maxlen = 0;
$found = 0;
while (<>) {
    chop; if (/(.*?) (.*)$/) {
	$_[0] = $1;
	$_[1] = $2;
	if ($_[1] =~ /^([0-9a-fA-f]{16,})?:/) {
	   $found = 1;
           $h = lc($1);
	   $maxlen = length($h) if ($maxlen < length($h));
	   $curlen = length($h);
	   if ($curlen <= 30) {
	       $_[0] =~ s/x/chop${curlen}x/;
	       $_[1] =~ s/^$h://;
	    }
	   if ($hfn{$h}) {
	       $v = substr($hfn{$h},index($hfn{$h},"x")+1);
	       $v1 = substr($_[0],index($_[0],"x")+1);
	       $v += 1;
	       $v1 += 1;
	       next if ($hfn{$h} eq $_[0] && length($_[1]) > length($hash{$h}));
	       next if ($v1 < $v);
	       next if (length($_[0]) > $hfn{$h});
	    }
	   $hash{$h} = $_[1];
	   $hfn{$h} = $_[0];
	    $fn{$_[0]}++;
	}
    }
}
$maxlen = 32 if ($maxlen == 30);
print "Found: ",join(" ",keys %fn),"\n";
exit(0) if ($found == 0);

$first = 1;
foreach $base (@names) {
    $hits = 0;
    open(IN, "<$base.txt") || die "can't open $base.txt:$!\n";
    open(NEW,">w.$$") || die "Can't open w.$$:$!\n";
    while (<IN>) {
        if (/^([0-9a-fA-F]{16,$maxlen})/) {
	   $h = lc($1);
	   chop($h) if (length($h) & 1);
	   $rev = reverse($h);
	   $chop30 = substr($h,0,30);
	   if ($hfn{$chop30} ne "") {
	       $hits++;
	       if ($first) {
	           open(OUT,">>$base.$hfn{$chop30}") || die "can't append to $base.$hfn{$chop30}:$!";
		   print OUT "$h:$hash{$chop30}\n";
		   close(OUT);
		}
		next;
	   }
	   if ($hfn{$h} ne "") {
	       $hits++;
	       if ($first) {
	           open(OUT,">>$base.$hfn{$h}") || die "can't append to $base.$hfn{$h}:$!";
		   print OUT "$hash{$h}\n";
		   close(OUT);
		}
		next;
	    }
	   if ($hfn{$rev} ne "") {
	       $hits++;
	       if ($first) {
	           open(OUT,">>$base.r$hfn{$rev}") || die "can't append to $base.r$hfn{$rev}:$!";
		   $t = $hash{$rev};
		   $t =~ s/$rev/$h/;
		   print OUT "$t\n";
		   close(OUT);
		}
		next;
	    }
	}
	print NEW $_;
    }
    close(NEW);close(IN);$first = 1;
    if ($hits) {
        system ("/bin/mv","w.$$","$base.txt");
	print "$hits in $base.txt\n";
    }
    unlink("w.$$");
}
    
