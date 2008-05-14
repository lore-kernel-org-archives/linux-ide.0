From: Mark Lord <liml@rtr.ca>
Subject: Re: ata_std_qc_defer not good enough for FIS-based switching ?
Date: Wed, 14 May 2008 11:59:25 -0400
Message-ID: <482B0C5D.5080207@rtr.ca>
References: <48163C5D.9050605@rtr.ca> <48164AE8.4070106@rtr.ca> <481659B5.7090703@gmail.com> <481660DD.80103@rtr.ca> <48167755.3000208@gmail.com> <4816873C.7090302@rtr.ca> <482AF322.2090605@gmail.com> <482AFB12.3040005@rtr.ca> <482AFCFA.40708@rtr.ca> <482B0A41.5030409@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1373 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752665AbYENP71 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 May 2008 11:59:27 -0400
In-Reply-To: <482B0A41.5030409@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@redhat.com>

Mark Lord wrote:
> Mark Lord wrote:
>> Mark Lord wrote:
>>> ..
>>> At the moment, I have the Sil PM plugged in, and it all behaves nicely.
>>> The previous failure was with the Marvell PM, so I'll hook that up next
>>> and retest with it.
>> ..
>>
>> It went bonkers again.  This is with 2.6.25.
>> I'll build 2.6.26-git and try again with that shortly.
> ..
> 
> Okay, I have today's 2.6.26-rc2-git installed now.
> My PCIe notebook has an ExpressCard with this on it:
> 
>  0d:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial 
> ATA Raid II Controller (rev 01)
> 
> That's the controller I use with sata_sil24 here.
> 
> I have a Marvell 4140 port-multiplier (standalone card),
> and have a Seagate 750GB drive (pmp=0) and a Hitachi 500GB drive (pmp=2).
> 
> When I simply do "hdparm -t" simultaneously on both drives,
> something gets very confused somewhere.  Neither drive has any media 
> errors,
> and this exact same test works fine with sata_mv in my other system.
> The same test also works fine with both controllers
> when using a Silicon Image PM instead of the Marvell.
> 
> When I move the second drive to pmp=1 (instead of pmp=2),
> then sata_sil24 no longer has problems.  Very peculiar.
> 
> Here's the log from sata_sil24, ports 0,2, as it fails:
..

And here is the log from sata_sil24, ports 0,1, as it works:

[ 2936.456644] pciehp: Card present on Slot(5)
[ 2937.462101] program_fw_provided_values: Could not get hotplug parameters
[ 2937.463877] sata_sil24 0000:0d:00.0: enabling device (0000 -> 0003)
[ 2937.463892] ACPI: PCI Interrupt 0000:0d:00.0[A] -> GSI 19 (level, low) -> IRQ 19
[ 2937.463980] PCI: Setting latency timer of device 0000:0d:00.0 to 64
[ 2937.466777] scsi10 : sata_sil24
[ 2937.480614] scsi11 : sata_sil24
[ 2937.482399] ata11: SATA max UDMA/100 host m128@0xefa04000 port 0xefa00000 irq 19
[ 2937.482399] ata12: SATA max UDMA/100 host m128@0xefa04000 port 0xefa02000 irq 19
[ 2939.550635] ata11: SATA link down (SStatus 0 SControl 0)
[ 2941.744327] ata12: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 2941.744818] ata12.15: Port Multiplier 1.1, 0x11ab:0x4140 r192, 4 ports, feat 0x1/0x1f
[ 2941.748237] ata12.00: hard resetting link
[ 2942.098261] ata12.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 2942.098272] ata12.01: hard resetting link
[ 2942.503173] ata12.01: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 2942.503184] ata12.02: hard resetting link
[ 2942.826474] ata12.02: SATA link down (SStatus 0 SControl 320)
[ 2942.826483] ata12.03: hard resetting link
[ 2943.148091] ata12.03: SATA link down (SStatus 0 SControl 320)
[ 2943.190748] ata12.00: ATA-7: ST3750640NS, 3.BAF, max UDMA/133
[ 2943.190748] ata12.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[ 2943.250806] ata12.00: configured for UDMA/100
[ 2943.258014] ata12.01: ATA-8: Hitachi HDP725050GLA360, GM4OA50E, max UDMA/133
[ 2943.258014] ata12.01: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[ 2943.258783] ata12.01: configured for UDMA/100
[ 2943.258811] ata12: EH complete
[ 2943.278337] scsi 11:0:0:0: Direct-Access     ATA      ST3750640NS      3.BA PQ: 0 ANSI: 5
[ 2943.278337] sd 11:0:0:0: [sdb] 1465149168 512-byte hardware sectors (750156 MB)
[ 2943.278337] sd 11:0:0:0: [sdb] Write Protect is off
[ 2943.278337] sd 11:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 2943.278337] sd 11:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 2943.278337] sd 11:0:0:0: [sdb] 1465149168 512-byte hardware sectors (750156 MB)
[ 2943.278337] sd 11:0:0:0: [sdb] Write Protect is off
[ 2943.278337] sd 11:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 2943.278337] sd 11:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 2943.278337]  sdb: sdb1
[ 2943.295762] sd 11:0:0:0: [sdb] Attached SCSI disk
[ 2943.295762] sd 11:0:0:0: Attached scsi generic sg2 type 0
[ 2943.295762] scsi 11:1:0:0: Direct-Access     ATA      Hitachi HDP72505 GM4O PQ: 0 ANSI: 5
[ 2943.300739] sd 11:1:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
[ 2943.300739] sd 11:1:0:0: [sdc] Write Protect is off
[ 2943.300739] sd 11:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 2943.300739] sd 11:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2943.300739] sd 11:1:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
[ 2943.300739] sd 11:1:0:0: [sdc] Write Protect is off
[ 2943.300739] sd 11:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 2943.300739] sd 11:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2943.300739]  sdc: sdc1
[ 2943.328995] sd 11:1:0:0: [sdc] Attached SCSI disk
[ 2943.328995] sd 11:1:0:0: Attached scsi generic sg3 type 0
[ 2943.338185] ata12.00: exception Emask 0x10 SAct 0x0 SErr 0x2 action 0x7
[ 2943.338197] ata12: SError: { RecovComm }
[ 2943.338250] ata12.00: hard resetting link
[ 2943.662422] ata12.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 2943.773084] ata12.00: configured for UDMA/100
[ 2943.773436] ata12.00: exception Emask 0x10 SAct 0x0 SErr 0x2 action 0x7 t4
[ 2943.773447] ata12: SError: { RecovComm }
[ 2943.773514] ata12.00: hard resetting link
[ 2944.102886] ata12.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 2944.194203] ata12.00: configured for UDMA/100
[ 2944.194376] ata12.00: exception Emask 0x10 SAct 0x0 SErr 0x2 action 0x7 t3
[ 2944.194376] ata12: SError: { RecovComm }
[ 2944.194390] ata12.00: hard resetting link
[ 2944.514084] ata12.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 2944.609247] ata12.00: configured for UDMA/100
[ 2944.609526] ata12.00: limiting SATA link speed to 1.5 Gbps
[ 2944.609702] ata12.00: exception Emask 0x10 SAct 0x0 SErr 0x2 action 0x7 t2
[ 2944.609710] ata12: SError: { RecovComm }
[ 2944.609777] ata12.00: hard resetting link
[ 2944.859691] ata12.15: qc timeout (cmd 0xe8)
[ 2944.859728] ata12.00: failed to write SCR 2 (Emask=0x4)
[ 2944.859734] ata12.00: COMRESET failed (errno=-5)
[ 2944.859743] ata12.00: failed to read SCR 0 (Emask=0x40)
[ 2944.859748] ata12.00: failed to read SCR 0 (Emask=0x40)
[ 2944.859753] ata12.00: reset failed, giving up
[ 2944.859761] ata12.15: hard resetting link
[ 2947.045128] ata12.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 2947.045566] ata12.00: hard resetting link
[ 2947.365932] ata12.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2947.365942] ata12.01: hard resetting link
[ 2947.685944] ata12.01: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 2947.685954] ata12.02: hard resetting link
[ 2948.011227] ata12.02: SATA link down (SStatus 0 SControl 320)
[ 2948.011238] ata12.03: hard resetting link
[ 2948.334180] ata12.03: SATA link down (SStatus 0 SControl 320)
[ 2948.429616] ata12.00: configured for UDMA/100
[ 2948.432581] ata12.01: configured for UDMA/100
[ 2948.432670] ata12.00: exception Emask 0x10 SAct 0x0 SErr 0x2 action 0x7 t1
[ 2948.432670] ata12: SError: { RecovComm }
[ 2948.434459] ata12.00: hard resetting link
[ 2948.755298] ata12.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2948.845434] ata12.00: configured for UDMA/100
[ 2948.845549] ata12: EH pending after 5 tries, giving up
[ 2948.845555] ata12: EH complete
[ 2948.845741] sd 11:0:0:0: [sdb] 1465149168 512-byte hardware sectors (750156 MB)
[ 2948.847678] sd 11:0:0:0: [sdb] Write Protect is off
[ 2948.847690] sd 11:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 2948.847756] sd 11:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2948.847820] sd 11:1:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
[ 2948.847850] sd 11:1:0:0: [sdc] Write Protect is off
[ 2948.847854] sd 11:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 2948.847905] sd 11:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2948.847957] sd 11:0:0:0: [sdb] 1465149168 512-byte hardware sectors (750156 MB)
[ 2948.847986] sd 11:0:0:0: [sdb] Write Protect is off
[ 2948.847990] sd 11:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 2948.848040] sd 11:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2948.848093] sd 11:1:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
[ 2948.848121] sd 11:1:0:0: [sdc] Write Protect is off
[ 2948.848126] sd 11:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 2948.848178] sd 11:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA

Simultaneous hdparm timings; nothing special happens.
