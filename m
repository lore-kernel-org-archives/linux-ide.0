From: kilgota@banach.math.auburn.edu
Subject: apparent need to blacklist Lexar flash drive in ide-dma.c
Date: Fri, 5 Oct 2007 16:49:05 -0500 (CDT)
Message-ID: <Pine.LNX.4.64.0710051600030.29942@banach.math.auburn.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from banach.math.auburn.edu ([131.204.45.3]:1968 "EHLO
	banach.math.auburn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754782AbXJEWJy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Oct 2007 18:09:54 -0400
Received: from banach.math.auburn.edu (localhost [127.0.0.1])
	by banach.math.auburn.edu (8.13.8/8.13.1) with ESMTP id l95Ln6fA029972
	for <linux-ide@vger.kernel.org>; Fri, 5 Oct 2007 16:49:06 -0500
Received: from localhost (kilgota@localhost)
	by banach.math.auburn.edu (8.13.8/8.13.1/Submit) with ESMTP id l95Ln5BM029969
	for <linux-ide@vger.kernel.org>; Fri, 5 Oct 2007 16:49:06 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I am trying to set up a rather weird piece of hardware to run Linux. 
The machine is an old Compaq IA-1 internet appliance, containing 32 meg of 
RAM and a K6-2-266 CPU, with VIA Apollo chipset on board. The machine has 
an internal flash drive consisting of a Sandisk SP3B-16 (16 megabytes) 
which is apparently a chip or chips permanently attached to the board and 
which contained an installation of WinCE which would do nothing except to 
boot and to attempt to connect to MSN.

The machine's BIOS "sees" the SP3B-16 as drive "C" and the default BIOS 
setting is to boot from it.

The  machine also contains an interface into which a CF card can be 
plugged, and if you put one there it is seen as the "D" drive (/dev/hdc in 
Linux). The BIOS also allows the possibility to boot from "D". The BIOS 
also has settings, whiich can be toggled, for

"IDE Drive Translation" (what this was supposed to mean I have no idea 
and I can see no practical difference if it is enabled or disabled)

"Enhanced IDE Transfer" (I would assume this means the pio mode can be 
enhanced)

"Ultra 33/66" (I would assume this means UDMA 33 or 66)

So, feeling adventurous, I went and bought a CF card on which is written

Lexar 2GB Compact Flash Platinum II 80x

and ran fdisk, creating a large partition re-formatted with Reiserfs on 
which I did an installation and a small one for swap, installed a 2.6.22.3 
kernel and LILO, and set the machine's BIOS to boot from "D".

Aside from some issues which are relevant for some other list (relating to 
issues with a USB keyboard and mouse), the machine boots. With DMA support 
for the VIA Apollo chip built in, the kernel while booting sees the SP3B 
first, of course, gives a couple of access errors, then duly blacklists 
it, and there are no further problems with that one. However, the Lexar 
gave repeated DMA errors and tried 3 times during the boot process to set 
up the DMA for the Lexar CF card and finally gave up and booted with DMA 
disabled. The only way to stop this rather agonizing and lengthy process 
was either to use the boot option ide=nodma or, more permanently, to put a 
line like this

         {"LEXAR ATA FLASH",             "ALL"},

into the blacklist in drivers/ide/ide-dma.c (note that "LEXAR ATA FLASH" 
is the way the drive is seen during the bootup messages).

To do this blacklisting essentially stops the problem while booting, but 
of course the "drive" is then not accessed with any DMA.

Under the circumstances, I am of course uncertain whether the "ALL" is 
appropriate or not, but I suspect it is. So perhaps you would like to add 
this entry to the blacklist.

I also remain rather puzzled that the BIOS in this machine had EIDE 
transfer and UDMA 33/66 turned on when I got the machine, and WinCE did 
not seem to have any big problems with that. Perhaps WinCE simply ignores 
those settings? I dunno. I do not claim to know much about WinCE.

Finally, when doing research about this problem, I came across a rather 
long thread on the kernel mailing list which related to the SP3B and its 
problems with DMA. I recall that this thread pretty much petered out 
without coming to any firm resolution of whether there is any solution to 
the problem. It seemed that one of the fundamental problems was the way 
the device is "seen". Namely, is it some kind of flash device, or is it an 
ordinary hard drive? And is it possible to use DMA with a flash device or 
not? Does it make any difference if the device is removable, or not? That 
kind of thing.

But at any rate, to say again what is seen here:

The BIOS says that the SP3B (which is not removable and is so physically 
inobtrusive that I could actually not even find it when I took the machine 
apart!) is the equivalent of /dev/hda, and the booting Linux kernel sees 
it as such, too.

The BIOS says that the LEXAR (which is obviously removable) is the 
equivalent of /dev/hdc, and the booting Linux kernel sees it as such, too.

The BIOS seems to think that DMA should work, but it doesn't, at least 
neither with the SP3B soldered on the board nor with the Lexar flash drive 
put in the CF slot.

Access to both of these devices is through the Linux IDE interface. I can 
imagine that it might be somehow superior to access them as flash devices, 
but it is difficult for me to visualize how to do that if the BIOS thinks 
they are "ordinary" IDE hard drives.

So you have a possible suggestion for the blacklist, or in the alternative 
or as well as that, some questions which might possibly be interesting. 
Frankly, I hope that some of the questions are interesting.

Theodore Kilgore
