From: =?ISO-8859-1?Q?=D6rjan_Nordlund?= <orjan@laxfiske.se>
Subject: Nvidia ION (MCP79) eSata fails for external cabinet Thecus N2050 (SIL5744)
Date: Wed, 7 Oct 2009 17:23:19 +0200
Message-ID: <A5D2B277-9D37-49FC-A5C2-30E8707C26B2@laxfiske.se>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailrelay2.bredband.net ([195.54.107.70]:52377 "EHLO
	mailrelay2.bredband.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755702AbZJGP7O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Oct 2009 11:59:14 -0400
Received: from mailrelay1.bredband.net (mailrelay1.bredband.net [195.54.107.83])
	by mailrelay2.bredband.net (Postfix) with ESMTP id 641221120AC
	for <linux-ide@vger.kernel.org>; Wed,  7 Oct 2009 17:25:18 +0200 (CEST)
Received: from [192.168.2.21] (c-6266e555.1412-13-64736c16.cust.bredbandsbolaget.se [85.229.102.98])
	by mailrelay1.bredband.net (Postfix) with ESMTP id 8124C18A88B
	for <linux-ide@vger.kernel.org>; Wed,  7 Oct 2009 17:22:02 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi !

I am having an issue using eSata to connect my Thecus N2050 storage =20
cabinet to my new homeserver running Ubuntu Server 9.04.
dmesg shows "failed to IDENTIFY (I/O error, err_mask=3D0x100)"

I have read forums and mailing lists to understand solutions to =20
similar problems and the following steps have been taken:
Upgraded to Vanilla kernel 2.6.31
Changed BIOS settings from SATA->AHCI and then back again
Tried boot with pci=3Dnomsi
Changed cables (i have three cables now and no one works)
Checked that no jumpers can be changed on disks or mainboard
Checked that the disks can be read through USB interface and from =20
other computers (works on Linux, OS X and Win XP)
Checked disks through eSata on Win XP box
Upgraded BIOS to latest release (August 2009)

I have looked in all forums and LKML archives for a solution but can =20
not really find anyone that has a similar problem.

I am suspecting the quirks are in the Thecus N2050. I have had some =20
problems with this device in linux before when i was using USB. =20
Thanks to Alan Stern a patch (as1154) was introduced in October 2008 =20
to help get the device recognized properly by scsi when probing it.

My Nvidia ION board has a MCP79 controller on-board (should be OK =20
from 2.6.24) and the Thecus has a Silicon Image controller (i opened =20
the box and read on the chip) with markings:
SIL5744CNU
WE8799.00-19
0710
AG01CX2

I do not know what to do next and i appreciate any and all help i can =20
get that could point me in the right direction.

Kind regards,
=D6rjan Nordlund
orjan@laxfiske.se

Attached are dmesg (hotplug of device), /proc/interrupts, lspci, =20
lspci -vv, dmesg (from boot)

dmesg (extract from hotplug of device):
[  753.849929] ata3: exception Emask 0x10 SAct 0x0 SErr 0x1810000 =20
action 0xe frozen
[  753.849970] ata3: irq_stat 0x00400000, PHY RDY changed
[  753.849994] ata3: SError: { PHYRdyChg LinkSeq TrStaTrns }
[  753.850024] ata3: hard resetting link
[  754.598415] ata3: SATA link down (SStatus 10 SControl 300)
[  754.598430] ata3: EH complete
[  758.663954] ata3: exception Emask 0x10 SAct 0x0 SErr 0x4140000 =20
action 0xe frozen
[  758.663993] ata3: irq_stat 0x00000040, connection status changed
[  758.664018] ata3: SError: { CommWake Dispar DevExch }
[  758.664046] ata3: hard resetting link
[  759.588208] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  759.588245] ata3.00: failed to IDENTIFY (I/O error, err_mask=3D0x100=
)
[  764.587996] ata3: hard resetting link
[  765.117974] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  765.118016] ata3.00: failed to IDENTIFY (I/O error, err_mask=3D0x100=
)
[  765.118023] ata3: limiting SATA link speed to 1.5 Gbps
[  770.117755] ata3: hard resetting link
[  770.647737] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  770.647783] ata3.00: failed to IDENTIFY (I/O error, err_mask=3D0x100=
)
[  775.647507] ata3: hard resetting link
[  776.177483] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  776.177507] ata3: exception Emask 0x10 SAct 0x0 SErr 0x0 action =20
0x1 t4
[  776.177536] ata3: irq_stat 0x08000000, interface fatal error
[  776.177564] ata3: EH complete

cat /proc/interrupts:
            CPU0
   0:         31    XT-PIC-XT        timer
   1:          4    XT-PIC-XT        i8042
   2:          0    XT-PIC-XT        cascade
   7:          1    XT-PIC-XT
   8:          0    XT-PIC-XT        rtc0
   9:          0    XT-PIC-XT        ehci_hcd:usb2
  10:       2449    XT-PIC-XT        ehci_hcd:usb1, eth0
  11:          0    XT-PIC-XT        ohci_hcd:usb4
  12:          6    XT-PIC-XT        i8042
  15:        149    XT-PIC-XT        ohci_hcd:usb3, HDA Intel
  29:       4132   PCI-MSI-edge      ahci
NMI:          0   Non-maskable interrupts
LOC:      84954   Local timer interrupts
SPU:          0   Spurious interrupts
CNT:          0   Performance counter interrupts
PND:          0   Performance pending work
RES:          0   Rescheduling interrupts
CAL:          0   Function call interrupts
TLB:          0   TLB shootdowns
ERR:          1
MIS:          0



lspci:
00:00.0 Host bridge: nVidia Corporation MCP79 Host Bridge (rev b1)
00:00.1 RAM memory: nVidia Corporation MCP79 Memory Controller (rev b1)
00:03.0 ISA bridge: nVidia Corporation MCP79 LPC Bridge (rev b2)
00:03.1 RAM memory: nVidia Corporation MCP79 Memory Controller (rev b1)
00:03.2 SMBus: nVidia Corporation MCP79 SMBus (rev b1)
00:03.3 RAM memory: nVidia Corporation MCP79 Memory Controller (rev b1)
00:03.5 Co-processor: nVidia Corporation MCP79 Co-processor (rev b1)
00:04.0 USB Controller: nVidia Corporation MCP79 OHCI USB 1.1 =20
Controller (rev b1)
00:04.1 USB Controller: nVidia Corporation MCP79 EHCI USB 2.0 =20
Controller (rev b1)
00:06.0 USB Controller: nVidia Corporation MCP79 OHCI USB 1.1 =20
Controller (rev b1)
00:06.1 USB Controller: nVidia Corporation MCP79 EHCI USB 2.0 =20
Controller (rev b1)
00:08.0 Audio device: nVidia Corporation MCP79 High Definition Audio =20
(rev b1)
00:09.0 PCI bridge: nVidia Corporation MCP79 PCI Bridge (rev b1)
00:0a.0 Ethernet controller: nVidia Corporation MCP79 Ethernet (rev b1)
00:0b.0 IDE interface: nVidia Corporation MCP79 SATA Controller (rev b1=
)
00:0c.0 PCI bridge: nVidia Corporation MCP79 PCI Express Bridge (rev b1=
)
00:10.0 PCI bridge: nVidia Corporation MCP79 PCI Express Bridge (rev b1=
)
00:15.0 PCI bridge: nVidia Corporation MCP79 PCI Express Bridge (rev b1=
)
00:16.0 PCI bridge: nVidia Corporation MCP79 PCI Express Bridge (rev b1=
)
00:17.0 PCI bridge: nVidia Corporation MCP79 PCI Express Bridge (rev b1=
)
00:18.0 PCI bridge: nVidia Corporation MCP79 PCI Express Bridge (rev b1=
)
03:00.0 VGA compatible controller: nVidia Corporation Device 087d =20
(rev b1)

lspci -vv:
00:00.0 Host bridge: nVidia Corporation MCP79 Host Bridge (rev b1)
         Subsystem: nVidia Corporation Device cb79
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- =20
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast =20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0

00:00.1 RAM memory: nVidia Corporation MCP79 Memory Controller (rev b1)
         Subsystem: nVidia Corporation Device cb79
         Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- =20
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast =20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0

00:03.0 ISA bridge: nVidia Corporation MCP79 LPC Bridge (rev b2)
         Subsystem: ZOTAC International (MCO) Ltd. Device a108
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- =20
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast =20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Region 0: I/O ports at 4f00 [size=3D256]

00:03.1 RAM memory: nVidia Corporation MCP79 Memory Controller (rev b1)
         Subsystem: ZOTAC International (MCO) Ltd. Device a108
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- =20
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast =20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:03.2 SMBus: nVidia Corporation MCP79 SMBus (rev b1)
         Subsystem: ZOTAC International (MCO) Ltd. Device a108
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- =20
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast =20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Interrupt: pin A routed to IRQ 11
         Region 0: I/O ports at 4900 [size=3D64]
         Region 4: I/O ports at 4d00 [size=3D64]
         Region 5: I/O ports at 4e00 [size=3D64]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME=20
(D0-,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
         Kernel driver in use: nForce2_smbus
         Kernel modules: i2c-nforce2

00:03.3 RAM memory: nVidia Corporation MCP79 Memory Controller (rev b1)
         Subsystem: nVidia Corporation Device cb79
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- =20
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast =20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:03.5 Co-processor: nVidia Corporation MCP79 Co-processor (rev b1)
         Subsystem: ZOTAC International (MCO) Ltd. Device a108
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- =20
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast =20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0 (750ns min, 250ns max)
         Interrupt: pin B routed to IRQ 9
         Region 0: Memory at fae80000 (32-bit, non-prefetchable) =20
[size=3D512K]

00:04.0 USB Controller: nVidia Corporation MCP79 OHCI USB 1.1 =20
Controller (rev b1) (prog-if 10)
         Subsystem: ZOTAC International (MCO) Ltd. Device a108
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- =20
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast =20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0 (750ns min, 250ns max)
         Interrupt: pin A routed to IRQ 15
         Region 0: Memory at fae7f000 (32-bit, non-prefetchable) =20
[size=3D4K]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D=
1=20
+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
         Kernel driver in use: ohci_hcd

00:04.1 USB Controller: nVidia Corporation MCP79 EHCI USB 2.0 =20
Controller (rev b1) (prog-if 20)
         Subsystem: ZOTAC International (MCO) Ltd. Device a108
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- =20
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast =20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0 (750ns min, 250ns max)
         Interrupt: pin B routed to IRQ 10
         Region 0: Memory at fae7ec00 (32-bit, non-prefetchable) =20
[size=3D256]
         Capabilities: [44] Debug port: BAR=3D1 offset=3D00a0
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D=
1=20
+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
         Kernel driver in use: ehci_hcd

00:06.0 USB Controller: nVidia Corporation MCP79 OHCI USB 1.1 =20
Controller (rev b1) (prog-if 10)
         Subsystem: ZOTAC International (MCO) Ltd. Device a108
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- =20
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast =20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0 (750ns min, 250ns max)
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at fae7d000 (32-bit, non-prefetchable) =20
[size=3D4K]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D=
1=20
+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
         Kernel driver in use: ohci_hcd

00:06.1 USB Controller: nVidia Corporation MCP79 EHCI USB 2.0 =20
Controller (rev b1) (prog-if 20)
         Subsystem: ZOTAC International (MCO) Ltd. Device a108
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- =20
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast =20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0 (750ns min, 250ns max)
         Interrupt: pin B routed to IRQ 9
         Region 0: Memory at fae7e800 (32-bit, non-prefetchable) =20
[size=3D256]
         Capabilities: [44] Debug port: BAR=3D1 offset=3D00a0
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D=
1=20
+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
         Kernel driver in use: ehci_hcd

00:08.0 Audio device: nVidia Corporation MCP79 High Definition Audio =20
(rev b1)
         Subsystem: PC Partner Limited Device 437b
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- =20
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast =20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0 (500ns min, 1250ns max)
         Interrupt: pin A routed to IRQ 15
         Region 0: Memory at fae78000 (32-bit, non-prefetchable) =20
[size=3D16K]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME=20
(D0-,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
         Kernel driver in use: HDA Intel
         Kernel modules: snd-hda-intel

00:09.0 PCI bridge: nVidia Corporation MCP79 PCI Bridge (rev b1) =20
(prog-if 01)
         Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- =20
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast =20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-laten=
cy=3D32
         Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=3Dmedium =20
 >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
         BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr+ DiscTmrStat- DiscTmrSERREn-
         Capabilities: [b8] Subsystem: ZOTAC International (MCO) Ltd. =20
Device a108

00:0a.0 Ethernet controller: nVidia Corporation MCP79 Ethernet (rev b1)
         Subsystem: ZOTAC International (MCO) Ltd. Device a108
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- =20
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast =20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0 (250ns min, 5000ns max)
         Interrupt: pin A routed to IRQ 10
         Region 0: Memory at fae7c000 (32-bit, non-prefetchable) =20
[size=3D4K]
         Region 1: I/O ports at d080 [size=3D8]
         Region 2: Memory at fae7e400 (32-bit, non-prefetchable) =20
[size=3D256]
         Region 3: Memory at fae7e000 (32-bit, non-prefetchable) =20
[size=3D16]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D=
1=20
+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable+ DSel=3D0 DScale=3D0 PME-
         Kernel driver in use: forcedeth
         Kernel modules: forcedeth

00:0b.0 IDE interface: nVidia Corporation MCP79 SATA Controller (rev =20
b1) (prog-if 85 [Master SecO PriO])
         Subsystem: ZOTAC International (MCO) Ltd. Device a108
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- =20
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast =20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0 (750ns min, 250ns max)
         Interrupt: pin A routed to IRQ 29
         Region 0: I/O ports at d000 [size=3D8]
         Region 1: I/O ports at cc00 [size=3D4]
         Region 2: I/O ports at c880 [size=3D8]
         Region 3: I/O ports at c800 [size=3D4]
         Region 4: I/O ports at c480 [size=3D16]
         Region 5: Memory at fae76000 (32-bit, non-prefetchable) =20
[size=3D8K]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME=20
(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
         Capabilities: [8c] SATA HBA <?>
         Capabilities: [b0] Message Signalled Interrupts: Mask- 64bit=20
+ Queue=3D0/3 Enable+
                 Address: 00000000fee0100c  Data: 4171
         Kernel driver in use: ahci

00:0c.0 PCI bridge: nVidia Corporation MCP79 PCI Express Bridge (rev b1=
)
         Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- =20
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast =20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 64 bytes
         Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-laten=
cy=3D0
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast =20
 >TAbort- <TAbort- <MAbort- <SERR- <PERR-
         BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [40] Subsystem: ZOTAC International (MCO) Ltd. =20
Device a108
         Capabilities: [48] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D=
1=20
+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
         Capabilities: [50] Message Signalled Interrupts: Mask- 64bit=20
+ Queue=3D0/1 Enable+
                 Address: 00000000fee0100c  Data: 4149
         Capabilities: [80] Express (v2) Root Port (Slot+), MSI 00
                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency =20
L0s <64ns, L1 <1us
                         ExtTag+ RBE+ FLReset-
                 DevCtl: Report errors: Correctable- Non-Fatal- =20
=46atal- Unsupported-
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 128 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- =20
AuxPwr- TransPend-
                 LnkCap: Port #0, Speed 2.5GT/s, Width x16, ASPM L0s =20
L1, Latency L0 <512ns, L1 <4us
                         ClockPM- Suprise- LLActRep+ BwNot+
                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- =20
Retrain- CommClk-
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s, Width x16, TrErr- Train- =20
SlotClk+ DLActive- BWMgmt- ABWMgmt-
                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- =20
HotPlug- Surpise-
                         Slot #  0, PowerLimit 0.000000; Interlock- =20
NoCompl-
                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- =20
CmdCplt- HPIrq+ LinkChg+
                         Control: AttnInd Off, PwrInd On, Power- =20
Interlock-
                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- =20
PresDet- Interlock-
                         Changed: MRL- PresDet- LinkState-
                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- =20
PMEIntEna- CRSVisible-
                 RootCap: CRSVisible-
                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         Kernel driver in use: pcieport-driver
         Kernel modules: shpchp

00:10.0 PCI bridge: nVidia Corporation MCP79 PCI Express Bridge (rev b1=
)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- =20
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast =20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 64 bytes
         Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-laten=
cy=3D0
         I/O behind bridge: 0000e000-0000efff
         Memory behind bridge: faf00000-fbffffff
         Prefetchable memory behind bridge: =20
00000000e0000000-00000000f9ffffff
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast =20
 >TAbort- <TAbort- <MAbort- <SERR- <PERR-
         BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [40] Subsystem: ZOTAC International (MCO) Ltd. =20
Device a108
         Capabilities: [48] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D=
1=20
+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
         Capabilities: [50] Message Signalled Interrupts: Mask- 64bit=20
+ Queue=3D0/1 Enable-
                 Address: 0000000000000000  Data: 0000
         Kernel modules: shpchp

00:15.0 PCI bridge: nVidia Corporation MCP79 PCI Express Bridge (rev b1=
)
         Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- =20
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast =20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 64 bytes
         Bus: primary=3D00, secondary=3D04, subordinate=3D04, sec-laten=
cy=3D0
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast =20
 >TAbort- <TAbort- <MAbort- <SERR- <PERR-
         BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [40] Subsystem: ZOTAC International (MCO) Ltd. =20
Device a108
         Capabilities: [48] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D=
1=20
+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
         Capabilities: [50] Message Signalled Interrupts: Mask- 64bit=20
+ Queue=3D0/1 Enable+
                 Address: 00000000fee0100c  Data: 4151
         Capabilities: [80] Express (v2) Root Port (Slot+), MSI 00
                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency =20
L0s <64ns, L1 <1us
                         ExtTag+ RBE+ FLReset-
                 DevCtl: Report errors: Correctable- Non-Fatal- =20
=46atal- Unsupported-
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 128 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- =20
AuxPwr- TransPend-
                 LnkCap: Port #3, Speed 2.5GT/s, Width x1, ASPM L0s =20
L1, Latency L0 <512ns, L1 <4us
                         ClockPM- Suprise- LLActRep+ BwNot+
                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- =20
Retrain- CommClk-
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train- =20
SlotClk+ DLActive- BWMgmt- ABWMgmt-
                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- =20
HotPlug- Surpise-
                         Slot #  0, PowerLimit 0.000000; Interlock- =20
NoCompl-
                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- =20
CmdCplt- HPIrq+ LinkChg+
                         Control: AttnInd Off, PwrInd On, Power- =20
Interlock-
                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- =20
PresDet+ Interlock-
                         Changed: MRL- PresDet- LinkState-
                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- =20
PMEIntEna- CRSVisible-
                 RootCap: CRSVisible-
                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         Kernel driver in use: pcieport-driver
         Kernel modules: shpchp

00:16.0 PCI bridge: nVidia Corporation MCP79 PCI Express Bridge (rev b1=
)
         Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- =20
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast =20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 64 bytes
         Bus: primary=3D00, secondary=3D05, subordinate=3D05, sec-laten=
cy=3D0
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast =20
 >TAbort- <TAbort- <MAbort- <SERR- <PERR-
         BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [40] Subsystem: ZOTAC International (MCO) Ltd. =20
Device a108
         Capabilities: [48] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D=
1=20
+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
         Capabilities: [50] Message Signalled Interrupts: Mask- 64bit=20
+ Queue=3D0/1 Enable+
                 Address: 00000000fee0100c  Data: 4159
         Capabilities: [80] Express (v2) Root Port (Slot+), MSI 00
                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency =20
L0s <64ns, L1 <1us
                         ExtTag+ RBE+ FLReset-
                 DevCtl: Report errors: Correctable- Non-Fatal- =20
=46atal- Unsupported-
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 128 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- =20
AuxPwr- TransPend-
                 LnkCap: Port #4, Speed 2.5GT/s, Width x1, ASPM L0s =20
L1, Latency L0 <512ns, L1 <4us
                         ClockPM- Suprise- LLActRep+ BwNot+
                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- =20
Retrain- CommClk-
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- =20
SlotClk+ DLActive- BWMgmt- ABWMgmt-
                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- =20
HotPlug- Surpise-
                         Slot #  0, PowerLimit 0.000000; Interlock- =20
NoCompl-
                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- =20
CmdCplt- HPIrq+ LinkChg+
                         Control: AttnInd Off, PwrInd On, Power- =20
Interlock-
                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- =20
PresDet- Interlock-
                         Changed: MRL- PresDet- LinkState-
                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- =20
PMEIntEna- CRSVisible-
                 RootCap: CRSVisible-
                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         Kernel driver in use: pcieport-driver
         Kernel modules: shpchp

00:17.0 PCI bridge: nVidia Corporation MCP79 PCI Express Bridge (rev b1=
)
         Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- =20
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast =20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 64 bytes
         Bus: primary=3D00, secondary=3D06, subordinate=3D06, sec-laten=
cy=3D0
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast =20
 >TAbort- <TAbort- <MAbort- <SERR- <PERR-
         BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [40] Subsystem: ZOTAC International (MCO) Ltd. =20
Device a108
         Capabilities: [48] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D=
1=20
+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
         Capabilities: [50] Message Signalled Interrupts: Mask- 64bit=20
+ Queue=3D0/1 Enable+
                 Address: 00000000fee0100c  Data: 4161
         Capabilities: [80] Express (v2) Root Port (Slot+), MSI 00
                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency =20
L0s <64ns, L1 <1us
                         ExtTag+ RBE+ FLReset-
                 DevCtl: Report errors: Correctable- Non-Fatal- =20
=46atal- Unsupported-
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 128 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- =20
AuxPwr- TransPend-
                 LnkCap: Port #5, Speed 2.5GT/s, Width x1, ASPM L0s =20
L1, Latency L0 <512ns, L1 <4us
                         ClockPM- Suprise- LLActRep+ BwNot+
                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- =20
Retrain- CommClk-
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- =20
SlotClk+ DLActive- BWMgmt- ABWMgmt-
                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- =20
HotPlug- Surpise-
                         Slot #  0, PowerLimit 0.000000; Interlock- =20
NoCompl-
                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- =20
CmdCplt- HPIrq+ LinkChg+
                         Control: AttnInd Off, PwrInd On, Power- =20
Interlock-
                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- =20
PresDet- Interlock-
                         Changed: MRL- PresDet- LinkState-
                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- =20
PMEIntEna- CRSVisible-
                 RootCap: CRSVisible-
                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         Kernel driver in use: pcieport-driver
         Kernel modules: shpchp

00:18.0 PCI bridge: nVidia Corporation MCP79 PCI Express Bridge (rev b1=
)
         Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- =20
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast =20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 64 bytes
         Bus: primary=3D00, secondary=3D07, subordinate=3D07, sec-laten=
cy=3D0
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast =20
 >TAbort- <TAbort- <MAbort- <SERR- <PERR-
         BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [40] Subsystem: ZOTAC International (MCO) Ltd. =20
Device a108
         Capabilities: [48] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D=
1=20
+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
         Capabilities: [50] Message Signalled Interrupts: Mask- 64bit=20
+ Queue=3D0/1 Enable+
                 Address: 00000000fee0100c  Data: 4169
         Capabilities: [80] Express (v2) Root Port (Slot+), MSI 00
                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency =20
L0s <64ns, L1 <1us
                         ExtTag+ RBE+ FLReset-
                 DevCtl: Report errors: Correctable- Non-Fatal- =20
=46atal- Unsupported-
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 128 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- =20
AuxPwr- TransPend-
                 LnkCap: Port #6, Speed 2.5GT/s, Width x1, ASPM L0s =20
L1, Latency L0 <512ns, L1 <4us
                         ClockPM- Suprise- LLActRep+ BwNot+
                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- =20
Retrain- CommClk-
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- =20
SlotClk+ DLActive- BWMgmt- ABWMgmt-
                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- =20
HotPlug- Surpise-
                         Slot #  0, PowerLimit 0.000000; Interlock- =20
NoCompl-
                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- =20
CmdCplt- HPIrq+ LinkChg+
                         Control: AttnInd Off, PwrInd On, Power- =20
Interlock-
                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- =20
PresDet- Interlock-
                         Changed: MRL- PresDet- LinkState-
                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- =20
PMEIntEna- CRSVisible-
                 RootCap: CRSVisible-
                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         Kernel driver in use: pcieport-driver
         Kernel modules: shpchp

03:00.0 VGA compatible controller: nVidia Corporation Device 087d =20
(rev b1)
         Subsystem: ZOTAC International (MCO) Ltd. Device a108
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- =20
ParErr- Stepping- SERR+ FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast =20
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 64 bytes
         Interrupt: pin A routed to IRQ 10
         Region 0: Memory at fb000000 (32-bit, non-prefetchable) =20
[size=3D16M]
         Region 1: Memory at e0000000 (64-bit, prefetchable) [size=3D25=
6M]
         Region 3: Memory at f8000000 (64-bit, prefetchable) [size=3D32=
M]
         Region 5: I/O ports at ec00 [size=3D128]
         Expansion ROM at fafe0000 [disabled] [size=3D128K]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME=20
(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
         Capabilities: [68] Message Signalled Interrupts: Mask- 64bit=20
+ Queue=3D0/0 Enable-
                 Address: 0000000000000000  Data: 0000
         Kernel modules: nvidiafb


dmesg (boot):
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.31-ion (root@server.nordlund.se) =20
(gcc version 4.3.3 (Ubuntu 4.3.3-5ubuntu4) ) #1 SMP Sun Sep 13 =20
14:14:48 CEST 2009
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   NSC Geode by NSC
[    0.000000]   Cyrix CyrixInstead
[    0.000000]   Centaur CentaurHauls
[    0.000000]   Transmeta GenuineTMx86
[    0.000000]   Transmeta TransmetaCPU
[    0.000000]   UMC UMC UMC UMC
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 =20
(reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 =20
(reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000006ffa0000 (usable)
[    0.000000]  BIOS-e820: 000000006ffa0000 - 000000006ffae000 (ACPI =20
data)
[    0.000000]  BIOS-e820: 000000006ffae000 - 000000006fff0000 (ACPI =20
NVS)
[    0.000000]  BIOS-e820: 000000006fff0000 - 0000000080000000 =20
(reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 =20
(reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 =20
(reserved)
[    0.000000]  BIOS-e820: 00000000ff700000 - 0000000100000000 =20
(reserved)
[    0.000000] DMI present.
[    0.000000] AMI BIOS detected: BIOS may corrupt low RAM, working =20
around it.
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 =20
(usable) =3D=3D> (reserved)
[    0.000000] last_pfn =3D 0x6ffa0 max_arch_pfn =3D 0x1000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-CFFFF write-protect
[    0.000000]   D0000-DFFFF uncachable
[    0.000000]   E0000-EFFFF write-through
[    0.000000]   F0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask 080000000 write-back
[    0.000000]   1 disabled
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] Scanning 0 areas for low memory corruption
[    0.000000] modified physical RAM map:
[    0.000000]  modified: 0000000000000000 - 0000000000010000 (reserved=
)
[    0.000000]  modified: 0000000000010000 - 000000000009fc00 (usable)
[    0.000000]  modified: 000000000009fc00 - 00000000000a0000 (reserved=
)
[    0.000000]  modified: 00000000000e0000 - 0000000000100000 (reserved=
)
[    0.000000]  modified: 0000000000100000 - 000000006ffa0000 (usable)
[    0.000000]  modified: 000000006ffa0000 - 000000006ffae000 (ACPI =20
data)
[    0.000000]  modified: 000000006ffae000 - 000000006fff0000 (ACPI NVS=
)
[    0.000000]  modified: 000000006fff0000 - 0000000080000000 (reserved=
)
[    0.000000]  modified: 00000000fec00000 - 00000000fec01000 (reserved=
)
[    0.000000]  modified: 00000000fee00000 - 00000000fee01000 (reserved=
)
[    0.000000]  modified: 00000000ff700000 - 0000000100000000 (reserved=
)
[    0.000000] initial memory mapped : 0 - 00c00000
[    0.000000] init_memory_mapping: 0000000000000000-00000000379fe000
[    0.000000] NX (Execute Disable) protection: active
[    0.000000]  0000000000 - 0000200000 page 4k
[    0.000000]  0000200000 - 0037800000 page 2M
[    0.000000]  0037800000 - 00379fe000 page 4k
[    0.000000] kernel direct mapping tables up to 379fe000 @ 10000-1600=
0
[    0.000000] RAMDISK: 351d3000 - 37fef032
[    0.000000] Allocated new RAMDISK: 0089b000 - 036b7032
[    0.000000] Move RAMDISK from 00000000351d3000 - 0000000037fef031 =20
to 0089b000 - 036b7031
[    0.000000] 901MB HIGHMEM available.
[    0.000000] 889MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 379fe000
[    0.000000]   low ram: 0 - 379fe000
[    0.000000]   node 0 low ram: 00000000 - 379fe000
[    0.000000]   node 0 bootmap 00012000 - 00018f40
[    0.000000] (9 early reservations) =3D=3D> bootmem [0000000000 - =20
00379fe000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page =3D=3D> =
=20
[0000000000 - 0000001000]
[    0.000000]   #1 [0000001000 - 0000002000]    EX TRAMPOLINE =3D=3D> =
=20
[0000001000 - 0000002000]
[    0.000000]   #2 [0000006000 - 0000007000]       TRAMPOLINE =3D=3D> =
=20
[0000006000 - 0000007000]
[    0.000000]   #3 [0000100000 - 0000893fd8]    TEXT DATA BSS =3D=3D> =
=20
[0000100000 - 0000893fd8]
[    0.000000]   #4 [000009fc00 - 0000100000]    BIOS reserved =3D=3D> =
=20
[000009fc00 - 0000100000]
[    0.000000]   #5 [0000894000 - 000089a1bf]              BRK =3D=3D> =
=20
[0000894000 - 000089a1bf]
[    0.000000]   #6 [0000010000 - 0000012000]          PGTABLE =3D=3D> =
=20
[0000010000 - 0000012000]
[    0.000000]   #7 [000089b000 - 00036b7032]      NEW RAMDISK =3D=3D> =
=20
[000089b000 - 00036b7032]
[    0.000000]   #8 [0000012000 - 0000019000]          BOOTMAP =3D=3D> =
=20
[0000012000 - 0000019000]
[    0.000000] found SMP MP-table at [c00ff780] ff780
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   Normal   0x00001000 -> 0x000379fe
[    0.000000]   HighMem  0x000379fe -> 0x0006ffa0
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009f
[    0.000000]     0: 0x00000100 -> 0x0006ffa0
[    0.000000] On node 0 totalpages: 458543
[    0.000000] free_area_init_node: node 0, pgdat c076c720, =20
node_mem_map c36b8200
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3951 pages, LIFO batch:0
[    0.000000]   Normal zone: 1748 pages used for memmap
[    0.000000]   Normal zone: 221994 pages, LIFO batch:31
[    0.000000]   HighMem zone: 1804 pages used for memmap
[    0.000000]   HighMem zone: 229014 pages, LIFO batch:31
[    0.000000] Using APIC driver default
[    0.000000] Nvidia board detected. Ignoring ACPI timer override.
[    0.000000] If you got timer trouble try acpi_use_timer_override
[    0.000000] Intel MultiProcessor Specification v1.4
[    0.000000]     Virtual Wire compatibility mode.
[    0.000000] MPTABLE: OEM ID: nVidia
[    0.000000] MPTABLE: Product ID: MCP7A
[    0.000000] MPTABLE: APIC at: 0xFEE00000
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] I/O APIC #1 Version 17 at 0xFEC00000.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] Processors: 1
[    0.000000] SMP: Allowing 1 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 24
[    0.000000] PM: Registered nosave memory: 000000000009f000 - =20
00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - =20
00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - =20
0000000000100000
[    0.000000] Allocating PCI resources starting at 80000000 (gap: =20
80000000:7ec00000)
[    0.000000] NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:1 nr_node_ids:1
[    0.000000] PERCPU: Embedded 15 pages at c44bf000, static data =20
38684 bytes
[    0.000000] Built 1 zonelists in Zone order, mobility grouping =20
on.  Total pages: 454959
[    0.000000] Kernel command line: root=3D/dev/mapper/server-root ro =20
acpi=3Doff noapic quiet splash
[    0.000000] PID hash table entries: 4096 (order: 12, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, =20
524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, =20
262144 bytes)
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] allocated 9172800 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=3Dmemory' option if you don't=
 =20
want memory cgroups
[    0.000000] Initializing HighMem for node 0 (000379fe:0006ffa0)
[    0.000000] Memory: 1754080k/1834624k available (4545k kernel =20
code, 79208k reserved, 2066k data, 464k init, 923272k highmem)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xfff1e000 - 0xfffff000   ( 900 kB)
[    0.000000]     pkmap   : 0xffa00000 - 0xffc00000   (2048 kB)
[    0.000000]     vmalloc : 0xf81fe000 - 0xff9fe000   ( 120 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf79fe000   ( 889 MB)
[    0.000000]       .init : 0xc0775000 - 0xc07e9000   ( 464 kB)
[    0.000000]       .data : 0xc0570433 - 0xc0774ec8   (2066 kB)
[    0.000000]       .text : 0xc0100000 - 0xc0570433   (4545 kB)
[    0.000000] Checking if this processor honours the WP bit even in =20
supervisor mode...Ok.
[    0.000000] SLUB: Genslabs=3D13, HWalign=3D64, Order=3D0-3, =20
MinObjects=3D0, CPUs=3D1, Nodes=3D1
[    0.000000] NR_IRQS:512
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 1600.096 MHz processor.
[    0.000018] spurious 8259A interrupt: IRQ7.
[    0.001954] Console: colour VGA+ 80x25
[    0.001960] console [tty0] enabled
[    0.010012] Calibrating delay loop (skipped), value calculated =20
using timer frequency.. 3200.19 BogoMIPS (lpj=3D16000960)
[    0.010052] Security Framework initialized
[    0.010062] SELinux:  Disabled at boot.
[    0.010076] Mount-cache hash table entries: 512
[    0.010299] Initializing cgroup subsys ns
[    0.010307] Initializing cgroup subsys cpuacct
[    0.010315] Initializing cgroup subsys memory
[    0.010329] Initializing cgroup subsys freezer
[    0.010353] CPU: L1 I cache: 32K, L1 D cache: 24K
[    0.010358] CPU: L2 cache: 512K
[    0.010363] CPU: Unsupported number of siblings 2
[    0.010370] using mwait in idle threads.
[    0.010381] Performance Counters: Atom events, Intel PMU driver.
[    0.010391] ... version:                 3
[    0.010395] ... bit width:               40
[    0.010399] ... generic counters:        2
[    0.010403] ... value mask:              000000ffffffffff
[    0.010407] ... max period:              000000007fffffff
[    0.010411] ... fixed-purpose counters:  3
[    0.010415] ... counter mask:            0000000700000003
[    0.010423] Checking 'hlt' instruction... OK.
[    0.050888] SMP alternatives: switching to UP code
[    0.061524] Freeing SMP alternatives: 30k freed
[    0.061640] CPU0: Intel(R) Atom(TM) CPU  230   @ 1.60GHz stepping 02
[    0.180193] Brought up 1 CPUs
[    0.180200] Total of 1 processors activated (3200.19 BogoMIPS).
[    0.180219] CPU0 attaching NULL sched-domain.
[    0.180600] Booting paravirtualized kernel on bare hardware
[    0.181059] regulator: core version 0.5
[    0.181127] Time: 13:54:18  Date: 10/07/09
[    0.181217] NET: Registered protocol family 16
[    0.181879] PCI: PCI BIOS revision 3.00 entry at 0xf0031, last bus=3D=
7
[    0.181886] PCI: Using configuration type 1 for base access
[    0.183772] bio: create slab <bio-0> at 0
[    0.183910] ACPI: Interpreter disabled.
[    0.184133] SCSI subsystem initialized
[    0.184209] libata version 3.00 loaded.
[    0.184358] usbcore: registered new interface driver usbfs
[    0.184393] usbcore: registered new interface driver hub
[    0.184450] usbcore: registered new device driver usb
[    0.184672] PCI: Probing PCI hardware
[    0.184678] PCI: Probing PCI hardware (bus 00)
[    0.184958] pci 0000:00:03.0: reg 10 io port: [0x4f00-0x4fff]
[    0.185085] pci 0000:00:03.2: reg 10 io port: [0x4900-0x493f]
[    0.185106] pci 0000:00:03.2: reg 20 io port: [0x4d00-0x4d3f]
[    0.185115] pci 0000:00:03.2: reg 24 io port: [0x4e00-0x4e3f]
[    0.185145] pci 0000:00:03.2: PME# supported from D3hot D3cold
[    0.185155] pci 0000:00:03.2: PME# disabled
[    0.185305] pci 0000:00:03.5: reg 10 32bit mmio: =20
[0xfae80000-0xfaefffff]
[    0.185413] pci 0000:00:04.0: reg 10 32bit mmio: =20
[0xfae7f000-0xfae7ffff]
[    0.185454] pci 0000:00:04.0: supports D1 D2
[    0.185458] pci 0000:00:04.0: PME# supported from D0 D1 D2 D3hot =20
D3cold
[    0.185465] pci 0000:00:04.0: PME# disabled
[    0.185505] pci 0000:00:04.1: reg 10 32bit mmio: =20
[0xfae7ec00-0xfae7ecff]
[    0.185552] pci 0000:00:04.1: supports D1 D2
[    0.185557] pci 0000:00:04.1: PME# supported from D0 D1 D2 D3hot =20
D3cold
[    0.185564] pci 0000:00:04.1: PME# disabled
[    0.185608] pci 0000:00:06.0: reg 10 32bit mmio: =20
[0xfae7d000-0xfae7dfff]
[    0.185649] pci 0000:00:06.0: supports D1 D2
[    0.185654] pci 0000:00:06.0: PME# supported from D0 D1 D2 D3hot =20
D3cold
[    0.185661] pci 0000:00:06.0: PME# disabled
[    0.185700] pci 0000:00:06.1: reg 10 32bit mmio: =20
[0xfae7e800-0xfae7e8ff]
[    0.185747] pci 0000:00:06.1: supports D1 D2
[    0.185752] pci 0000:00:06.1: PME# supported from D0 D1 D2 D3hot =20
D3cold
[    0.185759] pci 0000:00:06.1: PME# disabled
[    0.185803] pci 0000:00:08.0: reg 10 32bit mmio: =20
[0xfae78000-0xfae7bfff]
[    0.185845] pci 0000:00:08.0: PME# supported from D3hot D3cold
[    0.185851] pci 0000:00:08.0: PME# disabled
[    0.185927] pci 0000:00:0a.0: reg 10 32bit mmio: =20
[0xfae7c000-0xfae7cfff]
[    0.185937] pci 0000:00:0a.0: reg 14 io port: [0xd080-0xd087]
[    0.185946] pci 0000:00:0a.0: reg 18 32bit mmio: =20
[0xfae7e400-0xfae7e4ff]
[    0.185955] pci 0000:00:0a.0: reg 1c 32bit mmio: =20
[0xfae7e000-0xfae7e00f]
[    0.185986] pci 0000:00:0a.0: supports D1 D2
[    0.185991] pci 0000:00:0a.0: PME# supported from D0 D1 D2 D3hot =20
D3cold
[    0.185999] pci 0000:00:0a.0: PME# disabled
[    0.186040] pci 0000:00:0b.0: reg 10 io port: [0xd000-0xd007]
[    0.186049] pci 0000:00:0b.0: reg 14 io port: [0xcc00-0xcc03]
[    0.186058] pci 0000:00:0b.0: reg 18 io port: [0xc880-0xc887]
[    0.186067] pci 0000:00:0b.0: reg 1c io port: [0xc800-0xc803]
[    0.186076] pci 0000:00:0b.0: reg 20 io port: [0xc480-0xc48f]
[    0.186085] pci 0000:00:0b.0: reg 24 32bit mmio: =20
[0xfae76000-0xfae77fff]
[    0.186316] pci 0000:00:0c.0: PME# supported from D0 D1 D2 D3hot =20
D3cold
[    0.186327] pci 0000:00:0c.0: PME# disabled
[    0.186416] pci 0000:00:10.0: PME# supported from D0 D1 D2 D3hot =20
D3cold
[    0.186423] pci 0000:00:10.0: PME# disabled
[    0.186635] pci 0000:00:15.0: PME# supported from D0 D1 D2 D3hot =20
D3cold
[    0.186646] pci 0000:00:15.0: PME# disabled
[    0.186879] pci 0000:00:16.0: PME# supported from D0 D1 D2 D3hot =20
D3cold
[    0.186891] pci 0000:00:16.0: PME# disabled
[    0.187129] pci 0000:00:17.0: PME# supported from D0 D1 D2 D3hot =20
D3cold
[    0.187140] pci 0000:00:17.0: PME# disabled
[    0.187375] pci 0000:00:18.0: PME# supported from D0 D1 D2 D3hot =20
D3cold
[    0.187386] pci 0000:00:18.0: PME# disabled
[    0.187481] pci 0000:00:09.0: transparent bridge
[    0.187621] pci 0000:03:00.0: reg 10 32bit mmio: =20
[0xfb000000-0xfbffffff]
[    0.187636] pci 0000:03:00.0: reg 14 64bit mmio: =20
[0xe0000000-0xefffffff]
[    0.187650] pci 0000:03:00.0: reg 1c 64bit mmio: =20
[0xf8000000-0xf9ffffff]
[    0.187661] pci 0000:03:00.0: reg 24 io port: [0xec00-0xec7f]
[    0.187671] pci 0000:03:00.0: reg 30 32bit mmio: =20
[0xfafe0000-0xfaffffff]
[    0.187739] pci 0000:00:10.0: bridge io port: [0xe000-0xefff]
[    0.187746] pci 0000:00:10.0: bridge 32bit mmio: =20
[0xfaf00000-0xfbffffff]
[    0.187755] pci 0000:00:10.0: bridge 64bit mmio pref: =20
[0xe0000000-0xf9ffffff]
[    0.189350] pci 0000:00:03.1: default IRQ router [10de:0aa4]
[    0.189737] Bluetooth: Core ver 2.15
[    0.189814] NET: Registered protocol family 31
[    0.189818] Bluetooth: HCI device and connection manager initialized
[    0.189824] Bluetooth: HCI socket layer initialized
[    0.189829] NET: Registered protocol family 8
[    0.189833] NET: Registered protocol family 20
[    0.189856] NetLabel: Initializing
[    0.189860] NetLabel:  domain hash size =3D 128
[    0.189864] NetLabel:  protocols =3D UNLABELED CIPSOv4
[    0.189889] NetLabel:  unlabeled traffic allowed by default
[    0.192626] pnp: PnP ACPI: disabled
[    0.193089] pci 0000:00:09.0: PCI bridge, secondary bus 0000:01
[    0.193096] pci 0000:00:09.0:   IO window: disabled
[    0.193103] pci 0000:00:09.0:   MEM window: disabled
[    0.193110] pci 0000:00:09.0:   PREFETCH window: disabled
[    0.193117] pci 0000:00:0c.0: PCI bridge, secondary bus 0000:02
[    0.193121] pci 0000:00:0c.0:   IO window: disabled
[    0.193134] pci 0000:00:0c.0:   MEM window: disabled
[    0.193144] pci 0000:00:0c.0:   PREFETCH window: disabled
[    0.193156] pci 0000:00:10.0: PCI bridge, secondary bus 0000:03
[    0.193162] pci 0000:00:10.0:   IO window: 0xe000-0xefff
[    0.193170] pci 0000:00:10.0:   MEM window: 0xfaf00000-0xfbffffff
[    0.193178] pci 0000:00:10.0:   PREFETCH window: =20
0x000000e0000000-0x000000f9ffffff
[    0.193187] pci 0000:00:15.0: PCI bridge, secondary bus 0000:04
[    0.193191] pci 0000:00:15.0:   IO window: disabled
[    0.193204] pci 0000:00:15.0:   MEM window: disabled
[    0.193214] pci 0000:00:15.0:   PREFETCH window: disabled
[    0.193225] pci 0000:00:16.0: PCI bridge, secondary bus 0000:05
[    0.193229] pci 0000:00:16.0:   IO window: disabled
[    0.193242] pci 0000:00:16.0:   MEM window: disabled
[    0.193253] pci 0000:00:16.0:   PREFETCH window: disabled
[    0.193263] pci 0000:00:17.0: PCI bridge, secondary bus 0000:06
[    0.193268] pci 0000:00:17.0:   IO window: disabled
[    0.193281] pci 0000:00:17.0:   MEM window: disabled
[    0.193291] pci 0000:00:17.0:   PREFETCH window: disabled
[    0.193302] pci 0000:00:18.0: PCI bridge, secondary bus 0000:07
[    0.193306] pci 0000:00:18.0:   IO window: disabled
[    0.193319] pci 0000:00:18.0:   MEM window: disabled
[    0.193330] pci 0000:00:18.0:   PREFETCH window: disabled
[    0.193349] pci 0000:00:09.0: setting latency timer to 64
[    0.193380] pci 0000:00:0c.0: setting latency timer to 64
[    0.193393] pci 0000:00:10.0: setting latency timer to 64
[    0.193421] pci 0000:00:15.0: setting latency timer to 64
[    0.193452] pci 0000:00:16.0: setting latency timer to 64
[    0.193482] pci 0000:00:17.0: setting latency timer to 64
[    0.193513] pci 0000:00:18.0: setting latency timer to 64
[    0.193523] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
[    0.193530] pci_bus 0000:00: resource 1 mem: =20
[0x000000-0xffffffffffffffff]
[    0.193536] pci_bus 0000:01: resource 3 io:  [0x00-0xffff]
[    0.193542] pci_bus 0000:01: resource 4 mem: =20
[0x000000-0xffffffffffffffff]
[    0.193549] pci_bus 0000:03: resource 0 io:  [0xe000-0xefff]
[    0.193555] pci_bus 0000:03: resource 1 mem: [0xfaf00000-0xfbffffff]
[    0.193561] pci_bus 0000:03: resource 2 pref mem =20
[0xe0000000-0xf9ffffff]
[    0.193633] NET: Registered protocol family 2
[    0.193837] IP route cache hash table entries: 32768 (order: 5, =20
131072 bytes)
[    0.194496] TCP established hash table entries: 131072 (order: 8, =20
1048576 bytes)
[    0.195347] TCP bind hash table entries: 65536 (order: 7, 524288 =20
bytes)
[    0.195769] TCP: Hash tables configured (established 131072 bind =20
65536)
[    0.195776] TCP reno registered
[    0.195970] NET: Registered protocol family 1
[    0.196096] Trying to unpack rootfs image as initramfs...
[    2.764149] Freeing initrd memory: 47216k freed
[    2.805111] platform rtc_cmos: registered platform RTC device (no =20
PNP device found)
[    2.805220] cpufreq-nforce2: No nForce2 chipset.
[    2.805262] Scanning for low memory corruption every 60 seconds
[    2.805471] audit: initializing netlink socket (disabled)
[    2.805523] type=3D2000 audit(1254923660.799:1): initialized
[    2.821820] highmem bounce pool size: 64 pages
[    2.821832] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    2.824685] VFS: Disk quotas dquot_6.5.2
[    2.824812] Dquot-cache hash table entries: 1024 (order 0, 4096 =20
bytes)
[    2.826048] fuse init (API version 7.12)
[    2.826224] msgmni has been set to 1716
[    2.826607] alg: No test for stdrng (krng)
[    2.826636] io scheduler noop registered
[    2.826642] io scheduler anticipatory registered
[    2.826646] io scheduler deadline registered (default)
[    2.826750] io scheduler cfq registered
[    2.890260] pci 0000:03:00.0: Boot video device
[    2.890646] pcieport-driver 0000:00:0c.0: irq 24 for MSI/MSI-X
[    2.890672] pcieport-driver 0000:00:0c.0: setting latency timer to 6=
4
[    2.891095] pcieport-driver 0000:00:15.0: irq 25 for MSI/MSI-X
[    2.891120] pcieport-driver 0000:00:15.0: setting latency timer to 6=
4
[    2.891531] pcieport-driver 0000:00:16.0: irq 26 for MSI/MSI-X
[    2.891556] pcieport-driver 0000:00:16.0: setting latency timer to 6=
4
[    2.891965] pcieport-driver 0000:00:17.0: irq 27 for MSI/MSI-X
[    2.891989] pcieport-driver 0000:00:17.0: setting latency timer to 6=
4
[    2.892389] pcieport-driver 0000:00:18.0: irq 28 for MSI/MSI-X
[    2.892413] pcieport-driver 0000:00:18.0: setting latency timer to 6=
4
[    2.892620] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    2.892672] pciehp: PCI Express Hot Plug Controller Driver =20
version: 0.4
[    2.892790] XENFS: not registering filesystem on non-xen platform
[    2.895163] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.895279] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    2.897427] brd: module loaded
[    2.898398] loop: module loaded
[    2.898562] input: Macintosh mouse button emulation as /devices/=20
virtual/input/input0
[    2.898719] ahci 0000:00:0b.0: version 3.0
[    2.898739] ahci 0000:00:0b.0: guessed PCI INT A -> IRQ 5
[    2.898865] ahci 0000:00:0b.0: irq 29 for MSI/MSI-X
[    2.898978] ahci 0000:00:0b.0: AHCI 0001.0200 32 slots 6 ports 3 =20
Gbps 0x3f impl IDE mode
[    2.898986] ahci 0000:00:0b.0: flags: 64bit ncq sntf led pmp pio =20
slum part
[    2.898994] ahci 0000:00:0b.0: setting latency timer to 64
[    2.899942] scsi0 : ahci
[    2.900164] scsi1 : ahci
[    2.900276] scsi2 : ahci
[    2.900390] scsi3 : ahci
[    2.900500] scsi4 : ahci
[    2.900617] scsi5 : ahci
[    2.900700] ata1: SATA max UDMA/133 abar m8192@0xfae76000 port =20
0xfae76100 irq 29
[    2.900708] ata2: SATA max UDMA/133 abar m8192@0xfae76000 port =20
0xfae76180 irq 29
[    2.900714] ata3: SATA max UDMA/133 abar m8192@0xfae76000 port =20
0xfae76200 irq 29
[    2.900721] ata4: SATA max UDMA/133 abar m8192@0xfae76000 port =20
0xfae76280 irq 29
[    2.900727] ata5: SATA max UDMA/133 abar m8192@0xfae76000 port =20
0xfae76300 irq 29
[    2.900734] ata6: SATA max UDMA/133 abar m8192@0xfae76000 port =20
0xfae76380 irq 29
[    2.902205] Fixed MDIO Bus: probed
[    2.902218] PPP generic driver version 2.4.2
[    2.902423] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) =20
Driver
[    2.902476] ehci_hcd 0000:00:04.1: setting latency timer to 64
[    2.902483] ehci_hcd 0000:00:04.1: EHCI Host Controller
[    2.902590] ehci_hcd 0000:00:04.1: new USB bus registered, =20
assigned bus number 1
[    2.902633] ehci_hcd 0000:00:04.1: debug port 1
[    2.902642] ehci_hcd 0000:00:04.1: cache line size of 32 is not =20
supported
[    2.902659] ehci_hcd 0000:00:04.1: irq 10, io mem 0xfae7ec00
[    2.919875] ehci_hcd 0000:00:04.1: USB 2.0 started, EHCI 1.00
[    2.920029] usb usb1: configuration #1 chosen from 1 choice
[    2.920098] hub 1-0:1.0: USB hub found
[    2.920116] hub 1-0:1.0: 6 ports detected
[    2.920236] ehci_hcd 0000:00:06.1: setting latency timer to 64
[    2.920243] ehci_hcd 0000:00:06.1: EHCI Host Controller
[    2.920311] ehci_hcd 0000:00:06.1: new USB bus registered, =20
assigned bus number 2
[    2.920351] ehci_hcd 0000:00:06.1: debug port 1
[    2.920360] ehci_hcd 0000:00:06.1: cache line size of 32 is not =20
supported
[    2.920377] ehci_hcd 0000:00:06.1: irq 9, io mem 0xfae7e800
[    2.939866] ehci_hcd 0000:00:06.1: USB 2.0 started, EHCI 1.00
[    2.939995] usb usb2: configuration #1 chosen from 1 choice
[    2.940055] hub 2-0:1.0: USB hub found
[    2.940070] hub 2-0:1.0: 6 ports detected
[    2.940180] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.940231] ohci_hcd 0000:00:04.0: setting latency timer to 64
[    2.940238] ohci_hcd 0000:00:04.0: OHCI Host Controller
[    2.940309] ohci_hcd 0000:00:04.0: new USB bus registered, =20
assigned bus number 3
[    2.940335] ohci_hcd 0000:00:04.0: irq 15, io mem 0xfae7f000
[    3.001984] usb usb3: configuration #1 chosen from 1 choice
[    3.002044] hub 3-0:1.0: USB hub found
[    3.002061] hub 3-0:1.0: 6 ports detected
[    3.002163] ohci_hcd 0000:00:06.0: setting latency timer to 64
[    3.002170] ohci_hcd 0000:00:06.0: OHCI Host Controller
[    3.002241] ohci_hcd 0000:00:06.0: new USB bus registered, =20
assigned bus number 4
[    3.002266] ohci_hcd 0000:00:06.0: irq 11, io mem 0xfae7d000
[    3.061990] usb usb4: configuration #1 chosen from 1 choice
[    3.062048] hub 4-0:1.0: USB hub found
[    3.062064] hub 4-0:1.0: 6 ports detected
[    3.062165] uhci_hcd: USB Universal Host Controller Interface driver
[    3.062316] usbcore: registered new interface driver libusual
[    3.062384] usbcore: registered new interface driver usbserial
[    3.062407] USB Serial support registered for generic
[    3.062438] usbcore: registered new interface driver =20
usbserial_generic
[    3.062443] usbserial: USB Serial Driver core
[    3.062510] PNP: No PS/2 controller found. Probing ports directly.
[    3.063960] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.063973] serio: i8042 AUX port at 0x60,0x64 irq 12
[    3.064090] mice: PS/2 mouse device common for all mice
[    3.064267] rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
[    3.064316] rtc0: alarms up to one day, 114 bytes nvram
[    3.064536] device-mapper: uevent: version 1.0.3
[    3.064784] device-mapper: ioctl: 4.15.0-ioctl (2009-04-01) =20
initialised: dm-devel@redhat.com
[    3.064882] device-mapper: multipath: version 1.1.0 loaded
[    3.064889] device-mapper: multipath round-robin: version 1.0.0 =20
loaded
[    3.065152] cpuidle: using governor ladder
[    3.065157] cpuidle: using governor menu
[    3.066113] TCP cubic registered
[    3.066456] NET: Registered protocol family 10
[    3.067322] lo: Disabled Privacy Extensions
[    3.067982] NET: Registered protocol family 17
[    3.068027] Bluetooth: L2CAP ver 2.13
[    3.068031] Bluetooth: L2CAP socket layer initialized
[    3.068037] Bluetooth: SCO (Voice Link) ver 0.6
[    3.068041] Bluetooth: SCO socket layer initialized
[    3.068103] Bluetooth: RFCOMM TTY layer initialized
[    3.068110] Bluetooth: RFCOMM socket layer initialized
[    3.068114] Bluetooth: RFCOMM ver 1.11
[    3.068173] Using IPI No-Shortcut mode
[    3.068316] PM: Resume from disk failed.
[    3.068361] registered taskstats version 1
[    3.068575]   Magic number: 13:817:937
[    3.068683] rtc_cmos rtc_cmos: setting system clock to 2009-10-07 =20
13:54:21 UTC (1254923661)
[    3.068691] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    3.068695] EDD information not available.
[    3.249863] ata2: SATA link down (SStatus 0 SControl 300)
[    3.249899] ata5: SATA link down (SStatus 0 SControl 300)
[    3.249926] ata4: SATA link down (SStatus 0 SControl 300)
[    3.249963] ata6: SATA link down (SStatus 0 SControl 300)
[    3.429843] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.429866] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.429902] ata3.00: failed to IDENTIFY (I/O error, err_mask=3D0x100=
)
[    3.470145] ata1.00: ATA-7: ST3320620AS, 3.AAJ, max UDMA/133
[    3.470152] ata1.00: 625142448 sectors, multi 16: LBA48 NCQ (depth =20
31/32)
[    3.528485] ata1.00: configured for UDMA/133
[    3.528678] scsi 0:0:0:0: Direct-Access     ATA      =20
ST3320620AS      3.AA PQ: 0 ANSI: 5
[    3.528935] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    3.529024] sd 0:0:0:0: [sda] 625142448 512-byte logical blocks: =20
(320 GB/298 GiB)
[    3.529145] sd 0:0:0:0: [sda] Write Protect is off
[    3.529152] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    3.529215] sd 0:0:0:0: [sda] Write cache: enabled, read cache: =20
enabled, doesn't support DPO or FUA
[    3.529533]  sda: sda1 sda2 < sda5 >
[    3.592918] sd 0:0:0:0: [sda] Attached SCSI disk
[    8.959556] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    8.959596] ata3.00: failed to IDENTIFY (I/O error, err_mask=3D0x100=
)
[    8.959603] ata3: limiting SATA link speed to 1.5 Gbps
[   14.489267] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   14.489299] ata3.00: failed to IDENTIFY (I/O error, err_mask=3D0x100=
)
[   20.018980] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   20.019000] ata3: exception Emask 0x10 SAct 0x0 SErr 0x0 action =20
0x1 t4
[   20.019066] ata3: irq_stat 0x08000000, interface fatal error
[   20.019186] Freeing unused kernel memory: 464k freed
[   20.019572] Write protecting the kernel text: 4548k
[   20.019672] Write protecting the kernel read-only data: 1676k
[   20.363075] forcedeth: Reverse Engineered nForce ethernet driver. =20
Version 0.64.
[   20.363104] forcedeth 0000:00:0a.0: setting latency timer to 64
[   20.441292] forcedeth 0000:00:0a.0: ifname eth0, PHY OUI 0x732 @ =20
3, addr 00:01:2e:27:3c:19
[   20.441302] forcedeth 0000:00:0a.0: highdma csum pwrctl gbit =20
lnktim msi desc-v3
[   21.211257] PM: Starting manual resume from disk
[   21.211267] PM: Resume from partition 252:1
[   21.211271] PM: Checking hibernation image.
[   21.211447] PM: Resume from disk failed.
[   21.218989] EXT3-fs: INFO: recovery required on readonly filesystem.
[   21.218997] EXT3-fs: write access will be enabled during recovery.
[   21.308267] kjournald starting.  Commit interval 5 seconds
[   21.308293] EXT3-fs: recovery complete.
[   21.308707] EXT3-fs: mounted filesystem with writeback data mode.
[   22.885578] udev: starting version 141
[   23.273454] shpchp: Standard Hot Plug PCI Controller Driver =20
version: 0.4
[   23.433134] input: PC Speaker as /devices/platform/pcspkr/input/=20
input1
[   23.757633] i2c-adapter i2c-0: nForce2 SMBus adapter at 0x4d00
[   23.757676] i2c-adapter i2c-1: nForce2 SMBus adapter at 0x4e00
[   24.868474] HDA Intel 0000:00:08.0: setting latency timer to 64
[   26.298678] hda_codec: Unknown model for ALC662 rev1, trying auto-=20
probe from BIOS...
[   26.858750] input: HDA Digital PCBeep as /devices/=20
pci0000:00/0000:00:08.0/input/input2
[   27.857570] lp: driver loaded but no devices found
[   28.054378] Adding 5275640k swap on /dev/mapper/server-swap_1.  =20
Priority:-1 extents:1 across:5275640k
[   28.605744] EXT3 FS on dm-0, internal journal
[   34.057883] eth0: no IPv6 routers present
[   39.504541] NET: Registered protocol family 5






