From: "Johny Mail list" <maillist.johny@gmail.com>
Subject: PROBLEM: ata_piix.c for the ICH5 SATA Controller.
Date: Thu, 28 Jun 2007 14:46:31 +0200
Message-ID: <cd98e0260706280546m5d8c8f91kb639731e6e2da8db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.229]:65273 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760355AbXF1Mqd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jun 2007 08:46:33 -0400
Received: by wx-out-0506.google.com with SMTP id h31so500830wxd
        for <linux-ide@vger.kernel.org>; Thu, 28 Jun 2007 05:46:31 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hi,
I have a big problem with my SC1425 Dell Servers. I use Linux Software
RAID on them and last days i make few tests on them to see the
reaction of the server about different situations like : power
failure, hard drive prower failure ...
And the hard drive prower failure was the problem. When i unplug the
electric alimentation (or the SATA port cable) of one of my two hard
drives in RAID 1, the server stop responding and i get this messages :
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata4.00: cmd e7/00:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0
             res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata4: port is slow to respond, please be patient (Status 0xd0)
ata4: port failed to respond (30sec, Status 0xd0)
ata4: soft resetting port

I have make the same test on a SC1435 (the next generation) with a
broadcom chispset/driver and everything is fine when i unplug one hard
drive.
On SC1425 my bios is up-to-date from the dell website.

You can contact me for more informations, or some tests.

Thanks for your work

My informations :
# sh scripts/ver_linux
Linux raid-test 2.6.21.5-grsec-ipvs #1 SMP Thu Jun 28 13:51:34 CEST
2007 x86_64 GNU/Linux

Gnu C                  4.1.2
Gnu make               3.81
binutils               2.17
util-linux             2.12r
mount                  2.12r
module-init-tools      3.3-pre2
e2fsprogs              1.40-WIP
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.97
udev                   105

# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : 0000:00:1f.1
  0170-0177 : libata
01f0-01f7 : 0000:00:1f.1
  01f0-01f7 : libata
0376-0376 : 0000:00:1f.1
  0376-0376 : libata
03c0-03df : vga+
03f6-03f6 : 0000:00:1f.1
  03f6-03f6 : libata
03f8-03ff : serial
0800-087f : 0000:00:1f.0
  0800-087f : pnp 00:07
    0800-0803 : ACPI PM1a_EVT_BLK
    0804-0805 : ACPI PM1a_CNT_BLK
    0808-080b : ACPI PM_TMR
    0828-082f : ACPI GPE0_BLK
0880-08bf : 0000:00:1f.0
  0880-08bf : pnp 00:07
08c0-08df : pnp 00:07
08e0-08e3 : pnp 00:07
0c00-0c0f : pnp 00:07
0c10-0c1f : pnp 00:07
0ca0-0ca7 : pnp 00:07
0ca9-0cab : pnp 00:07
0cf8-0cff : PCI conf1
cc80-cc8f : 0000:00:1f.2
  cc80-cc8f : libata
cc98-cc9b : 0000:00:1f.2
  cc98-cc9b : libata
cca0-cca7 : 0000:00:1f.2
  cca0-cca7 : libata
ccb0-ccb3 : 0000:00:1f.2
  ccb0-ccb3 : libata
ccb8-ccbf : 0000:00:1f.2
  ccb8-ccbf : libata
ccc0-ccdf : 0000:00:1d.1
  ccc0-ccdf : uhci_hcd
cce0-ccff : 0000:00:1d.0
  cce0-ccff : uhci_hcd
d000-dfff : PCI Bus #04
  d800-d8ff : 0000:04:0d.0
  dcc0-dcff : 0000:04:03.0
    dcc0-dcff : e1000
e000-efff : PCI Bus #01
  e000-efff : PCI Bus #02
    ecc0-ecff : 0000:02:04.0
      ecc0-ecff : e1000
fc00-fc0f : 0000:00:1f.1
  fc00-fc0f : libata

# cat /proc/iomem
00000000-0009ffff : System RAM
  00000000-00000000 : Crash kernel
00100000-1ffbffff : System RAM
  00200000-004dcfb9 : Kernel code
  004dcfba-0059c9ef : Kernel data
1ffc0000-1ffcfbff : ACPI Tables
1ffcfc00-1fffefff : reserved
20000000-200003ff : 0000:00:1f.1
e0000000-efffffff : PCI MMCONFIG 0
  e0000000-efffffff : reserved
f0000000-f7ffffff : PCI Bus #04
  f0000000-f7ffffff : 0000:04:0d.0
fe500000-fe6fffff : PCI Bus #04
  fe500000-fe51ffff : 0000:04:0d.0
  fe5d0000-fe5dffff : 0000:04:0d.0
  fe5e0000-fe5fffff : 0000:04:03.0
    fe5e0000-fe5fffff : e1000
fe700000-feafffff : PCI Bus #01
  fe900000-feafffff : PCI Bus #02
    fe9e0000-fe9fffff : 0000:02:04.0
      fe9e0000-fe9fffff : e1000
feb00000-feb003ff : 0000:00:1d.7
  feb00000-feb003ff : ehci_hcd
fec00000-fec8ffff : reserved
  fec00000-fec00fff : IOAPIC 0
  fec80000-fec80fff : IOAPIC 1
fed00000-fed003ff : HPET 0
fee00000-fee00fff : Local APIC
ffb00000-ffffffff : reserved

# lspci -vvv
00:00.0 Host bridge: Intel Corporation E7520 Memory Controller Hub (rev 09)
        Subsystem: Dell PowerEdge SC1425
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [40] Vendor Specific Information

00:02.0 PCI bridge: Intel Corporation E7525/E7520/E7320 PCI Express
Port A (rev 09) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=01, subordinate=03, sec-latency=0
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fe700000-feafffff
        Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Message Signalled Interrupts: Mask- 64bit-
Queue=0/1 Enable-
                Address: fee00000  Data: 0000
        Capabilities: [64] Express Root Port (Slot-) IRQ 0
                Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
                Device: Latency L0s <64ns, L1 <1us
                Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                Device: MaxPayload 256 bytes, MaxReadReq 128 bytes
                Link: Supported Speed 2.5Gb/s, Width x8, ASPM L0s, Port 2
                Link: Latency L0s <4us, L1 unlimited
                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x8
                Root: Correctable- Non-Fatal- Fatal- PME-
        Capabilities: [100] Advanced Error Reporting

00:1d.0 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB
UHCI Controller #1 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Dell PowerEdge SC1425
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 4: I/O ports at cce0 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB
UHCI Controller #2 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Dell PowerEdge SC1425
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 4: I/O ports at ccc0 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2
EHCI Controller (rev 02) (prog-if 20 [EHCI])
        Subsystem: Dell PowerEdge SC1425
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 23
        Region 0: Memory at feb00000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev c2)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=32
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fe500000-fe6fffff
        Prefetchable memory behind bridge: f0000000-f7ffffff
        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity+ SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation 82801EB/ER (ICH5/ICH5R) LPC
Interface Bridge (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE
Controller (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Dell PowerEdge SC1425
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at 01f0 [size=8]
        Region 1: I/O ports at 03f4 [size=1]
        Region 2: I/O ports at 0170 [size=8]
        Region 3: I/O ports at 0374 [size=1]
        Region 4: I/O ports at fc00 [size=16]
        Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

00:1f.2 IDE interface: Intel Corporation 82801EB (ICH5) SATA
Controller (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: Dell PowerEdge SC1425
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at ccb8 [size=8]
        Region 1: I/O ports at ccb0 [size=4]
        Region 2: I/O ports at cca0 [size=8]
        Region 3: I/O ports at cc98 [size=4]
        Region 4: I/O ports at cc80 [size=16]

01:00.0 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI
Bridge A (rev 09) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=01, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fe900000-feafffff
        Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
        Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [44] Express PCI/PCI-X Bridge IRQ 0
                Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
                Device: Latency L0s <64ns, L1 <1us
                Device: AtnBtn- AtnInd- PwrInd-
                Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                Device: MaxPayload 256 bytes, MaxReadReq 512 bytes
                Link: Supported Speed 2.5Gb/s, Width x8, ASPM L0s, Port 0
                Link: Latency L0s unlimited, L1 unlimited
                Link: ASPM Disabled CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x8
        Capabilities: [5c] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [6c] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [d8] PCI-X bridge device
                Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=conv
                Status: Dev=01:00.0 64bit- 133MHz- SCD- USC- SCO- SRD-
                Upstream: Capacity=65535 CommitmentLimit=65535
                Downstream: Capacity=65535 CommitmentLimit=65535
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [300] Power Budgeting

01:00.2 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI
Bridge B (rev 09) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=01, secondary=03, subordinate=03, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
        Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [44] Express PCI/PCI-X Bridge IRQ 0
                Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
                Device: Latency L0s <64ns, L1 <1us
                Device: AtnBtn- AtnInd- PwrInd-
                Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                Device: MaxPayload 256 bytes, MaxReadReq 512 bytes
                Link: Supported Speed 2.5Gb/s, Width x8, ASPM L0s, Port 0
                Link: Latency L0s unlimited, L1 unlimited
                Link: ASPM Disabled CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x8
        Capabilities: [5c] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [6c] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [d8] PCI-X bridge device
                Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=133MHz
                Status: Dev=01:00.2 64bit- 133MHz- SCD- USC- SCO- SRD-
                Upstream: Capacity=65535 CommitmentLimit=65535
                Downstream: Capacity=65535 CommitmentLimit=65535
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [300] Power Budgeting

02:04.0 Ethernet controller: Intel Corporation 82541GI Gigabit
Ethernet Controller (rev 05)
        Subsystem: Dell PowerEdge SC1425
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (63750ns min), Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 32
        Region 0: Memory at fe9e0000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at ecc0 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [e4] PCI-X non-bridge device
                Command: DPERE- ERO+ RBC=512 OST=1
                Status: Dev=00:00.0 64bit- 133MHz- SCD- USC- DC=simple
DMMRBC=2048 DMOST=1 DMCRS=8 RSCEM- 266MHz- 533MHz-

04:03.0 Ethernet controller: Intel Corporation 82541GI Gigabit
Ethernet Controller (rev 05)
        Subsystem: Dell PowerEdge SC1425
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (63750ns min), Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at fe5e0000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at dcc0 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [e4] PCI-X non-bridge device
                Command: DPERE- ERO+ RBC=512 OST=1
                Status: Dev=00:00.0 64bit- 133MHz- SCD- USC- DC=simple
DMMRBC=2048 DMOST=1 DMCRS=8 RSCEM- 266MHz- 533MHz-

04:0d.0 VGA compatible controller: ATI Technologies Inc Radeon RV100
QY [Radeon 7000/VE] (prog-if 00 [VGA])
        Subsystem: Dell PowerEdge SC1425
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+
ParErr- Stepping+ SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at d800 [size=256]
        Region 2: Memory at fe5d0000 (32-bit, non-prefetchable) [size=64K]
        [virtual] Expansion ROM at fe500000 [disabled] [size=128K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

# cat /proc/scsi/scsi
Attached devices:
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WD800JD-75LS Rev: 09.0
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi3 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WD800JD-75LS Rev: 09.0
  Type:   Direct-Access                    ANSI  SCSI revision: 05
