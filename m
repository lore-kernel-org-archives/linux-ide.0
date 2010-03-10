From: Justin Maggard <jmaggard10@gmail.com>
Subject: Hotplug issue with Marvell 6121
Date: Tue, 9 Mar 2010 16:51:09 -0800
Message-ID: <150c16851003091651r4ce4259v693f1310d0aa95ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:41118 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755692Ab0CJAvK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Mar 2010 19:51:10 -0500
Received: by pvb32 with SMTP id 32so1973784pvb.19
        for <linux-ide@vger.kernel.org>; Tue, 09 Mar 2010 16:51:09 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I've been experiencing some issues with disk hotplugging using the
AHCI driver with a Marvell 6121 controller.  It varies a bit when the
driver gives up, but it's almost always within the first three
remove/add attempts.  I was using 2.6.27.6 for quite some time and
never had any issues with hotplug, even after many hotplugs.  The
problems started when I updated to 2.6.29, and they still exist today
on 2.6.33.  I'm running a regular i686 non-SMP kernel.  Anyone have
any ideas?

Below are some relevant portions of the kernel log from 2.6.27 and
2.6.33.  If anyone needs any more information from me, please let me
know.

Thanks,
-Justin

=== Removing disk, 2.6.27.6 ===
ata3: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
ata3: irq_stat 0x04400000, PHY RDY changed
ata3: hard resetting link
ata3: SATA link down (SStatus 0 SControl 300)
ata3: hard resetting link
ata3: SATA link down (SStatus 0 SControl 300)
ata3: hard resetting link
ata3: SATA link down (SStatus 0 SControl 300)
ata3.00: disabled
ata3: EH complete
ata3.00: detaching (SCSI 2:0:0:0)
sd 2:0:0:0: [sdc] Synchronizing SCSI cache
sd 2:0:0:0: [sdc] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
sd 2:0:0:0: [sdc] Stopping disk
sd 2:0:0:0: [sdc] START_STOP FAILED
sd 2:0:0:0: [sdc] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK

=== Removing disk, 2.6.33 ===
ata3: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
ata3: irq_stat 0x04400000, PHY RDY changed
ata3: hard resetting link
ata3: SATA link down (SStatus 0 SControl 300)
ata3: hard resetting link
ata3: SATA link down (SStatus 0 SControl 300)
ata3: limiting SATA link speed to 1.5 Gbps
ata3: hard resetting link
ata3: SATA link down (SStatus 0 SControl 310)
ata3.00: disabled
ata3: EH complete
ata3.00: detaching (SCSI 2:0:0:0)
sd 2:0:0:0: [sdc] Synchronizing SCSI cache
sd 2:0:0:0: [sdc] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
sd 2:0:0:0: [sdc] Stopping disk
sd 2:0:0:0: [sdc] START_STOP FAILED
sd 2:0:0:0: [sdc] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK

=== Adding disk, 2.6.27.6 ===
ata3: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
ata3: irq_stat 0x02400000, PHY RDY changed
ata3: hard resetting link
ata3: link is slow to respond, please be patient (ready=0)
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: ATA-8: ST3750330AS, SD15, max UDMA/133
ata3.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata3.00: configured for UDMA/133
ata3: EH complete
scsi 2:0:0:0: Direct-Access     ATA      ST3750330AS      SD15 PQ: 0 ANSI: 5
sd 2:0:0:0: [sdc] 1465149168 512-byte hardware sectors (750156 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 2:0:0:0: [sdc] 1465149168 512-byte hardware sectors (750156 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdc: sdc1 sdc2 sdc4 < sdc5 >
sd 2:0:0:0: [sdc] Attached SCSI disk
sd 2:0:0:0: Attached scsi generic sg2 type 0

=== Adding disk, 2.6.33 ===
ata3: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
ata3: irq_stat 0x02400000, PHY RDY changed
ata3: hard resetting link
ata3: link is slow to respond, please be patient (ready=0)
ata3: COMRESET failed (errno=-16)
ata3: hard resetting link
ata3: link is slow to respond, please be patient (ready=0)
ata3: COMRESET failed (errno=-16)
ata3: hard resetting link
ata3: link is slow to respond, please be patient (ready=0)
ata3: COMRESET failed (errno=-16)
ata3: limiting SATA link speed to 1.5 Gbps
ata3: hard resetting link
ata3: COMRESET failed (errno=-16)
ata3: reset failed, giving up
ata3: EH complete
