From: "Iain Barker" <ibarker@aastra.com>
Subject: RE: Delkin Cardbus IDE, a.k.a. ASKA "Ninja" chipset
Date: Thu, 17 Jan 2008 15:39:32 -0500
Message-ID: <6CC18F0C3EFF9D4DAE8286ABB9F4E23D079822@bosmail.us.aastra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.aastra.com ([216.94.98.95]:17009 "EHLO mail.aastra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756013AbYAQUzr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Jan 2008 15:55:47 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk, liml@rtr.ca
Cc: linux-ide@vger.kernel.org

Alan, Mark,

FYI, I had a chance to test the Ninja driver today using two manufacturers CardBus32 CF card adpaters (a Viking and a Lexar).

I can confirm Mark's observation that the access speeds are slower - around half the speed of the earlier Linux PIO driver, and a quarter the performance of WinXP. Test CF card was a SanDisk UltraII as the target, with CB1410 (Yenta compatible TI clone) as the host CB32 controller.

The driver works, but appears to use PIO only (PIO 4 is reported, actual performance is nearer PIO 0)
Should the UDMA modes of the CF be usable?

Linux throughput of 'dd bs=100MD' writing to FAT16 (Dell 3GHz P4 x86 32bit, kernel 2.6.23):

 3.1MB/sec for Linux PCMCIA     (legacy delkin_cb.c )
 1.8MB/sec for Linux CardBus 32 (libata pata_ninja32.c)

For comparison:

 1.4MB/sec for WinXP PCMCIA     (generic driver)
 7.8MB/sec for WinXP CardBus 32 (Lexmark driver)


Note: As a reference I used a SanDisk CF->USB2 adapter connected via an NEC USB2->CardBus32 in this same slot.
It gets >10MB/s to the same card so this is not a limitation with host DMA or the PCI/Yenta socket driver.


The following is the dmesg trace and hdparm in case it's of any use in locating the cause of the slowdown.

pccard: CardBus card inserted into slot 0
PCI: Found 0000:01:00.0 [1145/f021] 000180 00
PCI: Calling quirk c0022948 for 0000:01:00.0
PCI: Succeeded allocate mem resource #1:1000@34000000 for 0000:01:00.0
  got res [34000000:34000fff] bus [34000000:34000fff] flags 200 for BAR 1 of 0000:01:00.0
PCI: moved device 0000:01:00.0 resource 1 (200) to 34000000
PCI: Succeeded allocate I/O resource #0:20@2400 for 0000:01:00.0
  got res [2400:241f] bus [2400:241f] flags 101 for BAR 0 of 0000:01:00.0
PCI: moved device 0000:01:00.0 resource 0 (101) to 2400
PCI: enabling device 0000:01:00.0 (0000 -> 0003)
PCI: Enabling bus mastering for device 0000:01:00.0
PCI: Setting latency timer of device 0000:01:00.0 to 64
scsi0 : pata_ninja32
ata1: PATA max PIO4 cmd 0x00012410 ctl 0x0001241e bmdma 0x00012400 irq 39
ata1.00: CFA: SanDisk SDCFH-2048, HDX 4.04, max MWDMA2
ata1.00: 4001760 sectors, multi 0: LBA
ata1.00: configured for PIO4
scsi 0:0:0:0: Direct-Access     ATA      SanDisk SDCFH-20 HDX  PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 4001760 512-byte hardware sectors (2049 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 4001760 512-byte hardware sectors (2049 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1
sd 0:0:0:0: [sda] Attached SCSI removable disk


# hdparm /dev/sda

/dev/sda:
 IO_support    =  0 (default 16-bit)
 readonly      =  0 (off)
 readahead     = 256 (on)
 geometry      = 249/255/63, sectors = 4001760, start = 0

# hdparm -I /dev/sda

/dev/sda:

CompactFlash ATA device, with removable media
        Model Number:       SanDisk SDCFH-2048
        Serial Number:      011908D1907Q3145
        Firmware Revision:  HDX 4.04
Standards:
        Supported: 4
        Likely used: 4
Configuration:
        Logical         max     current
        cylinders       3970    3970
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:    4001760
        LBA    user addressable sectors:    4001760
        device size with M = 1024*1024:        1953 MBytes
        device size with M = 1000*1000:        2048 MBytes (2 GB)
Capabilities:
        LBA, IORDY(may be)(cannot be disabled)
        Standby timer values: spec'd by Vendor
        R/W multiple sector transfer: Max = 4   Current = 0
        DMA: mdma0 mdma1 mdma2 (?)
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    CFA feature set

# hdparm -d1 /dev/sda

/dev/sda:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Inappropriate ioctl for device


Let me know if there's any more useful info I could provide.


regards,

Iain Barker


----


To: Alan Cox <alan@xxxxxxxxxxxxxxxxxxx> 
Subject: Re: Delkin Cardbus IDE, a.k.a. ASKA "Ninja" chipset 
From: Mark Lord <liml@xxxxxx> 
Date: Tue, 13 Nov 2007 23:50:47 -0500 
Cc: Mikael Pettersson <mikpe@xxxxxxxx>, greg.freemyer@xxxxxxxxx, linux-ide@xxxxxxxxxxxxxxx 
In-reply-to: <20071114005718.7b151b37@xxxxxxxxxxxxxxxxx> 
References: <200711031541.lA3FfJ6h006120@xxxxxxxxxxxxxx> <20071103162203.5388a37f@xxxxxxxxxxxxxxxxx> <47323E13.3030205@xxxxxx> <20071107232132.238fdf04@xxxxxxxxxxxxxxxxx> <47324A16.5010205@xxxxxx> <4738B364.5030806@xxxxxx> <20071114005718.7b151b37@xxxxxxxxxxxxxxxxx> 
User-agent: Thunderbird 2.0.0.6 (X11/20070728) 

--------------------------------------------------------------------------------

Alan wrote:

First guess

/*
 * pata_ninja32.c 	- Ninja32 PATA for new ATA layer

..

Okay, I tried it on the wife's notebook.
It needs the patch below to enable chip interrupts,
and it is *very* slow on I/O (1MB/sec), slower even
than delkin_cb at present.

But it does work, with this patch:

Signed-off-by: Mark Lord <mlord@xxxxxxxxx>
---
(I still have hardware here to send you..)

--- old/pata_ninja32.c	2007-11-13 23:06:21.000000000 -0500
+++ new/pata_ninja32.c	2007-11-13 23:49:24.000000000 -0500
@@ -169,6 +169,7 @@
	ap->pio_mask = 0x1F;
	ap->flags |= ATA_FLAG_SLAVE_POSS;
	
+	iowrite8(0x05, base + 1);
	ap->ioaddr.cmd_addr = base + 0x10;
	ap->ioaddr.ctl_addr = base + 0x1E;
	ap->ioaddr.altstatus_addr = base + 0x1E;
-
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
the body of a message to majordomo@xxxxxxxxxxxxxxx
More majordomo info at  http://vger.kernel.org/majordomo-info.html

