From: kilgota@banach.math.auburn.edu
Subject: Re: apparent need to blacklist Lexar flash drive in ide-dma.c
Date: Fri, 5 Oct 2007 19:04:22 -0500 (CDT)
Message-ID: <Pine.LNX.4.64.0710051841340.30041@banach.math.auburn.edu>
References: <Pine.LNX.4.64.0710051600030.29942@banach.math.auburn.edu>
 <20071006002755.37c365bf@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from banach.math.auburn.edu ([131.204.45.3]:1379 "EHLO
	banach.math.auburn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765AbXJFAKF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Oct 2007 20:10:05 -0400
In-Reply-To: <20071006002755.37c365bf@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org



On Sat, 6 Oct 2007, Alan Cox wrote:

>> "Ultra 33/66" (I would assume this means UDMA 33 or 66)
>
> If it is cabled for it, DMA capable CF is quite new and that seems to
> cause problems sometimes.
>
>> Under the circumstances, I am of course uncertain whether the "ALL" is
>> appropriate or not, but I suspect it is. So perhaps you would like to add
>> this entry to the blacklist.
>
> The problem is almost certainly your box not the flash drive so ide=nodma
> is probably most appropriate. It really ought to handle both flash drives
> however.
>
> ide=nodma seems the right answer.
>
> Alan
>

Alan,

Thanks for the speedy answer.

If you think that the Lexar flash drive ought to function with DMA and you 
suspect that the problem might be in the box (which it could easily be!) 
then I would be curious if you have any ideas what one could do about 
that.

Current situation is that I stuck in a blacklist line for the Lexar flash, 
but otherwise

PCI access mode set to "any"

PCMCIA/CardBus support not turned on at all (would seem irrelevant but I 
could be wrong?)

IDE ACPI support on (and IIRC this gets used, too)

generic/default IDE chipset support (on)

PCI IDE chipset support (on)
Sharing PCI IDE interrupts (on) (but the bootup does report that primary 
interface gets IRQ 14 and secondary gets IRQ 15, which might mean this is 
not required?)

Generic PCI IDE chipset support (on)

Generic PCI busmaster support (on)

VIA 82CXXX chipset support (on)

and lspci output is as follows which looks pretty standard to me for VIA 
stuff of that vintage

---------------------------
00:00.0 Host bridge: VIA Technologies, Inc. VT8501 [Apollo MVP4] (rev 04)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8501 [Apollo MVP4 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] 
(rev 1b)
00:07.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 0e)
00:07.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 0e)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
20)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 
Audio
Controller (rev 21)
00:07.6 Communication controller: VIA Technologies, Inc. AC'97 Modem 
Controller
(rev 20)
01:00.0 VGA compatible controller: Trident Microsystems CyberBlade/i7d 
(rev 5d)
-----------------------------------------

So I do not know exactly what other tricks to try :(

The old box does have some other quirks, though. It seems to me that the 
BIOS must be quite flaky. It does have some intersting challenges as a 
project box. The first one is to get it to boot without glitches (the 
cursed BIOS, again, is what seems to blame here; it hangs if one attaches 
USB devices like keyboards and mice before booting) and after that it 
would be interesting to see what kinds of things can be done to cut the 
software on it, including the kernel, to a machine of such small 
resources.

Thanks again for answering.

Theodore Kilgore
