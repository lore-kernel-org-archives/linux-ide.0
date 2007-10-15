From: Guilherme Amadio <guilherme.amadio@gmail.com>
Subject: ata_piix: ICH7 "invalid MAP value 0" msg at boot
Date: Mon, 15 Oct 2007 15:14:44 -0200
Message-ID: <20071015171444.GA9512@vaio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.231]:52681 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756608AbXJORO4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Oct 2007 13:14:56 -0400
Received: by wr-out-0506.google.com with SMTP id 36so818891wra
        for <linux-ide@vger.kernel.org>; Mon, 15 Oct 2007 10:14:55 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

 Hello,

 I have a Sony laptop SZ series and I get the message
 
 ata_piix 0000:00:1f.2: invalid MAP value 0

 even with 'quiet' in the boot command line. I think it's because of a controller
 with no disk attached, but I am a total newb, so I went to #kernelnewbies and 
 I was told to post this here. The code that prints the message is here
 drivers/ata/ata_piix.c +973. 
 
 I'm using this kernel:
 Linux vaio 2.6.22-gentoo-r8 #1 SMP PREEMPT Sun Sep 30 13:19:56 BRT 2007
 i686 Genuine Intel(R) CPU T2400 @ 1.83GHz GenuineIntel GNU/Linux

 Below are the outputs that may be relevant for tracing the problem.
 If anything else is needed, I can provide, but please CC me, because I'm
 not subscribed to the list.

 Guilherme 

-- 
 dmesg:
 
 ata_piix 0000:00:1f.2: version 2.11
 ata_piix 0000:00:1f.2: MAP [ P0 P2 XX XX ]
 ata_piix 0000:00:1f.2: invalid MAP value 0
 ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 22 (level, low) -> IRQ 21
 PCI: Setting latency timer of device 0000:00:1f.2 to 64
 scsi0 : ata_piix
 scsi1 : ata_piix
 ata1: SATA max UDMA/133 cmd 0x000118d0 ctl 0x000118c6 bmdma 0x000118b0 irq 21
 ata2: SATA max UDMA/133 cmd 0x000118c8 ctl 0x000118c2 bmdma 0x000118b8 irq 21
 ata1.00: ATA-7: ST9100824AS, 3.14, max UDMA/133
 ata1.00: 195371568 sectors, multi 16: LBA48 NCQ (depth 0/32)
 ata1.00: configured for UDMA/133
 scsi 0:0:0:0: Direct-Access     ATA      ST9100824AS      3.14 PQ: 0 ANSI: 5
 sd 0:0:0:0: [sda] 195371568 512-byte hardware sectors (100030 MB)
 sd 0:0:0:0: [sda] Write Protect is off
 sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
 sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support
 DPO or FUA
 sd 0:0:0:0: [sda] 195371568 512-byte hardware sectors (100030 MB)
 sd 0:0:0:0: [sda] Write Protect is off
 sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
 sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support
 DPO or FUA
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
 sd 0:0:0:0: [sda] Attached SCSI disk

 lspci:

 00:00.0 Host bridge: Intel Corporation Mobile 945GM/PM/GMS, 943/940GML and
 945GT Express Memory Controller Hub (rev 03)
 00:02.0 VGA compatible controller: Intel Corporation Mobile 945GM/GMS,
 943/940GML Express Integrated Graphics Controller (rev 03)
 00:02.1 Display controller: Intel Corporation Mobile 945GM/GMS/GME, 943/940GML
 Express Integrated Graphics Controller (rev 03)
 00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition
 Audio Controller (rev 02)
 00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1
 (rev 02)
 00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 2
 (rev 02)
 00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 3
 (rev 02)
 00:1c.3 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 4
 (rev 02)
 00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
 Controller #1 (rev 02)
 00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
 Controller #2 (rev 02)
 00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
 Controller #3 (rev 02)
 00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
 Controller #4 (rev 02)
 00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI
 Controller (rev 02)
 00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e2)
 00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface Bridge
 (rev 02)
 00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller
 (rev 02)
 00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family) SATA IDE
 Controller (rev 02)
 00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 02)
 02:00.0 Network controller: Intel Corporation PRO/Wireless 3945ABG Network
 Connection (rev 02)
 03:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8036 PCI-E Fast
 Ethernet Controller (rev 15)
 05:04.0 CardBus bridge: Texas Instruments PCIxx12 Cardbus Controller
 05:04.1 FireWire (IEEE 1394): Texas Instruments PCIxx12 OHCI Compliant IEEE
 1394 Host Controller
 05:04.2 Mass storage controller: Texas Instruments 5-in-1 Multimedia Card
 Reader (SD/MMC/MS/MS PRO/xD)

 lspci -vvs 00:1f.2:

00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family) SATA IDE Controller
(rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
    Subsystem: Sony Corporation Unknown device 81e6
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin B routed to IRQ 21
    Region 0: I/O ports at 18d0 [size=8]
    Region 1: I/O ports at 18c4 [size=4]
    Region 2: I/O ports at 18c8 [size=8]
    Region 3: I/O ports at 18c0 [size=4]
    Region 4: I/O ports at 18b0 [size=16]
    Region 5: Memory at dc544400 (32-bit, non-prefetchable) [size=1K]
    Capabilities: [70] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-



