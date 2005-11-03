From: "SMALL, Timothy" <timothy.small@astrium.eads.net>
Subject: PIIX - adding support for Radisys 82600 - MDMA problem
Date: Thu, 3 Nov 2005 11:52:47 -0000
Message-ID: <C2D16922D674664C9CCA61127AC9B77B03E0D3@auk52177.ukr.astrium.corp>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from viruswall.astrium.eads.net ([194.203.13.70]:41222 "EHLO
	viruswall.astrium.eads.net") by vger.kernel.org with ESMTP
	id S964830AbVKCLsg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 Nov 2005 06:48:36 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Hi,

I'm working on adapting the PIIX PATA driver (drivers/ide/piix.c) to support
the Radisys 82600 chipset.  As far as I understand it, this is an embedded
chipset developed by Intel as a very low-power, highly-integrated product
(northbridge + southbridge in a single package).  Intel never launched the
product, and it was licensed for use by Radisys.

http://www.radisys.com/service_support/tech_solutions/techsupportlib_detail.
cfm?productid=1262

It includes a single UDMA66 capable IDE channel, which is presented in a
PIIX styley.  I've adapted the PCI device allocation, and channel probing
code in drivers/ide/piix.c, and have PIO compact flash cards, working OK
(~3.6 M/sec with hdparm -t), as well as a 250G Maxtor in UDMA33 mode (~25
M/sec according to hdparm) - the 80 pin cable not detected on the hardware
I'm using, but I haven't looked into why yet...

I also have a different load of Sandisk compact flash cards (these get about
10M/sec when tested with hdparm -t, whilst attached via a USB2 <-> CF card
reader).  The board's BIOS sets these devices up in PIO mode 2, for some
reason (which makes me suspicious that maybe it knows something that's not
in the published errata).  The PIIX driver sets these up for MDMA2 mode
(hdparm -I lists this as the default setting for the device), and I get DMA
timeouts on them.  hdparm -d0 gets stuff working again.

Here are my bootup messages (in this case, with the BIOS forced to set hda
to MDMA2, but this didn't seem to make any difference):

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
R82600PIIX: IDE controller at PCI slot 0000:00:00.1
R82600PIIX: chipset revision 4
R82600PIIX: not 100% native mode: will probe irqs later
R82600PIIX: Set up IDE ports
R82600PIIX: Set up port 0
R82600PIIX: Controller OK
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:DMA
R82600PIIX: Set up port 1
R82600PIIX: Controller OK
hda: SanDisk SDCFB-256, CFA DISK drive
hdb: Maxtor 7L250R0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 501760 sectors (256 MB) w/1KiB Cache, CHS=980/16/32, DMA
hda: cache flushes not supported
 hda:<4>hda: dma_timer_expiry: dma status == 0x61
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }

ide: failed opcode was: unknown
 hda1

hdb: max request size: 1024KiB
hdb: 490234752 sectors (251000 MB) w/16384KiB Cache, CHS=30515/255/63,
UDMA(33)
hdb: cache flushes supported
 hdb: hdb1

 

I've also tried setting the Maxtor to MDMA2, and this then behaves similarly
(using hdparm, and programming the device first, then the chipset) - DMA
timeouts.  Setting it to PIO4 is fine tho'.

Before I go delving into this one deeper (e.g. going through the driver, and
the datasheet with a fine toothed comb), is there anything obvious that I
should try?  It crossed my mind that the northbridge/southbridge integration
thing might be doing something to assumed timing delays?  Any ideas?  Is
there anything fundamentally different between UDMA, and MDMA transfers?

I'm planning to try this on some different (PIIX) hardware, but I don't have
any CF<->40pin IDE adaptors to try this with at the moment (the one I'm
using is soldered to the devel board).

Also, 32 bit mode doesn't seem to work, but I'll worry about that later.

I'm developing against kernel.org 2.6.12, but would be happy to get more
up-to-date if people thought it was a good idea.

Cheers,

Tim.

p.s. Sorry for the lawyer noise that is appended to this message against my
will ;o).

This email is for the intended addressee only.
If you have received it in error then you must not use, retain, disseminate or otherwise deal with it.
Please notify the sender by return email.
The views of the author may not necessarily constitute the views of EADS Astrium Limited.
Nothing in this email shall bind EADS Astrium Limited in any contract or obligation.

EADS Astrium Limited, Registered in England and Wales No. 2449259
Registered Office: Gunnels Wood Road, Stevenage, Hertfordshire, SG1 2AS, England
