From: Tomas Lund <tlund@nxs.se>
Subject: sata_sil24 failed command: READ FPDMA QUEUED
Date: Tue, 13 Jul 2010 23:09:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.1007132245000.24693@envy.nxs.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from envy.nxs.se ([212.247.200.182]:50480 "EHLO envy.nxs.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751829Ab0GMV2K (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Jul 2010 17:28:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by envy.nxs.se (Postfix) with ESMTP id 067882BEBE
	for <linux-ide@vger.kernel.org>; Tue, 13 Jul 2010 23:09:15 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Today I plugged in a brand new sil3132 controller (LYCOM SATA PE-103 2-CH) 
in my server, put it in the secondary graphics-card 16x PCI-Express slot 
(I wanted to find out if it worked there), hooked port 0 up to a PMP and 
attached two disks on port 0 and 1 and powered my server on.

After getting alot of errors at kernel start when it was detecting the 
disks (not saved, sorry) I started to eliminate things and narrow it down:

* SATA-controller is now in a "normal" 1x PCI-Express slot.
* No PMP, just one disk now attached to port 0 on the controller.
* Switched SATA-cable.
* Switched to a different disk (different vendor)

All disks I tried works fine on the motherboard ICH8 controler.

A google for the error message did not turn up alot of interesting 
results, trying my luck here instead, to see if anyone has any ideas.

Please let me know if you need any more output, or if you have something 
you want me to try.

Full "dmesg" output and kernel-config available at http://tlund.pp.se/sil24/

uname -a
========
Linux server 2.6.32.16 #3 SMP Tue Jul 13 21:14:20 CEST 2010 x86_64 GNU/Linux

SATA-controller as shown by "lcpci -v"
======================================
01:00.0 SATA controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01) (prog-if 00 [Vendor specific])
         Subsystem: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
         Flags: bus master, fast devsel, latency 0, IRQ 16
         Memory at f1004000 (64-bit, non-prefetchable) [size=128]
         Memory at f1000000 (64-bit, non-prefetchable) [size=16K]
         I/O ports at 8000 [size=128]
         [virtual] Expansion ROM at f8200000 [disabled] [size=512K]
         Capabilities: [54] Power Management version 2
         Capabilities: [5c] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
         Capabilities: [70] Express Legacy Endpoint, MSI 00
         Capabilities: [100] Advanced Error Reporting <?>
         Kernel driver in use: sata_sil24

"dmesg" output (relevant? parts)
================================
Linux version 2.6.32.16 (root@server) (gcc version 4.3.2 (Debian 4.3.2-1.1) ) #3 SMP Tue Jul 13 21:14:20 CEST 2010
<..>
sata_sil24 0000:02:00.0: version 1.1
sata_sil24 0000:02:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
sata_sil24 0000:02:00.0: setting latency timer to 64
<..>
scsi8 : sata_sil24
scsi9 : sata_sil24
ata9: SATA max UDMA/100 host m128@0xf1004000 port 0xf1000000 irq 17
ata10: SATA max UDMA/100 host m128@0xf1004000 port 0xf1002000 irq 17
<..>
ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata9.00: ATA-8: SAMSUNG HD103SJ, 1AJ10001, max UDMA/133
ata9.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata9.00: configured for UDMA/100
scsi 8:0:0:0: Direct-Access     ATA      SAMSUNG HD103SJ  1AJ1 PQ: 0 ANSI: 5
sd 8:0:0:0: [sdb] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
sd 8:0:0:0: Attached scsi generic sg1 type 0
sd 8:0:0:0: [sdb] Write Protect is off
sd 8:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 8:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
  sdb:
ata9.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x0
ata9.00: irq_stat 0x00020002, device error via D2H FIS
ata9.00: failed command: READ FPDMA QUEUED
ata9.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4096 in
          res 50/00:00:00:00:00/00:00:00:00:00/00 Emask 0x401 (device error) <F>
ata9.00: status: { DRDY }
ata9.00: configured for UDMA/100
ata9: EH complete
ata10: SATA link down (SStatus 0 SControl 0)
ata9.00: NCQ disabled due to excessive errors
ata9.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 frozen
ata9.00: failed command: READ FPDMA QUEUED
ata9.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4096 in
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata9.00: status: { DRDY }
ata9: hard resetting link
ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata9.00: configured for UDMA/100
ata9: EH complete
ata9.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata9.00: irq_stat 0x00020002, device error via D2H FIS
ata9.00: failed command: READ DMA
ata9.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
          res 51/04:08:00:00:00/00:00:00:00:00/e0 Emask 0x1 (device error)
ata9.00: status: { DRDY ERR }
ata9.00: error: { ABRT }
ata9.00: configured for UDMA/100
ata9: EH complete
ata9.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata9.00: irq_stat 0x00060002, device error via D2H FIS
ata9.00: failed command: READ DMA
ata9.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
          res 51/04:08:00:00:00/00:00:00:00:00/e0 Emask 0x1 (device error)
ata9.00: status: { DRDY ERR }
ata9.00: error: { ABRT }
ata9.00: configured for UDMA/100
ata9: EH complete
<..and it goes on..>

Best regards,
Tomas
