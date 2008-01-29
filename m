From: Gene Heskett <gene.heskett@gmail.com>
Subject: Re: Problem with ata layer in 2.6.24
Date: Tue, 29 Jan 2008 09:30:10 -0500
Message-ID: <200801290930.10425.gene.heskett@gmail.com>
References: <200801272122.21823.gene.heskett@gmail.com>
 <479E1D9E.3000900@bobjweil.com> <20080129121201.2f727f5f@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:61992 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428AbYA2OaR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jan 2008 09:30:17 -0500
In-reply-to: <20080129121201.2f727f5f@core>
Content-disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Richard Heck <rgheck@bobjweil.com>, Daniel Barkalow <barkalow@iabervon.org>, Zan Lynx <zlynx@acm.org>, Calvin Walton <calvin.walton@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ide Mailing list <linux-ide@vger.kernel.org>

On Tuesday 29 January 2008, Alan Cox wrote:
>> not one problem but lots---is sufficiently widespread that a Mini HOWTO,
>> say, would be really welcome and, I'm guessing, widely used.
>
>We don't see very many libata problems at the distro level and they for
>the most part boil down to
>
>- error messages looking different - Most bugs I get are things like
>media errors (timeout looks different, UNC report looks different)
>
>- broken hardware - I've closed a whole raft of bugs that turn out to be
>new PC systems where even the BIOS doesn't see the drives
>
>- faulty hardware being picked up because we actually do real error
>checking now. We now check for and give some devices more slack while
>still doing error checking. Both IDE layers also added blacklists for
>stuff like the TSScorp DVD drives. Qemu has now had its bugs patched.
>
>- sata_nv with >4GB of RAM, knowing being worked on, no old IDE driver
>anyway
>
>- pata_ali MWDMA with ATAPI, PIO works fine, all a bit of a mystery and
>as it affects only a few chip variants hard to figure out. Workaround
>libata.dma=1
>
>- CS handling. On a few boxes using cable select (particularly on one
>drive and not the other) shows up a problem, normally a failed SRST.
>That's still under investigation.
>
>- Promise timeouts. The old IDE times out then polls the device and finds
>the IRQ was never sent and then recovers so the user sees a short stall
>but no errors. The new libata doesn't do this and pdc202xx_old thus
>produces some error messages on some boxes. Backup polling is on my todo
>list.

I have not had a problem, no errors at all, since I rebooted to 
2.6.24-rc8 with the added argument in the kernel line in grub 
(from dmesg):
[    0.000000] Kernel command line: ro root=/dev/VolGroup00/LogVol00 acpi_use_timer_override rhgb quiet

which causes dmesg to log, some time later:

[   27.581823] ENABLING IO-APIC IRQs
[   27.582014] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[   27.592017] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
[   27.592068] ...trying to set up timer (IRQ0) through the 8259A ...  failed.
[   27.592071] ...trying to set up timer as Virtual Wire IRQ... works.
[   27.703623] Brought up 1 CPUs

This was about noonish yesterday, and the logs have been silent 
regarding this 'exception Emask' error since then.  The drive itself
has also passed a smartctl -t long test with no errors since then.

Now, the last boot that had the problem was to 2.6.24, which did 
NOT have that 'acpi_use_timer_override' argument, and its dmesg logged:

[   24.934176] ENABLING IO-APIC IRQs
[   24.934367] ..TIMER: vector=0x31 apic1=0 pin1=0 apic2=-1 pin2=-1
[   25.045973] Brought up 1 CPUs

Now, my question is, did the use of that argument, while it looked
like it failed, cause the setup code to do something correct that
the default path didn't do?  Is this the clue we're all looking for?

Since libata is apparently the path taken by TPTB, I'm going to build
and boot to a 2.6.24 using libata, but add that argument to grubs kernel
line in only one of 2 copies of that stanza.

Wish me luck.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
The intelligence of any discussion diminishes with the square of the
number of participants.
		-- Adam Walinsky
