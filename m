From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH libata-dev#upstream 2/2] libata: move EH repeat reporting into ata_eh_report()
Date: Tue, 31 Jul 2007 23:27:41 +0200 (MEST)
Message-ID: <200707312127.l6VLRfGR029509@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:63257 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934001AbXGaV17 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Jul 2007 17:27:59 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, jeff@garzik.org, linux-ide@vger.kernel.org, mikpe@it.uu.se

On Tue, 31 Jul 2007 16:51:00 +0900, Tejun Heo wrote:
> EH is sometimes repeated without any error or action.  For example,
> this happens when probing IDENTIFY fails because of a phantom device.
> In these cases, all the repeated EH does is making sure there is no
> unhandled error or pending action and return.  This repeation is
> necessary to avoid losing any event which occurred while EH was in
> progress.
> 
> Unfortunately, this dry run causes annonying "EH pending after
> completion" message.  This patch moves the repeat reporting into
> ata_eh_report() such that it's more compact and skipped on dry runs.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Mikael Pettersson <mikep@it.uu.se>
> ---
> Mikael, please verify this removes the annonying message you're
> seeing.

Yes, this patch eliminates the "EH pending after completion" message
I've been getting.

However, patch 1/2 in this set, "don't skip EH report if action is 
pending", causes a bunch of new "exception ... frozen" messages:

--- dmesg-2.6.23-rc1	2007-07-23 12:30:12.000000000 +0200
+++ -	2007-07-31 23:19:21.162137100 +0200
@@ -1,44 +1,44 @@
...
-pata_pdc2027x 0000:04:02.0: PLL input clock 16660 kHz
+pata_pdc2027x 0000:04:02.0: PLL input clock 16651 kHz
 scsi0 : pata_pdc2027x
 scsi1 : pata_pdc2027x
 ata1: PATA max UDMA/133 cmd 0xf88297c0 ctl 0xf8829fda bmdma 0xf8829000 irq 18
 ata2: PATA max UDMA/133 cmd 0xf88295c0 ctl 0xf8829dda bmdma 0xf8829008 irq 18
+ata1: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
 ata1.00: ATA-7: ST3320620A, 3.AAD, max UDMA/100
 ata1.00: 625142448 sectors, multi 16: LBA48 
 ata1.00: configured for UDMA/100
+ata2: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
 scsi 0:0:0:0: Direct-Access     ATA      ST3320620A       3.AA PQ: 0 ANSI: 5
 sd 0:0:0:0: [sda] 625142448 512-byte hardware sectors (320073 MB)
 sd 0:0:0:0: [sda] Write Protect is off
@@ -255,10 +256,11 @@
 scsi3 : ata_piix
 ata3: SATA max UDMA/133 cmd 0x0001ec00 ctl 0x0001e882 bmdma 0x0001e400 irq 19
 ata4: SATA max UDMA/133 cmd 0x0001e800 ctl 0x0001e482 bmdma 0x0001e408 irq 19
+ata3: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
+ata4: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
 ata4.00: ATAPI: TSSTcorpCD/DVDW SH-S183A, SB00, max UDMA/33
 ata4.00: applying bridge limits
 ata4.00: configured for UDMA/33
-ata4: EH pending after completion, repeating EH (cnt=4)
 scsi 3:0:0:0: CD-ROM            TSSTcorp CD/DVDW SH-S183A SB00 PQ: 0 ANSI: 5
 ata_piix 0000:00:1f.5: MAP [ P0 P2 P1 P3 ]
 ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 19 (level, low) -> IRQ 19
@@ -267,6 +269,8 @@
 scsi5 : ata_piix
 ata5: SATA max UDMA/133 cmd 0x0001d400 ctl 0x0001d082 bmdma 0x0001c880 irq 19
 ata6: SATA max UDMA/133 cmd 0x0001d000 ctl 0x0001cc02 bmdma 0x0001c888 irq 19
+ata5: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
+ata6: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
 kjournald starting.  Commit interval 5 seconds
 EXT3-fs: mounted filesystem with ordered data mode.
 usbcore: registered new interface driver usbfs

This is with both 1/2 and 2/2 applied, with only 2/2 applied the
"EH pending ..." is gone and the new "exception ... frozen" don't appear.

/Mikael
