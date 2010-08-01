From: Tomas Lund <tlund@nxs.se>
Subject: Re: sata_sil24 failed command: READ FPDMA QUEUED
Date: Sun, 1 Aug 2010 18:55:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.1008011849080.24693@envy.nxs.se>
References: <Pine.LNX.4.61.1007132245000.24693@envy.nxs.se> <4C3D134B.2090604@gmail.com>
 <Pine.LNX.4.61.1007140955080.24693@envy.nxs.se> <Pine.LNX.4.61.1007152103081.24693@envy.nxs.se>
 <Pine.LNX.4.61.1007171422530.24693@envy.nxs.se> <Pine.LNX.4.61.1007211404480.24693@envy.nxs.se>
 <Pine.LNX.4.61.1007211433360.24693@envy.nxs.se> <4C531A40.6080804@gmail.com>
 <Pine.LNX.4.61.1008011625490.24693@envy.nxs.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from envy.nxs.se ([212.247.200.182]:35994 "EHLO envy.nxs.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751110Ab0HAQzc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 1 Aug 2010 12:55:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by envy.nxs.se (Postfix) with ESMTP id 8ACCF2BEBE
	for <linux-ide@vger.kernel.org>; Sun,  1 Aug 2010 18:55:31 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.61.1008011625490.24693@envy.nxs.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Upgraded motherboard (965P-DS4) BIOS to latest version. Booted 2.6.27.48 
with one disk attached to motherboard sata controller (with root 
filesystem) and two disks (different vendors Samsung/WDC) on the 
SIL-controler:

<..>

sata_sil24 0000:03:00.0: version 1.1
sata_sil24 0000:03:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
sata_sil24 0000:03:00.0: setting latency timer to 64
scsi8 : sata_sil24
scsi9 : sata_sil24
ata9: SATA max UDMA/100 host m128@0xf8004000 port 0xf8000000 irq 17
ata10: SATA max UDMA/100 host m128@0xf8004000 port 0xf8002000 irq 17
ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata9.00: ATA-8: SAMSUNG HD103SJ, 1AJ10001, max UDMA/133
ata9.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata9.00: configured for UDMA/100
ata10: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata10.00: ATA-8: WDC WD20EARS-00S8B1, 80.00A80, max UDMA/133
ata10.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata10.00: configured for UDMA/100
scsi 8:0:0:0: Direct-Access     ATA      SAMSUNG HD103SJ  1AJ1 PQ: 0 ANSI: 5
sd 8:0:0:0: [sdb] 1953525168 512-byte hardware sectors (1000205 MB)
sd 8:0:0:0: [sdb] Write Protect is off
sd 8:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 8:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 8:0:0:0: [sdb] 1953525168 512-byte hardware sectors (1000205 MB)
sd 8:0:0:0: [sdb] Write Protect is off
sd 8:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 8:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
  sdb:<3>ata9.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x0
ata9.00: irq_stat 0x00020002, device error via D2H FIS
ata9.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4096 in
          res 50/00:00:00:00:00/00:00:00:00:00/00 Emask 0x401 (device error) <F>
ata9.00: status: { DRDY }
ata9.00: configured for UDMA/100
ata9: EH complete
ata9.00: NCQ disabled due to excessive errors
ata9.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 frozen
ata9.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4096 in
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata9.00: status: { DRDY }
ata9: hard resetting link
ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata9.00: configured for UDMA/100
ata9: EH complete

<..>

scsi 9:0:0:0: Direct-Access     ATA      WDC WD20EARS-00S 80.0 PQ: 0 ANSI: 5
sd 9:0:0:0: [sdc] 3907029168 512-byte hardware sectors (2000399 MB)
sd 9:0:0:0: [sdc] Write Protect is off
sd 9:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 9:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 9:0:0:0: [sdc] 3907029168 512-byte hardware sectors (2000399 MB)
sd 9:0:0:0: [sdc] Write Protect is off
sd 9:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 9:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
  sdc:<3>ata10: failed to read log page 10h (errno=-2)
ata10.00: exception Emask 0x1 SAct 0x1 SErr 0x0 action 0x0
ata10.00: irq_stat 0x00020002, device error via D2H FIS
ata10.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4096 in
          res 51/04:00:af:88:e0/00:00:e8:00:00/e0 Emask 0x1 (device error)
ata10.00: status: { DRDY ERR }
ata10.00: error: { ABRT }
ata10.00: configured for UDMA/100
ata10: EH complete
ata10: failed to read log page 10h (errno=-2)
ata10.00: NCQ disabled due to excessive errors
ata10.00: exception Emask 0x1 SAct 0x1 SErr 0x0 action 0x0
ata10.00: irq_stat 0x00060002, device error via D2H FIS
ata10.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4096 in
          res 51/04:00:af:88:e0/00:00:e8:00:00/e0 Emask 0x1 (device error)
ata10.00: status: { DRDY ERR }
ata10.00: error: { ABRT }
ata10.00: configured for UDMA/100
ata10: EH complete
ata10.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata10.00: irq_stat 0x00060002, device error via D2H FIS
ata10.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
          res 51/04:08:00:00:00/00:00:00:00:00/e0 Emask 0x1 (device error)
ata10.00: status: { DRDY ERR }
ata10.00: error: { ABRT }
ata10.00: configured for UDMA/100
ata10: EH complete

<..>

Starting to get a bit desperate, willing to try anything..

//tlund
