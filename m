From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: Re: ASUS M2A-VM - AMD690G - SB600 Non-Raid-5 SATA - problem
Date: Tue, 8 May 2007 06:37:14 +1000 (EST)
Message-ID: <47878.46146.qm@web52606.mail.re2.yahoo.com>
References: <463DA0CF.8080508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web52606.mail.re2.yahoo.com ([206.190.48.209]:47307 "HELO
	web52606.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S966669AbXEGUhT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 May 2007 16:37:19 -0400
In-Reply-To: <463DA0CF.8080508@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, conke.hu@gmail.com

--- Tejun Heo <htejun@gmail.com> wrote:
> Srihari Vijayaraghavan wrote:

[...]

> > Thank you for your insight into the problem. If there are any tricks
> involved
> > in making use of all 4 GB of RAM with SATA drives & with system stability,
> > I'll be very happy to learn them :-)).
> 
> It might be that you just have a bad ram module.  Does the machine work
> properly if you exchange the installed two modules with the other two?
> memtet86 time, I guess.

With the new case, new power supply & a few extra fans to keep the system
ventilated nicely, memtest86+ ran 8 hours of 6 successful runs without an
issue. Before that it would be fine on only DDR2 667, but not at DDR2 800
mode. (all the Corsair 6400 DIMMs are DDR 800 by specification, of course. ie,
nothing is overclocked)

Having proven the hardware stability (I'm sure now Linux stability will
greatly improve also), system stability is no longer a concern for me.

Even now, when 4 GB of RAM is installed, by default, the SATA drives aren't
recongnised in Linux, except when I pass mem=4095MB. If I pass mem=4095M, alas
only 3.6 of RAM is detected under Linux!

Here's the relevant section from dmesg:
 BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000dfee0000 (usable)
 BIOS-e820: 00000000dfee0000 - 00000000dfee3000 (ACPI NVS)
 BIOS-e820: 00000000dfee3000 - 00000000dfef0000 (ACPI data)
 BIOS-e820: 00000000dfef0000 - 00000000dff00000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000120000000 (usable)
Entering add_active_range(0, 0, 159) 0 entries of 3200 used
Entering add_active_range(0, 256, 917216) 1 entries of 3200 used
end_pfn_map = 1048576
...
Memory: 3570504k/3668864k available (2465k kernel code, 97972k reserved, 1445k
data, 332k init)
...

Surprisingly, this usable ~3.6 GB equals to the initial two e820 sections
only. I believe, when mem= parameter is used, the third 'usable' section
(between 0x100000000 - 0x120000000) isn't used at all by Linux.

I wonder if there is a trick involved in using mem= or memmap= needs to used
also (if so, I don't know yet how to construct memmap= parameter).

To recap:
    System is very stable with the new case, power supply & fans
    SATA drives aren't by default detected when 4 GB of RAM is used
    SATA drives are detected by default when only 2 GB of RAM is physically
installed (ie, with both pairs of 2 GB of DIMMs individually)
    SATA drives are detected when mem=4095M (the reported memory size in the
BIOS) is used, but only ~3.6 GB of RAM is used (suspected that the final e820
usable section, though detected, is not used).

Thank you for your help so far. I really appreciated that.

Hari


Send instant messages to your online friends http://au.messenger.yahoo.com 
