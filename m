From: Andi Kleen <andi@firstfloor.org>
Subject: libata exception handling messages at boot on qemu
Date: Tue, 8 Jan 2008 20:23:52 +0100
Message-ID: <20080108192352.GA9110@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out04.alice-dsl.net ([88.44.63.6]:48588 "EHLO
	smtp-out04.alice-dsl.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbYAHTkM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jan 2008 14:40:12 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Is there a workaround for the long ugly boot messages on sees
with libata and qemu (0.9.0 CVS 070719)? It boots eventually, but it looks 
quite ugly.

I suppose that's a qemu device model bug or could it be a Linux
problem?

-Andi

Driver 'sd' needs updating - please use bus_type methods
Driver 'sr' needs updating - please use bus_type methods
scsi0 : ata_piix
scsi1 : ata_piix
ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc000 irq 14
ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc008 irq 15
ata1.00: ATA-7: QEMU HARDDISK, 0.9.0, max UDMA/100
ata1.00: 14062608 sectors, multi 16: LBA48 
ata1.00: configured for MWDMA2
ata2.00: ATAPI: QEMU CD-ROM, 0.9.0, max UDMA/100
ata2.00: configured for MWDMA2
scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    0.9. PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 14062608 512-byte hardware sectors (7200 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DP
O or FUA
sd 0:0:0:0: [sda] 14062608 512-byte hardware sectors (7200 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DP
O or FUA
 sda: sda1
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 1:0:0:0: CD-ROM            QEMU     QEMU CD-ROM      0.9. PQ: 0 ANSI: 5
ata2: DRQ=1 with device error, dev_stat 0x49
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
         cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         res 41/20:03:00:00:00/00:00:00:00:00/a0 Emask 0x3 (HSM violation)
ata2.00: status: { DRDY ERR }
ata2: soft resetting link
ata2.00: configured for MWDMA2
ata2: EH complete
ata2: DRQ=1 with device error, dev_stat 0x49
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
         cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         res 41/20:03:00:00:00/00:00:00:00:00/a0 Emask 0x3 (HSM violation)
ata2.00: status: { DRDY ERR }
ata2: soft resetting link
ata2.00: configured for MWDMA2
ata2: EH complete
ata2: DRQ=1 with device error, dev_stat 0x49
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
         cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         res 41/20:03:00:00:00/00:00:00:00:00/a0 Emask 0x3 (HSM violation)
ata2.00: status: { DRDY ERR }
ata2: soft resetting link
ata2.00: configured for MWDMA2
ata2: EH complete
ata2: DRQ=1 with device error, dev_stat 0x49
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
         cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         res 41/20:03:00:00:00/00:00:00:00:00/a0 Emask 0x3 (HSM violation)
ata2.00: status: { DRDY ERR }
ata2: soft resetting link
ata2.00: configured for MWDMA2
ata2: EH complete
ata2: DRQ=1 with device error, dev_stat 0x49
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
         cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         res 41/20:03:00:00:00/00:00:00:00:00/a0 Emask 0x3 (HSM violation)
ata2.00: status: { DRDY ERR }
ata2: soft resetting link
ata2.00: configured for MWDMA2
ata2: EH complete
ata2: DRQ=1 with device error, dev_stat 0x49
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
         cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         res 41/20:03:00:00:00/00:00:00:00:00/a0 Emask 0x3 (HSM violation)
ata2.00: status: { DRDY ERR }
ata2: soft resetting link
ata2.00: configured for MWDMA2
ata2: EH complete
ata2: DRQ=1 with device error, dev_stat 0x49
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
         cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         res 41/20:03:00:00:00/00:00:00:00:00/a0 Emask 0x3 (HSM violation)
ata2.00: status: { DRDY ERR }
ata2: soft resetting link
ata2.00: configured for MWDMA2
ata2: EH complete
ata2: DRQ=1 with device error, dev_stat 0x49
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
         cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         res 41/20:03:00:00:00/00:00:00:00:00/a0 Emask 0x3 (HSM violation)
ata2.00: status: { DRDY ERR }
ata2: soft resetting link
ata2.00: configured for MWDMA2
ata2: EH complete
ata2: DRQ=1 with device error, dev_stat 0x49
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
         cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         res 41/20:03:00:00:00/00:00:00:00:00/a0 Emask 0x3 (HSM violation)
ata2.00: status: { DRDY ERR }
ata2: soft resetting link
ata2.00: configured for MWDMA2
ata2: EH complete
ata2: DRQ=1 with device error, dev_stat 0x49
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
         cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         res 41/20:03:00:00:00/00:00:00:00:00/a0 Emask 0x3 (HSM violation)
ata2.00: status: { DRDY ERR }
ata2: soft resetting link
ata2.00: configured for MWDMA2
ata2: EH complete
ata2: DRQ=1 with device error, dev_stat 0x49
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
         cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         res 41/20:03:00:00:00/00:00:00:00:00/a0 Emask 0x3 (HSM violation)
ata2.00: status: { DRDY ERR }
ata2: soft resetting link
ata2.00: configured for MWDMA2
ata2: EH complete
ata2: DRQ=1 with device error, dev_stat 0x49
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
         cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         res 41/20:03:00:00:00/00:00:00:00:00/a0 Emask 0x3 (HSM violation)
ata2.00: status: { DRDY ERR }
ata2: soft resetting link
ata2.00: configured for MWDMA2
ata2: EH complete
ata2: DRQ=1 with device error, dev_stat 0x49
...
ata2.00: status: { DRDY ERR }
ata2: soft resetting link
ata2.00: configured for MWDMA2
ata2: EH complete
ata2: DRQ=1 with device error, dev_stat 0x49
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
         cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         res 41/20:03:00:00:00/00:00:00:00:00/a0 Emask 0x3 (HSM violation)
ata2.00: status: { DRDY ERR }
ata2: soft resetting link
ata2.00: configured for MWDMA2
ata2: EH complete

