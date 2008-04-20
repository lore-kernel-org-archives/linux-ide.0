From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Commit 305d2a1ab137d1... breaks sata_nv, and PMP woes
Date: Sat, 19 Apr 2008 21:31:17 -0700
Message-ID: <480AC715.2060303@vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailgw.cvut.cz ([147.32.3.235]:54659 "EHLO mailgw.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750864AbYDTEtf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 20 Apr 2008 00:49:35 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello Tejun,
   since commit 305d2a (unify mechanism to request follow-up SRST) no 
devices behind my sata_nv are recognized anymore.  Driver reports 
correctly link speed 1.5GBps (for CDROM) and 3GBps (for harddisk), but 
devices themselves are not found, and so boot fails.  Reverting this 
commit fixes problem...

commit 305d2a1ab137d11d573319c315748a87060fe82d
Author: Tejun Heo <htejun@gmail.com>
Date:   Mon Apr 7 22:47:20 2008 +0900

     libata: unify mechanism to request follow-up SRST

Controller in question is:

00:08.0 IDE interface: nVidia Corporation MCP61 SATA Controller (rev a2)
00:08.1 IDE interface: nVidia Corporation MCP61 SATA Controller (rev a2)




Also another problem - which is too hardware demanding to bisect, but 
maybe you will know what's going on.  I have Sil3132 with external 
enclosure with PMP (sil3726), which is usually powered off.  When I 
power it on with Windows, all 4 disks are enumerated in ~20 seconds - 
just as they spin up one after another, without any resets.  Under Linux 
  up to 2.6.25 it took ~2 minutes, with two complete resets for each of 
drives (start spinup on first disk, two complete resets of enclosure, 
start spinup on second disk, two complete resets, ...).  With current 
git (up to commit 3925e6fc1f774048404fdd910b0345b06c699eb4) it even did 
not come up at all - enclosure says that all 4 disks are online, but 
somehow kernel gave up on PMP and started talking to drive 0 only 
(problem is with change above reverted, as without this my system does 
not even boot, not even talking about external disks):

<poweron enclosure>
ata8: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
ata8: irq_stat 0x00b40090, PHY RDY changed
ata8: hard resetting link
ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata8.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
ata8.00: hard resetting link
ata8.00: softreset failed (SRST command error)
ata8.00: failed to read SCR 0 (Emask=0x40)
ata8.00: reset failed, giving up
ata8.15: hard resetting link
ata8.15: softreset failed (SRST command error)
ata8.15: reset failed (errno=-5), retrying in 8 secs
ata8.15: hard resetting link
ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata8.15: PMP revalidation failed (errno=-19)
ata8.15: retrying reset in 5 secs
ata8.15: hard resetting link
ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata8.00: hard resetting link
ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
ata8.01: hard resetting link
ata8.01: softreset failed (SRST command error)
ata8.01: failed to read SCR 0 (Emask=0x40)
ata8.01: reset failed, giving up
ata8.15: hard resetting link
ata8: controller in dubious state, performing PORT_RST
ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata8.00: hard resetting link
ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
ata8.01: hard resetting link
ata8.01: softreset failed (SRST command error)
ata8.01: failed to read SCR 0 (Emask=0x40)
ata8.01: reset failed, giving up
ata8.15: hard resetting link
ata8: controller in dubious state, performing PORT_RST
ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata8.00: hard resetting link
ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
ata8.01: hard resetting link
ata8.01: softreset failed (SRST command error)
ata8.01: failed to read SCR 0 (Emask=0x40)
ata8.01: reset failed, giving up
ata8.01: failed to recover link after 3 tries, disabling
ata8: failed to recover PMP, retrying in 5 secs
ata8.15: hard resetting link
ata8: controller in dubious state, performing PORT_RST
ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata8.00: hard resetting link
ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
ata8.02: hard resetting link
ata8.02: softreset failed (SRST command error)
ata8.02: failed to read SCR 0 (Emask=0x40)
ata8.02: reset failed, giving up
ata8.15: hard resetting link
ata8.15: softreset failed (SRST command error)
ata8.15: reset failed (errno=-5), retrying in 8 secs
ata8.15: hard resetting link
ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata8.15: PMP revalidation failed (errno=-19)
ata8.15: retrying reset in 5 secs
ata8.15: hard resetting link
ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata8.00: hard resetting link
ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
ata8.02: hard resetting link
ata8.02: softreset failed (SRST command error)
ata8.02: failed to read SCR 0 (Emask=0x40)
ata8.02: reset failed, giving up
ata8.15: hard resetting link
ata8: controller in dubious state, performing PORT_RST
ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata8.00: hard resetting link
ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
ata8.02: hard resetting link
ata8.02: softreset failed (SRST command error)
ata8.02: failed to read SCR 0 (Emask=0x40)
ata8.02: reset failed, giving up
ata8.02: failed to recover link after 3 tries, disabling
ata8: failed to recover PMP, retrying in 5 secs
ata8.15: hard resetting link
ata8.15: softreset failed (SRST command error)
ata8.15: reset failed (errno=-5), retrying in 8 secs
ata8.15: hard resetting link
ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata8.15: PMP revalidation failed (errno=-19)
ata8.15: retrying reset in 5 secs
ata8.15: hard resetting link
ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata8.00: hard resetting link
ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
ata8.03: hard resetting link
ata8.03: softreset failed (SRST command error)
ata8.03: failed to read SCR 0 (Emask=0x40)
ata8.03: reset failed, giving up
ata8.15: hard resetting link
ata8.15: softreset failed (SRST command error)
ata8.15: reset failed (errno=-5), retrying in 8 secs
ata8.15: hard resetting link
ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata8.15: PMP revalidation failed (errno=-19)
ata8.15: retrying reset in 5 secs
ata8.15: hard resetting link
ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata8.00: hard resetting link
ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
ata8.03: hard resetting link
ata8.03: softreset failed (SRST command error)
ata8.03: failed to read SCR 0 (Emask=0x40)
ata8.03: reset failed, giving up
ata8.15: hard resetting link
ata8: controller in dubious state, performing PORT_RST
ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata8.00: hard resetting link
ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
ata8.03: hard resetting link
ata8.03: softreset failed (SRST command error)
ata8.03: failed to read SCR 0 (Emask=0x40)
ata8.03: reset failed, giving up
ata8.03: failed to recover link after 3 tries, disabling
ata8: failed to recover PMP, retrying in 5 secs
ata8.15: hard resetting link
ata8: controller in dubious state, performing PORT_RST
ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata8.00: hard resetting link
ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
ata8.04: hard resetting link
ata8.04: SATA link down (SStatus 0 SControl 320)
ata8.05: hard resetting link
ata8.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata8.00: ATA-7: Hitachi HDS721010KLA330, GKAOA70F, max UDMA/133
ata8.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata8.00: configured for UDMA/100
ata8.00: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x1 t4
ata8.00: irq_stat 0x00060002, failed to transmit command FIS
ata8.15: qc timeout (cmd 0xe8)
ata8.01: failed to write SCR 2 (Emask=0x4)
ata8.01: COMRESET failed (errno=-5)
ata8.01: failed to write SCR 1 (Emask=0x40)
ata8.01: failed to clear SError.N (errno=-5)
ata8: failed to recover PMP, retrying in 5 secs
ata8.15: hard resetting link
ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata8.00: hard resetting link
ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
ata8.04: hard resetting link
ata8.04: SATA link down (SStatus 0 SControl 320)
ata8.05: hard resetting link
ata8.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata8.00: configured for UDMA/100
ata8.15: qc timeout (cmd 0xe8)
ata8.01: failed to write SCR 2 (Emask=0x4)
ata8.01: COMRESET failed (errno=-5)
ata8.01: failed to write SCR 1 (Emask=0x40)
ata8.01: failed to clear SError.N (errno=-5)
ata8: failed to recover PMP, retrying in 5 secs
ata8.15: hard resetting link
ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata8.00: hard resetting link
ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
ata8.04: hard resetting link
ata8.04: SATA link down (SStatus 0 SControl 320)
ata8.05: hard resetting link
ata8.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata8.00: configured for UDMA/100
ata8.15: qc timeout (cmd 0xe8)
ata8.01: failed to write SCR 2 (Emask=0x4)
ata8.01: COMRESET failed (errno=-5)
ata8.01: failed to write SCR 1 (Emask=0x40)
ata8.01: failed to clear SError.N (errno=-5)
ata8: failed to recover PMP, retrying in 5 secs
ata8.15: hard resetting link
ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata8.00: hard resetting link
ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
ata8.04: hard resetting link
ata8.04: SATA link down (SStatus 0 SControl 320)
ata8.05: hard resetting link
ata8.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata8.00: configured for UDMA/100
ata8.15: qc timeout (cmd 0xe8)
ata8.01: failed to write SCR 2 (Emask=0x4)
ata8.01: COMRESET failed (errno=-5)
ata8.01: failed to write SCR 1 (Emask=0x40)
ata8.01: failed to clear SError.N (errno=-5)
ata8: failed to recover PMP, retrying in 5 secs
ata8.15: hard resetting link
ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata8.00: hard resetting link
ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
ata8.04: hard resetting link
ata8.04: SATA link down (SStatus 0 SControl 320)
ata8.05: hard resetting link
ata8.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata8.00: configured for UDMA/100
ata8: EH pending after 5 tries, giving up
ata8: EH complete
scsi 7:0:0:0: Direct-Access     ATA      Hitachi HDS72101 GKAO PQ: 0 ANSI: 5
sd 7:0:0:0: [sdf] 1953525168 512-byte hardware sectors (1000205 MB)
sd 7:0:0:0: [sdf] Write Protect is off
sd 7:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 7:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 7:0:0:0: [sdf] 1953525168 512-byte hardware sectors (1000205 MB)
sd 7:0:0:0: [sdf] Write Protect is off
sd 7:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 7:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sdf: sdf1
sd 7:0:0:0: [sdf] Attached SCSI disk
sd 7:0:0:0: Attached scsi generic sg7 type 0

That's all...  I had to reload sata_sil24 to bring them all back to life:

ACPI: PCI interrupt for device 0000:05:00.0 disabled
sata_sil24 0000:05:00.0: version 1.1
ACPI: PCI Interrupt 0000:05:00.0[A] -> Link [APC5] -> GSI 16 (level, 
low) -> IRQ 16
PCI: Setting latency timer of device 0000:05:00.0 to 64
scsi9 : sata_sil24
scsi10 : sata_sil24
ata9: SATA max UDMA/100 host m128@0xfdaff000 port 0xfdaf8000 irq 16
ata10: SATA max UDMA/100 host m128@0xfdaff000 port 0xfdafa000 irq 16
ata9: SATA link down (SStatus 0 SControl 0)
ata10: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata10.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
ata10.00: hard resetting link
ata10.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
ata10.01: hard resetting link
ata10.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.02: hard resetting link
ata10.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.03: hard resetting link
ata10.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.04: hard resetting link
ata10.04: SATA link down (SStatus 0 SControl 320)
ata10.05: hard resetting link
ata10.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata10.00: ATA-7: Hitachi HDS721010KLA330, GKAOA70F, max UDMA/133
ata10.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata10.00: configured for UDMA/100
ata10.01: ATA-7: Hitachi HDS721010KLA330, GKAOA70M, max UDMA/133
ata10.01: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata10.01: configured for UDMA/100
ata10.02: ATA-7: Hitachi HDS721010KLA330, GKAOA70F, max UDMA/133
ata10.02: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata10.02: configured for UDMA/100
ata10.03: ATA-7: Hitachi HDS721010KLA330, GKAOA70M, max UDMA/133
ata10.03: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata10.03: configured for UDMA/100
ata10: EH complete
scsi 10:0:0:0: Direct-Access     ATA      Hitachi HDS72101 GKAO PQ: 0 
ANSI: 5
sd 10:0:0:0: [sdf] 1953525168 512-byte hardware sectors (1000205 MB)
sd 10:0:0:0: [sdf] Write Protect is off
sd 10:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 10:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 10:0:0:0: [sdf] 1953525168 512-byte hardware sectors (1000205 MB)
sd 10:0:0:0: [sdf] Write Protect is off
sd 10:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 10:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sdf: sdf1
sd 10:0:0:0: [sdf] Attached SCSI disk
sd 10:0:0:0: Attached scsi generic sg7 type 0
scsi 10:1:0:0: Direct-Access     ATA      Hitachi HDS72101 GKAO PQ: 0 
ANSI: 5
sd 10:1:0:0: [sdg] 1953525168 512-byte hardware sectors (1000205 MB)
sd 10:1:0:0: [sdg] Write Protect is off
sd 10:1:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 10:1:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 10:1:0:0: [sdg] 1953525168 512-byte hardware sectors (1000205 MB)
sd 10:1:0:0: [sdg] Write Protect is off
sd 10:1:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 10:1:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sdg: sdg1
sd 10:1:0:0: [sdg] Attached SCSI disk
sd 10:1:0:0: Attached scsi generic sg8 type 0
scsi 10:2:0:0: Direct-Access     ATA      Hitachi HDS72101 GKAO PQ: 0 
ANSI: 5
sd 10:2:0:0: [sdh] 1953525168 512-byte hardware sectors (1000205 MB)
sd 10:2:0:0: [sdh] Write Protect is off
sd 10:2:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 10:2:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 10:2:0:0: [sdh] 1953525168 512-byte hardware sectors (1000205 MB)
sd 10:2:0:0: [sdh] Write Protect is off
sd 10:2:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 10:2:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sdh: sdh1
sd 10:2:0:0: [sdh] Attached SCSI disk
sd 10:2:0:0: Attached scsi generic sg9 type 0
scsi 10:3:0:0: Direct-Access     ATA      Hitachi HDS72101 GKAO PQ: 0 
ANSI: 5
sd 10:3:0:0: [sdi] 1953525168 512-byte hardware sectors (1000205 MB)
sd 10:3:0:0: [sdi] Write Protect is off
sd 10:3:0:0: [sdi] Mode Sense: 00 3a 00 00
sd 10:3:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 10:3:0:0: [sdi] 1953525168 512-byte hardware sectors (1000205 MB)
sd 10:3:0:0: [sdi] Write Protect is off
sd 10:3:0:0: [sdi] Mode Sense: 00 3a 00 00
sd 10:3:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sdi: sdi1
sd 10:3:0:0: [sdi] Attached SCSI disk
sd 10:3:0:0: Attached scsi generic sg10 type 0


					Thanks,
							Petr

