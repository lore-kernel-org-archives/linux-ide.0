From: Christian Brandt <brandtc@psi5.com>
Subject: Re: Highpoint DC7280
Date: Wed, 27 Jun 2012 18:27:09 +0200
Message-ID: <4FEB345D.2070708@psi5.com>
References: <4FDEDE3A.7030507@psi5.com> <4FDFF1C1.4060808@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010609050802010503080904"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:59014 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330Ab2F0Q1M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Jun 2012 12:27:12 -0400
In-Reply-To: <4FDFF1C1.4060808@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------010609050802010503080904
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Sorry for the delay, I was sick for a couple of days.

Am 19.06.2012 05:28, schrieb Robert Hancock:
> What does lspci -vv show for that board?

 Please see MIME attachment dc7280lspci-initialized.txt (for
completeness, uninitialized the IRQ is 64 and MaxPayload is 128 bytes).

> It looks like that driver contains a binary blob so who knows what it is
> actually doing internally.

 I am now done playing with ubuntu 12.04 and are going to dig a bit
deeper in using debian and a vanilla kernel.

-- 
Christian Brandt

 life is short and in most cases it ends with death
 but my tombstone will carry the hiscore


--------------010609050802010503080904
Content-Type: text/plain; charset=windows-1252;
 name="dc7280lspci-initialized.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dc7280lspci-initialized.txt"

84:00.0 RAID bus controller: HighPoint Technologies, Inc. Device 7280 (rev 03)
        Subsystem: HighPoint Technologies, Inc. Device 0000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 64
        Region 0: Memory at fbe40000 (64-bit, non-prefetchable) [size=128K]
        Region 2: Memory at fbe00000 (64-bit, non-prefetchable) [size=256K]
        Expansion ROM at fbe60000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA PME(D0+,D1+,D2-,D3hot+,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 4096 bytes, PhantFunc 0, Latency L0s <1us, L1 <8us
                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
                LnkCap: Port #0, Speed 5GT/s, Width x8, ASPM unknown, Latency L0 <512ns, L1 <64us
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis+
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
        Capabilities: [140 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
                        Status: NegoPending- InProgress-
        Kernel modules: dc7280


--------------010609050802010503080904--
