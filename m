From: Russell King <rmk@arm.linux.org.uk>
Subject: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Thu, 24 Dec 2009 18:13:00 +0000
Message-ID: <20091224181300.GA4654@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41578 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754396AbZLXSNI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Dec 2009 13:13:08 -0500
Received: from flint.arm.linux.org.uk ([2002:4e20:1eda:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <rmk@arm.linux.org.uk>)
	id 1NNsBL-000734-Qt
	for linux-ide@vger.kernel.org; Thu, 24 Dec 2009 18:13:04 +0000
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.69)
	(envelope-from <rmk@flint.arm.linux.org.uk>)
	id 1NNsBJ-000217-Gu
	for linux-ide@vger.kernel.org; Thu, 24 Dec 2009 18:13:01 +0000
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I tried upgrading my main machine from an old 2.6.23 kernel to 2.6.32.
In doing so, I switched from IDE to ATA support.

However, I find that the Promise UDMA33 card fails to work in DMA mode
under PATA on 2.6.32, where as the 2.6.23 IDE driver works fine.  Reads
on PATA seem fine, it's just writes that seem to be causing grief.

Messages from 2.6.32 kernel (a little edited to remove the interleaving
with other kernel messages):

scsi0 : pata_pdc202xx_old
scsi1 : pata_pdc202xx_old
ata1: PATA max UDMA/33 cmd 0x10b0 ctl 0x10c0 bmdma 0x1080 irq 24
ata2: PATA max UDMA/33 cmd 0x10b8 ctl 0x10c4 bmdma 0x1088 irq 24
...
ata1.00: ATA-6: ST340015A, 3.01, max UDMA/100
ata1.00: 78165360 sectors, multi 16: LBA 
ata1.00: configured for UDMA/33
scsi 0:0:0:0: Direct-Access     ATA      ST340015A        3.01 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 78165360 512-byte logical blocks: (40.0 GB/37.2 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO
 or FUA
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 >
sd 0:0:0:0: [sda] Attached SCSI disk
ata2.00: ATA-6: ST340015A, 3.01, max UDMA/100
ata2.00: 78165360 sectors, multi 16: LBA 
ata2.00: configured for UDMA/33
scsi 1:0:0:0: Direct-Access     ATA      ST340015A        3.01 PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 78165360 512-byte logical blocks: (40.0 GB/37.2 GiB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO
 or FUA
 sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 sdb7 sdb8 sdb9 >
sd 1:0:0:0: [sdb] Attached SCSI disk
...
md1: detected capacity change from 0 to 2147876864
md: considering sdb1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: created md0
md: bind<sda1>
md: bind<sdb1>
md: running: <sdb1><sda1>
raid1: raid set md0 active with 2 out of 2 mirrors
md0: detected capacity change from 0 to 367329280
md: ... autorun DONE.
 md0: unknown partition table
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with writeback data mode.
VFS: Mounted root (ext3 filesystem) readonly on device 9:0.
Freeing init memory: 144K
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
ata1.00: BMDMA stat 0x24
ata1.00: failed command: WRITE DMA
ata1.00: cmd ca/00:08:bf:f2:0a/00:00:00:00:00/e0 tag 0 dma 4096 out
         res 51/84:00:bf:f2:0a/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata1.00: status: { DRDY ERR }
ata1.00: error: { ICRC ABRT }
ata1: soft resetting link
ata1.00: configured for UDMA/33
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
ata1.00: BMDMA stat 0x24
ata1.00: failed command: WRITE DMA
ata1.00: cmd ca/00:08:bf:f2:0a/00:00:00:00:00/e0 tag 0 dma 4096 out
         res 51/84:00:bf:f2:0a/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata1.00: status: { DRDY ERR }
ata1.00: error: { ICRC ABRT }
ata1: soft resetting link
ata1.00: configured for UDMA/33
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
ata1.00: BMDMA stat 0x24
ata1.00: failed command: WRITE DMA
ata1.00: cmd ca/00:08:bf:f2:0a/00:00:00:00:00/e0 tag 0 dma 4096 out
         res 51/84:00:bf:f2:0a/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata1.00: status: { DRDY ERR }
ata1.00: error: { ICRC ABRT }
ata1: soft resetting link
ata1.00: configured for UDMA/33
ata1: EH complete
ata1.00: limiting speed to UDMA/25:PIO4
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
ata1.00: BMDMA stat 0x24
ata1.00: failed command: WRITE DMA
ata1.00: cmd ca/00:08:bf:f2:0a/00:00:00:00:00/e0 tag 0 dma 4096 out
         res 51/84:00:bf:f2:0a/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata1.00: status: { DRDY ERR }
ata1.00: error: { ICRC ABRT }
ata1: soft resetting link
ata1.00: configured for UDMA/25
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
ata1.00: BMDMA stat 0x24
ata1.00: failed command: WRITE DMA
ata1.00: cmd ca/00:08:bf:f2:0a/00:00:00:00:00/e0 tag 0 dma 4096 out
         res 51/84:00:bf:f2:0a/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata1.00: status: { DRDY ERR }
ata1.00: error: { ICRC ABRT }
ata1: soft resetting link
ata1.00: configured for UDMA/25
ata1: EH complete
ata1.00: limiting speed to PIO4
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
ata1.00: BMDMA stat 0x24
ata1.00: failed command: WRITE DMA
ata1.00: cmd ca/00:08:bf:f2:0a/00:00:00:00:00/e0 tag 0 dma 4096 out
         res 51/84:00:bf:f2:0a/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata1.00: status: { DRDY ERR }
ata1.00: error: { ICRC ABRT }
ata1: soft resetting link
ata1.00: configured for PIO4
sd 0:0:0:0: [sda] Result: hostbyte=0x00 driverbyte=0x08
sd 0:0:0:0: [sda] Sense Key : 0xb [current] [descriptor]
Descriptor sense data with sense descriptors (in hex):
        72 0b 47 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
        00 0a f2 bf 
sd 0:0:0:0: [sda] ASC=0x47 ASCQ=0x0
sd 0:0:0:0: [sda] CDB: cdb[0]=0x2a: 2a 00 00 0a f2 bf 00 00 08 00
end_request: I/O error, dev sda, sector 717503
ata1: EH complete
end_request: I/O error, dev sda, sector 717503
md: super_written gets error=-5, uptodate=0
raid1: Disk failure on sda1, disabling device.
raid1: Operation continuing on 1 devices.
ata2: lost interrupt (Status 0x51)
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata2.00: failed command: WRITE DMA
ata2.00: cmd ca/00:08:bf:f2:0a/00:00:00:00:00/e0 tag 0 dma 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata2.00: status: { DRDY }
ata2: soft resetting link
ata2.00: configured for UDMA/33
ata2.00: device reported invalid CHS sector 0
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
ata2.00: BMDMA stat 0x44
ata2.00: failed command: WRITE DMA
ata2.00: cmd ca/00:08:bf:f2:0a/00:00:00:00:00/e0 tag 0 dma 4096 out
         res 51/84:00:bf:f2:0a/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata2.00: status: { DRDY ERR }
ata2.00: error: { ICRC ABRT }
ata2: soft resetting link
ata2.00: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
ata2.00: BMDMA stat 0x44
ata2.00: failed command: WRITE DMA
ata2.00: cmd ca/00:08:bf:f2:0a/00:00:00:00:00/e0 tag 0 dma 4096 out
         res 51/84:00:bf:f2:0a/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata2.00: status: { DRDY ERR }
ata2.00: error: { ICRC ABRT }
ata2: soft resetting link
ata2.00: configured for UDMA/33
ata2: EH complete
ata2.00: limiting speed to UDMA/25:PIO4
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
ata2.00: BMDMA stat 0x44
ata2.00: failed command: WRITE DMA
ata2.00: cmd ca/00:08:bf:f2:0a/00:00:00:00:00/e0 tag 0 dma 4096 out
         res 51/84:00:bf:f2:0a/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata2.00: status: { DRDY ERR }
ata2.00: error: { ICRC ABRT }
ata2: soft resetting link
ata2.00: configured for UDMA/25
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
ata2.00: BMDMA stat 0x44
ata2.00: failed command: WRITE DMA
ata2.00: cmd ca/00:08:bf:f2:0a/00:00:00:00:00/e0 tag 0 dma 4096 out
         res 51/84:00:bf:f2:0a/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata2.00: status: { DRDY ERR }
ata2.00: error: { ICRC ABRT }
ata2: soft resetting link
ata2.00: configured for UDMA/25
ata2: EH complete
ata2.00: limiting speed to PIO4
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
ata2.00: BMDMA stat 0x44
ata2.00: failed command: WRITE DMA
ata2.00: cmd ca/00:08:bf:f2:0a/00:00:00:00:00/e0 tag 0 dma 4096 out
         res 51/84:00:bf:f2:0a/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata2.00: status: { DRDY ERR }
ata2.00: error: { ICRC ABRT }
ata2: soft resetting link
ata2.00: configured for PIO4
sd 1:0:0:0: [sdb] Result: hostbyte=0x00 driverbyte=0x08
sd 1:0:0:0: [sdb] Sense Key : 0xb [current] [descriptor]
Descriptor sense data with sense descriptors (in hex):
        72 0b 47 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
        00 0a f2 bf 
sd 1:0:0:0: [sdb] ASC=0x47 ASCQ=0x0
sd 1:0:0:0: [sdb] CDB: cdb[0]=0x2a: 2a 00 00 0a f2 bf 00 00 08 00
end_request: I/O error, dev sdb, sector 717503
ata2: EH complete
end_request: I/O error, dev sdb, sector 717503
md: super_written gets error=-5, uptodate=0
RAID1 conf printout:
 --- wd:1 rd:2
 disk 0, wo:0, o:1, dev:sdb1
 disk 1, wo:1, o:0, dev:sda1



Diffing the PCI space, and the BMDMA space between the 2.6.23 and 2.6.32
kernels reveals nothing unexpected given the results from above:

--- promise-2.6.23-dump	2009-12-24 17:43:29.000000000 +0000
+++ promise-2.6.32-dump	2009-12-24 17:15:00.000000000 +0000
@@ -5,7 +5,7 @@
 30: 00 00 01 04 00 00 00 00 00 00 00 00 18 01 00 00
 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 50: ee 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-60: f1 24 41 00 c4 f3 4f 00 f1 24 41 00 c4 f3 4f 00
+60: f1 44 42 00 c9 f3 4f 00 f1 44 42 00 c9 f3 4f 00
 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 80: 5a 10 33 4d 07 00 00 02 01 00 04 01 00 00 00 00
 90: b1 10 00 00 c1 10 00 00 b9 10 00 00 c5 10 00 00
@@ -13,9 +13,9 @@
 b0: 00 00 01 04 00 00 00 00 00 00 00 00 18 01 00 00
 c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 d0: ee 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-e0: f1 24 41 00 c4 f3 4f 00 f1 24 41 00 c4 f3 4f 00
+e0: f1 44 42 00 c9 f3 4f 00 f1 44 42 00 c9 f3 4f 00
 f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 
-1080: 00240000  e051b008  00640000  e051c008
+1080: 00200000  e7942008  00400000  e7943008
 1090: 00000000  00000000  00000000  01d2110c
 

Could this be another case where the kernel should always need to write
out the full task file to the drive?  I don't see any form of hardware
control on the PDC20247 (which is the UDMA add-on to the PDC20246 chip)
to control its mode, other than it snooping the taskfile writes.

(I'm referring there to my old 380XD thinkpad where the drive regularly
goes into lemon mode because the APM bios touches it behind the kernel's
back.  Alan said that was caused by PATA not writing the full taskfile
out, resulting in some registers being left in unexpected states by the
APM bios.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
