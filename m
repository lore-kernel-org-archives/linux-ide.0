From: "Matthew Stoltenberg" <d3matt@gmail.com>
Subject: pata_marvell woes
Date: Sun, 28 Sep 2008 20:27:52 -0500
Message-ID: <3c1bc2140809281827h2154039rec8e65482e54a0f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:22919 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbYI2B1y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Sep 2008 21:27:54 -0400
Received: by yw-out-2324.google.com with SMTP id 9so281961ywe.1
        for <linux-ide@vger.kernel.org>; Sun, 28 Sep 2008 18:27:52 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hey Alan, Jeff, and the linux-ide ML,

I'm having trouble with a Marvell pata controller.  It's on an Asus
P5Q PRO.  It's an intel P45 based board with an added PATA controller.
 The manual (and website) says that the chip a Marvell 88SE6111.

Here's where the fun begins.  I've been playing around with different
distributions lately (I use Fedora at work).  The fedora 9 live cd
won't boot because it can't find the rootfs (on a PATA dvd drive
connected through the Marvell controller).  Gentoo's and Ubuntu's
liveCDs both work, but when I built a gentoo-sources 2.6.25 kernel, it
doesn't see the drive anymore.

I've narrowed it down by building vanilla kernels.  It seems that the
driver stopped working sometime in the 2.6.25 series (and is still
broken in 2.6.26), but it does work in the 2.6.24 series.  See below
for dumps from lspci.

I'm not sure to begin to debug this problem, but it looks like there
might be a bug in the ahci driver since lspci shows that ahci has it
in use.

Here's what lspci reports in the working 2.6.24.7:
03:00.0 IDE interface: Marvell Technology Group Ltd. Device 6121 (rev
b2) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: ASUSTeK Computer Inc. Device 82e0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at ec00 [size=8]
        Region 1: I/O ports at e880 [size=4]
        Region 2: I/O ports at e800 [size=8]
        Region 3: I/O ports at e480 [size=4]
        Region 4: I/O ports at e400 [size=16]
        Region 5: Memory at feaffc00 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0+,D1+,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Message Signalled Interrupts: Mask- 64bit-
Queue=0/0 Enable-
                Address: 00000000  Data: 0000
        Capabilities: [e0] Express (v1) Legacy Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq+
AuxPwr- TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s,
Latency L0 <256ns, L1 unlimited
                        ClockPM- Suprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
SlotClk+ DLActive- BWMgmt- ABWMgmt-
        Kernel driver in use: pata_marvell
        Kernel modules: pata_marvell


Here's what lspci reports in the not-working 2.6.26.5
03:00.0 IDE interface: Marvell Technology Group Ltd. Device 6121 (rev
b2) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: ASUSTeK Computer Inc. Device 82e0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at ec00 [size=8]
        Region 1: I/O ports at e880 [size=4]
        Region 2: I/O ports at e800 [size=8]
        Region 3: I/O ports at e480 [size=4]
        Region 4: I/O ports at e400 [size=16]
        Region 5: Memory at feaffc00 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0+,D1+,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Message Signalled Interrupts: Mask- 64bit-
Queue=0/0 Enable-
                Address: 00000000  Data: 0000
        Capabilities: [e0] Express (v1) Legacy Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq+
AuxPwr- TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s,
Latency L0 <256ns, L1 unlimited
                        ClockPM- Suprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
SlotClk+ DLActive- BWMgmt- ABWMgmt-
        Capabilities: [100] Advanced Error Reporting <?>
        Kernel driver in use: ahci
        Kernel modules: ide-pci-generic, pata_marvell
