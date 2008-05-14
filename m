From: Mark Lord <liml@rtr.ca>
Subject: Re: ata_std_qc_defer not good enough for FIS-based switching ?
Date: Wed, 14 May 2008 11:50:25 -0400
Message-ID: <482B0A41.5030409@rtr.ca>
References: <48163C5D.9050605@rtr.ca> <48164AE8.4070106@rtr.ca> <481659B5.7090703@gmail.com> <481660DD.80103@rtr.ca> <48167755.3000208@gmail.com> <4816873C.7090302@rtr.ca> <482AF322.2090605@gmail.com> <482AFB12.3040005@rtr.ca> <482AFCFA.40708@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2348 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752665AbYENPu1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 May 2008 11:50:27 -0400
In-Reply-To: <482AFCFA.40708@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@redhat.com>

Mark Lord wrote:
> Mark Lord wrote:
>> ..
>> At the moment, I have the Sil PM plugged in, and it all behaves nicely.
>> The previous failure was with the Marvell PM, so I'll hook that up next
>> and retest with it.
> ..
> 
> It went bonkers again.  This is with 2.6.25.
> I'll build 2.6.26-git and try again with that shortly.
..

Okay, I have today's 2.6.26-rc2-git installed now.
My PCIe notebook has an ExpressCard with this on it:

  0d:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)

That's the controller I use with sata_sil24 here.

I have a Marvell 4140 port-multiplier (standalone card),
and have a Seagate 750GB drive (pmp=0) and a Hitachi 500GB drive (pmp=2).

When I simply do "hdparm -t" simultaneously on both drives,
something gets very confused somewhere.  Neither drive has any media errors,
and this exact same test works fine with sata_mv in my other system.
The same test also works fine with both controllers
when using a Silicon Image PM instead of the Marvell.

When I move the second drive to pmp=1 (instead of pmp=2),
then sata_sil24 no longer has problems.  Very peculiar.

Here's the log from sata_sil24, ports 0,2, as it fails:

plug in the card, with Marvell PM and drives on pmp 0,2:
[ 1439.967977] pciehp: Card present on Slot(5)
[ 1440.981266] program_fw_provided_values: Could not get hotplug parameters
[ 1440.982529] sata_sil24 0000:0d:00.0: enabling device (0000 -> 0003)
[ 1440.982529] ACPI: PCI Interrupt 0000:0d:00.0[A] -> GSI 19 (level, low) -> IRQ 19
[ 1440.982529] PCI: Setting latency timer of device 0000:0d:00.0 to 64
[ 1440.982529] scsi8 : sata_sil24
[ 1440.982529] scsi9 : sata_sil24
[ 1440.982529] ata9: SATA max UDMA/100 host m128@0xefa04000 port 0xefa00000 irq 19
[ 1440.982529] ata10: SATA max UDMA/100 host m128@0xefa04000 port 0xefa02000 irq 19
[ 1443.055025] ata9: SATA link down (SStatus 0 SControl 0)
[ 1445.242668] ata10: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 1445.245453] ata10.15: Port Multiplier 1.1, 0x11ab:0x4140 r192, 4 ports, feat 0x1/0x1f
[ 1445.246012] ata10.00: hard resetting link
[ 1445.591512] ata10.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 1445.591524] ata10.01: hard resetting link
[ 1445.928570] ata10.01: SATA link down (SStatus 0 SControl 320)
[ 1445.928570] ata10.02: hard resetting link
[ 1446.353566] ata10.02: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 1446.353991] ata10.03: hard resetting link
[ 1446.674686] ata10.03: SATA link down (SStatus 0 SControl 320)
[ 1446.723144] ata10.00: ATA-7: ST3750640NS, 3.BAF, max UDMA/133
[ 1446.723144] ata10.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[ 1446.781972] ata10.00: configured for UDMA/100
[ 1446.785055] ata10.02: ATA-8: Hitachi HDP725050GLA360, GM4OA50E, max UDMA/133
[ 1446.785055] ata10.02: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[ 1446.786866] ata10.02: configured for UDMA/100
[ 1446.786894] ata10: EH complete
[ 1446.802592] scsi 9:0:0:0: Direct-Access     ATA      ST3750640NS      3.BA PQ: 0 ANSI: 5
[ 1446.802783] sd 9:0:0:0: [sdb] 1465149168 512-byte hardware sectors (750156 MB)
[ 1446.802816] sd 9:0:0:0: [sdb] Write Protect is off
[ 1446.802823] sd 9:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1446.802877] sd 9:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1446.802980] sd 9:0:0:0: [sdb] 1465149168 512-byte hardware sectors (750156 MB)
[ 1446.803012] sd 9:0:0:0: [sdb] Write Protect is off
[ 1446.803017] sd 9:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1446.803070] sd 9:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1446.803076]  sdb: sdb1
[ 1446.825903] sd 9:0:0:0: [sdb] Attached SCSI disk
[ 1446.825903] sd 9:0:0:0: Attached scsi generic sg2 type 0
[ 1446.825903] scsi 9:2:0:0: Direct-Access     ATA      Hitachi HDP72505 GM4O PQ: 0 ANSI: 5
[ 1446.828119] sd 9:2:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
[ 1446.828151] sd 9:2:0:0: [sdc] Write Protect is off
[ 1446.828156] sd 9:2:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1446.828208] sd 9:2:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1446.828299] sd 9:2:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
[ 1446.828329] sd 9:2:0:0: [sdc] Write Protect is off
[ 1446.828334] sd 9:2:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1446.828386] sd 9:2:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1446.828392]  sdc: sdc1
[ 1446.844892] sd 9:2:0:0: [sdc] Attached SCSI disk
[ 1446.844928] sd 9:2:0:0: Attached scsi generic sg3 type 0
[ 1446.854711] ata10.00: exception Emask 0x10 SAct 0x0 SErr 0x2 action 0x7
[ 1446.854717] ata10: SError: { RecovComm }
[ 1446.854917] ata10.00: hard resetting link
[ 1447.174918] ata10.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 1447.285294] ata10.00: configured for UDMA/100
[ 1447.285378] ata10.00: exception Emask 0x10 SAct 0x0 SErr 0x2 action 0x7 t4
[ 1447.285478] ata10: SError: { RecovComm }
[ 1447.285775] ata10.00: hard resetting link
[ 1447.610328] ata10.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 1447.701675] ata10.00: configured for UDMA/100
[ 1447.701760] ata10.00: exception Emask 0x10 SAct 0x0 SErr 0x2 action 0x7 t3
[ 1447.701760] ata10: SError: { RecovComm }
[ 1447.701899] ata10.00: hard resetting link
[ 1448.024145] ata10.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 1448.118645] ata10.00: configured for UDMA/100
[ 1448.118702] ata10.00: limiting SATA link speed to 1.5 Gbps
[ 1448.118744] ata10.00: exception Emask 0x10 SAct 0x0 SErr 0x2 action 0x7 t2
[ 1448.118744] ata10: SError: { RecovComm }
[ 1448.119050] ata10.00: hard resetting link
[ 1448.370286] ata10.15: qc timeout (cmd 0xe8)
[ 1448.370658] ata10.00: failed to write SCR 2 (Emask=0x4)
[ 1448.370961] ata10.00: COMRESET failed (errno=-5)
[ 1448.371138] ata10.00: failed to read SCR 0 (Emask=0x40)
[ 1448.371138] ata10.00: failed to read SCR 0 (Emask=0x40)
[ 1448.371138] ata10.00: reset failed, giving up
[ 1448.371138] ata10.15: hard resetting link
[ 1450.557452] ata10.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 1450.558290] ata10.00: hard resetting link
[ 1450.879173] ata10.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1450.879504] ata10.01: hard resetting link
[ 1451.202505] ata10.01: SATA link down (SStatus 0 SControl 320)
[ 1451.202860] ata10.02: hard resetting link
[ 1451.525975] ata10.02: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 1451.526309] ata10.03: hard resetting link
[ 1451.846862] ata10.03: SATA link down (SStatus 0 SControl 320)
[ 1451.935344] ata10.00: configured for UDMA/100
[ 1451.938390] ata10.02: configured for UDMA/100
[ 1451.938476] ata10.00: exception Emask 0x10 SAct 0x0 SErr 0x2 action 0x7 t1
[ 1451.938476] ata10: SError: { RecovComm }
[ 1451.938490] ata10.00: hard resetting link
[ 1452.261789] ata10.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1452.352836] ata10.00: configured for UDMA/100
[ 1452.352864] ata10: EH pending after 5 tries, giving up
[ 1452.352864] ata10: EH complete
[ 1452.356551] sd 9:0:0:0: [sdb] 1465149168 512-byte hardware sectors (750156 MB)
[ 1452.356551] sd 9:0:0:0: [sdb] Write Protect is off
[ 1452.356551] sd 9:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1452.356551] sd 9:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1452.356551] sd 9:2:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
[ 1452.356551] sd 9:2:0:0: [sdc] Write Protect is off
[ 1452.356551] sd 9:2:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1452.356551] sd 9:2:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1452.356551] sd 9:0:0:0: [sdb] 1465149168 512-byte hardware sectors (750156 MB)
[ 1452.356551] sd 9:0:0:0: [sdb] Write Protect is off
[ 1452.356551] sd 9:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1452.356551] sd 9:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1452.356551] sd 9:2:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
[ 1452.356551] sd 9:2:0:0: [sdc] Write Protect is off
[ 1452.356551] sd 9:2:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1452.356551] sd 9:2:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA

simultaneous hdparm -t tasks:
[ 1470.883924] ata10.00: failed to read SCR 1 (Emask=0x40)
[ 1470.884335] ata10.01: failed to read SCR 1 (Emask=0x40)
[ 1470.884648] ata10.02: failed to read SCR 1 (Emask=0x40)
[ 1470.884956] ata10.03: failed to read SCR 1 (Emask=0x40)
[ 1470.885266] ata10.00: exception Emask 0x100 SAct 0x8 SErr 0x0 action 0x6 frozen
[ 1470.885640] ata10.00: cmd 60/f8:18:08:04:00/01:00:00:00:00/40 tag 3 ncq 258048 in
[ 1470.885643]          res d6/34:00:00:00:00/00:00:40:31:d6/00 Emask 0x2 (HSM violation)
[ 1470.886317] ata10.00: status: { Busy }
[ 1470.886571] ata10.00: error: { IDNF ABRT }
[ 1470.886841] ata10.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1470.890513] ata10.02: exception Emask 0x2 SAct 0x16 SErr 0x0 action 0x6 frozen
[ 1470.890513] ata10.02: irq_stat 0x00020002, data directon mismatch
[ 1470.890513] ata10.02: cmd 60/08:08:00:0d:00/00:00:00:00:00/40 tag 1 ncq 4096 in
[ 1470.890513]          res d6/34:00:00:00:00/00:00:00:10:d6/00 Emask 0x2 (HSM violation)
[ 1470.890513] ata10.02: status: { Busy }
[ 1470.890513] ata10.02: error: { IDNF ABRT }
[ 1470.890513] ata10.02: cmd 60/f8:10:08:0c:00/00:00:00:00:00/40 tag 2 ncq 126976 in
[ 1470.890513]          res d6/34:00:00:00:00/00:00:00:20:d6/00 Emask 0x2 (HSM violation)
[ 1470.890513] ata10.02: status: { Busy }
[ 1470.890513] ata10.02: error: { IDNF ABRT }
[ 1470.890513] ata10.02: cmd 60/f8:20:08:0d:00/00:00:00:00:00/40 tag 4 ncq 126976 in
[ 1470.890513]          res d6/34:00:00:00:00/00:00:00:40:d6/00 Emask 0x2 (HSM violation)
[ 1470.891147] ata10.02: status: { Busy }
[ 1470.891372] ata10.02: error: { IDNF ABRT }
[ 1470.891613] ata10.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1470.893824] ata10.15: hard resetting link
[ 1470.894057] ata10: controller in dubious state, performing PORT_RST
[ 1473.107981] ata10.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 1473.108876] ata10.00: hard resetting link
[ 1473.442708] ata10.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1473.443121] ata10.01: hard resetting link
[ 1473.767992] ata10.01: SATA link down (SStatus 0 SControl 320)
[ 1473.768414] ata10.02: hard resetting link
[ 1474.096001] ata10.02: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 1474.096001] ata10.03: hard resetting link
[ 1474.427047] ata10.03: SATA link down (SStatus 0 SControl 320)
[ 1474.532829] ata10.00: configured for UDMA/100
[ 1474.536133] ata10.02: configured for UDMA/100
[ 1474.536147] ata10: EH complete
[ 1474.544220] sd 9:0:0:0: [sdb] 1465149168 512-byte hardware sectors (750156 MB)
[ 1474.544220] sd 9:0:0:0: [sdb] Write Protect is off
[ 1474.544220] sd 9:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1474.544220] sd 9:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1474.544220] sd 9:2:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
[ 1474.544220] sd 9:2:0:0: [sdc] Write Protect is off
[ 1474.544220] sd 9:2:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1474.544220] sd 9:2:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1474.544220] sd 9:0:0:0: [sdb] 1465149168 512-byte hardware sectors (750156 MB)
[ 1474.544220] sd 9:0:0:0: [sdb] Write Protect is off
[ 1474.544220] sd 9:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1474.547554] sd 9:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1474.547554] sd 9:2:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
[ 1474.547554] sd 9:2:0:0: [sdc] Write Protect is off
[ 1474.547554] sd 9:2:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1474.547554] sd 9:2:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA

simultaneous hdparm -t tasks:
[ 1478.180962] ata10.00: failed to read SCR 1 (Emask=0x40)
[ 1478.182188] ata10.01: failed to read SCR 1 (Emask=0x40)
[ 1478.182544] ata10.02: failed to read SCR 1 (Emask=0x40)
[ 1478.182859] ata10.03: failed to read SCR 1 (Emask=0x40)
[ 1478.183170] ata10.00: exception Emask 0x100 SAct 0x18 SErr 0x0 action 0x6 frozen
[ 1478.183546] ata10.00: cmd 60/08:18:00:b0:00/00:00:00:00:00/40 tag 3 ncq 4096 in
[ 1478.183549]          res d6/34:00:00:00:00/00:00:00:30:d6/00 Emask 0x2 (HSM violation)
[ 1478.184041] ata10.00: status: { Busy }
[ 1478.184041] ata10.00: error: { IDNF ABRT }
[ 1478.184041] ata10.00: cmd 60/f8:20:08:b0:00/00:00:00:00:00/40 tag 4 ncq 126976 in
[ 1478.184041]          res d6/34:00:00:00:00/00:00:00:40:d6/00 Emask 0x2 (HSM violation)
[ 1478.187332] ata10.00: status: { Busy }
[ 1478.187332] ata10.00: error: { IDNF ABRT }
[ 1478.187332] ata10.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1478.187453] ata10.02: exception Emask 0x2 SAct 0x4 SErr 0x0 action 0x6 frozen
[ 1478.190639] ata10.02: irq_stat 0x00060002, data directon mismatch
[ 1478.191845] ata10.02: cmd 60/f8:10:08:c0:00/00:00:00:00:00/40 tag 2 ncq 126976 in
[ 1478.191848]          res d6/34:00:00:00:00/00:00:00:20:d6/00 Emask 0x2 (HSM violation)
[ 1478.195386] ata10.02: status: { Busy }
[ 1478.195609] ata10.02: error: { IDNF ABRT }
[ 1478.195814] ata10.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1478.195814] ata10.15: hard resetting link
[ 1478.195814] ata10: controller in dubious state, performing PORT_RST
[ 1480.408238] ata10.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 1480.409144] ata10.00: hard resetting link
[ 1480.730221] ata10.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1480.730638] ata10.01: hard resetting link
[ 1481.051302] ata10.01: SATA link down (SStatus 0 SControl 320)
[ 1481.051698] ata10.02: hard resetting link
[ 1481.379538] ata10.02: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 1481.379967] ata10.03: hard resetting link
[ 1481.699587] ata10.03: SATA link down (SStatus 0 SControl 320)
[ 1481.807972] ata10.00: configured for UDMA/100
[ 1481.810193] ata10.02: configured for UDMA/100
[ 1481.810207] ata10: EH complete
[ 1481.810207] sd 9:0:0:0: [sdb] 1465149168 512-byte hardware sectors (750156 MB)
[ 1481.810207] sd 9:0:0:0: [sdb] Write Protect is off
[ 1481.810207] sd 9:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1481.812118] sd 9:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1481.812118] sd 9:2:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
[ 1481.812118] sd 9:2:0:0: [sdc] Write Protect is off
[ 1481.812118] sd 9:2:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1481.812118] sd 9:2:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1481.812118] sd 9:0:0:0: [sdb] 1465149168 512-byte hardware sectors (750156 MB)
[ 1481.812118] sd 9:0:0:0: [sdb] Write Protect is off
[ 1481.812118] sd 9:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1481.812118] sd 9:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1481.812118] sd 9:2:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
[ 1481.812118] sd 9:2:0:0: [sdc] Write Protect is off
[ 1481.812118] sd 9:2:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1481.812118] sd 9:2:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA

