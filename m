From: Borislav Petkov <bp@alien8.de>
Subject: Re: HDD problem, software bug, bios bug, or hardware ?
Date: Sat, 15 Sep 2012 12:34:29 +0200
Message-ID: <20120915103429.GA12364@liondog.tnic>
References: <1345858271.82172.YahooMailNeo@web124705.mail.ne1.yahoo.com>
 <20120825113301.GA15210@liondog.tnic>
 <CAPL5yKdj2NrtQ0edWLjv6nefkcAG0VacQgSxPhuZ_TLpXeb+0Q@mail.gmail.com>
 <20120902072420.GC21982@liondog.tnic>
 <CAPL5yKcyzf1ta9Vc8Sh0EKCxBhonYjRFH7dnMEDBHbFYDh7u5w@mail.gmail.com>
 <20120910205121.GA11370@liondog.tnic>
 <CAPL5yKdNJnKoWQSKb6-bjDAGP4sEtvUdfR+bZb9XEhseE=SMYg@mail.gmail.com>
 <20120910215916.GA13334@liondog.tnic>
 <CAPL5yKdyDk8RdDhYWHHjQXVb1G6+9xqDKQgGrTZ4UZ1+6fOvRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:35705 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753054Ab2IOKee (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 Sep 2012 06:34:34 -0400
Content-Disposition: inline
In-Reply-To: <CAPL5yKdyDk8RdDhYWHHjQXVb1G6+9xqDKQgGrTZ4UZ1+6fOvRA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Merillat <dan.merillat@gmail.com>
Cc: Adko Branil <adkobranil@yahoo.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Fri, Sep 14, 2012 at 09:34:52PM -0400, Dan Merillat wrote:
> I didn't want to re-flash it,

That's perfectly understandable :)

> but I went ahead and cleared the CMOS, then went in and re-enabled the
> power-management functions (back to "Auto")
> 
> [    0.000000] Linux version 3.6.0-rc4-dan-00128-geeea3ac (harik@fileserver) (g
> cc version 4.7.1 (Debian 4.7.1-2) ) #2 SMP PREEMPT Fri Sep 7 06:30:20 EDT 2012
> ...
> [    0.000000] ACPI: SSDT 00000000c7de9640 00248 (v01 PTLTD  POWERNOW
> 00000001  LTP 00000001)
> ...
> [   22.601027] powernow-k8: Found 1 AMD Athlon(tm) 64 X2 Dual Core
> Processor 4600+ (2 cpu cores) (version 2.20.00)
> [   22.601328] powernow-k8: fid 0x10 (2400 MHz), vid 0xc
> [   22.601366] powernow-k8: fid 0xe (2200 MHz), vid 0xe
> [   22.601402] powernow-k8: fid 0xc (2000 MHz), vid 0x10
> [   22.601438] powernow-k8: fid 0xa (1800 MHz), vid 0x10
> [   22.601476] powernow-k8: fid 0x2 (1000 MHz), vid 0x12
> 
> So damned if I know why the BIOS quit exporting the SSDT, I'll chalk
> it up to bit-rot.   As far as I can tell, every BIOS setting is the
> same as before I wiped it.

Ha!

Clearing the CMOS helped in Adko's case with the random reboots too. I
have to make a mental note to myself to tell people to first clear their
CMOS when they're reporting strange issues related to BIOS.

Btw, I'll chalk this to whatever the monkeys have been smoking at the
time they've been writing your BIOS. Boy, if I could get a cent for
every BIOS bug out there...

Great, one more bug fixed. Thanks.

-- 
Regards/Gruss,
    Boris.
