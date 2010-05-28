From: Alessandro Zummo <a.zummo@towertech.it>
Subject: sata_sil: freeze on modprobe
Date: Fri, 28 May 2010 20:38:32 +0200
Message-ID: <20100528203832.065a2469@linux.lan.towertech.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from elettra.colt-to.towertech.it ([213.215.222.70]:59332 "EHLO
	elettra.colt-to.towertech.it" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752397Ab0E1SqX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 May 2010 14:46:23 -0400
Received: from linux.lan.towertech.it (93-39-36-246.ip74.fastwebnet.it [93.39.36.246])
	by elettra.colt-to.towertech.it (Postfix) with ESMTPSA id DB2C1116695
	for <linux-ide@vger.kernel.org>; Fri, 28 May 2010 20:38:23 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


 I'm testing sata_sil with this controller:

00:0b.0 RAID bus controller: Silicon Image, Inc. SiI 3114 [SATALink/SATARaid] Serial ATA Controller (rev 02)
00:0b.0 0104: 1095:3114 (rev 02)

 with two different hard disks. On modprobe there's an EH situation
 which freezes the task for several minutes. The device
 node is not even created. The module device count is incremented to 3.

 an echo 1 >rescan triggers the same situation again.

 I'm running on 2.6.34. 

 how can I help debugging?


sata_sil 0000:00:0b.0: version 2.4
sata_sil 0000:00:0b.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
sata_sil 0000:00:0b.0: Applying R_ERR on DMA activate FIS errata fix
scsi4 : sata_sil
scsi5 : sata_sil
scsi6 : sata_sil
scsi7 : sata_sil
ata5: SATA max UDMA/100 mmio m1024@0xfde00000 tf 0xfde00080 irq 16
ata6: SATA max UDMA/100 mmio m1024@0xfde00000 tf 0xfde000c0 irq 16
ata7: SATA max UDMA/100 mmio m1024@0xfde00000 tf 0xfde00280 irq 16
ata8: SATA max UDMA/100 mmio m1024@0xfde00000 tf 0xfde002c0 irq 16
ata5: SATA link down (SStatus 0 SControl 310)
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata6.00: ATA-8: WDC WD2502ABYS-18B7A0, 02.03B04, max UDMA/133
ata6.00: 488281250 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata6.00: applying Seagate errata fix (mod15write workaround)
ata6.00: configured for UDMA/100
scsi 5:0:0:0: Direct-Access     ATA      WDC WD2502ABYS-1 02.0 PQ: 0 ANSI: 5
sd 5:0:0:0: Attached scsi generic sg2 type 0
sd 5:0:0:0: [sdc] 488281250 512-byte logical blocks: (250 GB/232 GiB)
sd 5:0:0:0: [sdc] Write Protect is off
sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdc:
ata7: SATA link down (SStatus 0 SControl 310)
ata8: SATA link down (SStatus 0 SControl 310)
ata6: drained 65536 bytes to clear DRQ.
ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.00: failed command: READ DMA
ata6.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata6.00: status: { DRDY }
ata6: hard resetting link
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata6.00: configured for UDMA/100
ata6.00: device reported invalid CHS sector 0
ata6: EH complete
ata6: drained 65536 bytes to clear DRQ.
ata6.00: limiting speed to UDMA/66:PIO4
ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.00: failed command: READ DMA
ata6.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata6.00: status: { DRDY }
ata6: hard resetting link
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata6.00: configured for UDMA/66
ata6.00: device reported invalid CHS sector 0
ata6: EH complete
ata6: drained 65536 bytes to clear DRQ.
ata6.00: limiting speed to UDMA/33:PIO4
ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.00: failed command: READ DMA
ata6.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata6.00: status: { DRDY }
ata6: hard resetting link
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata6.00: configured for UDMA/33
ata6.00: device reported invalid CHS sector 0
ata6: EH complete
ata6: drained 65536 bytes to clear DRQ.
ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.00: failed command: READ DMA
ata6.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata6.00: status: { DRDY }
ata6: hard resetting link
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata6.00: configured for UDMA/33
ata6.00: device reported invalid CHS sector 0
ata6: EH complete
ata6: drained 65536 bytes to clear DRQ.
ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.00: failed command: READ DMA
ata6.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata6.00: status: { DRDY }
ata6: hard resetting link
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata6.00: configured for UDMA/33
ata6.00: device reported invalid CHS sector 0
ata6: EH complete
ata6: drained 65536 bytes to clear DRQ.
ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.00: failed command: READ DMA
ata6.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata6.00: status: { DRDY }
ata6: hard resetting link
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata6.00: configured for UDMA/33
ata6.00: device reported invalid CHS sector 0
sd 5:0:0:0: [sdc] Result: hostbyte=0x00 driverbyte=0x08
sd 5:0:0:0: [sdc] Sense Key : 0xb [current] [descriptor]
Descriptor sense data with sense descriptors (in hex):
        72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
        00 00 00 00 
sd 5:0:0:0: [sdc] ASC=0x0 ASCQ=0x0
sd 5:0:0:0: [sdc] CDB: cdb[0]=0x28: 28 00 00 00 00 00 00 00 08 00
end_request: I/O error, dev sdc, sector 0
Buffer I/O error on device sdc, logical block 0
Buffer I/O error on device sdc, logical block 1
Buffer I/O error on device sdc, logical block 2
Buffer I/O error on device sdc, logical block 3
ata6: EH complete
ata6: drained 65536 bytes to clear DRQ.
ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.00: failed command: READ DMA
ata6.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata6.00: status: { DRDY }
ata6: hard resetting link
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata6.00: configured for UDMA/33
ata6.00: device reported invalid CHS sector 0
ata6: EH complete
ata6: drained 65536 bytes to clear DRQ.
ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.00: failed command: READ DMA
ata6.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata6.00: status: { DRDY }
ata6: hard resetting link
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata6.00: configured for UDMA/33
ata6.00: device reported invalid CHS sector 0
ata6: EH complete
ata6: drained 65536 bytes to clear DRQ.
ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.00: failed command: READ DMA
ata6.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata6.00: status: { DRDY }
ata6: hard resetting link
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata6.00: configured for UDMA/33
ata6.00: device reported invalid CHS sector 0
ata6: EH complete
ata6: drained 65536 bytes to clear DRQ.
ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.00: failed command: READ DMA
ata6.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata6.00: status: { DRDY }
ata6: hard resetting link
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata6.00: configured for UDMA/33
ata6.00: device reported invalid CHS sector 0
ata6: EH complete
ata6: drained 65536 bytes to clear DRQ.
ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.00: failed command: READ DMA
ata6.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata6.00: status: { DRDY }
ata6: hard resetting link
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata6.00: configured for UDMA/33
ata6.00: device reported invalid CHS sector 0
ata6: EH complete
ata6: drained 65536 bytes to clear DRQ.
ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.00: failed command: READ DMA
ata6.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata6.00: status: { DRDY }
ata6: hard resetting link
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata6.00: configured for UDMA/33
ata6.00: device reported invalid CHS sector 0
sd 5:0:0:0: [sdc] Result: hostbyte=0x00 driverbyte=0x08
sd 5:0:0:0: [sdc] Sense Key : 0xb [current] [descriptor]
Descriptor sense data with sense descriptors (in hex):
        72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
        00 00 00 00 
sd 5:0:0:0: [sdc] ASC=0x0 ASCQ=0x0
sd 5:0:0:0: [sdc] CDB: cdb[0]=0x28: 28 00 00 00 00 00 00 00 08 00
end_request: I/O error, dev sdc, sector 0
Buffer I/O error on device sdc, logical block 0
Buffer I/O error on device sdc, logical block 1
Buffer I/O error on device sdc, logical block 2
Buffer I/O error on device sdc, logical block 3
 unable to read partition table
ata6: EH complete
sdc: detected capacity change from 0 to 250000000000
sd 5:0:0:0: [sdc] Attached SCSI disk
sdc: detected capacity change from 0 to 250000000000


-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it

