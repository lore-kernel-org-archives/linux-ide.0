From: Dan Merillat <dan.merillat@gmail.com>
Subject: Re: HDD problem, software bug, bios bug, or hardware ?
Date: Fri, 14 Sep 2012 21:34:52 -0400
Message-ID: <CAPL5yKdyDk8RdDhYWHHjQXVb1G6+9xqDKQgGrTZ4UZ1+6fOvRA@mail.gmail.com>
References: <1345858271.82172.YahooMailNeo@web124705.mail.ne1.yahoo.com>
	<20120825113301.GA15210@liondog.tnic>
	<CAPL5yKdj2NrtQ0edWLjv6nefkcAG0VacQgSxPhuZ_TLpXeb+0Q@mail.gmail.com>
	<20120902072420.GC21982@liondog.tnic>
	<CAPL5yKcyzf1ta9Vc8Sh0EKCxBhonYjRFH7dnMEDBHbFYDh7u5w@mail.gmail.com>
	<20120910205121.GA11370@liondog.tnic>
	<CAPL5yKdNJnKoWQSKb6-bjDAGP4sEtvUdfR+bZb9XEhseE=SMYg@mail.gmail.com>
	<20120910215916.GA13334@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47056 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab2IOBex (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Sep 2012 21:34:53 -0400
Received: by pbbrr13 with SMTP id rr13so6436270pbb.19
        for <linux-ide@vger.kernel.org>; Fri, 14 Sep 2012 18:34:52 -0700 (PDT)
In-Reply-To: <20120910215916.GA13334@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Adko Branil <adkobranil@yahoo.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Mon, Sep 10, 2012 at 5:59 PM, Borislav Petkov <bp@alien8.de> wrote:
> On Mon, Sep 10, 2012 at 05:29:50PM -0400, Dan Merillat wrote:
>> It has two states, "Automatic" and "Disabled", but anything
>> OS-controlled (such as virtualization) has the same two states. It's
>> set to "Automatic".
>
> Hmm, so it should be enabled then.
> Now, if we look at your ACPI tables:
>
> [    0.000000] ACPI: RSDP 00000000000f7170 00014 (v00 GBT   )
> [    0.000000] ACPI: RSDT 00000000c7de3000 00034 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
> [    0.000000] ACPI: FACP 00000000c7de3040 00074 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
> [    0.000000] ACPI: DSDT 00000000c7de30c0 064A2 (v01 GBT    GBTUACPI 00001000 MSFT 03000000)
> [    0.000000] ACPI: FACS 00000000c7de0000 00040
> [    0.000000] ACPI: HPET 00000000c7de9640 00038 (v01 GBT    GBTUACPI 42302E31 GBTU 00000098)
> [    0.000000] ACPI: MCFG 00000000c7de9680 0003C (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
> [    0.000000] ACPI: APIC 00000000c7de9580 00084 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
>
> the one missing is the SSDT table so either your BIOS is not providing
> the it, or P-states are hidden in some other table or ...
>
> Your BIOS is from 2008. Can you get a newer one from Gigabyte and update
> it, if possible?

I didn't want to re-flash it, but I went ahead and cleared the CMOS,
then went in and re-enabled the power-management functions (back to
"Auto")

[    0.000000] Linux version 3.6.0-rc4-dan-00128-geeea3ac (harik@fileserver) (g
cc version 4.7.1 (Debian 4.7.1-2) ) #2 SMP PREEMPT Fri Sep 7 06:30:20 EDT 2012
...
[    0.000000] ACPI: SSDT 00000000c7de9640 00248 (v01 PTLTD  POWERNOW
00000001  LTP 00000001)
...
[   22.601027] powernow-k8: Found 1 AMD Athlon(tm) 64 X2 Dual Core
Processor 4600+ (2 cpu cores) (version 2.20.00)
[   22.601328] powernow-k8: fid 0x10 (2400 MHz), vid 0xc
[   22.601366] powernow-k8: fid 0xe (2200 MHz), vid 0xe
[   22.601402] powernow-k8: fid 0xc (2000 MHz), vid 0x10
[   22.601438] powernow-k8: fid 0xa (1800 MHz), vid 0x10
[   22.601476] powernow-k8: fid 0x2 (1000 MHz), vid 0x12

So damned if I know why the BIOS quit exporting the SSDT, I'll chalk
it up to bit-rot.   As far as I can tell, every BIOS setting is the
same as before I wiped it.
