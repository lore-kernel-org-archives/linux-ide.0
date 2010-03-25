From: Marc MERLIN <marc@merlins.org>
Subject: PMP failure decoding help
Date: Thu, 25 Mar 2010 11:21:09 -0700
Message-ID: <20100325182109.GZ4442@merlins.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from magic.merlins.org ([209.81.13.136]:52009 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753974Ab0CYSs1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Mar 2010 14:48:27 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Hi,

I just added 5 2TB drives in an external enclosure that came with a PMP (so I have a single 
eSata cable going to some internal sil3124).
02:02.0 Mass storage controller: Silicon Image, Inc. SiI 3124 PCI-X Serial ATA Controller (rev 01)
PMP is detected as
ata6.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9                                                      

kernel: 2.6.31.6

2 logs below: 
1) drive discovery and init (with some errors)
2) drive being killed with
ata6.05: unsupported device, disabling
sd 7:0:0:0: [sdm] Add. Sense: Unrecovered read error - auto reallocate failed

Any idea if this is just one of those erratas between the sil 3124 and the
PMP that is so that it won't even work long enough to init the drives?

Thanks,
Marc


This is when I plugged the eSata cable in on a running system:

ata6: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
ata6: irq_stat 0x00b40090, PHY RDY changed
ata6: hard resetting link
ata6: SATA link down (SStatus 0 SControl 0)
ata6: EH complete
ata6: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
ata6: irq_stat 0x00b00090, PHY RDY changed
ata6: hard resetting link
ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata6.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
scsi_eh_7: page allocation failure. order:4, mode:0x10
ata6.15: failed to initialize PMP links
ata6: hard resetting link
ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata6.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
ata6.00: hard resetting link
ata6.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
ata6.01: hard resetting link
ata6.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.02: hard resetting link
ata6.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.03: hard resetting link
ata6.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.04: hard resetting link
ata6.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.05: hard resetting link
ata6.05: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata6.06: hard resetting link
ata6.06: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata6.00: qc timeout (cmd 0xec)
ata6.00: failed to IDENTIFY (I/O error, err_mask=0x5)
ata6.15: hard resetting link
ata6.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata6.00: hard resetting link
ata6.00: failed to read SCR 0 (Emask=0x40)
ata6.00: COMRESET failed (errno=-5)
ata6.00: failed to read SCR 0 (Emask=0x40)
ata6.00: reset failed, giving up
ata6.15: hard resetting link
ata6.15: SATA link down (SStatus 0 SControl 0)
ata6.15: failed to read PMP GSCR[0] (Emask=0x1)
ata6.15: PMP revalidation failed (errno=-5)
ata6.15: hard resetting link
ata6.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata6.00: hard resetting link
ata6.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
ata6.01: hard resetting link
ata6.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.02: hard resetting link
ata6.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.03: hard resetting link
ata6.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.04: hard resetting link
ata6.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.05: hard resetting link
ata6.05: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata6.06: hard resetting link
ata6.06: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata6.00: ATA-8: WDC WD20EADS-00R6B0, 01.00A01, max UDMA/133
ata6.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata6.00: configured for UDMA/100
ata6.01: ATA-8: WDC WD20EADS-00R6B0, 01.00A01, max UDMA/133
ata6.01: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata6.01: configured for UDMA/100
ata6.02: ATA-8: WDC WD20EADS-00R6B0, 01.00A01, max UDMA/133
ata6.02: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata6.02: configured for UDMA/100
ata6.03: ATA-8: WDC WD20EADS-00R6B0, 01.00A01, max UDMA/133
ata6.03: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata6.03: configured for UDMA/100
ata6.04: ATA-8: WDC WD20EADS-00S2B0, 01.00A01, max UDMA/133
ata6.04: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata6.04: configured for UDMA/100
ata6.05: unsupported device, disabling
ata6.05: disabled
ata6.15: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9 t4
ata6.15: irq_stat 0x00b40090, PHY RDY changed
ata6: EH complete
scsi 7:0:0:0: Direct-Access     ATA      WDC WD20EADS-00R 01.0 PQ: 0 ANSI: 5
sd 7:0:0:0: Attached scsi generic sg22 type 0
scsi 7:1:0:0: Direct-Access     ATA      WDC WD20EADS-00R 01.0 PQ: 0 ANSI: 5
sd 7:1:0:0: Attached scsi generic sg23 type 0
scsi 7:2:0:0: Direct-Access     ATA      WDC WD20EADS-00R 01.0 PQ: 0 ANSI: 5
sd 7:0:0:0: [sdm] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
sd 7:1:0:0: [sdn] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
sd 7:1:0:0: [sdn] Write Protect is off
sd 7:1:0:0: [sdn] Mode Sense: 00 3a 00 00
sd 7:1:0:0: [sdn] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 7:2:0:0: Attached scsi generic sg24 type 0
scsi 7:3:0:0: Direct-Access     ATA      WDC WD20EADS-00R 01.0 PQ: 0 ANSI: 5
 sdn:
sd 7:0:0:0: [sdm] Write Protect is off
 unknown partition table
sd 7:0:0:0: [sdm] Mode Sense: 00 3a 00 00
sd 7:0:0:0: [sdm] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdm:
sd 7:2:0:0: [sdo] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
sd 7:2:0:0: [sdo] Write Protect is off
sd 7:2:0:0: [sdo] Mode Sense: 00 3a 00 00
sd 7:2:0:0: [sdo] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 7:1:0:0: [sdn] Attached SCSI disk
sd 7:3:0:0: [sdp] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
sd 7:3:0:0: [sdp] Write Protect is off
sd 7:3:0:0: [sdp] Mode Sense: 00 3a 00 00
sd 7:3:0:0: [sdp] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 unknown partition table
 sdp: unknown partition table
sd 7:3:0:0: Attached scsi generic sg25 type 0
sd 7:0:0:0: [sdm] Attached SCSI disk
scsi 7:4:0:0: Direct-Access     ATA      WDC WD20EADS-00S 01.0 PQ: 0 ANSI: 5
sd 7:4:0:0: [sdq] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
sd 7:4:0:0: [sdq] Write Protect is off
sd 7:4:0:0: [sdq] Mode Sense: 00 3a 00 00
sd 7:4:0:0: [sdq] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 7:4:0:0: Attached scsi generic sg26 type 0
 sdo:
sd 7:3:0:0: [sdp] Attached SCSI disk
 unknown partition table
 sdq: unknown partition table
sd 7:2:0:0: [sdo] Attached SCSI disk
sd 7:4:0:0: [sdq] Attached SCSI disk
ata6.00: failed to read SCR 1 (Emask=0x40)
ata6.01: failed to read SCR 1 (Emask=0x40)
ata6.02: failed to read SCR 1 (Emask=0x40)
ata6.03: failed to read SCR 1 (Emask=0x40)
ata6.04: failed to read SCR 1 (Emask=0x40)
ata6.05: failed to read SCR 1 (Emask=0x40)
ata6.06: failed to read SCR 1 (Emask=0x40)
ata6.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xe frozen
ata6.15: irq_stat 0x01140010, PHY RDY changed
ata6.15: SError: { 10B8B }
ata6.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.15: hard resetting link
ata6.15: SATA link down (SStatus 0 SControl 0)
ata6.15: failed to read PMP GSCR[0] (Emask=0x1)
ata6.15: PMP revalidation failed (errno=-5)
ata6.15: hard resetting link
ata6.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata6.00: hard resetting link
ata6.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
ata6.01: hard resetting link
ata6.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.02: hard resetting link
ata6.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.03: hard resetting link
ata6.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.04: hard resetting link
ata6.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.05: hard resetting link
ata6.05: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata6.06: hard resetting link
ata6.06: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata6.00: configured for UDMA/100
ata6.01: configured for UDMA/100
ata6.02: configured for UDMA/100
ata6.03: configured for UDMA/100
ata6.04: configured for UDMA/100
ata6.05: unsupported device, disabling
ata6.05: disabled
ata6.15: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9 t4
ata6.15: irq_stat 0x00b40090, PHY RDY changed
ata6: EH complete

After that, I created my raid5 on top and started initializing it.
It worked for about 12H and then crapped out:

ata6.00: exception Emask 0x0 SAct 0xd SErr 0x0 action 0x6
ata6.00: irq_stat 0x00060002, device error via SDB FIS
ata6.00: cmd 60/d8:00:77:05:90/00:00:d0:00:00/40 tag 0 ncq 110592 in
         res 2e/36:00:00:00:00/00:00:00:00:2e/00 Emask 0x2 (HSM violation)
ata6.00: status: { DF DRQ }
ata6.00: error: { IDNF ABRT }
ata6.00: cmd 60/10:10:5f:05:90/00:00:d0:00:00/40 tag 2 ncq 8192 in
         res 41/40:00:69:05:90/2e:00:d0:00:00/40 Emask 0x409 (media error) <F>
ata6.00: status: { DRDY ERR }
ata6.00: error: { UNC }
ata6.00: cmd 60/08:18:6f:05:90/00:00:d0:00:00/40 tag 3 ncq 4096 in
         res 2e/36:00:00:00:00/00:00:00:30:2e/00 Emask 0x2 (HSM violation)
ata6.00: status: { DF DRQ }
ata6.00: error: { IDNF ABRT }
ata6.00: hard resetting link
ata6.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
ata6.00: configured for UDMA/100
ata6: EH complete
ata6.00: exception Emask 0x0 SAct 0x7 SErr 0x0 action 0x6
ata6.00: irq_stat 0x00060002, device error via SDB FIS
ata6.00: cmd 60/08:00:6f:05:90/00:00:d0:00:00/40 tag 0 ncq 4096 in
         res 2e/36:00:00:00:00/00:00:00:00:2e/00 Emask 0x2 (HSM violation)
ata6.00: status: { DF DRQ }
ata6.00: error: { IDNF ABRT }
ata6.00: cmd 60/10:08:5f:05:90/00:00:d0:00:00/40 tag 1 ncq 8192 in
         res 41/40:00:69:05:90/2e:00:d0:00:00/40 Emask 0x409 (media error) <F>
ata6.00: status: { DRDY ERR }
ata6.00: error: { UNC }
ata6.00: cmd 60/d8:10:77:05:90/00:00:d0:00:00/40 tag 2 ncq 110592 in
         res 2e/36:00:00:00:00/2e:00:00:20:2e/00 Emask 0x2 (HSM violation)
ata6.00: status: { DF DRQ }
ata6.00: error: { IDNF ABRT }
ata6.00: hard resetting link
ata6.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
ata6.00: configured for UDMA/100
ata6: EH complete
ata6.00: exception Emask 0x0 SAct 0x7 SErr 0x0 action 0x6
ata6.00: irq_stat 0x00060002, device error via SDB FIS
ata6.00: cmd 60/d8:00:77:05:90/00:00:d0:00:00/40 tag 0 ncq 110592 in
         res 2e/36:00:00:00:00/00:00:00:00:2e/00 Emask 0x2 (HSM violation)
ata6.00: status: { DF DRQ }
ata6.00: error: { IDNF ABRT }
ata6.00: cmd 60/10:08:5f:05:90/00:00:d0:00:00/40 tag 1 ncq 8192 in
         res 41/40:00:69:05:90/2e:00:d0:00:00/40 Emask 0x409 (media error) <F>
ata6.00: status: { DRDY ERR }
ata6.00: error: { UNC }
ata6.00: cmd 60/08:10:6f:05:90/00:00:d0:00:00/40 tag 2 ncq 4096 in
         res 2e/36:00:00:00:00/2e:00:00:20:2e/00 Emask 0x2 (HSM violation)
ata6.00: status: { DF DRQ }
ata6.00: error: { IDNF ABRT }
ata6.00: hard resetting link
ata6.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
ata6.00: configured for UDMA/100
ata6: EH complete
ata6.00: NCQ disabled due to excessive errors
ata6.00: exception Emask 0x0 SAct 0x7 SErr 0x0 action 0x6
ata6.00: irq_stat 0x00060002, device error via SDB FIS
ata6.00: cmd 60/08:00:6f:05:90/00:00:d0:00:00/40 tag 0 ncq 4096 in
         res 2e/36:00:00:00:00/00:00:00:00:2e/00 Emask 0x2 (HSM violation)
ata6.00: status: { DF DRQ }
ata6.00: error: { IDNF ABRT }
ata6.00: cmd 60/10:08:5f:05:90/00:00:d0:00:00/40 tag 1 ncq 8192 in
         res 41/40:00:69:05:90/2e:00:d0:00:00/40 Emask 0x409 (media error) <F>
ata6.00: status: { DRDY ERR }
ata6.00: error: { UNC }
ata6.00: cmd 60/d8:10:77:05:90/00:00:d0:00:00/40 tag 2 ncq 110592 in
         res 2e/36:00:00:00:00/2e:00:00:20:2e/00 Emask 0x2 (HSM violation)
ata6.00: status: { DF DRQ }
ata6.00: error: { IDNF ABRT }
ata6.00: hard resetting link
ata6.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
ata6.00: configured for UDMA/100
ata6: EH complete
ata6.00: failed to read SCR 1 (Emask=0x40)
ata6.01: failed to read SCR 1 (Emask=0x40)
ata6.02: failed to read SCR 1 (Emask=0x40)
ata6.03: failed to read SCR 1 (Emask=0x40)
ata6.04: failed to read SCR 1 (Emask=0x40)
ata6.05: failed to read SCR 1 (Emask=0x40)
ata6.06: failed to read SCR 1 (Emask=0x40)
ata6.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.00: irq_stat 0x00060002, device error via D2H FIS
ata6.00: cmd 25/00:10:5f:05:90/00:00:d0:00:00/e0 tag 0 dma 8192 in
         res 51/40:00:69:05:90/00:00:d0:00:00/e0 Emask 0x9 (media error)
ata6.00: status: { DRDY ERR }
ata6.00: error: { UNC }
ata6.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.02: exception Emask 0x2 SAct 0x4 SErr 0x0 action 0x6 frozen
ata6.02: irq_stat 0x00020002, ran out of SGEs while writing
ata6.02: cmd 61/d8:10:77:05:90/00:00:d0:00:00/40 tag 2 ncq 110592 out
         res 2e/36:00:00:00:00/2e:00:c0:21:2e/00 Emask 0x2 (HSM violation)
ata6.02: status: { DF DRQ }
ata6.02: error: { IDNF ABRT }
ata6.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.15: hard resetting link
ata6: spurious interrupt (slot_stat 0x0 active_tag -84148995 sactive 0x0)
ata6.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata6.15: PMP revalidation failed (errno=-19)
ata6.15: hard resetting link
ata6.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata6.00: hard resetting link
ata6.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
ata6.01: hard resetting link
ata6.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.02: hard resetting link
ata6.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.03: hard resetting link
ata6.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.04: hard resetting link
ata6.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.05: hard resetting link
ata6.05: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata6.06: hard resetting link
ata6.06: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata6.00: configured for UDMA/100
ata6.01: configured for UDMA/100
ata6.02: configured for UDMA/100
ata6.03: configured for UDMA/100
ata6.04: configured for UDMA/100
ata6.05: unsupported device, disabling
ata6.05: disabled
ata6: EH complete
ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata6.00: irq_stat 0x00060002, device error via D2H FIS
ata6.00: cmd 25/00:10:5f:05:90/00:00:d0:00:00/e0 tag 0 dma 8192 in
         res 51/40:00:69:05:90/00:00:d0:00:00/e0 Emask 0x9 (media error)
ata6.00: status: { DRDY ERR }
ata6.00: error: { UNC }
ata6.00: configured for UDMA/100
sd 7:0:0:0: [sdm] Unhandled sense code
sd 7:0:0:0: [sdm] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
sd 7:0:0:0: [sdm] Sense Key : Medium Error [current] [descriptor]
Descriptor sense data with sense descriptors (in hex):
        72 03 11 04 00 00 00 0c 00 0a 80 00 00 00 00 00
        d0 90 05 69
sd 7:0:0:0: [sdm] Add. Sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sdm, sector 3499099497
raid5:md7: read error not correctable (sector 3499099432 on sdm1).

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems & security ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
