From: Brad Campbell <brad@wasp.net.au>
Subject: libata oops 2.6.11-rc4 yesterdays BK
Date: Wed, 16 Feb 2005 08:28:06 +0400
Message-ID: <4212CBD6.7020703@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from wasp.net.au ([203.190.192.17]:31641 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S261985AbVBPE2Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Feb 2005 23:28:16 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Woke up to this, this morning.
This is yesterdays 2.6.11-rc4 BK + libata BK + libata-dev BK
It was in the middle of a RAID-6 rebuild (scheduled to take about 740 minutes)


Regards,
Brad

Feb 16 07:32:17 storage1 kernel: ata15: command timeout
Feb 16 07:32:17 storage1 kernel: Assertion failed! qc->flags & 
ATA_QCFLAG_ACTIVE,drivers/scsi/libata-core.c,ata_qc_complete,line=2703
Feb 16 07:32:17 storage1 kernel: ata15: status=0x51 { DriveReady SeekComplete Error }
Feb 16 07:32:17 storage1 kernel: ata15: called with no error (51)!
Feb 16 07:32:17 storage1 kernel: ------------[ cut here ]------------
Feb 16 07:32:17 storage1 kernel: kernel BUG at drivers/scsi/scsi.c:299!
Feb 16 07:32:17 storage1 kernel: invalid operand: 0000 [#1]
Feb 16 07:32:17 storage1 kernel: CPU:    0
Feb 16 07:32:17 storage1 kernel: EIP:    0060:[<c0257a0b>]    Not tainted VLI
Feb 16 07:32:17 storage1 kernel: EFLAGS: 00010046   (2.6.11-rc4)
Feb 16 07:32:17 storage1 kernel: EIP is at scsi_put_command+0x8b/0xa0
Feb 16 07:32:17 storage1 kernel: eax: df99cb80   ebx: df99cb80   ecx: df99cb90   edx: df99cb90
Feb 16 07:32:17 storage1 kernel: esi: dfc70000   edi: 00000292   ebp: dfc66400   esp: dfcabe7c
Feb 16 07:32:17 storage1 kernel: ds: 007b   es: 007b   ss: 0068
Feb 16 07:32:17 storage1 kernel: Process scsi_eh_14 (pid: 799, threadinfo=dfcaa000 task=dfc73a20)
Feb 16 07:32:17 storage1 kernel: Stack: dfc7d3c8 dfcc6200 dfc65a28 df99cb80 00000296 dfc65a28 
c025c859 df99cb80
Feb 16 07:32:17 storage1 kernel:        dfc7d3c8 c025c97f df99cb80 00000001 00000000 df99cb80 
df99cb80 00000004
Feb 16 07:32:17 storage1 kernel:        df99cc3c c025ccfe df99cb80 00000001 00000000 00000000 
000057b3 000057b3
Feb 16 07:32:17 storage1 kernel: Call Trace:
Feb 16 07:32:17 storage1 kernel:  [<c025c859>] scsi_next_command+0x19/0x30
Feb 16 07:32:17 storage1 kernel:  [<c025c97f>] scsi_end_request+0xbf/0xe0
Feb 16 07:32:17 storage1 kernel:  [<c025ccfe>] scsi_io_completion+0x1ae/0x490
Feb 16 07:32:17 storage1 kernel:  [<c026927b>] sd_rw_intr+0xcb/0x280
Feb 16 07:32:17 storage1 kernel:  [<c02580ea>] scsi_finish_command+0x7a/0xc0
Feb 16 07:32:17 storage1 kernel:  [<c0266ad9>] ata_scsi_qc_complete+0x39/0x70
Feb 16 07:32:17 storage1 kernel:  [<c026460a>] ata_qc_complete+0x3a/0xc0
Feb 16 07:32:17 storage1 kernel:  [<c0267e30>] pdc_eng_timeout+0x90/0x120
Feb 16 07:32:17 storage1 kernel:  [<c026663a>] ata_scsi_error+0x1a/0x30
Feb 16 07:32:17 storage1 kernel:  [<c025bd4e>] scsi_error_handler+0x9e/0xe0
Feb 16 07:32:17 storage1 kernel:  [<c025bcb0>] scsi_error_handler+0x0/0xe0
Feb 16 07:32:17 storage1 kernel:  [<c0100831>] kernel_thread_helper+0x5/0x14
Feb 16 07:32:17 storage1 kernel: Code: 5c 24 08 8b 74 24 0c 89 44 24 1c 8b 7c 24 10 8b 6c 24 14 83 
c4 18 e9 e5 15 fd ff 89 43 10 89 48 04 31 db 89 51 04 89 4e 0c eb b7 <0f> 0b 2b 01 e7 1a 32 c0 eb 95 
8d 74 26 00 8d bc 27
00 00 00 00
Feb 16 07:32:19 storage1 kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual 
address 00000004
Feb 16 07:32:19 storage1 kernel:  printing eip:
Feb 16 07:32:19 storage1 kernel: c01333c3
Feb 16 07:32:19 storage1 kernel: *pde = 00000000
Feb 16 07:32:19 storage1 kernel: Oops: 0000 [#2]
Feb 16 07:32:19 storage1 kernel: CPU:    0
Feb 16 07:32:19 storage1 kernel: EIP:    0060:[<c01333c3>]    Not tainted VLI
Feb 16 07:32:19 storage1 kernel: EFLAGS: 00010016   (2.6.11-rc4)
Feb 16 07:32:19 storage1 kernel: EIP is at free_block+0x43/0xd0
Feb 16 07:32:19 storage1 kernel: eax: 00800000   ebx: 00000000   ecx: 00000000   edx: c1000000
Feb 16 07:32:19 storage1 kernel: esi: c1506d60   edi: 00000000   ebp: c1506d6c   esp: c14e9ef0
Feb 16 07:32:19 storage1 kernel: ds: 007b   es: 007b   ss: 0068
Feb 16 07:32:19 storage1 kernel: Process events/0 (pid: 3, threadinfo=c14e8000 task=c14da020)
Feb 16 07:32:19 storage1 kernel: Stack: c0132601 00000014 c1506d7c dff08b70 dff08b60 00000001 
c1506d60 c0133a0a
Feb 16 07:32:19 storage1 kernel:        c1506d60 dff08b70 00000001 c1506d60 00000003 c1506dd0 
c1506cfc c0133aaa
Feb 16 07:32:19 storage1 kernel:        c1506d60 dff08b60 00000000 c14da170 00000293 00000000 
c051fca4 c0133a50
Feb 16 07:32:19 storage1 kernel: Call Trace:
Feb 16 07:32:19 storage1 kernel:  [<c0132601>] kmem_freepages+0x81/0xa0
Feb 16 07:32:19 storage1 kernel:  [<c0133a0a>] drain_array_locked+0x7a/0xc0
Feb 16 07:32:19 storage1 kernel:  [<c0133aaa>] cache_reap+0x5a/0x150
Feb 16 07:32:19 storage1 kernel:  [<c0133a50>] cache_reap+0x0/0x150
Feb 16 07:32:19 storage1 kernel:  [<c012326e>] worker_thread+0x19e/0x240
Feb 16 07:32:19 storage1 kernel:  [<c0111b50>] default_wake_function+0x0/0x20
Feb 16 07:32:19 storage1 kernel:  [<c0111b50>] default_wake_function+0x0/0x20
Feb 16 07:32:19 storage1 kernel:  [<c01230d0>] worker_thread+0x0/0x240
Feb 16 07:32:19 storage1 kernel:  [<c0126ae5>] kthread+0xa5/0xb0
Feb 16 07:32:19 storage1 kernel:  [<c0126a40>] kthread+0x0/0xb0
Feb 16 07:32:19 storage1 kernel:  [<c0100831>] kernel_thread_helper+0x5/0x14
Feb 16 07:32:19 storage1 kernel: Code: 83 00 00 00 8d 46 1c 8d 6e 0c 89 44 24 08 8b 44 24 24 8b 15 
b0 fd 51 c0 8b 0c b8 8d 81 00 00 00 40 c1 e8 0c c1 e0 05 8b 5c 02 1c <8b> 53 04 8b 03 89 50 04 89 02 
c7 43 04 00 02 20 00
2b 4b 0c c7

storage1:/home/brad# lspci -vv
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host Bridge (rev 80)
         Subsystem: Asustek Computer, Inc. A7V8X motherboard
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- 
<PERR-
         Latency: 0
         Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
         Capabilities: [80] AGP version 3.5
                 Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3+ 
Rate=x4,x8,x@
                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- 
<PERR-
         Latency: 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         Memory behind bridge: e6000000-e7dfffff
         Prefetchable memory behind bridge: e7f00000-efffffff
         BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:09.0 Ethernet controller: 3Com Corporation 3c940 10/100/1000Base-T [Marvell] (rev 12)
         Subsystem: Asustek Computer, Inc. P4P800 Mainboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 32 (5750ns min, 7750ns max), Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin A routed to IRQ 18
         Region 0: Memory at e5800000 (32-bit, non-prefetchable) [size=16K]
         Region 1: I/O ports at d800 [size=256]
         Capabilities: [48] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
         Capabilities: [50] Vital Product Data

0000:00:0b.0 Unknown mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)
         Subsystem: Promise Technology, Inc. PDC20318 (SATA150 TX4)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 96 (1000ns min, 4500ns max), Cache Line Size: 0x90 (576 bytes)
         Interrupt: pin A routed to IRQ 19
         Region 0: I/O ports at d400 [size=64]
         Region 1: I/O ports at d000 [size=16]
         Region 2: I/O ports at b800 [size=128]
         Region 3: Memory at e5000000 (32-bit, non-prefetchable) [size=4K]
         Region 4: Memory at e4800000 (32-bit, non-prefetchable) [size=128K]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0d.0 Unknown mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)
         Subsystem: Promise Technology, Inc. PDC20318 (SATA150 TX4)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 96 (1000ns min, 4500ns max), Cache Line Size: 0x90 (576 bytes)
         Interrupt: pin A routed to IRQ 16
         Region 0: I/O ports at b400 [size=64]
         Region 1: I/O ports at b000 [size=16]
         Region 2: I/O ports at a800 [size=128]
         Region 3: Memory at e4000000 (32-bit, non-prefetchable) [size=4K]
         Region 4: Memory at e3800000 (32-bit, non-prefetchable) [size=128K]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0e.0 Unknown mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)
         Subsystem: Promise Technology, Inc. PDC20318 (SATA150 TX4)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 32 (1000ns min, 4500ns max), Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin A routed to IRQ 17
         Region 0: I/O ports at a400 [size=64]
         Region 1: I/O ports at a000 [size=16]
         Region 2: I/O ports at 9800 [size=128]
         Region 3: Memory at e3000000 (32-bit, non-prefetchable) [size=4K]
         Region 4: Memory at e2800000 (32-bit, non-prefetchable) [size=128K]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 32
         Interrupt: pin A routed to IRQ 0
         Region 0: I/O ports at 9400 [size=8]
         Region 1: I/O ports at 9000 [size=4]
         Region 2: I/O ports at 8800 [size=8]
         Region 3: I/O ports at 8400 [size=4]
         Region 4: I/O ports at 8000 [size=16]
         Region 5: I/O ports at 7800 [size=256]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus 
Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Interrupt: pin A routed to IRQ 14
         Region 4: I/O ports at 7400 [disabled] [size=16]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) 
(prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 32, Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin A routed to IRQ 0
         Region 4: I/O ports at 7000 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) 
(prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 32, Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin A routed to IRQ 0
         Region 4: I/O ports at 6800 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) 
(prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 32, Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin B routed to IRQ 0
         Region 4: I/O ports at 6400 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) 
(prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 32, Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin B routed to IRQ 0
         Region 4: I/O ports at 6000 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if 20 [EHCI])
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 32, Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin C routed to IRQ 0
         Region 0: Memory at e2000000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 0
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:13.0 Unknown mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)
         Subsystem: Promise Technology, Inc. PDC20318 (SATA150 TX4)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 32 (1000ns min, 4500ns max), Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin A routed to IRQ 18
         Region 0: I/O ports at 5800 [size=64]
         Region 1: I/O ports at 5400 [size=16]
         Region 2: I/O ports at 5000 [size=128]
         Region 3: Memory at e1800000 (32-bit, non-prefetchable) [size=4K]
         Region 4: Memory at e1000000 (32-bit, non-prefetchable) [size=128K]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX 4000 AGP 8x] (rev c1) 
(prog-if 00 [VGA])
         Subsystem: Unknown device 1682:201a
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 64 (1250ns min, 250ns max)
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at e6000000 (32-bit, non-prefetchable) [size=16M]
         Region 1: Memory at e8000000 (32-bit, prefetchable) [size=128M]
         Expansion ROM at e7fe0000 [disabled] [size=128K]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [44] AGP version 3.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ 
Rate=x4,x8
                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_EXTRA_PASS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
CONFIG_X86_PC=y
CONFIG_MK7=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_BLACKLIST_YEAR=0
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_PCI=y
CONFIG_PCI_GOBIOS=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_BINFMT_ELF=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_INITRAMFS_SOURCE=""
CONFIG_LBD=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y
CONFIG_BLK_DEV_SD=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_SATA=y
CONFIG_SCSI_SATA_PROMISE=y
CONFIG_SCSI_QLA2XXX=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_RAID6=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_NETDEVICES=y
CONFIG_SK98LIN=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_LIBPS2=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_RTC=y
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ISA=y
CONFIG_I2C_SENSOR=y
CONFIG_SENSORS_IT87=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_DNOTIFY=y
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_DEVFS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_ROOT_NFS=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_EARLY_PRINTK=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_DES=y
CONFIG_CRC32=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

storage1:/home/brad# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi2 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi3 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi4 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi5 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi6 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi7 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi8 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi9 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi10 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi11 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi12 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi13 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi14 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05

storage1:/home/brad# cat /proc/meminfo
MemTotal:       514824 kB
MemFree:        453212 kB
Buffers:           772 kB
Cached:          27820 kB
SwapCached:          0 kB
Active:          12788 kB
Inactive:        20320 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       514824 kB
LowFree:        453212 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:           9480 kB
Slab:            11148 kB
CommitLimit:    257412 kB
Committed_AS:    12824 kB
PageTables:        424 kB
VmallocTotal:   516024 kB
VmallocUsed:        96 kB
VmallocChunk:   515920 kB
storage1:/home/brad# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Sempron(TM) 2600+
stepping        : 1
cpu MHz         : 0.000
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr 
sse pni syscall mp mmxext 3dnowext 3dnow
bogomips        : 1828.45

storage1:/home/brad# cat /proc/devices
Character devices:
   1 mem
   2 pty
   3 ttyp
   4 /dev/vc/0
   4 tty
   4 ttyS
   5 /dev/tty
   5 /dev/console
   5 /dev/ptmx
   7 vcs
  10 misc
  13 input
  89 i2c
128 ptm
136 pts
254 devfs

Block devices:
   8 sd
   9 md
  65 sd
  66 sd
  67 sd
  68 sd
  69 sd
  70 sd
  71 sd
128 sd
129 sd
130 sd
131 sd
132 sd
133 sd
134 sd
135 sd
254 mdp
storage1:/home/brad# cat /proc/interrupts
            CPU0
   0:     234810    IO-APIC-edge  timer
   1:         74    IO-APIC-edge  i8042
   8:          4    IO-APIC-edge  rtc
   9:          0   IO-APIC-level  acpi
  16:     237783   IO-APIC-level  libata
  17:     234690   IO-APIC-level  libata
  18:     322433   IO-APIC-level  SysKonnect SK-98xx, libata
  19:     214411   IO-APIC-level  libata
NMI:          0
LOC:     235733
ERR:          0
MIS:          0

-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
