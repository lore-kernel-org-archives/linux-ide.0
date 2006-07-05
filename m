From: Robin Humble <rjh@cita.utoronto.ca>
Subject: sata_sil via and seagate
Date: Wed, 5 Jul 2006 17:28:35 -0400
Message-ID: <20060705212835.GA28904@lemming.cita.utoronto.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8t9RHnE3ZwKMSgU+"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from quail.cita.utoronto.ca ([128.100.76.6]:27340 "EHLO
	quail.cita.utoronto.ca") by vger.kernel.org with ESMTP
	id S965042AbWGEV2f (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Jul 2006 17:28:35 -0400
Received: from cita.utoronto.ca (lemming.cita.utoronto.ca [128.100.76.53])
	by quail.cita.utoronto.ca (8.13.1/8.13.1) with ESMTP id k65LSZrY009438
	for <linux-ide@vger.kernel.org>; Wed, 5 Jul 2006 17:28:35 -0400
Received: from lemming.cita.utoronto.ca (localhost [127.0.0.1])
	by cita.utoronto.ca (8.13.6/8.12.8) with ESMTP id k65LSZE3000908
	for <linux-ide@vger.kernel.org>; Wed, 5 Jul 2006 17:28:35 -0400
Received: (from rjh@localhost)
	by lemming.cita.utoronto.ca (8.13.6/8.13.6/Submit) id k65LSZbH000907
	for linux-ide@vger.kernel.org; Wed, 5 Jul 2006 17:28:35 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi,

I'm having some traumas getting a new seagate 7200.10 320G ST3320620AS
disk working with a Sil 3112a card in a k7v m/b, Athlon700 cpu, fc5.

the SATA controller card + disk works just fine (70+MB/s hdparm -Tt,
multi-GB transferred ok) in much more recent k8v Athlon64 fc5 x86_64
machine so I don't think there's any fundamental hardware problems with
controller, cable, or disk.

also an older disk (7200.7 160G ST3160023AS) has worked fine with the k7v
and the 3112a card for a couple of years now - albeit with the usual slow
pace because of 'applying Seagate errata fix (mod15write workaround)'.
so to me that sounds like the old k7v motherboard is actually more or
less ok.

I've tried kernels 2.6.16, 2.6.17.3 and 2.6.16-1.2133_FC5 and
unfortunately all behave much the same.
various acpi=off nolapic noapic etc. options don't help, but I'm not
sure I've run through all the permutations of those...
as far as I know nothing shares an interrupt with the 3112a card. 

using the 'irqpoll' boot option as dmesg suggests lets the ST3320620AS
work at about half speed (~30MB/s hdparm -Tt).
however the irqpoll thing isn't a great final solution as I eventually
want to have both the seagate disks on the 3112a card, and in irqpoll
mode the older drive on the first port then runs at 1MB/s(!).

dmesg snippets are below and lspci -v is attached, please let me know
if I can provide anything else.

thanks for any assistance!

cheers,
robin


the relevant part of dmesg for kernel 2.6.17.3 is:

libata version 1.20 loaded.
sata_sil 0000:00:0a.0: version 0.9
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 4
PCI: setting IRQ 4 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 4 (level, low) -> IRQ 4
ata1: SATA max UDMA/100 cmd 0xE8832080 ctl 0xE883208A bmdma 0xE8832000 irq 4
ata2: SATA max UDMA/100 cmd 0xE88320C0 ctl 0xE88320CA bmdma 0xE8832008 irq 4
ata1: SATA link up 1.5 Gbps (SStatus 113)
irq 4: nobody cared (try booting with the "irqpoll" option)
 <c013579a> __report_bad_irq+0x36/0x7d  <c0135962> note_interrupt+0x181/0x1b3
 <c013533a> handle_IRQ_event+0x23/0x4c  <c01353d0> __do_IRQ+0x6d/0x95
 <c0104b1f> do_IRQ+0x36/0x4e 
 =======================
 <c0103416> common_interrupt+0x1a/0x20  <c011d182> __do_softirq+0x2c/0x7f
 <c0104b6f> do_softirq+0x38/0x41 
 =======================
 <c0104b2f> do_IRQ+0x46/0x4e  <c0103416> common_interrupt+0x1a/0x20
 <c01dd392> acpi_processor_idle+0x15a/0x32c  <c0101db8> cpu_idle+0x3a/0x4f
 <c03c165e> start_kernel+0x2c0/0x2c4  <c03c119d> unknown_bootoption+0x0/0x201
handlers:
[<e887f29c>] (ata_interrupt+0x0/0x128 [libata])
Disabling IRQ #4
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f
ata1: dev 0 ATA-7, max UDMA/133, 625142448 sectors: LBA48
ata1: qc timeout (cmd 0xef)
ata1: failed to set xfermode (err_mask=0x4)
scsi0 : sata_sil
ata2: SATA link down (SStatus 0)
scsi1 : sata_sil


dmesg for kernel 2.6.16-1.2133_FC5 is pretty much the same:

libata version 1.20 loaded.
sata_sil 0000:00:0a.0: version 0.9
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 4
PCI: setting IRQ 4 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 4 (level, low) -> IRQ 4
ata1: SATA max UDMA/100 cmd 0xE8832080 ctl 0xE883208A bmdma 0xE8832000 irq 4
ata2: SATA max UDMA/100 cmd 0xE88320C0 ctl 0xE88320CA bmdma 0xE8832008 irq 4
ata1: SATA link up 1.5 Gbps (SStatus 113)
irq 4: nobody cared (try booting with the "irqpoll" option)
 [<c013a62b>] __report_bad_irq+0x2b/0x69     [<c013a7ec>] note_interrupt+0x183/0x1af
 [<c013a192>] handle_IRQ_event+0x23/0x4c     [<c013a255>] __do_IRQ+0x9a/0xcd
 [<c0104c2e>] do_IRQ+0x5c/0x77     =======================
 [<c01035b6>] common_interrupt+0x1a/0x20
 [<c011fb39>] __do_softirq+0x2c/0x7f     [<c0104c81>] do_softirq+0x38/0x3f
 =======================
 [<c0104c40>] do_IRQ+0x6e/0x77     [<c01035b6>] common_interrupt+0x1a/0x20
 [<c0200179>] acpi_processor_idle+0x15a/0x329     [<c0101e76>] cpu_idle+0x3a/0x4f
 [<c03a96a3>] start_kernel+0x28c/0x28e    <3>handlers:
[<e887d006>] (ata_interrupt+0x0/0x12e [libata])
Disabling IRQ #4
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f
ata1: dev 0 ATA-7, max UDMA/133, 625142448 sectors: LBA48
ata1: qc timeout (cmd 0xef)
ata1: failed to set xfermode, disabled
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: SATA link down (SStatus 0)
scsi1 : sata_sil


booting with 'irqpoll' and any kernel lets me access the drive at a
slow rate. dmesg for 2.6.16-1.2133_FC5 then says:

libata version 1.20 loaded.
sata_sil 0000:00:0a.0: version 0.9
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 4
PCI: setting IRQ 4 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 4 (level, low) -> IRQ 4
ata1: SATA max UDMA/100 cmd 0xE8832080 ctl 0xE883208A bmdma 0xE8832000 irq 4
ata2: SATA max UDMA/100 cmd 0xE88320C0 ctl 0xE88320CA bmdma 0xE8832008 irq 4
ata1: SATA link up 1.5 Gbps (SStatus 113)
irq 4: nobody cared (try booting with the "irqpoll" option)
 [<c013a62b>] __report_bad_irq+0x2b/0x69     [<c013a7ec>] note_interrupt+0x183/0x1af
 [<c013a255>] __do_IRQ+0x9a/0xcd     [<c0104c2e>] do_IRQ+0x5c/0x77
 =======================
 [<c01035b6>] common_interrupt+0x1a/0x20     [<c011fb39>] __do_softirq+0x2c/0x7f
 [<c0104c81>] do_softirq+0x38/0x3f     =======================
 [<c0104c40>] do_IRQ+0x6e/0x77
 [<c01035b6>] common_interrupt+0x1a/0x20     [<c0200179>] acpi_processor_idle+0x15a/0x329
 [<c0101e76>] cpu_idle+0x3a/0x4f     [<c03a96a3>] start_kernel+0x28c/0x28e
handlers:
[<e887d006>] (ata_interrupt+0x0/0x12e [libata])
Disabling IRQ #4
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f
ata1: dev 0 ATA-7, max UDMA/133, 625142448 sectors: LBA48
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: SATA link down (SStatus 0)
scsi1 : sata_sil
  Vendor: ATA       Model: ST3320620AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda

--
    Robin Humble       http://www.cita.utoronto.ca/~rjh/

--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci-v.txt"

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev 02)
	Subsystem: ASUSTeK Computer Inc. Unknown device 8023
	Flags: bus master, medium devsel, latency 0
	Memory at e4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: e0800000-e1dfffff
	Prefetchable memory behind bridge: e1f00000-e3ffffff
	Capabilities: [80] Power Management version 2

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
	Subsystem: ASUSTeK Computer Inc. Unknown device 8023
	Flags: bus master, stepping, medium devsel, latency 0

00:04.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
	Flags: bus master, stepping, medium devsel, latency 32
	I/O ports at d800 [size=16]
	Capabilities: [c0] Power Management version 2

00:04.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 10) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Flags: bus master, medium devsel, latency 32, IRQ 3
	I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2

00:04.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 10) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Flags: bus master, medium devsel, latency 32, IRQ 3
	I/O ports at d000 [size=32]
	Capabilities: [80] Power Management version 2

00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
	Flags: medium devsel, IRQ 9
	Capabilities: [68] Power Management version 2

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Flags: bus master, medium devsel, latency 32, IRQ 3
	I/O ports at a400 [size=256]
	Memory at e0000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2

00:0a.0 RAID bus controller: Silicon Image, Inc. SiI 3112 [SATALink/SATARaid] Serial ATA Controller (rev 01)
	Subsystem: Silicon Image, Inc. SiI 3112 SATARaid Controller
	Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 4
	I/O ports at a000 [size=8]
	I/O ports at 9800 [size=4]
	I/O ports at 9400 [size=8]
	I/O ports at 9000 [size=4]
	I/O ports at 8800 [size=16]
	Memory at df800000 (32-bit, non-prefetchable) [size=512]
	[virtual] Expansion ROM at 30000000 [disabled] [size=512K]
	Capabilities: [60] Power Management version 2

00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
	Subsystem: Creative Labs CT4832 SBLive! Value
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at 8400 [size=32]
	Capabilities: [dc] Power Management version 1

00:0b.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 08)
	Subsystem: Creative Labs Gameport Joystick
	Flags: bus master, medium devsel, latency 32
	I/O ports at 8000 [size=8]
	Capabilities: [dc] Power Management version 1

01:00.0 VGA compatible controller: Matrox Graphics, Inc. G400/G450 (rev 04) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G400 Dual Head Max
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at e2000000 (32-bit, prefetchable) [size=32M]
	Memory at e1000000 (32-bit, non-prefetchable) [size=16K]
	Memory at e0800000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at e1ff0000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
	Capabilities: [f0] AGP version 2.0


--8t9RHnE3ZwKMSgU+--
