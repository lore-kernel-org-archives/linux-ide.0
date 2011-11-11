From: Romain DEGEZ <romain.degez@smartjog.com>
Subject: Support for Promise FastTrack TX8660 SAS HBA via AHCI
Date: Fri, 11 Nov 2011 16:43:20 +0100
Message-ID: <4EBD4298.6080604@smartjog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:44458 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753540Ab1KKPnb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 Nov 2011 10:43:31 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hi Jeff,

(Contacting you because you seem to be the maintainer of drivers/ata/ahci.c )

I recently bought a Promise FastTrack TX8660 (8xSAS PCIe-x4 SAS HBA).

The board can be switched either in RAID or in pure SAS JBOD mode by entering 
into the firmware menu at boot time.

I don't care about the RAID mode (I am using software raid) but sadly even the 
direct SAS mode is not working out of the box using a vanilla kernel.

I did a few googling and found this : 
http://ubuntuforums.org/showpost.php?p=10379020&postcount=29

Basically a guy saying that adding { PCI_VDEVICE(PROMISE, 0x3781), board_ahci } 
in the ahci_pci_tbl[] in drivers/ata/ahci.c do the trick with this board.

I gave it a try and ... it just works.

Here is an lspci output of the card
04:00.0 RAID bus controller: Promise Technology, Inc. Device 3781
         Subsystem: Promise Technology, Inc. Device 3781
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 32 bytes
         Interrupt: pin A routed to IRQ 16
         Region 0: I/O ports at ac00 [size=128]
         Region 2: I/O ports at a800 [size=256]
         Region 3: Memory at efaff000 (32-bit, non-prefetchable) [size=4K]
         Region 4: Memory at efac0000 (32-bit, non-prefetchable) [size=128K]
         Region 5: Memory at efafc000 (32-bit, non-prefetchable) [size=8K]
         Expansion ROM at efa80000 [disabled] [size=256K]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [70] Express (v1) Legacy Endpoint, MSI 00
                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, 
L1 <1us
                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                         MaxPayload 128 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
                 LnkCap: Port #0, Speed 2.5GT/s, Width x4, ASPM L0s L1, Latency 
L0 <128ns, L1 <2us
                         ClockPM- Surprise- LLActRep- BwNot-
                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk- 
DLActive- BWMgmt- ABWMgmt-
         Capabilities: [94] SATA HBA v1.0 BAR2 Offset=00000024
         Capabilities: [100 v1] Advanced Error Reporting
                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                 AERCap: First Error Pointer: 14, GenCap- CGenEn- ChkCap- ChkEn-
         Capabilities: [140 v1] Virtual Channel
                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                 Arb:    Fixed- WRR32- WRR64- WRR128-
                 Ctrl:   ArbSelect=Fixed
                 Status: InProgress-
                 VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                         Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                         Status: NegoPending- InProgress-
         Capabilities: [160 v1] Device Serial Number 00-00-00-02-00-00-00-01
         Capabilities: [170 v1] Power Budgeting <?>
         Kernel driver in use: ahci


Would it be possible to patch have this single line ?

Thanks,

-- 
RD
