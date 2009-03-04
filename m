From: Peter Rabbitson <rabbit+list@rabbit.us>
Subject: Re: Mysteriously slow writes SiI 3124
Date: Wed, 04 Mar 2009 18:39:28 +0100
Message-ID: <49AEBCD0.70302@rabbit.us>
References: <49AB079A.9090407@rabbit.us> <49AE294D.2020002@rabbit.us> <da824cf30903040910gff4d99en8fc8097fc6a05668@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from arx.rabbit.us ([76.244.88.238]:45564 "EHLO arx.rabbit.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753975AbZCDRjd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Mar 2009 12:39:33 -0500
In-Reply-To: <da824cf30903040910gff4d99en8fc8097fc6a05668@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: linux-ide@vger.kernel.org

Grant Grundler wrote:
> On Tue, Mar 3, 2009 at 11:10 PM, Peter Rabbitson <rabbit+list@rabbit.us> wrote:
>> No takers? Can I provide more info/measurements/whatever? I would
>> really like to get to the bottom of this, pretty frustrating.
> 
> Are you ok with wild guesses?
> This sounds remarkable similar to the performance of the equivalent
> PCIe SATA controller from Silicon Image (3132). The 3132 has 1 PCI-E
> lane and should able to move more than 220 MB/s or so. But in fact can
> only read 120MB/s and write 170MB/s.

Interesting...

> I would either try a different SATA controller in the same slot of the
> same host machine OR try the same SATA controller in a different host
> machine just to rule out issues with the system chipset.

Hm... since this is a PCI-X I can't really try it anywhere else... but then
I can just stick it into a 32bit PCI  slot, and see what happens then (as
it should give me at least equal-to-read speed).

> One other wild guess would be some environmental problem with the disk
> drives. If they are hot or being vibrated (e.g. enclosure fan), write
> performance will suffer more than read performance. Since these are
> 500G "Nearline" drives, I expect them to do better under
> "adverse" conditions than predecessor "Desktop" (model number ends with "AS").

A hard drive problem (environmental or otherwise) would not explain the
performance difference when doing IO on a single drive vs doing it on
several at the same time. It got to be something bus congestion related.

Thank you for your input!


>> Peter Rabbitson wrote:
>>> Hello,
>>>
>>> I have a sil 3124 PCI-X SATA card with 4 drives attached to it.
>>> When I read simultaneously from all 4 drives, I get the expected
>>> ~220MB/s combined read speed, limited by the presence of a 32bit
>>> card on the same bus (entire bus runs on 66mhz, mix of 64 and 32
>>> bit cards). When I write to the drives however I only get half of
>>> that ~106MB/s combined. Can someone shed some light?
>>>
>>> All measurements are made on an idle system in single-user mode
>>>
>>>
>>> Combined read:
>>> root@Arzamas:~/tr# for d in sde sdb sdc sdd ; do dd if="/dev/${d}2" of=/dev/null count=500 bs=1M & done
>>> [1] 30243
>>> [2] 30244
>>> [3] 30245
>>> [4] 30246
>>> root@Arzamas:~/tr# 500+0 records in
>>> 500+0 records out
>>> 524288000 bytes (524 MB) copied, 9.23146 s, 56.8 MB/s
>>> 500+0 records in
>>> 500+0 records out
>>> 524288000 bytes (524 MB) copied, 9.3649 s, 56.0 MB/s
>>> 500+0 records in
>>> 500+0 records out
>>> 524288000 bytes (524 MB) copied, 9.59152 s, 54.7 MB/s
>>> 500+0 records in
>>> 500+0 records out
>>> 524288000 bytes (524 MB) copied, 9.60045 s, 54.6 MB/s
>>>
>>>
>>> Combined write:
>>> root@Arzamas:~/tr# for d in sde sdb sdc sdd ; do dd of="/dev/${d}2" if=/dev/zero count=500 bs=1M & done
>>> [1] 30239
>>> [2] 30240
>>> [3] 30241
>>> [4] 30242
>>> root@Arzamas:~/tr# 500+0 records in
>>> 500+0 records out
>>> 524288000 bytes (524 MB) copied, 19.4508 s, 27.0 MB/s
>>> 500+0 records in
>>> 500+0 records out
>>> 524288000 bytes (524 MB) copied, 19.6314 s, 26.7 MB/s
>>> 500+0 records in
>>> 500+0 records out
>>> 524288000 bytes (524 MB) copied, 19.7663 s, 26.5 MB/s
>>> 500+0 records in
>>> 500+0 records out
>>> 524288000 bytes (524 MB) copied, 19.7598 s, 26.5 MB/s
>>>
>>>
>>> Individual read (making sure disks are good):
>>> root@Arzamas:~/tr# for d in sde sdb sdc sdd ; do dd if="/dev/${d}2" of=/dev/null count=500 bs=1M ; done
>>> 500+0 records in
>>> 500+0 records out
>>> 524288000 bytes (524 MB) copied, 5.00963 s, 105 MB/s
>>> 500+0 records in
>>> 500+0 records out
>>> 524288000 bytes (524 MB) copied, 5.15979 s, 102 MB/s
>>> 500+0 records in
>>> 500+0 records out
>>> 524288000 bytes (524 MB) copied, 5.19258 s, 101 MB/s
>>> 500+0 records in
>>> 500+0 records out
>>> 524288000 bytes (524 MB) copied, 5.24153 s, 100 MB/s
>>> root@Arzamas:~/tr#
>>>
>>>
>>> Individual write:
>>> root@Arzamas:~/tr# for d in sde sdb sdc sdd ; do dd of="/dev/${d}2" if=/dev/zero count=500 bs=1M ; done
>>> 500+0 records in
>>> 500+0 records out
>>> 524288000 bytes (524 MB) copied, 5.15325 s, 102 MB/s
>>> 500+0 records in
>>> 500+0 records out
>>> 524288000 bytes (524 MB) copied, 5.36731 s, 97.7 MB/s
>>> 500+0 records in
>>> 500+0 records out
>>> 524288000 bytes (524 MB) copied, 5.24908 s, 99.9 MB/s
>>> 500+0 records in
>>> 500+0 records out
>>> 524288000 bytes (524 MB) copied, 5.36189 s, 97.8 MB/s
>>> root@Arzamas:~/tr#
>>>
>>>
>>> Card:
>>> 02:03.0 Mass storage controller: Silicon Image, Inc. SiI 3124 PCI-X Serial ATA Controller (rev 02)
>>>       Subsystem: Silicon Image, Inc. SiI 3124 PCI-X Serial ATA Controller
>>>       Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr+ Stepping+ SERR+ FastB2B- DisINTx-
>>>       Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>       Latency: 64, Cache Line Size: 64 bytes
>>>       Interrupt: pin A routed to IRQ 25
>>>       Region 0: Memory at fc5fd800 (64-bit, non-prefetchable) [size=128]
>>>       Region 2: Memory at fc5f0000 (64-bit, non-prefetchable) [size=32K]
>>>       Region 4: I/O ports at bc00 [size=16]
>>>       Expansion ROM at fc480000 [disabled] [size=512K]
>>>       Capabilities: [64] Power Management version 2
>>>               Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>>               Status: D0 PME-Enable- DSel=0 DScale=1 PME-
>>>       Capabilities: [40] PCI-X non-bridge device
>>>               Command: DPERE- ERO+ RBC=512 OST=12
>>>               Status: Dev=ff:1f.0 64bit+ 133MHz+ SCD- USC- DC=simple DMMRBC=2048 DMOST=12 DMCRS=128 RSCEM- 266MHz- 533MHz-
>>>       Capabilities: [54] MSI: Mask- 64bit+ Count=1/1 Enable-
>>>               Address: 0000000000000000  Data: 0000
>>>       Kernel driver in use: sata_sil24
>>>
>>>
>>> Disks (excerpt from kernel bootup):
>>> sata_sil24 0000:02:03.0: version 1.1
>>> sata_sil24 0000:02:03.0: PCI INT A -> GSI 25 (level, low) -> IRQ 25
>>> scsi3 : sata_sil24
>>> scsi4 : sata_sil24
>>> scsi5 : sata_sil24
>>> scsi6 : sata_sil24
>>> ata3: SATA max UDMA/100 host m128@0xfc5fd800 port 0xfc5f0000 irq 25
>>> ata4: SATA max UDMA/100 host m128@0xfc5fd800 port 0xfc5f2000 irq 25
>>> ata5: SATA max UDMA/100 host m128@0xfc5fd800 port 0xfc5f4000 irq 25
>>> ata6: SATA max UDMA/100 host m128@0xfc5fd800 port 0xfc5f6000 irq 25
>>> ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
>>> ata3.00: ATA-8: ST3500320NS, SN05, max UDMA/133
>>> ata3.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
>>> ata3.00: configured for UDMA/100
>>> ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
>>> ata4.00: ATA-8: ST3500320NS, SN05, max UDMA/133
>>> ata4.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
>>> ata4.00: configured for UDMA/100
>>> ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
>>> ata5.00: ATA-8: ST3500320NS, SN05, max UDMA/133
>>> ata5.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
>>> ata5.00: configured for UDMA/100
>>> ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
>>> ata6.00: ATA-8: ST3500320NS, SN05, max UDMA/133
>>> ata6.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
>>> ata6.00: configured for UDMA/100
>>> scsi 3:0:0:0: Direct-Access     ATA      ST3500320NS      SN05 PQ: 0 ANSI: 5
>>> sd 3:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
>>> sd 3:0:0:0: [sdb] Write Protect is off
>>> sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
>>> sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>>> sd 3:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
>>> sd 3:0:0:0: [sdb] Write Protect is off
>>> sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
>>> sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>>>  sdb: sdb1 sdb2 sdb3
>>> sd 3:0:0:0: [sdb] Attached SCSI disk
>>> scsi 4:0:0:0: Direct-Access     ATA      ST3500320NS      SN05 PQ: 0 ANSI: 5
>>> sd 4:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
>>> sd 4:0:0:0: [sdc] Write Protect is off
>>> sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
>>> sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>>> sd 4:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
>>> sd 4:0:0:0: [sdc] Write Protect is off
>>> sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
>>> sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>>>  sdc: sdc1 sdc2 sdc3
>>> sd 4:0:0:0: [sdc] Attached SCSI disk
>>> scsi 5:0:0:0: Direct-Access     ATA      ST3500320NS      SN05 PQ: 0 ANSI: 5
>>> sd 5:0:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
>>> sd 5:0:0:0: [sdd] Write Protect is off
>>> sd 5:0:0:0: [sdd] Mode Sense: 00 3a 00 00
>>> sd 5:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>>> sd 5:0:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
>>> sd 5:0:0:0: [sdd] Write Protect is off
>>> sd 5:0:0:0: [sdd] Mode Sense: 00 3a 00 00
>>> sd 5:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>>>  sdd: sdd1 sdd2 sdd3
>>> sd 5:0:0:0: [sdd] Attached SCSI disk
>>> scsi 6:0:0:0: Direct-Access     ATA      ST3500320NS      SN05 PQ: 0 ANSI: 5
>>> sd 6:0:0:0: [sde] 976773168 512-byte hardware sectors (500108 MB)
>>> sd 6:0:0:0: [sde] Write Protect is off
>>> sd 6:0:0:0: [sde] Mode Sense: 00 3a 00 00
>>> sd 6:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>>> sd 6:0:0:0: [sde] 976773168 512-byte hardware sectors (500108 MB)
>>> sd 6:0:0:0: [sde] Write Protect is off
>>> sd 6:0:0:0: [sde] Mode Sense: 00 3a 00 00
>>> sd 6:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>>>  sde: sde1 sde2 sde3
>>> sd 6:0:0:0: [sde] Attached SCSI disk
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

