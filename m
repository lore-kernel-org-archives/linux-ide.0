From: Daniel Schroeder <sec@dschroeder.info>
Subject: device error via SDB FIS
Date: Sat, 30 Jun 2007 19:10:26 +0200
Message-ID: <46868E82.8010906@dschroeder.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:60518 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754960AbXF3RKb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jun 2007 13:10:31 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by isla-magica.local (Postfix) with ESMTP id 82E9F785A4A
	for <linux-ide@vger.kernel.org>; Sat, 30 Jun 2007 19:10:26 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

hello list,

i do not know, what this could mean, but i have never seen it before.
System is 2.6.22-rc6, sil3132, samsung hd501lj (new hd under 10 power on 
hours)

time line:
1: power on (single esata enclosure)
2: system recognizes and configures the disk
3: mount disk
4: use disk
5: device error via SDB FIS
6: mount is still there, everything looks good except of this entry in logs

<quote>
ata3: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0x2 frozen
ata3: (irq_stat 0x01140010, PHY RDY changed)
ata3: soft resetting port
ata3: SATA link down (SStatus 0 SControl 300)
ata3: EH complete
ata3: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3: (irq_stat 0x00b00090, PHY RDY changed)
ata3: soft resetting port
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: ata_hpa_resize 1: sectors = 976773168, hpa_sectors = 976773168
ata3.00: ATA-8: SAMSUNG HD501LJ, CR100-10, max UDMA7
ata3.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata3.00: ata_hpa_resize 1: sectors = 976773168, hpa_sectors = 976773168
ata3.00: configured for UDMA/100
ata3: EH complete
scsi 2:0:0:0: Direct-Access     ATA      SAMSUNG HD501LJ  CR10 PQ: 0 ANSI: 5
sd 2:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 2:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
 sdc: sdc1
sd 2:0:0:0: [sdc] Attached SCSI disk
sd 2:0:0:0: Attached scsi generic sg2 type 0
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ata3.00: exception Emask 0x0 SAct 0x2ef SErr 0x0 action 0x0
ata3.00: (irq_stat 0x00020002, device error via SDB FIS)
ata3.00: cmd 61/28:30:17:83:68/00:00:1f:00:00/40 tag 6 cdb 0x0 data 
20480 out
         res 51/04:30:17:83:68/50:04:1f:00:00/40 Emask 0x1 (device error)
ata3.00: ata_hpa_resize 1: sectors = 976773168, hpa_sectors = 976773168
ata3.00: ata_hpa_resize 1: sectors = 976773168, hpa_sectors = 976773168
ata3.00: configured for UDMA/100
ata3: EH complete
sd 2:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
</quote>

daniel
