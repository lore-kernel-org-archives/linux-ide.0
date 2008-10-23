From: Bokhan Artem <APTEM@ngs.ru>
Subject: Re: sata_mv, io stucks
Date: Thu, 23 Oct 2008 23:32:18 +0700
Message-ID: <4900A712.4000700@ngs.ru>
References: <48F88449.1000704@ngs.ru> <49007C9A.7000103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpout1.ngs.ru ([195.93.186.195]:37942 "EHLO smtpout1.ngs.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754696AbYJWQcQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Oct 2008 12:32:16 -0400
In-Reply-To: <49007C9A.7000103@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harri Olin <harri.olin@gmail.com>
Cc: linux-ide@vger.kernel.org, liml@rtr.ca

The controller is AOC-SAT2-MV8 too.


Harri Olin =D0=C9=DB=C5=D4:
> Artem Bokhan wrote:
>> I try to simulate random reads  with "sysbench --test=3Dfileio=20
>> --num-threads=3D16 --max-requests=3D9999999 --max-time=3D60 --init-r=
ng=3Don=20
>> --file-num=3D16 --file-fsync-freq=3D0 --file-test-mode=3Drndrd=20
>> --file-total-size=3D30G run"
>>
>> Two marvell controllers, 16 disks, software raid10, IO stucks on=20
>> different disks, kernel 2.6.26.5.
>> With default ubuntu's 8.04 2.6.24 kernel the problem can not be repe=
ated
>
> I have the same problem with recent kernels with updated sata_mv=20
> driver. First IO stops for a while and afer EH runs, everything works=
=20
> again for a while. Happens on 3 different computers using WD5000ABYS,=
=20
> WD5000YS and WD7500AYYS hard disks, RAID5 and 6 configurations using=20
> Linux MD.
>
> Stalls seem to happen only on controller ports 0-3, ports 4-7 work=20
> without problems.
>
> Contoller is Supermicro AOC-SAT2-MV8, connected to 133MHz PCI-X slot=20
> on one computer, 66MHz 64bit PCI slot on the second machine and to=20
> normal 32bit PCI slot on third computer.
> http://www.supermicro.com/products/accessories/addon/AoC-SAT2-MV8.cfm
>
> At the moment I don't have disks connected to failing ports, but if=20
> needed, I can test patches.
>
> Oct 10 18:56:17 mizar kernel: ata10.00: exception Emask 0x0 SAct 0x0=20
> SErr 0x0 action 0x6 frozen
> Oct 10 18:56:17 mizar kernel: ata10.00: cmd=20
> 35/00:08:3f:52:54/00:00:57:00:00/e0 tag 0 dma 4096 out
> Oct 10 18:56:17 mizar kernel:          res=20
> 40/00:ff:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
> Oct 10 18:56:17 mizar kernel: ata10.00: status: { DRDY }
> Oct 10 18:56:17 mizar kernel: ata10: hard resetting link
> Oct 10 18:56:17 mizar kernel: ata10: SATA link up 1.5 Gbps (SStatus=20
> 113 SControl 310)
> Oct 10 18:56:17 mizar kernel: ata10.00: max_sectors limited to 256 fo=
r=20
> NCQ
> Oct 10 18:56:17 mizar kernel: ata10.00: max_sectors limited to 256 fo=
r=20
> NCQ
> Oct 10 18:56:17 mizar kernel: ata10.00: configured for UDMA/33
> Oct 10 18:56:17 mizar kernel: ata10: EH complete
> Oct 10 18:56:17 mizar kernel: sd 9:0:0:0: [sdg] 1465149168 512-byte=20
> hardware sectors (750156 MB)
> Oct 10 18:56:17 mizar kernel: sd 9:0:0:0: [sdg] Write Protect is off
> Oct 10 18:56:17 mizar kernel: sd 9:0:0:0: [sdg] Mode Sense: 00 3a 00 =
00
> Oct 10 18:56:17 mizar kernel: sd 9:0:0:0: [sdg] Write cache: enabled,=
=20
> read cache: enabled, doesn't support DPO or FUA
> Oct 10 19:34:58 mizar kernel: ata10.00: exception Emask 0x0 SAct 0x0=20
> SErr 0x0 action 0x6 frozen
> Oct 10 19:34:58 mizar kernel: ata10.00: cmd=20
> 35/00:08:3f:52:54/00:00:57:00:00/e0 tag 0 dma 4096 out
> Oct 10 19:34:58 mizar kernel:          res=20
> 40/00:ff:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
> Oct 10 19:34:58 mizar kernel: ata10.00: status: { DRDY }
> Oct 10 19:34:58 mizar kernel: ata10: hard resetting link
> Oct 10 19:34:58 mizar kernel: ata10: SATA link up 1.5 Gbps (SStatus=20
> 113 SControl 310)
> Oct 10 19:34:58 mizar kernel: ata10.00: max_sectors limited to 256 fo=
r=20
> NCQ
> Oct 10 19:34:58 mizar kernel: ata10.00: max_sectors limited to 256 fo=
r=20
> NCQ
> Oct 10 19:34:58 mizar kernel: ata10.00: configured for UDMA/33
> Oct 10 19:34:58 mizar kernel: ata10: EH complete
> Oct 10 19:34:58 mizar kernel: sd 9:0:0:0: [sdg] 1465149168 512-byte=20
> hardware sectors (750156 MB)
> Oct 10 19:34:58 mizar kernel: sd 9:0:0:0: [sdg] Write Protect is off
> Oct 10 19:34:58 mizar kernel: sd 9:0:0:0: [sdg] Mode Sense: 00 3a 00 =
00
> Oct 10 19:34:58 mizar kernel: sd 9:0:0:0: [sdg] Write cache: enabled,=
=20
> read cache: enabled, doesn't support DPO or FUA
>
> Oct 10 19:37:05 mizar kernel: ata10.00: exception Emask 0x0 SAct 0x0=20
> SErr 0x0 action 0x6 frozen
> Oct 10 19:37:05 mizar kernel: ata10.00: cmd=20
> 35/00:08:3f:52:54/00:00:57:00:00/e0 tag 0 dma 4096 out
> Oct 10 19:37:05 mizar kernel:          res=20
> 40/00:ff:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
> Oct 10 19:37:05 mizar kernel: ata10.00: status: { DRDY }
> Oct 10 19:37:05 mizar kernel: ata10: hard resetting link
> Oct 10 19:37:06 mizar kernel: ata10: SATA link up 1.5 Gbps (SStatus=20
> 113 SControl 310)
> Oct 10 19:37:06 mizar kernel: ata10.00: max_sectors limited to 256 fo=
r=20
> NCQ
> Oct 10 19:37:06 mizar kernel: ata10.00: max_sectors limited to 256 fo=
r=20
> NCQ
> Oct 10 19:37:06 mizar kernel: ata10.00: configured for UDMA/33
> Oct 10 19:37:06 mizar kernel: ata10: EH complete
> Oct 10 19:37:06 mizar kernel: sd 9:0:0:0: [sdg] 1465149168 512-byte=20
> hardware sectors (750156 MB)
> Oct 10 19:37:06 mizar kernel: sd 9:0:0:0: [sdg] Write Protect is off
> Oct 10 19:37:06 mizar kernel: sd 9:0:0:0: [sdg] Mode Sense: 00 3a 00 =
00
> Oct 10 19:37:06 mizar kernel: sd 9:0:0:0: [sdg] Write cache: enabled,=
=20
> read cache: enabled, doesn't support DPO or FUA
>
> Sep 26 15:47:14 mvsrv02 kernel: ata5.00: exception Emask 0x0 SAct 0xf=
=20
> SErr 0x0 action 0x6 frozen
> Sep 26 15:47:14 mvsrv02 kernel: ata5.00: cmd=20
> 60/40:00:7f:a1:e2/00:00:28:00:00/40 tag 0 ncq 32768 in
> Sep 26 15:47:14 mvsrv02 kernel:          res=20
> 40/00:00:09:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
> Sep 26 15:47:14 mvsrv02 kernel: ata5.00: status: { DRDY }
> Sep 26 15:47:14 mvsrv02 kernel: ata5.00: cmd=20
> 60/40:08:3f:a1:e2/00:00:28:00:00/40 tag 1 ncq 32768 in
> Sep 26 15:47:14 mvsrv02 kernel:          res=20
> 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Sep 26 15:47:14 mvsrv02 kernel: ata5.00: status: { DRDY }
> Sep 26 15:47:14 mvsrv02 kernel: ata5.00: cmd=20
> 60/40:10:3f:a2:e2/00:00:28:00:00/40 tag 2 ncq 32768 in
> Sep 26 15:47:14 mvsrv02 kernel:          res=20
> 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Sep 26 15:47:14 mvsrv02 kernel: ata5.00: status: { DRDY }
> Sep 26 15:47:14 mvsrv02 kernel: ata5.00: cmd=20
> 60/c0:18:7f:a2:e2/00:00:28:00:00/40 tag 3 ncq 98304 in
> Sep 26 15:47:14 mvsrv02 kernel:          res=20
> 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Sep 26 15:47:14 mvsrv02 kernel: ata5.00: status: { DRDY }
> Sep 26 15:47:14 mvsrv02 kernel: ata5: hard resetting link
> Sep 26 15:47:14 mvsrv02 kernel: ata5: SATA link up 3.0 Gbps (SStatus=20
> 123 SControl 300)
> Sep 26 15:47:14 mvsrv02 kernel: ata5.00: max_sectors limited to 256=20
> for NCQ
> Sep 26 15:47:14 mvsrv02 kernel: ata5.00: max_sectors limited to 256=20
> for NCQ
> Sep 26 15:47:14 mvsrv02 kernel: ata5.00: configured for UDMA/133
> Sep 26 15:47:14 mvsrv02 kernel: ata5: EH complete
> Sep 26 15:47:14 mvsrv02 kernel: sd 4:0:0:0: [sdb] 976773168 512-byte=20
> hardware sectors (500108 MB)
> Sep 26 15:47:14 mvsrv02 kernel: sd 4:0:0:0: [sdb] Write Protect is of=
f
> Sep 26 15:47:14 mvsrv02 kernel: sd 4:0:0:0: [sdb] Mode Sense: 00 3a 0=
0 00
> Sep 26 15:47:14 mvsrv02 kernel: sd 4:0:0:0: [sdb] Write cache:=20
> enabled, read cache: enabled, doesn't support DPO or FUA
>
> 1st comuter: 133MHz PCI-X slot
> 03:01.0 SCSI storage controller: Marvell Technology Group Ltd.=20
> MV88SX6081 8-port SATA II PCI-X Controller (rev 09)
>        Subsystem: Marvell Technology Group Ltd. Unknown device 11ab
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-=20
> ParErr- Stepping- SERR- FastB2B+ DisINTx-
>        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium=20
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Latency: 32, Cache Line Size: 32 bytes
>        Interrupt: pin A routed to IRQ 48
>        Region 0: Memory at d8800000 (64-bit, non-prefetchable) [size=3D=
1M]
>        Region 2: I/O ports at 3000 [size=3D256]
>        Capabilities: [40] Power Management version 2
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>        Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+=20
> Queue=3D0/0 Enable-
>                Address: 0000000000000000  Data: 0000
>        Capabilities: [60] PCI-X non-bridge device
>                Command: DPERE- ERO- RBC=3D512 OST=3D4
>                Status: Dev=3D03:01.0 64bit+ 133MHz+ SCD- USC- DC=3Dsi=
mple=20
> DMMRBC=3D512 DMOST=3D4 DMCRS=3D8 RSCEM- 266MHz- 533MHz-
>        Kernel driver in use: sata_mv
>
> 2nd: 66MHz 64bit PCI
> 02:01.0 SCSI storage controller: Marvell Technology Group Ltd.=20
> MV88SX6081 8-port SATA II PCI-X Controller (rev 09)
>        Subsystem: Marvell Technology Group Ltd. Unknown device 11ab
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-=20
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium=20
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 32, Cache Line Size: 128 bytes
>        Interrupt: pin A routed to IRQ 24
>        Region 0: Memory at f2800000 (64-bit, non-prefetchable) [size=3D=
1M]
>        Region 2: I/O ports at c000 [size=3D256]
>        Capabilities: [40] Power Management version 2
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>        Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+=20
> Queue=3D0/0 Enable-
>                Address: 0000000000000000  Data: 0000
>        Capabilities: [60] PCI-X non-bridge device
>                Command: DPERE- ERO- RBC=3D512 OST=3D4
>                Status: Dev=3D02:01.0 64bit+ 133MHz+ SCD- USC- DC=3Dsi=
mple=20
> DMMRBC=3D512 DMOST=3D4 DMCRS=3D8 RSCEM- 266MHz- 533MHz-
>
> 3rd computer: 32bit 33MHz PCI
> 00:0a.0 SCSI storage controller: Marvell Technology Group Ltd.=20
> MV88SX6081 8-port SATA II PCI-X Controller (rev 09)
>        Subsystem: Marvell Technology Group Ltd. Unknown device 11ab
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-=20
> ParErr- Stepping- SERR+ FastB2B-
>        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium=20
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 32, Cache Line Size: 32 bytes
>        Interrupt: pin A routed to IRQ 16
>        Region 0: Memory at cfe00000 (64-bit, non-prefetchable) [size=3D=
1M]
>        Region 2: I/O ports at dc00 [size=3D256]
>        Capabilities: [40] Power Management version 2
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>        Capabilities: [50] Message Signalled Interrupts: 64bit+=20
> Queue=3D0/0 Enable-
>                Address: 0000000000000000  Data: 0000
>        Capabilities: [60] PCI-X non-bridge device
>                Command: DPERE- ERO- RBC=3D512 OST=3D4
>                Status: Dev=3Dff:1f.0 64bit+ 133MHz+ SCD- USC- DC=3Dsi=
mple=20
> DMMRBC=3D512 DMOST=3D4 DMCRS=3D8 RSCEM- 266MHz- 533MHz-
>
>

