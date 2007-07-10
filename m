From: Rod Whitby <rod@whitby.id.au>
Subject: sata-via failure on 2.6.22 for via 6421 chipset (Was: Libata PATA
 status)
Date: Tue, 10 Jul 2007 21:23:52 +0930
Message-ID: <46937350.7070108@whitby.id.au>
References: <20070703185116.59c8f5f5@the-village.bc.nu> <468D7034.7060107@whitby.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:50616 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752985AbXGJL4q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jul 2007 07:56:46 -0400
In-Reply-To: <468D7034.7060107@whitby.id.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rod Whitby <rod@whitby.id.au>, linux-ide@vger.kernel.org, jeff@garzik.org

Rod Whitby wrote:
> Our project is also working on adding support to the kernel for the
> Freecom FSG-3 NAS device.  It uses the sata-via driver for it's VIA_6421
> chipset, but the main drive is a PATA drive (the device also has an
> eSATA external port).
> 
> We're currently stuck at 2.6.18 with vendor patches for scsi/sata-via,
> and would love to move to 2.6.22 and libata, but are having problems
> with the latest sata-via driver for this chipset booting from an IDE
> drive.  I'll contact you separately for this issue (as it's off-topic on
> this thread).

Here is the dmesg output of the sata-via driver failing to access the
internal PATA disk on the Freecom FSG-3 running mainline 2.6.22.  The
other two SATA ports are unused on this device (one is not connected at
all on the PCB, the other is an external eSATA port).

Any advice on how to debug this failure further would be greatly
appreciated.

> PCI: enabling device 0000:00:0c.0 (0000 -> 0001)
> sata_via 0000:00:0c.0: routed to hard irq line 6
> scsi0 : sata_via
> scsi1 : sata_via
> scsi2 : sata_via
> ata1: SATA max UDMA/133 cmd 0x00011420 ctl 0x0001142a bmdma 0x00011400 irq 22
> ata2: SATA max UDMA/133 cmd 0x00011430 ctl 0x0001143a bmdma 0x00011408 irq 22
> ata3: PATA max UDMA/133 cmd 0x00011440 ctl 0x0001144a bmdma 0x00011410 irq 22
> ata1: SATA link down (SStatus 0 SControl 310)
> ata2: SATA link down (SStatus 0 SControl 310)
> ata3.00: ATA-7: HDT722516DLAT80, V43OA96A, max UDMA/133
> ata3.00: 321672960 sectors, multi 0: LBA48
> ata3.00: limited to UDMA/33 due to 40-wire cable
> ata3.00: configured for UDMA/33
> scsi 2:0:0:0: Direct-Access     ATA      HDT722516DLAT80  V43O PQ: 0 ANSI: 5
> sd 2:0:0:0: [sda] 321672960 512-byte hardware sectors (164697 MB)
> sd 2:0:0:0: [sda] Write Protect is off
> sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPA
> sd 2:0:0:0: [sda] 321672960 512-byte hardware sectors (164697 MB)
> sd 2:0:0:0: [sda] Write Protect is off
> sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPA
>  sda: sda1 sda2 sda3 sda4
> sd 2:0:0:0: [sda] Attached SCSI disk
> ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata3.00: cmd c8/00:02:4f:00:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 1024 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3: soft resetting port
> ata3.00: qc timeout (cmd 0x27)
> ata3.00: ata_hpa_resize 1: hpa sectors (0) is smaller than sectors (321672960)
> ata3.00: failed to set xfermode (err_mask=0x40)
> ata3: failed to recover some devices, retrying in 5 secs
> ata3: soft resetting port
> ata3.00: qc timeout (cmd 0x27)
> ata3.00: ata_hpa_resize 1: hpa sectors (0) is smaller than sectors (321672960)
> ata3.00: failed to set xfermode (err_mask=0x40)
> ata3.00: limiting speed to UDMA/33:PIO3
> ata3: failed to recover some devices, retrying in 5 secs
> ata3: soft resetting port
> ata3.00: qc timeout (cmd 0x27)
> ata3.00: ata_hpa_resize 1: hpa sectors (0) is smaller than sectors (321672960)
> ata3.00: failed to set xfermode (err_mask=0x40)
> ata3.00: disabled
> ata3: EH complete
> sd 2:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
> end_request: I/O error, dev sda, sector 79
> ReiserFS: sda1: warning: sh-2006: read_super_block: bread failed (dev sda1, blo)
> sd 2:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
> end_request: I/O error, dev sda, sector 191
> ReiserFS: sda1: warning: sh-2006: read_super_block: bread failed (dev sda1, blo)
> sd 2:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
> end_request: I/O error, dev sda, sector 65
> sd 2:0:0:0: [sda] READ CAPACITY failed
> sd 2:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
> sd 2:0:0:0: [sda] Sense not available.
> EXT3-fs: unable to read superblock
> sd 2:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
> end_request: I/O error, dev sda, sector 65
> sd 2:0:0:0: [sda] Write Protect is off
> EXT2-fs: unable to read superblock

-- Rod
