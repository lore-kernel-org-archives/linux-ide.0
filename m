From: Andrew Ryder <tireman@shaw.ca>
Subject: sata pmp / ata bus errors
Date: Wed, 31 Aug 2011 17:04:51 -0400
Message-ID: <4E5EA1F3.8030600@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo2no.shaw.ca ([64.59.134.9]:31414 "EHLO
	idcmail-mo2no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754672Ab1IABtJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Aug 2011 21:49:09 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I've got a couple sw raid arrays attached to my machine and one with 4 
new 2TB drives recently installed is throwing some odd errors during 
writing so far that I'm not sure if I can ignore?

The arrays are connected to my machine using the SIL 3124 PMP HBA and 
the array causing some weird errors with the new 2TB seagate drives is 
using a SIL4726 chipset.

Thanks,
Andrew


[3218691.585029] ata3.00: failed to read SCR 1 (Emask=0x40)
[3218691.585040] ata3.01: failed to read SCR 1 (Emask=0x40)
[3218691.585044] ata3.02: failed to read SCR 1 (Emask=0x40)
[3218691.585048] ata3.03: failed to read SCR 1 (Emask=0x40)
[3218691.585052] ata3.04: failed to read SCR 1 (Emask=0x40)
[3218691.585056] ata3.05: failed to read SCR 1 (Emask=0x40)
[3218691.585063] ata3.15: exception Emask 0x100 SAct 0x0 SErr 0x280000 
action 0x6 frozen
[3218691.585067] ata3.15: irq_stat 0x00060002, PMP DMA CS errata
[3218691.585072] ata3.15: SError: { 10B8B BadCRC }
[3218691.585077] ata3.00: exception Emask 0x100 SAct 0x26 SErr 0x0 
action 0x6 frozen
[3218691.585082] ata3.00: failed command: READ FPDMA QUEUED
[3218691.585091] ata3.00: cmd 60/78:08:08:bf:49/00:00:da:00:00/40 tag 1 
ncq 61440 in
[3218691.585093]          res 48/7c:00:00:00:00/00:00:40:10:48/00 Emask 
0x2 (HSM violation)
[3218691.585097] ata3.00: status: { DRDY DRQ }
[3218691.585100] ata3.00: error: { UNC IDNF ABRT }
[3218691.585103] ata3.00: failed command: READ FPDMA QUEUED
[3218691.585111] ata3.00: cmd 60/30:10:00:c0:49/00:00:da:00:00/40 tag 2 
ncq 24576 in
[3218691.585113]          res 60/30:10:00:c0:49/00:00:da:00:00/40 Emask 
0x81 (invalid argument)
[3218691.585117] ata3.00: status: { DRDY DF }
[3218691.585119] ata3.00: error: { IDNF }
[3218691.585123] ata3.00: failed command: READ FPDMA QUEUED
[3218691.585130] ata3.00: cmd 60/d0:28:30:c0:49/00:00:da:00:00/40 tag 5 
ncq 106496 in
[3218691.585132]          res 60/d0:28:30:c0:49/00:00:da:00:00/40 Emask 
0x10 (ATA bus error)
[3218691.585136] ata3.00: status: { DRDY DF }
[3218691.585139] ata3.00: error: { ICRC UNC IDNF }
[3218691.585144] ata3.01: exception Emask 0x100 SAct 0x50 SErr 0x0 
action 0x6 frozen
[3218691.585148] ata3.01: failed command: READ FPDMA QUEUED
[3218691.585156] ata3.01: cmd 60/80:20:80:bf:49/00:00:da:00:00/40 tag 4 
ncq 65536 in
[3218691.585157]          res 48/7c:00:00:00:00/00:00:80:40:48/00 Emask 
0x2 (HSM violation)
[3218691.585161] ata3.01: status: { DRDY DRQ }
[3218691.585164] ata3.01: error: { UNC IDNF ABRT }
[3218691.585167] ata3.01: failed command: READ FPDMA QUEUED
[3218691.585175] ata3.01: cmd 60/00:30:00:c0:49/01:00:da:00:00/40 tag 6 
ncq 131072 in
[3218691.585177]          res 60/00:30:00:c0:49/00:00:da:00:00/40 Emask 
0x1 (device error)
[3218691.585181] ata3.01: status: { DRDY DF }
[3218691.585186] ata3.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 
0x6 frozen
[3218691.585189] ata3.02: irq_stat 0x00060002, device error via D2H FIS
[3218691.585193] ata3.02: failed command: READ DMA EXT
[3218691.585200] ata3.02: cmd 25/00:80:80:bf:49/00:00:da:00:00/e0 tag 0 
dma 65536 in
[3218691.585202]          res 51/84:60:a0:bf:49/00:00:da:00:00/e0 Emask 
0x10 (ATA bus error)
[3218691.585206] ata3.02: status: { DRDY ERR }
[3218691.585209] ata3.02: error: { ICRC ABRT }
[3218691.585214] ata3.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 
0x6 frozen
[3218691.585218] ata3.03: failed command: READ DMA EXT
[3218691.585226] ata3.03: cmd 25/00:80:01:b7:49/00:00:da:00:00/e0 tag 3 
dma 65536 in
[3218691.585228]          res 48/7c:00:00:00:00/00:00:c0:30:48/00 Emask 
0x2 (HSM violation)
[3218691.585231] ata3.03: status: { DRDY DRQ }
[3218691.585234] ata3.03: error: { UNC IDNF ABRT }
[3218691.585239] ata3.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 
0x6 frozen
[3218691.585245] ata3.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 
0x6 frozen
[3218691.585253] ata3.15: hard resetting link
[3218691.585256] ata3: controller in dubious state, performing PORT_RST
[3218693.740039] ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[3218693.740237] ata3.00: hard resetting link
[3218694.046539] ata3.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[3218694.046604] ata3.01: hard resetting link
[3218694.352260] ata3.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[3218694.352296] ata3.02: hard resetting link
[3218694.657510] ata3.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[3218694.657562] ata3.03: hard resetting link
[3218694.963250] ata3.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[3218694.963278] ata3.04: hard resetting link
[3218695.268608] ata3.04: SATA link down (SStatus 0 SControl 320)
[3218695.268651] ata3.05: hard resetting link
[3218695.579209] ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[3218695.591705] ata3.00: configured for UDMA/100
[3218695.603969] ata3.01: configured for UDMA/100
[3218695.605429] ata3.02: configured for UDMA/100
[3218695.606935] ata3.03: configured for UDMA/100
[3218695.607042] ata3: EH complete

[3270876.406026] ata3.00: failed to read SCR 1 (Emask=0x40)
[3270876.406041] ata3.01: failed to read SCR 1 (Emask=0x40)
[3270876.406049] ata3.02: failed to read SCR 1 (Emask=0x40)
[3270876.406055] ata3.03: failed to read SCR 1 (Emask=0x40)
[3270876.406062] ata3.04: failed to read SCR 1 (Emask=0x40)
[3270876.406069] ata3.05: failed to read SCR 1 (Emask=0x40)
[3270876.406080] ata3.15: exception Emask 0x100 SAct 0x0 SErr 0x280000 
action 0x6 frozen
[3270876.406086] ata3.15: irq_stat 0x00060002, PMP DMA CS errata
[3270876.406094] ata3.15: SError: { 10B8B BadCRC }
[3270876.406104] ata3.00: exception Emask 0x100 SAct 0x4 SErr 0x0 action 
0x6 frozen
[3270876.406113] ata3.00: failed command: READ FPDMA QUEUED
[3270876.406128] ata3.00: cmd 60/80:10:00:c3:f6/00:00:51:00:00/40 tag 2 
ncq 65536 in
[3270876.406131]          res 48/7c:00:00:00:00/00:00:40:20:48/00 Emask 
0x2 (HSM violation)
[3270876.406138] ata3.00: status: { DRDY DRQ }
[3270876.406143] ata3.00: error: { UNC IDNF ABRT }
[3270876.406153] ata3.01: exception Emask 0x100 SAct 0x8 SErr 0x0 action 
0x6 frozen
[3270876.406160] ata3.01: failed command: READ FPDMA QUEUED
[3270876.406174] ata3.01: cmd 60/48:18:80:c3:f6/00:00:51:00:00/40 tag 3 
ncq 36864 in
[3270876.406177]          res 48/7c:00:00:00:00/00:00:00:30:48/00 Emask 
0x2 (HSM violation)
[3270876.406184] ata3.01: status: { DRDY DRQ }
[3270876.406189] ata3.01: error: { UNC IDNF ABRT }
[3270876.406198] ata3.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 
0x6 frozen
[3270876.406205] ata3.02: failed command: READ DMA EXT
[3270876.406219] ata3.02: cmd 25/00:70:10:c3:f6/00:00:51:00:00/e0 tag 0 
dma 57344 in
[3270876.406222]          res 48/7c:00:00:00:00/00:00:80:00:48/00 Emask 
0x2 (HSM violation)
[3270876.406229] ata3.02: status: { DRDY DRQ }
[3270876.406234] ata3.02: error: { UNC IDNF ABRT }
[3270876.406243] ata3.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 
0x6 frozen
[3270876.406249] ata3.03: irq_stat 0x00060002, device error via D2H FIS
[3270876.406256] ata3.03: failed command: READ DMA EXT
[3270876.406270] ata3.03: cmd 25/00:80:01:bb:f6/00:00:51:00:00/e0 tag 1 
dma 65536 in
[3270876.406273]          res 51/84:50:31:bb:f6/00:00:51:00:00/e0 Emask 
0x10 (ATA bus error)
[3270876.406280] ata3.03: status: { DRDY ERR }
[3270876.406285] ata3.03: error: { ICRC ABRT }
[3270876.406294] ata3.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 
0x6 frozen
[3270876.406304] ata3.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 
0x6 frozen
[3270876.406316] ata3.15: hard resetting link
[3270876.406322] ata3: controller in dubious state, performing PORT_RST
[3270878.560051] ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[3270878.560529] ata3.00: hard resetting link
[3270878.865268] ata3.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[3270878.865305] ata3.01: hard resetting link
[3270879.170303] ata3.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[3270879.170335] ata3.02: hard resetting link
[3270879.475274] ata3.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[3270879.475307] ata3.03: hard resetting link
[3270879.780237] ata3.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[3270879.780270] ata3.04: hard resetting link
[3270880.085436] ata3.04: SATA link down (SStatus 0 SControl 320)
[3270880.085518] ata3.05: hard resetting link
[3270880.390268] ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[3270880.402541] ata3.00: configured for UDMA/100
[3270880.414832] ata3.01: configured for UDMA/100
[3270880.416257] ata3.02: configured for UDMA/100
[3270880.417772] ata3.03: configured for UDMA/100
[3270880.417842] ata3: EH complete

