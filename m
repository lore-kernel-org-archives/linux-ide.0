From: "KueiHuan Chen" <khchen@synology.com>
Subject: Re: SATA port multiplier(Marvell 6121 with ahci) and Marvell 4140, simg 3726
Date: Tue, 5 Aug 2008 16:54:04 +0800
Message-ID: <788014650808050154r7f41cb05t5d883ee043497ba5@mail.gmail.com>
References: <788014650807302022j30cea641wcfe4105ac8702b8c@mail.gmail.com>
	 <48918D52.3010404@gmail.com> <48918DD9.9050603@kernel.org>
	 <788014650807310612x70347f8dt56ed650dc6b8c5ca@mail.gmail.com>
	 <48926F7E.1020807@kernel.org> <48930B2E.9060604@pobox.com>
	 <489336E0.7020409@kernel.org>
	 <788014650808021053y5b5a8e01y62099464cc96d8a4@mail.gmail.com>
	 <48953D42.1010408@kernel.org>
Reply-To: khchen@synology.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:26441 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758598AbYHEIyF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Aug 2008 04:54:05 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2502758rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 05 Aug 2008 01:54:04 -0700 (PDT)
In-Reply-To: <48953D42.1010408@kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: jgarzik@pobox.com, Mark Lord <mlord@pobox.com>, linux-ide@vger.kernel.org

Hi,

  Sorry for delay responding, here is my x86_64 with 2.6.26 dmesg and
lspci.  ^__^

Thanks.

Dmesg: hotplug-in 3726 into 6145 , and the unplug, finally plug again
ata9: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
ata9: irq_stat 0x02400000, PHY RDY changed
ata9: hard resetting link
ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata9.15: qc timeout (cmd 0xe4)
ata9.15: failed to read PMP GSCR[0] (Emask=0x4)
ata9: failed to recover some devices, retrying in 5 secs
ata9: hard resetting link
ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata9.15: qc timeout (cmd 0xe4)
ata9.15: failed to read PMP GSCR[0] (Emask=0x4)
ata9: failed to recover some devices, retrying in 5 secs
ata9: hard resetting link
ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata9.15: qc timeout (cmd 0xe4)
ata9.15: failed to read PMP GSCR[0] (Emask=0x4)
ata9: failed to recover some devices, retrying in 5 secs
ata9: hard resetting link
ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata9: EH complete
ata9: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
ata9: irq_stat 0x00400000, PHY RDY changed
ata9: hard resetting link
ata9: SATA link down (SStatus 0 SControl 300)
ata9: EH complete
ata10: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
ata10: irq_stat 0x02400000, PHY RDY changed
ata10: hard resetting link
ata10: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.15: qc timeout (cmd 0xe4)
ata10.15: failed to read PMP GSCR[0] (Emask=0x4)
ata10: failed to recover some devices, retrying in 5 secs
ata10: hard resetting link
ata10: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.15: qc timeout (cmd 0xe4)
ata10.15: failed to read PMP GSCR[0] (Emask=0x4)
ata10: failed to recover some devices, retrying in 5 secs
ata10: hard resetting link
ata10: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.15: qc timeout (cmd 0xe4)
ata10.15: failed to read PMP GSCR[0] (Emask=0x4)
ata10: failed to recover some devices, retrying in 5 secs
ata10: hard resetting link
ata10: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10: EH complete


lspci -nnvvv
00:00.0 Host bridge [0600]: Intel Corporation 82P965/G965 Memory
Controller Hub [8086:29a0] (rev 02)
        Subsystem: Giga-byte Technology Unknown device [1458:5000]
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Capabilities: [e0] Vendor Specific Information

00:02.0 VGA compatible controller [0300]: Intel Corporation 82G965
Integrated Graphics Controller [8086:29a2] (rev 02) (prog-if 00 [VGA])
        Subsystem: Giga-byte Technology Unknown device [1458:d000]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at f4000000 (32-bit, non-prefetchable) [size=1M]
        Region 2: Memory at e0000000 (64-bit, prefetchable) [size=256M]
        Region 4: I/O ports at b000 [size=8]
        Capabilities: [90] Message Signalled Interrupts: Mask- 64bit-
Queue=0/0 Enable-
                Address: 00000000  Data: 0000
        Capabilities: [d0] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1a.0 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family)
USB UHCI Contoller #4 [8086:2834] (rev 02) (prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology Unknown device [1458:5004]
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 4: I/O ports at b400 [size=32]

00:1a.1 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family)
USB UHCI Controller #5 [8086:2835] (rev 02) (prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology Unknown device [1458:5004]
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 21
        Region 4: I/O ports at b800 [size=32]

00:1a.7 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family)
USB2 EHCI Controller #2 [8086:283a] (rev 02) (prog-if 20 [EHCI])
        Subsystem: Giga-byte Technology Unknown device [1458:5006]
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 18
        Region 0: Memory at f4305000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1b.0 Audio device [0403]: Intel Corporation 82801H (ICH8 Family) HD
Audio Controller [8086:284b] (rev 02)
        Subsystem: Giga-byte Technology Unknown device [1458:a002]
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 22
        Region 0: Memory at f4300000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] Express Unknown type IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
                Device: Latency L0s <64ns, L1 <1us
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed unknown, Width x0, ASPM unknown, Port 0
                Link: Latency L0s <64ns, L1 <1us
                Link: ASPM Disabled CommClk- ExtSynch-
                Link: Speed unknown, Width x0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)

00:1c.0 PCI bridge [0604]: Intel Corporation 82801H (ICH8 Family) PCI
Express Port 1 [8086:283f] (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 32 bytes
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00006000-00007fff
        Memory behind bridge: f0000000-f1ffffff
        Prefetchable memory behind bridge: 0000000040000000-00000000400fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
                Device: Latency L0s unlimited, L1 unlimited
                Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 1
                Link: Latency L0s <256ns, L1 <4us
                Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
                Link: Speed 2.5Gb/s, Width x1
                Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
                Slot: Number 16, PowerLimit 10.000000
                Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
                Slot: AttnInd Unknown, PwrInd Unknown, Power-
                Root: Correctable- Non-Fatal- Fatal- PME-
        Capabilities: [80] Message Signalled Interrupts: Mask- 64bit-
Queue=0/0 Enable-
                Address: fee0300c  Data: 4161
        Capabilities: [90] Subsystem: Giga-byte Technology Unknown
device [1458:5001]
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [100] Virtual Channel
        Capabilities: [180] Unknown (5)

00:1c.1 PCI bridge [0604]: Intel Corporation 82801H (ICH8 Family) PCI
Express Port 2 [8086:2841] (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 32 bytes
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 00008000-00008fff
        Memory behind bridge: f2000000-f3ffffff
        Prefetchable memory behind bridge: 0000000040100000-00000000401fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
                Device: Latency L0s unlimited, L1 unlimited
                Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 2
                Link: Latency L0s <256ns, L1 <4us
                Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
                Link: Speed 2.5Gb/s, Width x1
                Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
                Slot: Number 17, PowerLimit 10.000000
                Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
                Slot: AttnInd Unknown, PwrInd Unknown, Power-
                Root: Correctable- Non-Fatal- Fatal- PME-
        Capabilities: [80] Message Signalled Interrupts: Mask- 64bit-
Queue=0/0 Enable-
                Address: fee0300c  Data: 4169
        Capabilities: [90] Subsystem: Giga-byte Technology Unknown
device [1458:5001]
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [100] Virtual Channel
        Capabilities: [180] Unknown (5)

00:1c.2 PCI bridge [0604]: Intel Corporation 82801H (ICH8 Family) PCI
Express Port 3 [8086:2843] (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 32 bytes
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
        I/O behind bridge: 00009000-0000afff
        Memory behind bridge: f4100000-f41fffff
        Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
                Device: Latency L0s unlimited, L1 unlimited
                Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 3
                Link: Latency L0s <256ns, L1 <4us
                Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
                Link: Speed 2.5Gb/s, Width x1
                Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
                Slot: Number 18, PowerLimit 10.000000
                Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
                Slot: AttnInd Unknown, PwrInd Unknown, Power-
                Root: Correctable- Non-Fatal- Fatal- PME-
        Capabilities: [80] Message Signalled Interrupts: Mask- 64bit-
Queue=0/0 Enable-
                Address: fee0300c  Data: 4171
        Capabilities: [90] Subsystem: Giga-byte Technology Unknown
device [1458:5001]
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [100] Virtual Channel
        Capabilities: [180] Unknown (5)

00:1d.0 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family)
USB UHCI Controller #1 [8086:2830] (rev 02) (prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology Unknown device [1458:5004]
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 23
        Region 4: I/O ports at bc00 [size=32]

00:1d.1 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family)
USB UHCI Controller #2 [8086:2831] (rev 02) (prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology Unknown device [1458:5004]
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 4: I/O ports at c000 [size=32]

00:1d.2 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family)
USB UHCI Controller #3 [8086:2832] (rev 02) (prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology Unknown device [1458:5004]
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 18
        Region 4: I/O ports at c400 [size=32]

00:1d.7 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family)
USB2 EHCI Controller #1 [8086:2836] (rev 02) (prog-if 20 [EHCI])
        Subsystem: Giga-byte Technology Unknown device [1458:5006]
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 23
        Region 0: Memory at f4304000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge [0604]: Intel Corporation 82801 PCI Bridge
[8086:244e] (rev f2) (prog-if 01 [Subtractive decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: f4200000-f42fffff
        Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [50] Subsystem: Giga-byte Technology Unknown
device [1458:5000]

00:1f.0 ISA bridge [0601]: Intel Corporation 82801HB/HR (ICH8/R) LPC
Interface Controller [8086:2810] (rev 02)
        Subsystem: Giga-byte Technology Unknown device [1458:5001]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [e0] Vendor Specific Information

00:1f.2 IDE interface [0101]: Intel Corporation 82801H (ICH8 Family) 4
port SATA IDE Controller [8086:2820] (rev 02) (prog-if 8a [Master SecP
PriP])
        Subsystem: Giga-byte Technology Unknown device [1458:b002]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 0: I/O ports at 01f0 [size=8]
        Region 1: I/O ports at 03f4 [size=1]
        Region 2: I/O ports at 0170 [size=8]
        Region 3: I/O ports at 0374 [size=1]
        Region 4: I/O ports at f000 [size=16]
        Region 5: I/O ports at fc00 [size=16]
        Capabilities: [70] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1f.3 SMBus [0c05]: Intel Corporation 82801H (ICH8 Family) SMBus
Controller [8086:283e] (rev 02)
        Subsystem: Giga-byte Technology Unknown device [1458:5001]
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 18
        Region 0: Memory at f4306000 (32-bit, non-prefetchable) [size=256]
        Region 4: I/O ports at 0500 [size=32]

00:1f.5 IDE interface [0101]: Intel Corporation 82801H (ICH8 Family) 2
port SATA IDE Controller [8086:2825] (rev 02) (prog-if 85 [Master SecO
PriO])
        Subsystem: Giga-byte Technology Unknown device [1458:b002]
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 0: I/O ports at cc00 [size=8]
        Region 1: I/O ports at d000 [size=4]
        Region 2: I/O ports at d400 [size=8]
        Region 3: I/O ports at d800 [size=4]
        Region 4: I/O ports at dc00 [size=16]
        Region 5: I/O ports at e000 [size=16]
        Capabilities: [70] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 RAID bus controller [0104]: Marvell Technology Group Ltd.
Unknown device [11ab:6145] (rev a1) (prog-if 8f)
        Subsystem: Marvell Technology Group Ltd. Unknown device [11ab:6145]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (2000ns min), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at 6000 [size=8]
        Region 1: I/O ports at 6400 [size=4]
        Region 2: I/O ports at 6800 [size=8]
        Region 3: I/O ports at 6c00 [size=4]
        Region 4: I/O ports at 7000 [size=16]
        Region 5: Memory at f1000000 (32-bit, non-prefetchable) [size=1K]
        [virtual] Expansion ROM at 40000000 [disabled] [size=256K]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0+,D1+,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Message Signalled Interrupts: Mask- 64bit-
Queue=0/0 Enable-
                Address: 00000000  Data: 0000
        Capabilities: [e0] Express Legacy Endpoint IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
                Device: Latency L0s unlimited, L1 unlimited
                Device: AtnBtn- AtnInd- PwrInd-
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop-
                Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
                Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 0
                Link: Latency L0s <256ns, L1 unlimited
                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x1
        Capabilities: [100] Advanced Error Reporting

02:00.0 Ethernet controller [0200]: Marvell Technology Group Ltd.
88E8056 PCI-E Gigabit Ethernet Controller [11ab:4364] (rev 13)
        Subsystem: Giga-byte Technology Unknown device [1458:e000]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 2300
        Region 0: Memory at f3000000 (64-bit, non-prefetchable) [size=16K]
        Region 2: I/O ports at 8000 [size=256]
        [virtual] Expansion ROM at 40100000 [disabled] [size=128K]
        Capabilities: [48] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [5c] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable+
                Address: 00000000fee0200c  Data: 4191
        Capabilities: [e0] Express Legacy Endpoint IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
                Device: Latency L0s unlimited, L1 unlimited
                Device: AtnBtn- AtnInd- PwrInd-
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
                Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 0
                Link: Latency L0s <256ns, L1 unlimited
                Link: ASPM Disabled RCB 128 bytes CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x1
        Capabilities: [100] Advanced Error Reporting

03:00.0 SATA controller [0106]: JMicron Technologies, Inc. JMicron
20360/20363 AHCI Controller [197b:2363] (rev 02) (prog-if 01 [AHCI
1.0])
        Subsystem: Giga-byte Technology Unknown device [1458:b000]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 18
        Region 5: Memory at f4100000 (32-bit, non-prefetchable) [size=8K]
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] Express Legacy Endpoint IRQ 1
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
                Device: Latency L0s <64ns, L1 <1us
                Device: AtnBtn- AtnInd- PwrInd-
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
                Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 1
                Link: Latency L0s unlimited, L1 unlimited
                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x1

03:00.1 IDE interface [0101]: JMicron Technologies, Inc. JMicron
20360/20363 AHCI Controller [197b:2363] (rev 02) (prog-if 85 [Master
SecO PriO])
        Subsystem: Giga-byte Technology Unknown device [1458:b000]
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 0: I/O ports at 9000 [size=8]
        Region 1: I/O ports at 9400 [size=4]
        Region 2: I/O ports at 9800 [size=8]
        Region 3: I/O ports at 9c00 [size=4]
        Region 4: I/O ports at a000 [size=16]
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

04:07.0 FireWire (IEEE 1394) [0c00]: Texas Instruments TSB43AB23
IEEE-1394a-2000 Controller (PHY/Link) [104c:8024] (prog-if 10 [OHCI])
        Subsystem: Giga-byte Technology Unknown device [1458:1000]
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 1000ns max), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 23
        Region 0: Memory at f4204000 (32-bit, non-prefetchable) [size=2K]
        Region 1: Memory at f4200000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

2008/8/3 Tejun Heo <tj@kernel.org>:
> KueiHuan Chen wrote:
>> 2008/8/2 Tejun Heo <tj@kernel.org>:
>>> Mark Lord wrote:
>>>> I have exactly zero documentation on those chips,
>>>> but they are supposedly AHCI compliant.
>>>>
>>>> Looking in drivers/ata/ahci.c, one can see that the chips are indeed
>>>> supported,
>>>> and there the AHCI_HFLAG_NO_PMP is *not* set, so one might expect them
>>>> to work
>>>> with a port-multiplier already.  ?
>>> I bet it's more like nobody tried yet.  :-P
>>
>>
>>  Thanks for your explaining, i had tried it already.
>>
>>  Port multiplier of Silicon image 3726 is not supported from 2.6.24 to
>> 2.6.26 with 6121 and 6145 which using ahci.c  : (
>>
>>  Here is the test envirement:
>>
>>   Port Multipiler : Silicon image 3726. (Marvell 4140 is not fully
>> tested, so i don't listed, but it is the same in arm arch.)
>>
>>  arch/kernel   2.6.24        2.6.25       2.6.26
>>
>>   arm            Not Work   Not tested   Not tested
>>
>>   powerpc     Not Work   Not tested   Not tested
>>
>>   x86_64       Not Work   Not Work     Not Work
>>
>>
>>  Should we need disable 6121/6145 pmp support in ahci.c until it is
>> fully supported?
>
> I'd like to find out why it's failing before disabling it.  Can you
> please post the failing log from 2.6.26?
>
> --
> tejun
>



-- 
---
Thanks,
KueiHuan-Chen
