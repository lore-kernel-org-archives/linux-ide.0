From: Harri Olin <harri.olin@gmail.com>
Subject: Re: sata_mv, io stucks
Date: Thu, 23 Oct 2008 16:31:06 +0300
Message-ID: <49007C9A.7000103@gmail.com>
References: <48F88449.1000704@ngs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw03.mail.saunalahti.fi ([195.197.172.111]:42725 "EHLO
	gw03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756698AbYJWNkE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Oct 2008 09:40:04 -0400
In-Reply-To: <48F88449.1000704@ngs.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Artem Bokhan <aptem@ngs.ru>
Cc: linux-ide@vger.kernel.org, tj@kernel.org, liml@rtr.ca

Artem Bokhan wrote:
> I try to simulate random reads  with "sysbench --test=fileio 
> --num-threads=16 --max-requests=9999999 --max-time=60 --init-rng=on 
> --file-num=16 --file-fsync-freq=0 --file-test-mode=rndrd 
> --file-total-size=30G run"
>
> Two marvell controllers, 16 disks, software raid10, IO stucks on 
> different disks, kernel 2.6.26.5.
> With default ubuntu's 8.04 2.6.24 kernel the problem can not be repeated

I have the same problem with recent kernels with updated sata_mv driver. 
First IO stops for a while and afer EH runs, everything works again for 
a while. Happens on 3 different computers using WD5000ABYS, WD5000YS and 
WD7500AYYS hard disks, RAID5 and 6 configurations using Linux MD.

Stalls seem to happen only on controller ports 0-3, ports 4-7 work 
without problems.

Contoller is Supermicro AOC-SAT2-MV8, connected to 133MHz PCI-X slot on 
one computer, 66MHz 64bit PCI slot on the second machine and to normal 
32bit PCI slot on third computer.
http://www.supermicro.com/products/accessories/addon/AoC-SAT2-MV8.cfm

At the moment I don't have disks connected to failing ports, but if 
needed, I can test patches.

Oct 10 18:56:17 mizar kernel: ata10.00: exception Emask 0x0 SAct 0x0 
SErr 0x0 action 0x6 frozen
Oct 10 18:56:17 mizar kernel: ata10.00: cmd 
35/00:08:3f:52:54/00:00:57:00:00/e0 tag 0 dma 4096 out
Oct 10 18:56:17 mizar kernel:          res 
40/00:ff:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
Oct 10 18:56:17 mizar kernel: ata10.00: status: { DRDY }
Oct 10 18:56:17 mizar kernel: ata10: hard resetting link
Oct 10 18:56:17 mizar kernel: ata10: SATA link up 1.5 Gbps (SStatus 113 
SControl 310)
Oct 10 18:56:17 mizar kernel: ata10.00: max_sectors limited to 256 for NCQ
Oct 10 18:56:17 mizar kernel: ata10.00: max_sectors limited to 256 for NCQ
Oct 10 18:56:17 mizar kernel: ata10.00: configured for UDMA/33
Oct 10 18:56:17 mizar kernel: ata10: EH complete
Oct 10 18:56:17 mizar kernel: sd 9:0:0:0: [sdg] 1465149168 512-byte 
hardware sectors (750156 MB)
Oct 10 18:56:17 mizar kernel: sd 9:0:0:0: [sdg] Write Protect is off
Oct 10 18:56:17 mizar kernel: sd 9:0:0:0: [sdg] Mode Sense: 00 3a 00 00
Oct 10 18:56:17 mizar kernel: sd 9:0:0:0: [sdg] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Oct 10 19:34:58 mizar kernel: ata10.00: exception Emask 0x0 SAct 0x0 
SErr 0x0 action 0x6 frozen
Oct 10 19:34:58 mizar kernel: ata10.00: cmd 
35/00:08:3f:52:54/00:00:57:00:00/e0 tag 0 dma 4096 out
Oct 10 19:34:58 mizar kernel:          res 
40/00:ff:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
Oct 10 19:34:58 mizar kernel: ata10.00: status: { DRDY }
Oct 10 19:34:58 mizar kernel: ata10: hard resetting link
Oct 10 19:34:58 mizar kernel: ata10: SATA link up 1.5 Gbps (SStatus 113 
SControl 310)
Oct 10 19:34:58 mizar kernel: ata10.00: max_sectors limited to 256 for NCQ
Oct 10 19:34:58 mizar kernel: ata10.00: max_sectors limited to 256 for NCQ
Oct 10 19:34:58 mizar kernel: ata10.00: configured for UDMA/33
Oct 10 19:34:58 mizar kernel: ata10: EH complete
Oct 10 19:34:58 mizar kernel: sd 9:0:0:0: [sdg] 1465149168 512-byte 
hardware sectors (750156 MB)
Oct 10 19:34:58 mizar kernel: sd 9:0:0:0: [sdg] Write Protect is off
Oct 10 19:34:58 mizar kernel: sd 9:0:0:0: [sdg] Mode Sense: 00 3a 00 00
Oct 10 19:34:58 mizar kernel: sd 9:0:0:0: [sdg] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA

Oct 10 19:37:05 mizar kernel: ata10.00: exception Emask 0x0 SAct 0x0 
SErr 0x0 action 0x6 frozen
Oct 10 19:37:05 mizar kernel: ata10.00: cmd 
35/00:08:3f:52:54/00:00:57:00:00/e0 tag 0 dma 4096 out
Oct 10 19:37:05 mizar kernel:          res 
40/00:ff:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
Oct 10 19:37:05 mizar kernel: ata10.00: status: { DRDY }
Oct 10 19:37:05 mizar kernel: ata10: hard resetting link
Oct 10 19:37:06 mizar kernel: ata10: SATA link up 1.5 Gbps (SStatus 113 
SControl 310)
Oct 10 19:37:06 mizar kernel: ata10.00: max_sectors limited to 256 for NCQ
Oct 10 19:37:06 mizar kernel: ata10.00: max_sectors limited to 256 for NCQ
Oct 10 19:37:06 mizar kernel: ata10.00: configured for UDMA/33
Oct 10 19:37:06 mizar kernel: ata10: EH complete
Oct 10 19:37:06 mizar kernel: sd 9:0:0:0: [sdg] 1465149168 512-byte 
hardware sectors (750156 MB)
Oct 10 19:37:06 mizar kernel: sd 9:0:0:0: [sdg] Write Protect is off
Oct 10 19:37:06 mizar kernel: sd 9:0:0:0: [sdg] Mode Sense: 00 3a 00 00
Oct 10 19:37:06 mizar kernel: sd 9:0:0:0: [sdg] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA

Sep 26 15:47:14 mvsrv02 kernel: ata5.00: exception Emask 0x0 SAct 0xf 
SErr 0x0 action 0x6 frozen
Sep 26 15:47:14 mvsrv02 kernel: ata5.00: cmd 
60/40:00:7f:a1:e2/00:00:28:00:00/40 tag 0 ncq 32768 in
Sep 26 15:47:14 mvsrv02 kernel:          res 
40/00:00:09:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
Sep 26 15:47:14 mvsrv02 kernel: ata5.00: status: { DRDY }
Sep 26 15:47:14 mvsrv02 kernel: ata5.00: cmd 
60/40:08:3f:a1:e2/00:00:28:00:00/40 tag 1 ncq 32768 in
Sep 26 15:47:14 mvsrv02 kernel:          res 
40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Sep 26 15:47:14 mvsrv02 kernel: ata5.00: status: { DRDY }
Sep 26 15:47:14 mvsrv02 kernel: ata5.00: cmd 
60/40:10:3f:a2:e2/00:00:28:00:00/40 tag 2 ncq 32768 in
Sep 26 15:47:14 mvsrv02 kernel:          res 
40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Sep 26 15:47:14 mvsrv02 kernel: ata5.00: status: { DRDY }
Sep 26 15:47:14 mvsrv02 kernel: ata5.00: cmd 
60/c0:18:7f:a2:e2/00:00:28:00:00/40 tag 3 ncq 98304 in
Sep 26 15:47:14 mvsrv02 kernel:          res 
40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Sep 26 15:47:14 mvsrv02 kernel: ata5.00: status: { DRDY }
Sep 26 15:47:14 mvsrv02 kernel: ata5: hard resetting link
Sep 26 15:47:14 mvsrv02 kernel: ata5: SATA link up 3.0 Gbps (SStatus 123 
SControl 300)
Sep 26 15:47:14 mvsrv02 kernel: ata5.00: max_sectors limited to 256 for NCQ
Sep 26 15:47:14 mvsrv02 kernel: ata5.00: max_sectors limited to 256 for NCQ
Sep 26 15:47:14 mvsrv02 kernel: ata5.00: configured for UDMA/133
Sep 26 15:47:14 mvsrv02 kernel: ata5: EH complete
Sep 26 15:47:14 mvsrv02 kernel: sd 4:0:0:0: [sdb] 976773168 512-byte 
hardware sectors (500108 MB)
Sep 26 15:47:14 mvsrv02 kernel: sd 4:0:0:0: [sdb] Write Protect is off
Sep 26 15:47:14 mvsrv02 kernel: sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Sep 26 15:47:14 mvsrv02 kernel: sd 4:0:0:0: [sdb] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA

1st comuter: 133MHz PCI-X slot
03:01.0 SCSI storage controller: Marvell Technology Group Ltd. 
MV88SX6081 8-port SATA II PCI-X Controller (rev 09)
        Subsystem: Marvell Technology Group Ltd. Unknown device 11ab
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B+ DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 32, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 48
        Region 0: Memory at d8800000 (64-bit, non-prefetchable) [size=1M]
        Region 2: I/O ports at 3000 [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ 
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [60] PCI-X non-bridge device
                Command: DPERE- ERO- RBC=512 OST=4
                Status: Dev=03:01.0 64bit+ 133MHz+ SCD- USC- DC=simple 
DMMRBC=512 DMOST=4 DMCRS=8 RSCEM- 266MHz- 533MHz-
        Kernel driver in use: sata_mv

2nd: 66MHz 64bit PCI
02:01.0 SCSI storage controller: Marvell Technology Group Ltd. 
MV88SX6081 8-port SATA II PCI-X Controller (rev 09)
        Subsystem: Marvell Technology Group Ltd. Unknown device 11ab
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 128 bytes
        Interrupt: pin A routed to IRQ 24
        Region 0: Memory at f2800000 (64-bit, non-prefetchable) [size=1M]
        Region 2: I/O ports at c000 [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ 
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [60] PCI-X non-bridge device
                Command: DPERE- ERO- RBC=512 OST=4
                Status: Dev=02:01.0 64bit+ 133MHz+ SCD- USC- DC=simple 
DMMRBC=512 DMOST=4 DMCRS=8 RSCEM- 266MHz- 533MHz-

3rd computer: 32bit 33MHz PCI
00:0a.0 SCSI storage controller: Marvell Technology Group Ltd. 
MV88SX6081 8-port SATA II PCI-X Controller (rev 09)
        Subsystem: Marvell Technology Group Ltd. Unknown device 11ab
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at cfe00000 (64-bit, non-prefetchable) [size=1M]
        Region 2: I/O ports at dc00 [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] Message Signalled Interrupts: 64bit+ 
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [60] PCI-X non-bridge device
                Command: DPERE- ERO- RBC=512 OST=4
                Status: Dev=ff:1f.0 64bit+ 133MHz+ SCD- USC- DC=simple 
DMMRBC=512 DMOST=4 DMCRS=8 RSCEM- 266MHz- 533MHz-


-- 
Harri.
