From: <cyrix12@cox.net>
Subject: libata problem or hard drive failure?
Date: Wed, 25 Jul 2007 14:44:56 -0400
Message-ID: <11718197.1185389096527.JavaMail.root@eastrmwml27.mgt.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eastrmmtai111.cox.net ([68.230.240.30]:38872 "EHLO
	eastrmmtai111.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661AbXGYTDy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Jul 2007 15:03:54 -0400
Received: from eastrmimpo02.cox.net ([68.1.16.120])
          by eastrmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070725184456.WRLJ9166.eastrmmtao105.cox.net@eastrmimpo02.cox.net>
          for <linux-ide@vger.kernel.org>; Wed, 25 Jul 2007 14:44:56 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I've been having a problem with one of my two sata drives (both Maxtor 500gb, model 7H500F0) for a considerable amount of time, and I can't figure out whether the cause is a defect in the drive itself or in the kernel sata drivers.  I'm hoping that someone here will be able to help me out.

Motherboard: NFORCE-MCP51
System:           2.4ghz core 2 duo, 2gb ram
SATA driver:    sata_nv (compiled into kernel)
Kernel:             2.6.22-ck1 (I've tried vanilla though, no difference)


At present, the kernel does not correctly detect my drive, instead giving the following error on bootup (including the correct detection of the other identical sata drive right after the error) :

ide: Assuming 66MHz system bus speed for PIO modes
NFORCE-MCP51: IDE controller at PCI slot 0000:00:0d.0
NFORCE-MCP51: chipset revision 161
NFORCE-MCP51: not 100% native mode: will probe irqs later
NFORCE-MCP51: User given PCI clock speed impossible (66000), using 33 MHz instead.
NFORCE-MCP51: 0000:00:0d.0 (rev a1) UDMA133 controller
    ide0: BM-DMA at 0xf400-0xf407, BIOS settings: hda:DMA, hdb:DMA
Probing IDE interface ide0...
hda: WDC WD800JB-00CRA1, ATA DISK drive
hdb: SAMSUNG SP1203N, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes not supported
 hda: hda1 hda2 hda3 hda4 < hda5 >
hdb: max request size: 512KiB
hdb: 234493056 sectors (120060 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
hdb: cache flushes supported
 hdb: hdb1
sata_nv 0000:00:0e.0: version 3.4
PCI: Setting latency timer of device 0000:00:0e.0 to 64
scsi0 : sata_nv
scsi1 : sata_nv
ata1: SATA max UDMA/133 cmd 0x000109f0 ctl 0x00010bf2 bmdma 0x0001e000 irq 11
ata2: SATA max UDMA/133 cmd 0x00010970 ctl 0x00010b72 bmdma 0x0001e008 irq 11
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-7: Maxtor 7H500F0, HA431DN0, max UDMA/133
ata1.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata1.00: configured for UDMA/133
ata2: port is slow to respond, please be patient (Status 0xff)
ata2: device not ready (errno=-16), forcing hardreset
ata2: SRST failed (errno=-19)
ata2: reset failed (errno=-19), retrying in 10 secs
ata2: SRST failed (errno=-19)
ata2: reset failed (errno=-19), retrying in 10 secs
ata2: SRST failed (errno=-19)
ata2: reset failed (errno=-19), retrying in 35 secs
ata2: SRST failed (errno=-19)
ata2: reset failed, giving up
scsi 0:0:0:0: Direct-Access     ATA      Maxtor 7H500F0   HA43 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda:<3>ata2: exception Emask 0x10 SAct 0x0 SErr 0x150000 action 0x2 frozen
ata2: hard resetting port
 sda1
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0

Later on, it tries to reset the bus again (I'm assuming, since I don't actually know how the mechanism for this works):

ata2: exception Emask 0x10 SAct 0x0 SErr 0x150000 action 0x2 frozen
ata2: hard resetting port
ata2: SRST failed (errno=-19)
ata2: reset failed (errno=-19), retrying in 9 secs
ata2: hard resetting port
ata2: SRST failed (errno=-19)
ata2: reset failed (errno=-19), retrying in 9 secs
ata2: hard resetting port
ata2: SRST failed (errno=-19)
ata2: reset failed (errno=-19), retrying in 34 secs
ata2: hard resetting port
ata2: SRST failed (errno=-19)
ata2: reset failed, giving up
ata2: EH pending after completion, repeating EH (cnt=4)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x150000 action 0x2 frozen
ata2: hard resetting port
ata2: SRST failed (errno=-19)
ata2: reset failed (errno=-19), retrying in 9 secs
ata2: hard resetting port
ata2: SRST failed (errno=-19)
ata2: reset failed (errno=-19), retrying in 9 secs
ata2: hard resetting port
ata2: SRST failed (errno=-19)
ata2: reset failed (errno=-19), retrying in 34 secs
ata2: hard resetting port
ata2: SRST failed (errno=-19)
ata2: reset failed, giving up
ata2: EH complete


According to smart the last time I had the drive available to the system, there is nothing wrong with the drive.  I ran bad block scans on the drive a couple days ago and come up with nothing.  It only stopped being detected today.  Prior to this, it would die at random with something like the following in my logs:

Jul 23 06:34:15 [kernel] ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
Jul 23 06:34:15 [kernel] ata4.00: (BMDMA stat 0x24)
Jul 23 06:34:15 [kernel] ata4.00: cmd 25/00:08:9f:9a:6b/00:00:32:00:00/e0 tag 0 cdb 0x0 data 4096 in
Jul 23 06:34:15 [kernel]          res 51/40:08:9f:9a:6b/40:00:32:00:00/e0 Emask 0x9 (media error)
Jul 23 06:34:32 [shutdown] shutting down for system halt
Jul 23 06:34:46 [kernel] ata4.00: qc timeout (cmd 0xec)
Jul 23 06:34:46 [kernel] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
Jul 23 06:34:46 [kernel] ata4.00: revalidation failed (errno=-5)
Jul 23 06:34:46 [kernel] ata4: failed to recover some devices, retrying in 5 secs
Jul 23 06:34:58 [kernel] ata4: port is slow to respond, please be patient (Status 0xd1)
Jul 23 06:35:22 [kernel] ata4: port failed to respond (30 secs, Status 0xd1)
Jul 23 06:35:22 [kernel] ata4: soft resetting port
Jul 23 06:35:29 [kernel] ata4: port is slow to respond, please be patient (Status 0xd1)
Jul 23 06:35:52 [kernel] ata4: port failed to respond (30 secs, Status 0xd1)
Jul 23 06:35:52 [kernel] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jul 23 06:35:52 [kernel] ATA: abnormal status 0xD1 on port 0x00010967
                - Last output repeated 6 times -
Jul 23 06:36:23 [kernel] ata4.00: qc timeout (cmd 0xec)
Jul 23 06:36:23 [kernel] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
Jul 23 06:36:23 [kernel] ata4.00: revalidation failed (errno=-5)
Jul 23 06:36:23 [kernel] ata4.00: limiting speed to UDMA/133:PIO3
Jul 23 06:36:23 [kernel] ata4: failed to recover some devices, retrying in 5 secs
Jul 23 06:36:28 [kernel] ata4: hard resetting port
Jul 23 06:36:29 [kernel] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jul 23 06:36:59 [kernel] ata4.00: qc timeout (cmd 0xec)
Jul 23 06:36:59 [kernel] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
Jul 23 06:36:59 [kernel] ata4.00: revalidation failed (errno=-5)
Jul 23 06:36:59 [kernel] ata4.00: disabled
Jul 23 06:37:00 [kernel] ata4: EH complete
Jul 23 06:37:00 [kernel] sd 3:0:0:0: SCSI error: return code = 0x00040000
Jul 23 06:37:00 [kernel] end_request: I/O error, dev sdb, sector 845912735
Jul 23 06:37:00 [kernel] sd 3:0:0:0: SCSI error: return code = 0x00040000
Jul 23 06:37:00 [kernel] end_request: I/O error, dev sdb, sector 59175
Jul 23 06:37:00 [kernel] Buffer I/O error on device sdb1, logical block 7389
Jul 23 06:37:00 [kernel] lost page write due to I/O error on sdb1
Jul 23 06:37:00 [kernel] Buffer I/O error on device sdb1, logical block 7390
Jul 23 06:37:00 [kernel] lost page write due to I/O error on sdb1
Jul 23 06:37:00 [kernel] sd 3:0:0:0: SCSI error: return code = 0x00040000


The last several lines were iterated many, many times, and subsequent scans of the listed blocks never returned any errors.

If there's any further information that I can provide to assist in diagnosing the problem, let me know.


M. Blumenkrantz
