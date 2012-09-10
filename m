From: Borislav Petkov <bp@alien8.de>
Subject: Re: HDD problem, software bug, bios bug, or hardware ?
Date: Mon, 10 Sep 2012 23:59:16 +0200
Message-ID: <20120910215916.GA13334@liondog.tnic>
References: <1345858271.82172.YahooMailNeo@web124705.mail.ne1.yahoo.com>
 <20120825113301.GA15210@liondog.tnic>
 <CAPL5yKdj2NrtQ0edWLjv6nefkcAG0VacQgSxPhuZ_TLpXeb+0Q@mail.gmail.com>
 <20120902072420.GC21982@liondog.tnic>
 <CAPL5yKcyzf1ta9Vc8Sh0EKCxBhonYjRFH7dnMEDBHbFYDh7u5w@mail.gmail.com>
 <20120910205121.GA11370@liondog.tnic>
 <CAPL5yKdNJnKoWQSKb6-bjDAGP4sEtvUdfR+bZb9XEhseE=SMYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:49184 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754430Ab2IJV7T (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Sep 2012 17:59:19 -0400
Content-Disposition: inline
In-Reply-To: <CAPL5yKdNJnKoWQSKb6-bjDAGP4sEtvUdfR+bZb9XEhseE=SMYg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Merillat <dan.merillat@gmail.com>
Cc: Adko Branil <adkobranil@yahoo.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Mon, Sep 10, 2012 at 05:29:50PM -0400, Dan Merillat wrote:
> It has two states, "Automatic" and "Disabled", but anything
> OS-controlled (such as virtualization) has the same two states. It's
> set to "Automatic".

Hmm, so it should be enabled then.

> I can probably boot back to a 3.2 where it was working, what ACPI
> debugging would be useful to you from a good kernel?

Hmm, if you say it worked before 3.2, then it didn't use ACPI the way it
does today so that it fails on your box.

Here's what I got on my box:

[    0.000000] ACPI: RSDP 00000000000f6620 00014 (v00 GBT   )
[    0.000000] ACPI: RSDT 00000000cfff3000 00038 (v01 GBT    NVDAACPI 42302E31 NVDA 01010101)
[    0.000000] ACPI: FACP 00000000cfff3040 00074 (v01 GBT    NVDAACPI 42302E31 NVDA 01010101)
[    0.000000] ACPI: DSDT 00000000cfff30c0 04C8E (v01 GBT    NVDAACPI 00001000 MSFT 0100000C)
[    0.000000] ACPI: FACS 00000000cfff0000 00040
[    0.000000] ACPI: SSDT 00000000cfff7e40 004CE (v01 PTLTD  POWERNOW 00000001  LTP 00000001)
[    0.000000] ACPI: HPET 00000000cfff8340 00038 (v01 GBT    NVDAACPI 42302E31 NVDA 00000098)
[    0.000000] ACPI: MCFG 00000000cfff8380 0003C (v01 GBT    NVDAACPI 42302E31 NVDA 01010101)
[    0.000000] ACPI: APIC 00000000cfff7d80 00098 (v01 GBT    NVDAACPI 42302E31 NVDA 01010101)

and the SSDT table contains, when disassembled, all those _PCT and _PSS
objects. (I guessed it by the OEM Table ID "POWERNOW" :-)) They look
something like this:

        Name (_PCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x40,               // Bit Width
                    0x00,               // Bit Offset
                    0x00000000C0010062, // Address
                    ,)
            }, 
	...

each in a _PR - processor - scope. (Boy, do I hate ACPI!).

Now, if we look at your ACPI tables:

[    0.000000] ACPI: RSDP 00000000000f7170 00014 (v00 GBT   )
[    0.000000] ACPI: RSDT 00000000c7de3000 00034 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
[    0.000000] ACPI: FACP 00000000c7de3040 00074 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
[    0.000000] ACPI: DSDT 00000000c7de30c0 064A2 (v01 GBT    GBTUACPI 00001000 MSFT 03000000)
[    0.000000] ACPI: FACS 00000000c7de0000 00040
[    0.000000] ACPI: HPET 00000000c7de9640 00038 (v01 GBT    GBTUACPI 42302E31 GBTU 00000098)
[    0.000000] ACPI: MCFG 00000000c7de9680 0003C (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
[    0.000000] ACPI: APIC 00000000c7de9580 00084 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)

the one missing is the SSDT table so either your BIOS is not providing
the it, or P-states are hidden in some other table or ...

Your BIOS is from 2008. Can you get a newer one from Gigabyte and update
it, if possible?

-- 
Regards/Gruss,
    Boris.
