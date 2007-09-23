From: Daniel Drake <dsd@gentoo.org>
Subject: via82cxxx/pata_via 80 wire cable detection misbehaviour
Date: Sun, 23 Sep 2007 23:57:47 +0100
Message-ID: <46F6EF6B.2030204@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clarity.mcc.ac.uk ([130.88.200.144]:61214 "EHLO
	clarity.mcc.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753133AbXIWXVo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Sep 2007 19:21:44 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: alexsaa@gmail.com, alan@lxorguk.ukuu.org.uk

Hi,

This bug was reported downstream:
https://bugs.gentoo.org/show_bug.cgi?id=171619
but I've summarised it below.

This system includes the following IDE interface:
VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus 
Master IDE (rev 06)

with this southbridge:
VIA Technologies, Inc. VT8233A ISA Bridge

There are 2 disks on the primary IDE channel, and a disk and a cdrom on 
the secondary IDE channel.  There is an 80-wire cable on the primary 
channel, and a 40 wire one on the secondary.

During boot, the secondary channel runs into some problems:

hdc: hdc1 hdc2 < hdc5hdc: dma_intr: status=0x51 { DriveReady SeekComplete
Error }
hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
  hdc6 hdc7 hdc8 hdc9 hdc10 >

or with pata_via:

ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata2.00: BMDMA stat 0x64
ata2.00: cmd c8/00:08:6a:40:1d/00:00:00:00:00/e1 tag 0 cdb 0x12 data 4096 in
          res 51/84:00:71:40:1d/00:00:00:00:00/e1 Emask 0x10 (ATA bus error)
ata2: soft resetting port
ata2.00: configured for UDMA/100
ata2.01: configured for UDMA/66
ata2: EH complete

Replacing the 40 wire cable with an 80 makes these problems go away.

The driver reads the VIA_UDMA_TIMING register (offset 0x50 into PCI 
configuration space) in order to determine if 40 or 80 wire cables are 
in use. pata_via does:

	if (ata66 & (0x10100000 >> (16 * ap->port_no)))
		return ATA_CBL_PATA80;

according to specs found at 
http://gkernel.sourceforge.net/specs/via/DS686B200.pdf.bz2 page 71
these 2 bits are:

"UltraDMA mode enable" enabled by bit 6 (which is not even checked in 
pata_via, but is handled in via82cxxx)
"Drive transfer mode" (0 is DMA/PIO, 1 is UDMA)

Sidenote: bit 4 talks about cable type reporting, but this is not 
checked (and the specs don't make it clear how to actually detect cable 
type if that bit is set).

Anyway, the user actually added a printk to look at the ata66 values for 
the two different cable types.

80 wire on primary and 80 wire on secondary: 0xf1f1f1f6
80 wire on primary and 40 wire on secondary: 0xf1f1f6f6

The only bits that changed in this register are related to cycle time.

Maybe this is the wrong register to be using for cable detection? Any ideas?

Thanks,
Daniel
