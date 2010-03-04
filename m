From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 15445] New: pata_jmicron incorrectly downgrades CompactFlash to
 UDMA/33
Date: Thu, 4 Mar 2010 20:41:27 GMT
Message-ID: <bug-15445-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:60163 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756165Ab0CDUl2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Mar 2010 15:41:28 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o24KfR0g004049
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Thu, 4 Mar 2010 20:41:27 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=15445

           Summary: pata_jmicron incorrectly downgrades CompactFlash to
                    UDMA/33
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 2.6.32.9
          Platform: All
        OS/Version: Linux
              Tree: Fedora
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: pizza@shaftnet.org
        Regression: No


This is with the Fedora 2.6.39-67.x86_64 kernel on an Asus G51Vt laptop.

I picked up an SIIG "ExpressCard/54 CF RW" adapter as its native PCIe design
makes it much faster than a USB reader, at least in theory.

Under WinVista, the card sustains ~40MB/s transfers.  Under Linux (2.6.32.9),
I'm lucky to get ~25MB/s, not much faster than a good USB reader.  The CF card
advertises itself capable of UDMA/100, but the PATA layer downgrades it to
UDMA/33. hurting performance.

partial dmesg showing the hot-insertion:

pciehp 0000:00:1c.2:pcie04: Card present on Slot(0)
pci 0000:04:00.0: reg 10 io port: [0x00-0x07]
pci 0000:04:00.0: reg 14 io port: [0x00-0x03]
pci 0000:04:00.0: reg 18 io port: [0x00-0x07]
pci 0000:04:00.0: reg 1c io port: [0x00-0x03]
pci 0000:04:00.0: reg 20 io port: [0x00-0x0f]
pci 0000:04:00.0: reg 30 32bit mmio pref: [0x000000-0x00ffff]
pci 0000:04:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it
with 'pcie_aspm=force'
pata_jmicron 0000:04:00.0: enabling device (0100 -> 0101)
pata_jmicron 0000:04:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
pata_jmicron 0000:04:00.0: setting latency timer to 64
scsi8 : pata_jmicron
scsi9 : pata_jmicron
ata9: PATA max UDMA/100 cmd 0xc010 ctl 0xc020 bmdma 0xc000 irq 18
ata10: PATA max UDMA/100 cmd 0xc018 ctl 0xc024 bmdma 0xc008 irq 18
ata9.00: CFA: TRANSCEND, 20081024, max UDMA/100
ata9.00: 15924384 sectors, multi 0: LBA 
ata9.00: limited to UDMA/33 due to 40-wire cable
ata9.00: configured for UDMA/33
scsi 8:0:0:0: Direct-Access     ATA      TRANSCEND        2008 PQ: 0 ANSI: 5
sd 8:0:0:0: Attached scsi generic sg2 type 0
sd 8:0:0:0: [sdb] 15924384 512-byte logical blocks: (8.15 GB/7.59 GiB)
sd 8:0:0:0: [sdb] Write Protect is off
sd 8:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 8:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support
DPO or FUA
 sdb: sdb1
sd 8:0:0:0: [sdb] Attached SCSI disk

And then the 'lspci -v' output including the IDE controller:

04:00.0 IDE interface: JMicron Technologies, Inc. JMB368 IDE controller
(prog-if 85 [Master SecO PriO])
        Subsystem: JMicron Technologies, Inc. JMB368 IDE controller
        Physical Slot: 0
        Flags: bus master, fast devsel, latency 0, IRQ 18
        I/O ports at c010 [size=8]
        I/O ports at c020 [size=4]
        I/O ports at c018 [size=8]
        I/O ports at c024 [size=4]
        I/O ports at c000 [size=16]
        [virtual] Expansion ROM at f6000000 [disabled] [size=64K]
        Capabilities: [68] Power Management version 2
        Capabilities: [50] Express Legacy Endpoint, MSI 01
        Capabilities: [70] MSI: Enable- Count=1/1 Maskable- 64bit-
        Kernel driver in use: pata_jmicron
        Kernel modules: ata_generic, pata_acpi, pata_jmicron

I can understand the reasoning behind 40/80 wire detection/downgrading, but
this is a compactflash card in a PCIe card reader so there's effectively no
cable to detect, so forcing the cable type to ATA_CBL_PATA40_SHORT when this
particular PCIe CF reader is detected should just work.  

Unfortunately, I suspect the reported PCI sys/subsys IDs are not unique to this
particular card (197b:2368 for both) so I don't know how to go about adding
this exception in a sane manner.  Thoughts?

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
