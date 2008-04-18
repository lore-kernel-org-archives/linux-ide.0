From: Mark Lord <liml@rtr.ca>
Subject: "ata73" == "sd 72" ?
Date: Thu, 17 Apr 2008 20:30:12 -0400
Message-ID: <4807EB94.80104@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2435 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750915AbYDRAaO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Apr 2008 20:30:14 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

While working on sata_mv today, I noticed something weird in the syslog.
The messages from libata show "ata73" for the port with my drives (pmp),
but the messages from SCSI (sd) show "sd 72" for those same drives.

One would really think that these two numbers should agree,
not be off by one.  I wonder why they differ (or why they are
almost the same) ?

   ata73.00: ATA-7: ST3400832AS, 3.03, max UDMA/133
   ata73.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 31/32)
   ata73.00: configured for UDMA/133
   ata73.02: ATA-7: ST3400832AS, 3.03, max UDMA/133
   ata73.02: 781422768 sectors, multi 0: LBA48 NCQ (depth 31/32)
   ata73.02: configured for UDMA/133
   ata73: EH complete
   ata74: SATA link down (SStatus 0 SControl 300)
   ata75: SATA link down (SStatus 0 SControl 300)
   ata76: SATA link down (SStatus 0 SControl 300)
   scsi 72:0:0:0: Direct-Access     ATA      ST3400832AS      3.03 PQ: 0 ANSI: 5
   sd 72:0:0:0: [sdb] 781422768 512-byte hardware sectors (400088 MB)
   sd 72:0:0:0: [sdb] Write Protect is off
   sd 72:0:0:0: [sdb] Mode Sense: 00 3a 00 00
   sd 72:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
   sd 72:0:0:0: [sdb] 781422768 512-byte hardware sectors (400088 MB)
   sd 72:0:0:0: [sdb] Write Protect is off
   sd 72:0:0:0: [sdb] Mode Sense: 00 3a 00 00
   sd 72:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
    sdb: sdb1
   sd 72:0:0:0: [sdb] Attached SCSI disk
   sd 72:0:0:0: Attached scsi generic sg2 type 0
   scsi 72:2:0:0: Direct-Access     ATA      ST3400832AS      3.03 PQ: 0 ANSI: 5
   sd 72:2:0:0: [sdc] 781422768 512-byte hardware sectors (400088 MB)
   sd 72:2:0:0: [sdc] Write Protect is off
   sd 72:2:0:0: [sdc] Mode Sense: 00 3a 00 00
   sd 72:2:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
   sd 72:2:0:0: [sdc] 781422768 512-byte hardware sectors (400088 MB)
   sd 72:2:0:0: [sdc] Write Protect is off
   sd 72:2:0:0: [sdc] Mode Sense: 00 3a 00 00
   sd 72:2:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA

