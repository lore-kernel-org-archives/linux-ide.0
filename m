From: "Jon Chelton" <jchelton@ffpglobal.com>
Subject: new errors with sata_sil24 with port multiplier
Date: Fri, 2 Nov 2007 21:22:40 -0400
Message-ID: <FD6311B7ED175B4480F31633F6098B4DA0EB24@ffpglobal_mail.corp.ffplus.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 66-189-16-56.static.oxfr.ma.charter.com ([66.189.16.56]:59432
	"EHLO mail.ffpglobal.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755125AbXKCBU6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 21:20:58 -0400
content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun,

I've been having good success using your patches from late September
with a sil3124 pcix sata controller connected to 4 drives.  Ive added
another PM and 4 more drives and connected to port 2 on the card.
However on these 4 additional drives I consistently get these errors
when doing any disk IO (reading or write) (no errors on the first 4
drives of which all 8 part of a single software raid array).  Ive tried
2 new eSATA cables, reseated the drives, etc, with no luck.  Any ideas?

Thanks,
Jon

ata2.15: exception Emask 0x100 SAct 0x0 SErr 0x200000 action 0x6 frozen
ata2.15: irq_stat 0x02020002, PMP DMA CS errata
ata2.00: exception Emask 0x0 SAct 0x48 SErr 0x0 action 0x2 frozen
ata2.01: exception Emask 0x0 SAct 0x20 SErr 0x0 action 0x2 frozen
ata2.02: exception Emask 0x1 SAct 0x1 SErr 0x0 action 0x2 frozen
ata2.02: irq_stat 0x02020002, device error via SDB FIS
ata2.02: cmd 60/50:00:6f:5b:02/00:00:00:00:00/40 tag 0 cdb 0x0 data
40960 in
         res 50/00:00:00:00:00/00:00:00:00:00/00 Emask 0x1 (device
error)
ata2.03: exception Emask 0x0 SAct 0x10 SErr 0x0 action 0x2 frozen
ata2.15: hard resetting link
ata2: controller in dubious state, performing PORT_RST
ata2.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata2.00: hard resetting link
ata2.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.01: hard resetting link
ata2.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.02: hard resetting link
ata2.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.03: hard resetting link
ata2.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.04: hard resetting link
ata2.04: SATA link down (SStatus 0 SControl 300)
ata2.05: hard resetting link
ata2.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for UDMA/100
ata2.01: configured for UDMA/100
ata2.02: configured for UDMA/100
ata2.03: configured for UDMA/100
ata2: EH complete
sd 1:0:0:0: [sde] 976773168 512-byte hardware sectors (500108 MB)
sd 1:0:0:0: [sde] Write Protect is off
sd 1:0:0:0: [sde] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 1:1:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 1:1:0:0: [sdf] Write Protect is off
sd 1:1:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 1:2:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
sd 1:2:0:0: [sdg] Write Protect is off
sd 1:2:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 1:3:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 1:3:0:0: [sdh] Write Protect is off
sd 1:3:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 1:3:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 1:0:0:0: [sde] 976773168 512-byte hardware sectors (500108 MB)
sd 1:0:0:0: [sde] Write Protect is off
sd 1:0:0:0: [sde] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 1:1:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 1:1:0:0: [sdf] Write Protect is off
sd 1:1:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 1:2:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
sd 1:2:0:0: [sdg] Write Protect is off
sd 1:2:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 1:3:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 1:3:0:0: [sdh] Write Protect is off
sd 1:3:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 1:3:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
ata2.00: exception Emask 0x0 SAct 0x20 SErr 0x0 action 0x0
ata2.02: exception Emask 0x0 SAct 0x8 SErr 0x380000 action 0x2
ata2.02: irq_stat 0x02020002, device error via SDB FIS
ata2.02: cmd 60/78:18:47:6f:76/00:00:00:00:00/40 tag 3 cdb 0x0 data
61440 in
         res 41/84:07:b8:6f:76/00:00:00:00:00/40 Emask 0x410 (ATA bus
error) <F>
ata2.02: soft resetting link
ata2.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.02: configured for UDMA/100
ata2: EH complete
sd 1:0:0:0: [sde] 976773168 512-byte hardware sectors (500108 MB)
sd 1:0:0:0: [sde] Write Protect is off
sd 1:0:0:0: [sde] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 1:1:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 1:1:0:0: [sdf] Write Protect is off
sd 1:1:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 1:2:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
sd 1:2:0:0: [sdg] Write Protect is off
sd 1:2:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 1:3:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 1:3:0:0: [sdh] Write Protect is off
sd 1:3:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 1:3:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
ata2.02: exception Emask 0x0 SAct 0x80 SErr 0x380000 action 0x2
ata2.02: irq_stat 0x02020002, device error via SDB FIS
ata2.02: cmd 60/80:38:3f:78:77/00:00:00:00:00/40 tag 7 cdb 0x0 data
65536 in
         res 41/84:6f:50:78:77/00:00:00:00:00/40 Emask 0x410 (ATA bus
error) <F>
ata2.02: soft resetting link
ata2.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.02: configured for UDMA/100
ata2: EH complete
sd 1:0:0:0: [sde] 976773168 512-byte hardware sectors (500108 MB)
sd 1:0:0:0: [sde] Write Protect is off
sd 1:0:0:0: [sde] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 1:1:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 1:1:0:0: [sdf] Write Protect is off
sd 1:1:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 1:2:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
sd 1:2:0:0: [sdg] Write Protect is off
sd 1:2:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 1:3:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 1:3:0:0: [sdh] Write Protect is off
sd 1:3:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 1:3:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
ata2.02: exception Emask 0x0 SAct 0x77060000 SErr 0x380000 action 0x2
ata2.02: irq_stat 0x02020002, device error via SDB FIS
ata2.02: cmd 60/08:e0:7f:05:77/00:00:00:00:00/40 tag 28 cdb 0x0 data
4096 in
         res 41/84:00:86:05:77/00:00:00:00:00/40 Emask 0x410 (ATA bus
error) <F>
ata2.02: soft resetting link
ata2.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.02: configured for UDMA/100
ata2: EH complete
sd 1:0:0:0: [sde] 976773168 512-byte hardware sectors (500108 MB)
sd 1:0:0:0: [sde] Write Protect is off
sd 1:0:0:0: [sde] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 1:1:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 1:1:0:0: [sdf] Write Protect is off
sd 1:1:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 1:2:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
sd 1:2:0:0: [sdg] Write Protect is off
sd 1:2:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 1:3:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 1:3:0:0: [sdh] Write Protect is off
sd 1:3:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 1:3:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
ata2.02: limiting SATA link speed to 1.5 Gbps
ata2.02: exception Emask 0x0 SAct 0x6 SErr 0x380000 action 0x6
ata2.02: irq_stat 0x02020002, device error via SDB FIS
ata2.02: cmd 60/80:10:bf:54:79/00:00:00:00:00/40 tag 2 cdb 0x0 data
65536 in
         res 41/84:0f:30:55:79/0c:00:00:00:00/40 Emask 0x410 (ATA bus
error) <F>
ata2.02: hard resetting link
ata2.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata2.02: configured for UDMA/100
ata2: EH complete
sd 1:0:0:0: [sde] 976773168 512-byte hardware sectors (500108 MB)
sd 1:0:0:0: [sde] Write Protect is off
sd 1:0:0:0: [sde] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 1:1:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 1:1:0:0: [sdf] Write Protect is off
sd 1:1:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 1:2:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
sd 1:2:0:0: [sdg] Write Protect is off
sd 1:2:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 1:3:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 1:3:0:0: [sdh] Write Protect is off
sd 1:3:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 1:3:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA

