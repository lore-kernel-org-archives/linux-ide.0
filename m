From: Borislav Petkov <bp@alien8.de>
Subject: Re: HDD problem, software bug, bios bug, or hardware ?
Date: Sun, 2 Sep 2012 09:24:20 +0200
Message-ID: <20120902072420.GC21982@liondog.tnic>
References: <1345858271.82172.YahooMailNeo@web124705.mail.ne1.yahoo.com>
 <20120825113301.GA15210@liondog.tnic>
 <CAPL5yKdj2NrtQ0edWLjv6nefkcAG0VacQgSxPhuZ_TLpXeb+0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:41776 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754826Ab2IBHYZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Sep 2012 03:24:25 -0400
Content-Disposition: inline
In-Reply-To: <CAPL5yKdj2NrtQ0edWLjv6nefkcAG0VacQgSxPhuZ_TLpXeb+0Q@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Merillat <dan.merillat@gmail.com>
Cc: Adko Branil <adkobranil@yahoo.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Sat, Sep 01, 2012 at 08:45:56AM -0400, Dan Merillat wrote:
> I haven't been in my BIOS in years, but powernow-k8 quit working
> sometime after 3.2 when the ACPI bits were reworked.  So whatever
> broke it, it's 100% software.  Not something I use a lot so I haven't
> done an exact regression on it, but:
> Feb 19 18:23:32 fileserver kernel: [    0.000000] Linux version 3.2.0
> (harik@fileserver) (gcc version 4.5.3 (Debian 4.5.3-3) ) #1 SMP Mon
> Jan 23 21:57:27 EST 2012
> Feb 19 18:23:32 fileserver kernel: [    1.268123] powernow-k8: Found 1
> AMD Athlon(tm) 64 X2 Dual Core Processor 4600+ (2 cpu cores) (version
> 2.20.00)

Which one is yours:

http://products.amd.com/en-us/QuickSearch.aspx?q=4600+

?

Also, can you send /proc/cpuinfo pls.

> Feb 19 18:23:32 fileserver kernel: [    1.268206] powernow-k8: fid
> 0x10 (2400 MHz), vid 0xc
> Feb 19 18:23:32 fileserver kernel: [    1.268242] powernow-k8: fid 0xe
> (2200 MHz), vid 0xe
> Feb 19 18:23:32 fileserver kernel: [    1.268277] powernow-k8: fid 0xc
> (2000 MHz), vid 0x10
> Feb 19 18:23:32 fileserver kernel: [    1.268313] powernow-k8: fid 0xa
> (1800 MHz), vid 0x10
> Feb 19 18:23:32 fileserver kernel: [    1.268348] powernow-k8: fid 0x2
> (1000 MHz), vid 0x12
> 
> vs
> 
> Jul 31 00:33:09 fileserver kernel: [    0.000000] Linux version
> 3.4.0-dan-00002-ga84219d (harik@fileserver) (gcc version 4.6.2 (Debian
> 4.6.2-12) ) #2 SMP PREEMPT Mon May 21 09:36:23 EDT 2012
> Jul 31 00:33:09 fileserver kernel: [    0.972056] powernow-k8: Found 1
> AMD Athlon(tm) 64 X2 Dual Core Processor 4600+ (2 cpu cores) (version
> 2.20.00)
> Jul 31 00:33:09 fileserver kernel: [    0.972118] [Firmware Bug]:
> powernow-k8: No compatible ACPI _PSS objects found.
> Jul 31 00:33:09 fileserver kernel: [    0.972120] [Firmware Bug]:
> powernow-k8: Try again with latest BIOS.

Hmm, can you enable all the debug statements in the driver?

Simply edit drivers/cpufreq/powernow-k8.c by adding

#define DEBUG

as the very first line in the .c file.

Then rebuild kernel, reinstall and reboot with "ignore_loglevel
log_buf_len=10M" on the kernel command line.

You can send me dmesg privately if you prefer.

Thanks.

-- 
Regards/Gruss,
    Boris.
