From: Brad Campbell <brad@wasp.net.au>
Subject: sata_promise timeouts in 2.6.21-rc7
Date: Fri, 20 Apr 2007 12:12:14 +0400
Message-ID: <462875DE.9020108@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:49815 "EHLO wasp.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753786AbXDTIMd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Apr 2007 04:12:33 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

G'day all,

I recently upgraded this box from 2.6.16 to 2.6.21-rc7 and I've started seeing these timeouts in the 
logs. Not incredibly frequent, and thus far not causing problems.. just there where they were not 
before. Only generally happening when the storage system is under a bit of strain (like re-building 
or checking md).

All the drives pass long smart tests and have nothing pending..

Any more info or help I can provide?


[153509.879113] ata8.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[153509.879145] ata8.00: cmd c8/00:00:3f:ec:8b/00:00:00:00:00/eb tag 0 cdb 0x0 data 131072 in
[153509.879147]          res 40/00:00:01:01:80/00:00:00:00:00/00 Emask 0x4 (timeout)
[153509.879610] ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[153509.879632] ata7.00: cmd c8/00:00:3f:ec:8b/00:00:00:00:00/eb tag 0 cdb 0x0 data 131072 in
[153509.879634]          res 40/00:00:01:01:80/00:00:00:00:00/00 Emask 0x4 (timeout)
[153510.208904] ata8: soft resetting port
[153510.208993] ata7: soft resetting port
[153510.368845] ata8: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[153510.368998] ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[153510.409352] ata8.00: configured for UDMA/133
[153510.409385] ata8: EH complete
[153510.409418] ata7.00: configured for UDMA/133
[153510.409441] ata7: EH complete
[153510.416392] SCSI device sdg: 490234752 512-byte hdwr sectors (251000 MB)
[153510.430850] sdg: Write Protect is off
[153510.430877] sdg: Mode Sense: 00 3a 00 00
[153510.504275] SCSI device sdg: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[153510.600591] SCSI device sdf: 490234752 512-byte hdwr sectors (251000 MB)
[153510.625200] sdf: Write Protect is off
[153510.625226] sdf: Mode Sense: 00 3a 00 00
[153510.673865] SCSI device sdf: write cache: enabled, read cache: enabled, doesn't support DPO or FUA


0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host Bridge (rev 80)
         Subsystem: Asustek Computer, Inc. A7V8X motherboard
         Flags: bus master, 66MHz, medium devsel, latency 64
         Memory at f8000000 (32-bit, prefetchable) [size=64M]
         Capabilities: [80] AGP version 3.5
         Capabilities: [c0] Power Management version 2

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge (prog-if 00 [Normal decode])
         Flags: bus master, 66MHz, medium devsel, latency 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         I/O behind bridge: 0000d000-0000dfff
         Memory behind bridge: df000000-dfdfffff
         Prefetchable memory behind bridge: dff00000-f7ffffff
         Capabilities: [80] Power Management version 2

0000:00:09.0 Ethernet controller: 3Com Corporation 3c940 10/100/1000Base-T [Marvell] (rev 12)
         Subsystem: Asustek Computer, Inc. P4P800 Mainboard
         Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 16
         Memory at de800000 (32-bit, non-prefetchable) [size=16K]
         I/O ports at b800 [size=256]
         Capabilities: [48] Power Management version 2
         Capabilities: [50] Vital Product Data

0000:00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
         Subsystem: Realtek Semiconductor Co., Ltd. RT8139
         Flags: bus master, medium devsel, latency 64, IRQ 17
         I/O ports at b400 [size=256]
         Memory at de000000 (32-bit, non-prefetchable) [size=256]
         Expansion ROM at 70000000 [disabled] [size=64K]
         Capabilities: [50] Power Management version 2

0000:00:0b.0 Unknown mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)
         Subsystem: Promise Technology, Inc. PDC20318 (SATA150 TX4)
         Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 19
         I/O ports at b000 [size=64]
         I/O ports at a800 [size=16]
         I/O ports at a400 [size=128]
         Memory at dd800000 (32-bit, non-prefetchable) [size=4K]
         Memory at dd000000 (32-bit, non-prefetchable) [size=128K]
         Expansion ROM at 70010000 [disabled] [size=16K]
         Capabilities: [60] Power Management version 2

0000:00:0c.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46) 
(prog-if 10 [OHCI])
         Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
         Flags: bus master, stepping, medium devsel, latency 64, IRQ 7
         Memory at dc800000 (32-bit, non-prefetchable) [size=2K]
         I/O ports at a000 [size=128]
         Capabilities: [50] Power Management version 2

0000:00:0d.0 Ethernet controller: Marvell Technology Group Ltd. Yukon Gigabit Ethernet 
10/100/1000Base-T Adapter (rev 12)
         Subsystem: Standard Microsystems Corp [SMC]: Unknown device b452
         Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 17
         Memory at dc000000 (32-bit, non-prefetchable) [size=16K]
         I/O ports at 9800 [size=256]
         Capabilities: [48] Power Management version 2
         Capabilities: [50] Vital Product Data

0000:00:0e.0 Unknown mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)
         Subsystem: Promise Technology, Inc. PDC20318 (SATA150 TX4)
         Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 20
         I/O ports at 9400 [size=64]
         I/O ports at 9000 [size=16]
         I/O ports at 8800 [size=128]
         Memory at db800000 (32-bit, non-prefetchable) [size=4K]
         Memory at db000000 (32-bit, non-prefetchable) [size=128K]
         Expansion ROM at 70014000 [disabled] [size=16K]
         Capabilities: [60] Power Management version 2

0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Flags: bus master, medium devsel, latency 64, IRQ 18
         I/O ports at 8400 [size=8]
         I/O ports at 8000 [size=4]
         I/O ports at 7800 [size=8]
         I/O ports at 7400 [size=4]
         I/O ports at 7000 [size=16]
         I/O ports at 6800 [size=256]
         Capabilities: [c0] Power Management version 2

0000:00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus 
Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Flags: bus master, medium devsel, latency 64, IRQ 18
         [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [size=8]
         [virtual] Memory at 000003f0 (type 3, non-prefetchable) [size=1]
         [virtual] Memory at 00000170 (32-bit, non-prefetchable) [size=8]
         [virtual] Memory at 00000370 (type 3, non-prefetchable) [size=1]
         I/O ports at 6400 [size=16]
         Capabilities: [c0] Power Management version 2

0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) 
(prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Flags: bus master, medium devsel, latency 64, IRQ 21
         I/O ports at 6000 [size=32]
         Capabilities: [80] Power Management version 2

0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) 
(prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Flags: bus master, medium devsel, latency 64, IRQ 21
         I/O ports at 5800 [size=32]
         Capabilities: [80] Power Management version 2

0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) 
(prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Flags: bus master, medium devsel, latency 64, IRQ 21
         I/O ports at 5400 [size=32]
         Capabilities: [80] Power Management version 2

0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) 
(prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Flags: bus master, medium devsel, latency 64, IRQ 21
         I/O ports at 5000 [size=32]
         Capabilities: [80] Power Management version 2

0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if 20 [EHCI])
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Flags: bus master, medium devsel, latency 64, IRQ 21
         Memory at da800000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [80] Power Management version 2

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Flags: bus master, stepping, medium devsel, latency 0
         Capabilities: [c0] Power Management version 2

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio 
Controller (rev 60)
         Flags: medium devsel
         I/O ports at e000 [disabled] [size=256]
         Capabilities: [c0] Power Management version 2

0000:00:11.6 Communication controller: VIA Technologies, Inc. Intel 537 [AC97 Modem] (rev 80)
         Flags: medium devsel
         I/O ports at e500 [disabled] [size=256]
         Capabilities: [d0] Power Management version 2

0000:00:13.0 Unknown mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)
         Subsystem: Promise Technology, Inc. PDC20318 (SATA150 TX4)
         Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 16
         I/O ports at 4800 [size=64]
         I/O ports at 4400 [size=16]
         I/O ports at 4000 [size=128]
         Memory at da000000 (32-bit, non-prefetchable) [size=4K]
         Memory at d9800000 (32-bit, non-prefetchable) [size=128K]
         Expansion ROM at 70018000 [disabled] [size=16K]
         Capabilities: [60] Power Management version 2

0000:01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 315PRO PCI/AGP VGA Display 
Adapter (prog-if 00 [VGA])
         Subsystem: Silicon Integrated Systems [SiS] 315PRO PCI/AGP VGA Display Adapter
         Flags: bus master, 66MHz, medium devsel, latency 71
         BIST result: 00
         Memory at e0000000 (32-bit, prefetchable) [size=256M]
         Memory at df000000 (32-bit, non-prefetchable) [size=256K]
         I/O ports at d800 [size=128]
         Expansion ROM at dfff0000 [disabled] [size=64K]
         Capabilities: [40] Power Management version 2
         Capabilities: [50] AGP version 2.0

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(TM) XP 2600+
stepping        : 0
cpu MHz         : 1916.544
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr 
sse syscall mmxext 3dnowext 3dnow ts
bogomips        : 3835.46
clflush size    : 32

Linux srv 2.6.21-rc7 #4 Wed Apr 18 16:07:59 GST 2007 i686 GNU/Linux


Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
