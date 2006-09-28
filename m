From: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>
Subject: Adaptec Unknown device 0241 (rev01): Serial ATA II RAID 1420SA
Date: Thu, 28 Sep 2006 07:23:17 -0400
Message-ID: <8E8F647D7835334B985D069AE964A4F7028FDFEB@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fwstl1-1.wul.qc.ec.gc.ca ([205.211.132.24]:7729 "EHLO
	ecqcmtlbh.quebec.int.ec.gc.ca") by vger.kernel.org with ESMTP
	id S1161078AbWI1LXW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Sep 2006 07:23:22 -0400
content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi all,

I don't know if it's worth to mention but I have an Adaptec Serial ATA
II RAID 1420SA quad port which supports RAID 0, 1 and 10.

I am using it whith a single 160GB HD and it is working properly since
around 2.6.16 ...

The lspci show the device has Unknown:
0000:04:0e.0 RAID bus controller: Adaptec: Unknown device 0241 (rev 01)

Lspci -vv
0000:04:0e.0 RAID bus controller: Adaptec: Unknown device 0241 (rev 01)
        Subsystem: Adaptec: Unknown device 0241
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 201
        Region 0: Memory at fe100000 (64-bit, non-prefetchable)
[size=1M]
        Region 2: I/O ports at e800 [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [60] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=3
                Status: Bus=255 Dev=31 Func=0 64bit+ 133MHz+ SCD- USC-,
DC=simple, DMMRBC=0, DMOST=3, DMCRS=0, RSCEM-


While the dmesg loads properly the sata_mv driver:
libata version 1.20 loaded.
sata_mv 0000:04:0e.0: version 0.7
ACPI: PCI Interrupt 0000:04:0e.0[A] -> GSI 18 (level, low) -> IRQ 201
sata_mv 0000:04:0e.0: Applying B2 workarounds to unknown rev
sata_mv 0000:04:0e.0: 32 slots 4 ports unknown mode IRQ via INTx
ata1: SATA max UDMA/133 cmd 0x0 ctl 0xF8DA2120 bmdma 0x0 irq 201
ata2: SATA max UDMA/133 cmd 0x0 ctl 0xF8DA4120 bmdma 0x0 irq 201
ata3: SATA max UDMA/133 cmd 0x0 ctl 0xF8DA6120 bmdma 0x0 irq 201
ata4: SATA max UDMA/133 cmd 0x0 ctl 0xF8DA8120 bmdma 0x0 irq 201
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[805b0600cbb18600]
ata1: dev 0 cfg 49:2f00 82:3069 83:7c01 84:4023 85:3069 86:3c01 87:4023
88:203f
ata1: dev 0 ATA-7, max UDMA/100, 312581808 sectors: LBA48
ata1: dev 0 configured for UDMA/100
scsi0 : sata_mv
ata2: no device found (phy stat 00000000)
scsi1 : sata_mv
ata3: no device found (phy stat 00000000)
scsi2 : sata_mv
ata4: no device found (phy stat 00000000)
scsi3 : sata_mv
  Vendor: ATA       Model: ST3160828AS       Rev: 3.02
  Type:   Direct-Access                      ANSI SCSI revision: 05
eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
sd 0:0:0:0: Attached scsi disk sda


One more thing I've found out is that the port probing is in reverse
order since the ports 0 1 2 3 are actually 4 3 2 1 (maybie 3 2 1 0
have'nt looked lately :) has wrote down on the adapter?

Thnx!

- vin

