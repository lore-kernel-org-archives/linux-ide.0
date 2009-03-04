From: Grant Grundler <grundler@google.com>
Subject: Re: Mysteriously slow writes SiI 3124
Date: Wed, 4 Mar 2009 09:10:18 -0800
Message-ID: <da824cf30903040910gff4d99en8fc8097fc6a05668@mail.gmail.com>
References: <49AB079A.9090407@rabbit.us> <49AE294D.2020002@rabbit.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:31223 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088AbZCDRKY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Mar 2009 12:10:24 -0500
Received: from spaceape8.eur.corp.google.com (spaceape8.eur.corp.google.com [172.28.16.142])
	by smtp-out.google.com with ESMTP id n24HAKgI016437
	for <linux-ide@vger.kernel.org>; Wed, 4 Mar 2009 09:10:20 -0800
Received: from wf-out-1314.google.com (wfa25.prod.google.com [10.142.1.25])
	by spaceape8.eur.corp.google.com with ESMTP id n24H9Ydj015192
	for <linux-ide@vger.kernel.org>; Wed, 4 Mar 2009 09:10:18 -0800
Received: by wf-out-1314.google.com with SMTP id 25so6632389wfa.30
        for <linux-ide@vger.kernel.org>; Wed, 04 Mar 2009 09:10:18 -0800 (PST)
In-Reply-To: <49AE294D.2020002@rabbit.us>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Rabbitson <rabbit+list@rabbit.us>
Cc: linux-ide@vger.kernel.org

On Tue, Mar 3, 2009 at 11:10 PM, Peter Rabbitson <rabbit+list@rabbit.us=
> wrote:
> No takers? Can I provide more info/measurements/whatever? I would
> really like to get to the bottom of this, pretty frustrating.

Are you ok with wild guesses?
This sounds remarkable similar to the performance of the equivalent
PCIe SATA controller from Silicon Image (3132). The 3132 has 1 PCI-E
lane and should able to move more than 220 MB/s or so. But in fact can
only read 120MB/s and write 170MB/s.

I would either try a different SATA controller in the same slot of the
same host machine OR try the same SATA controller in a different host
machine just to rule out issues with the system chipset.

One other wild guess would be some environmental problem with the disk
drives. If they are hot or being vibrated (e.g. enclosure fan), write
performance will suffer more than read performance. Since these are
500G "Nearline" drives, I expect them to do better under
"adverse" conditions than predecessor "Desktop" (model number ends with=
 "AS").

hth,
grant

>
> Peter Rabbitson wrote:
>> Hello,
>>
>> I have a sil 3124 PCI-X SATA card with 4 drives attached to it.
>> When I read simultaneously from all 4 drives, I get the expected
>> ~220MB/s combined read speed, limited by the presence of a 32bit
>> card on the same bus (entire bus runs on 66mhz, mix of 64 and 32
>> bit cards). When I write to the drives however I only get half of
>> that ~106MB/s combined. Can someone shed some light?
>>
>> All measurements are made on an idle system in single-user mode
>>
>>
>> Combined read:
>> root@Arzamas:~/tr# for d in sde sdb sdc sdd ; do dd if=3D"/dev/${d}2=
" of=3D/dev/null count=3D500 bs=3D1M & done
>> [1] 30243
>> [2] 30244
>> [3] 30245
>> [4] 30246
>> root@Arzamas:~/tr# 500+0 records in
>> 500+0 records out
>> 524288000 bytes (524 MB) copied, 9.23146 s, 56.8 MB/s
>> 500+0 records in
>> 500+0 records out
>> 524288000 bytes (524 MB) copied, 9.3649 s, 56.0 MB/s
>> 500+0 records in
>> 500+0 records out
>> 524288000 bytes (524 MB) copied, 9.59152 s, 54.7 MB/s
>> 500+0 records in
>> 500+0 records out
>> 524288000 bytes (524 MB) copied, 9.60045 s, 54.6 MB/s
>>
>>
>> Combined write:
>> root@Arzamas:~/tr# for d in sde sdb sdc sdd ; do dd of=3D"/dev/${d}2=
" if=3D/dev/zero count=3D500 bs=3D1M & done
>> [1] 30239
>> [2] 30240
>> [3] 30241
>> [4] 30242
>> root@Arzamas:~/tr# 500+0 records in
>> 500+0 records out
>> 524288000 bytes (524 MB) copied, 19.4508 s, 27.0 MB/s
>> 500+0 records in
>> 500+0 records out
>> 524288000 bytes (524 MB) copied, 19.6314 s, 26.7 MB/s
>> 500+0 records in
>> 500+0 records out
>> 524288000 bytes (524 MB) copied, 19.7663 s, 26.5 MB/s
>> 500+0 records in
>> 500+0 records out
>> 524288000 bytes (524 MB) copied, 19.7598 s, 26.5 MB/s
>>
>>
>> Individual read (making sure disks are good):
>> root@Arzamas:~/tr# for d in sde sdb sdc sdd ; do dd if=3D"/dev/${d}2=
" of=3D/dev/null count=3D500 bs=3D1M ; done
>> 500+0 records in
>> 500+0 records out
>> 524288000 bytes (524 MB) copied, 5.00963 s, 105 MB/s
>> 500+0 records in
>> 500+0 records out
>> 524288000 bytes (524 MB) copied, 5.15979 s, 102 MB/s
>> 500+0 records in
>> 500+0 records out
>> 524288000 bytes (524 MB) copied, 5.19258 s, 101 MB/s
>> 500+0 records in
>> 500+0 records out
>> 524288000 bytes (524 MB) copied, 5.24153 s, 100 MB/s
>> root@Arzamas:~/tr#
>>
>>
>> Individual write:
>> root@Arzamas:~/tr# for d in sde sdb sdc sdd ; do dd of=3D"/dev/${d}2=
" if=3D/dev/zero count=3D500 bs=3D1M ; done
>> 500+0 records in
>> 500+0 records out
>> 524288000 bytes (524 MB) copied, 5.15325 s, 102 MB/s
>> 500+0 records in
>> 500+0 records out
>> 524288000 bytes (524 MB) copied, 5.36731 s, 97.7 MB/s
>> 500+0 records in
>> 500+0 records out
>> 524288000 bytes (524 MB) copied, 5.24908 s, 99.9 MB/s
>> 500+0 records in
>> 500+0 records out
>> 524288000 bytes (524 MB) copied, 5.36189 s, 97.8 MB/s
>> root@Arzamas:~/tr#
>>
>>
>> Card:
>> 02:03.0 Mass storage controller: Silicon Image, Inc. SiI 3124 PCI-X =
Serial ATA Controller (rev 02)
>> =C2=A0 =C2=A0 =C2=A0 Subsystem: Silicon Image, Inc. SiI 3124 PCI-X S=
erial ATA Controller
>> =C2=A0 =C2=A0 =C2=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWIN=
V+ VGASnoop- ParErr+ Stepping+ SERR+ FastB2B- DisINTx-
>> =C2=A0 =C2=A0 =C2=A0 Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSE=
L=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>> =C2=A0 =C2=A0 =C2=A0 Latency: 64, Cache Line Size: 64 bytes
>> =C2=A0 =C2=A0 =C2=A0 Interrupt: pin A routed to IRQ 25
>> =C2=A0 =C2=A0 =C2=A0 Region 0: Memory at fc5fd800 (64-bit, non-prefe=
tchable) [size=3D128]
>> =C2=A0 =C2=A0 =C2=A0 Region 2: Memory at fc5f0000 (64-bit, non-prefe=
tchable) [size=3D32K]
>> =C2=A0 =C2=A0 =C2=A0 Region 4: I/O ports at bc00 [size=3D16]
>> =C2=A0 =C2=A0 =C2=A0 Expansion ROM at fc480000 [disabled] [size=3D51=
2K]
>> =C2=A0 =C2=A0 =C2=A0 Capabilities: [64] Power Management version 2
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Flags: PMEClk- DSI+=
 D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Status: D0 PME-Enab=
le- DSel=3D0 DScale=3D1 PME-
>> =C2=A0 =C2=A0 =C2=A0 Capabilities: [40] PCI-X non-bridge device
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Command: DPERE- ERO=
+ RBC=3D512 OST=3D12
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Status: Dev=3Dff:1f=
=2E0 64bit+ 133MHz+ SCD- USC- DC=3Dsimple DMMRBC=3D2048 DMOST=3D12 DMCR=
S=3D128 RSCEM- 266MHz- 533MHz-
>> =C2=A0 =C2=A0 =C2=A0 Capabilities: [54] MSI: Mask- 64bit+ Count=3D1/=
1 Enable-
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Address: 0000000000=
000000 =C2=A0Data: 0000
>> =C2=A0 =C2=A0 =C2=A0 Kernel driver in use: sata_sil24
>>
>>
>> Disks (excerpt from kernel bootup):
>> sata_sil24 0000:02:03.0: version 1.1
>> sata_sil24 0000:02:03.0: PCI INT A -> GSI 25 (level, low) -> IRQ 25
>> scsi3 : sata_sil24
>> scsi4 : sata_sil24
>> scsi5 : sata_sil24
>> scsi6 : sata_sil24
>> ata3: SATA max UDMA/100 host m128@0xfc5fd800 port 0xfc5f0000 irq 25
>> ata4: SATA max UDMA/100 host m128@0xfc5fd800 port 0xfc5f2000 irq 25
>> ata5: SATA max UDMA/100 host m128@0xfc5fd800 port 0xfc5f4000 irq 25
>> ata6: SATA max UDMA/100 host m128@0xfc5fd800 port 0xfc5f6000 irq 25
>> ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
>> ata3.00: ATA-8: ST3500320NS, SN05, max UDMA/133
>> ata3.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
>> ata3.00: configured for UDMA/100
>> ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
>> ata4.00: ATA-8: ST3500320NS, SN05, max UDMA/133
>> ata4.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
>> ata4.00: configured for UDMA/100
>> ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
>> ata5.00: ATA-8: ST3500320NS, SN05, max UDMA/133
>> ata5.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
>> ata5.00: configured for UDMA/100
>> ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
>> ata6.00: ATA-8: ST3500320NS, SN05, max UDMA/133
>> ata6.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
>> ata6.00: configured for UDMA/100
>> scsi 3:0:0:0: Direct-Access =C2=A0 =C2=A0 ATA =C2=A0 =C2=A0 =C2=A0ST=
3500320NS =C2=A0 =C2=A0 =C2=A0SN05 PQ: 0 ANSI: 5
>> sd 3:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
>> sd 3:0:0:0: [sdb] Write Protect is off
>> sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
>> sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't=
 support DPO or FUA
>> sd 3:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
>> sd 3:0:0:0: [sdb] Write Protect is off
>> sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
>> sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't=
 support DPO or FUA
>> =C2=A0sdb: sdb1 sdb2 sdb3
>> sd 3:0:0:0: [sdb] Attached SCSI disk
>> scsi 4:0:0:0: Direct-Access =C2=A0 =C2=A0 ATA =C2=A0 =C2=A0 =C2=A0ST=
3500320NS =C2=A0 =C2=A0 =C2=A0SN05 PQ: 0 ANSI: 5
>> sd 4:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
>> sd 4:0:0:0: [sdc] Write Protect is off
>> sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
>> sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't=
 support DPO or FUA
>> sd 4:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
>> sd 4:0:0:0: [sdc] Write Protect is off
>> sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
>> sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't=
 support DPO or FUA
>> =C2=A0sdc: sdc1 sdc2 sdc3
>> sd 4:0:0:0: [sdc] Attached SCSI disk
>> scsi 5:0:0:0: Direct-Access =C2=A0 =C2=A0 ATA =C2=A0 =C2=A0 =C2=A0ST=
3500320NS =C2=A0 =C2=A0 =C2=A0SN05 PQ: 0 ANSI: 5
>> sd 5:0:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
>> sd 5:0:0:0: [sdd] Write Protect is off
>> sd 5:0:0:0: [sdd] Mode Sense: 00 3a 00 00
>> sd 5:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't=
 support DPO or FUA
>> sd 5:0:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
>> sd 5:0:0:0: [sdd] Write Protect is off
>> sd 5:0:0:0: [sdd] Mode Sense: 00 3a 00 00
>> sd 5:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't=
 support DPO or FUA
>> =C2=A0sdd: sdd1 sdd2 sdd3
>> sd 5:0:0:0: [sdd] Attached SCSI disk
>> scsi 6:0:0:0: Direct-Access =C2=A0 =C2=A0 ATA =C2=A0 =C2=A0 =C2=A0ST=
3500320NS =C2=A0 =C2=A0 =C2=A0SN05 PQ: 0 ANSI: 5
>> sd 6:0:0:0: [sde] 976773168 512-byte hardware sectors (500108 MB)
>> sd 6:0:0:0: [sde] Write Protect is off
>> sd 6:0:0:0: [sde] Mode Sense: 00 3a 00 00
>> sd 6:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't=
 support DPO or FUA
>> sd 6:0:0:0: [sde] 976773168 512-byte hardware sectors (500108 MB)
>> sd 6:0:0:0: [sde] Write Protect is off
>> sd 6:0:0:0: [sde] Mode Sense: 00 3a 00 00
>> sd 6:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't=
 support DPO or FUA
>> =C2=A0sde: sde1 sde2 sde3
>> sd 6:0:0:0: [sde] Attached SCSI disk
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-ide"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
