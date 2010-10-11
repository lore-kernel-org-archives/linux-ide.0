From: Jeremy Sanders <jeremy@jeremysanders.net>
Subject: Sil 3124: "softreset failed (SRST command error)"
Date: Mon, 11 Oct 2010 16:44:15 +0100
Message-ID: <i8vbcg$4hc$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:45221 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754314Ab0JKPuH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Oct 2010 11:50:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-ide@m.gmane.org>)
	id 1P5KdZ-0002jM-2w
	for linux-ide@vger.kernel.org; Mon, 11 Oct 2010 17:50:05 +0200
Received: from xpc1.ast.cam.ac.uk ([131.111.68.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 11 Oct 2010 17:50:05 +0200
Received: from jeremy by xpc1.ast.cam.ac.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 11 Oct 2010 17:50:05 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi - I'm having problems getting a Sil 3124 card with a PCI-Express 1x
interface to work, see https://bugzilla.redhat.com/show_bug.cgi?id=641878
Here is the card:
 http://www.era-adapter.com/pciexpress-1x-to-4-ports-sata-ii-adapter-p-60.html

I hope this is an appropriate place to report this. I've tried both
the Fedora 12 (2.6.32.21) and Fedora 14 beta install kernel (2.6.35),
running x86-64.

I just get timeouts when booting with two drives attached:

Oct 11 12:47:29 xpc12 kernel: scsi7 : sata_sil24
Oct 11 12:47:29 xpc12 kernel: scsi6 : pata_jmicron
Oct 11 12:47:29 xpc12 kernel: scsi8 : sata_sil24
Oct 11 12:47:29 xpc12 kernel: scsi9 : sata_sil24
Oct 11 12:47:29 xpc12 kernel: scsi11 : sata_sil24
Oct 11 12:47:29 xpc12 kernel: ata9: SATA max UDMA/100 host m128@0xe2388000 port 0xe2380000 irq 18
Oct 11 12:47:29 xpc12 kernel: ata10: SATA max UDMA/100 host m128@0xe2388000 port 0xe2382000 irq 18
Oct 11 12:47:29 xpc12 kernel: ata11: SATA max UDMA/100 host m128@0xe2388000 port 0xe2384000 irq 18
Oct 11 12:47:29 xpc12 kernel: ata12: SATA max UDMA/100 host m128@0xe2388000 port 0xe2386000 irq 18
Oct 11 12:47:29 xpc12 kernel: scsi10 : pata_jmicron
Oct 11 12:47:29 xpc12 kernel: ata7: PATA max UDMA/100 cmd 0xd040 ctl 0xd030 bmdma 0xd000 irq 19
Oct 11 12:47:29 xpc12 kernel: ata8: PATA max UDMA/100 cmd 0xd020 ctl 0xd010 bmdma 0xd008 irq 19
Oct 11 12:47:29 xpc12 kernel: ata7.00: ATAPI: TSSTcorpCD/DVDW SH-S162A, TS01, max UDMA/33
Oct 11 12:47:29 xpc12 kernel: ata7.00: configured for UDMA/33
Oct 11 12:47:29 xpc12 kernel: ata9: SATA link down (SStatus 0 SControl 0)
Oct 11 12:47:29 xpc12 kernel: ata10: SATA link down (SStatus 0 SControl 0)
Oct 11 12:47:29 xpc12 kernel: ata11: softreset failed (SRST command error)
Oct 11 12:47:29 xpc12 kernel: ata11: reset failed (errno=-5), retrying in 8 secs
Oct 11 12:47:29 xpc12 kernel: ata11: softreset failed (SRST command error)
Oct 11 12:47:29 xpc12 kernel: ata11: reset failed (errno=-5), retrying in 8 secs
Oct 11 12:47:29 xpc12 kernel: ata11: softreset failed (SRST command error)
Oct 11 12:47:29 xpc12 kernel: ata11: reset failed (errno=-5), retrying in 33 secs
Oct 11 12:47:29 xpc12 kernel: ata11: limiting SATA link speed to 1.5 Gbps
Oct 11 12:47:29 xpc12 kernel: ata11: softreset failed (SRST command error)
Oct 11 12:47:29 xpc12 kernel: ata11: reset failed, giving up
Oct 11 12:47:29 xpc12 kernel: ata12: softreset failed (SRST command error)
Oct 11 12:47:29 xpc12 kernel: ata12: reset failed (errno=-5), retrying in 8 secs
Oct 11 12:47:29 xpc12 kernel: ata12: softreset failed (SRST command error)
Oct 11 12:47:29 xpc12 kernel: ata12: reset failed (errno=-5), retrying in 8 secs
Oct 11 12:47:29 xpc12 kernel: ata12: softreset failed (SRST command error)
Oct 11 12:47:29 xpc12 kernel: ata12: reset failed (errno=-5), retrying in 33 secs
Oct 11 12:47:29 xpc12 kernel: ata12: limiting SATA link speed to 1.5 Gbps
Oct 11 12:47:29 xpc12 kernel: ata12: softreset failed (SRST command error)
Oct 11 12:47:29 xpc12 kernel: ata12: reset failed, giving up

This is what lspci reports for the card and its PCIex to PCI-X bridge:
03:00.0 PCI bridge: PLX Technology, Inc. PEX8112 x1 Lane PCI Express-to-PCI Bridge (rev aa) (prog-if 00 [Normal decode])
        Physical Slot: 0-1
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=03, secondary=04, subordinate=04, sec-latency=32
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: e2300000-e23fffff
        Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0+,D1+,D2-,D3hot+,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [60] Express (v1) PCI/PCI-X Bridge, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- BrConfRtry-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, L1 <16us
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
        Capabilities: [100 v1] Power Budgeting <?>
        Kernel modules: shpchp

04:00.0 RAID bus controller: Silicon Image, Inc. SiI 3124 PCI-X Serial ATA Controller (rev 01)
        Subsystem: Silicon Image, Inc. Device 7124
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
        Latency: 32, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at e2388000 (64-bit, non-prefetchable) [size=128]
        Region 2: Memory at e2380000 (64-bit, non-prefetchable) [size=32K]
        Region 4: I/O ports at e000 [size=16]
        Expansion ROM at e2300000 [disabled] [size=512K]
        Capabilities: [64] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [40] PCI-X non-bridge device
                Command: DPERE- ERO+ RBC=512 OST=12
                Status: Dev=ff:1f.0 64bit+ 133MHz+ SCD- USC- DC=simple DMMRBC=2048 DMOST=12 DMCRS=128 RSCEM- 266MHz- 
533MHz-
        Capabilities: [54] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Kernel driver in use: sata_sil24
        Kernel modules: sata_sil24

The motherboard is an Intel DP43TF with Intel Q9650 CPU. I haven't configured
any RAID on the device.

Any ideas?

Thanks

Jeremy



