From: "Michal Suchanek" <hramrach@centrum.cz>
Subject: some ide cd-rom dma broken on older intel chipsets
Date: Thu, 13 Sep 2007 11:19:11 +0000
Message-ID: <a5d587fb0709130419n45a371bap74908e95a83ed67c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:28025 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568AbXIMLTO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Sep 2007 07:19:14 -0400
Received: by ug-out-1314.google.com with SMTP id z38so368187ugc
        for <linux-ide@vger.kernel.org>; Thu, 13 Sep 2007 04:19:12 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello

(please CC me when replying)

I tried booting a livecd (2.6.21 Debian kernel) on several systems
with Intel 440BX chipset and a Sony CD-ROM. I got some DMA error and
the system froze for about half a minute while reseting the ide
interface. It then disabled DMA and proceedded booting. Replacing with
a different brand unit fixed the problem.

Earlier with some ~ 2.6.10 kernel I tried installing on a i430VX/LX
system with a Mitsumi CD-ROM and I got kernel oops in interrupt
handler unless I disabled DMA.

Now I put both CD-ROMs into a different system to read the ident info,
and I can read from both fine, DMA is enabled, and I see no problems.
However, dd on the 52x unit gives only about 2MB/s while on the 8x
about 1MB/s.

 dd if=/dev/hdd of=/dev/null
187857+0 records in
187856+0 records out
96182272 bytes (96 MB) copied, 91.5743 seconds, 1.1 MB/s

dd if=/dev/hdc of=/dev/null
170433+0 records in
170432+0 records out
87261184 bytes (87 MB) copied, 45.9842 seconds, 1.9 MB/s



/dev/hdc:

 Model=CDU5211, FwRev=YYS2, SerialNo=
 Config={ SpinMotCtl Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2
 AdvancedPM=no

 * signifies the current active mode


/dev/hdd:

 Model=FX800S, FwRev=R03, SerialNo=
 Config={ SpinMotCtl Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=256kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:180,w/IORDY:180}, tDMA={min:150,rec:172}
 PIO modes:  pio0 pio1 pio2 pio3
 DMA modes:  sdma0 sdma1 sdma2 mdma0 *mdma1
 AdvancedPM=no

 * signifies the current active mode
00:00.0 Host bridge: VIA Technologies, Inc. K8M800 Host Bridge
00:00.1 Host bridge: VIA Technologies, Inc. K8M800 Host Bridge
00:00.2 Host bridge: VIA Technologies, Inc. K8M800 Host Bridge
00:00.3 Host bridge: VIA Technologies, Inc. K8M800 Host Bridge
00:00.4 Host bridge: VIA Technologies, Inc. K8M800 Host Bridge
00:00.7 Host bridge: VIA Technologies, Inc. K8M800 Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge
[K8T800/K8T890 South]
00:0f.0 IDE interface: VIA Technologies, Inc. VIA VT6420 SATA RAID
Controller (rev 80)
00:0f.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge
[KT600/K8T800/K8T890 South]
00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 78)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
01:00.0 VGA compatible controller: VIA Technologies, Inc. S3 Unichrome
Pro VGA Adapter (rev 01)


Sep 13 11:23:57  kernel: ACPI: PCI Interrupt 0000:00:0f.1[A] -> Link
[ALKA] -> GSI 20 (level, low) -> IRQ 18
Sep 13 11:23:57  kernel: VP_IDE: chipset revision 6
Sep 13 11:23:57  kernel: VP_IDE: not 100% native mode: will probe irqs later
Sep 13 11:23:57  kernel: VP_IDE: VIA vt8237 (rev 00) IDE UDMA133
controller on pci0000:00:0f.1
Sep 13 11:23:57  kernel:     ide0: BM-DMA at 0xe600-0xe607, BIOS
settings: hda:DMA, hdb:pio
Sep 13 11:23:57  kernel:     ide1: BM-DMA at 0xe608-0xe60f, BIOS
settings: hdc:DMA, hdd:DMA
Sep 13 11:23:57  kernel: input: PC Speaker as /class/input/input2
Sep 13 11:23:57  kernel: Floppy drive(s): fd0 is 1.44M
Sep 13 11:23:57  kernel: hda: ST340014A, ATA DISK drive
Sep 13 11:23:57  kernel: FDC 0 is a post-1991 82077
Sep 13 11:23:57  kernel: parport: PnPBIOS parport detected.
Sep 13 11:23:57  kernel: parport0: PC-style at 0x378 (0x778), irq 7,
dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
Sep 13 11:23:57  kernel: Real Time Clock Driver v1.12ac
Sep 13 11:23:57  kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Sep 13 11:23:57  kernel: hdc: CDU5211, ATAPI CD/DVD-ROM drive
Sep 13 11:23:57  kernel: hdd: FX800S, ATAPI CD/DVD-ROM drive
Sep 13 11:23:57  kernel: ide1 at 0x170-0x177,0x376 on irq 15
Sep 13 11:23:57  kernel: ACPI: PCI Interrupt Link [ALKC] enabled at IRQ 22
Sep 13 11:23:57  kernel: ACPI: PCI Interrupt 0000:00:11.5[C] -> Link
[ALKC] -> GSI 22 (level, low) -> IRQ 19
Sep 13 11:23:57  kernel: hda: max request size: 512KiB
Sep 13 11:23:57  kernel: hda: 78165360 sectors (40020 MB) w/2048KiB
Cache, CHS=16383/255/63, UDMA(100)
Sep 13 11:23:57  kernel: hda: cache flushes supported
Sep 13 11:23:57  kernel:  hda: hda1
Sep 13 11:23:57  kernel: hdc: ATAPI 52X CD-ROM drive, 120kB Cache, UDMA(33)
Sep 13 11:23:57  kernel: Uniform CD-ROM driver Revision: 3.20
Sep 13 11:23:57  kernel: hdd: ATAPI 8X CD-ROM drive, 256kB Cache, DMA


Thanks

Michal
