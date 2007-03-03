From: =?ISO-8859-1?Q?D=E2niel?= Fraga <fragabr@gmail.com>
Subject: sata_nv: "abnormal status 0x7F on port 0xE407"
Date: Sat, 3 Mar 2007 14:07:32 -0300
Message-ID: <kjmob4-j82.ln1@tux.abusar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:55529 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030344AbXCCR21 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Mar 2007 12:28:27 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HNY1p-0005gC-Qu
	for linux-ide@vger.kernel.org; Sat, 03 Mar 2007 18:28:17 +0100
Received: from 200-207-206-233.dsl.telesp.net.br ([200.207.206.233])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 03 Mar 2007 18:28:17 +0100
Received: from fragabr by 200-207-206-233.dsl.telesp.net.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 03 Mar 2007 18:28:17 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Linux 2.6.20
x86_64
nforce 410 chipset
ST3160811AS (Seagate 160GB SATA 2)

sata_nv 0000:00:0e.0: version 3.2
ACPI: PCI Interrupt Link [LSA0] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [LSA0] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:0e.0 to 64
ata1: SATA max UDMA/133 cmd 0xE800 ctl 0xE482 bmdma 0xE000 irq 23
ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE082 bmdma 0xE008 irq 23
scsi0 : sata_nv
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-7, max UDMA/133, 312581808 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi1 : sata_nv
ata2: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0xE407

	I bought this HD today and it is working perfectly, but it's
strange the last message. Should I worry about it?

	I saw many similar logs on Google, so I think it's harmless,
right? Thanks!

	If you want hdparm -I:

/dev/sda:

ATA device, with non-removable media
        Model Number:       ST3160811AS                             
        Serial Number:      9PT030VD
        Firmware Revision:  3.AAE   
Standards:
        Supported: 7 6 5 4 
        Likely used: 7
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:  268435455
        LBA48  user addressable sectors:  312581808
        device size with M = 1024*1024:      152627 MBytes
        device size with M = 1000*1000:      160041 MBytes (160 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 32
        Standby timer values: spec'd by Standard, no device specific
minimum R/W multiple sector transfer: Max = 16  Current = 16
        Recommended acoustic management value: 208, current value: 0
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5
*udma6 Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4 
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    SMART feature set
                Security Mode feature set
           *    Power Management feature set
           *    Write cache
           *    Look-ahead
           *    Host Protected Area feature set
           *    WRITE_BUFFER command
           *    READ_BUFFER command
           *    DOWNLOAD_MICROCODE
                SET_MAX security extension
           *    48-bit Address feature set
           *    Device Configuration Overlay feature set
           *    Mandatory FLUSH_CACHE
           *    FLUSH_CACHE_EXT
           *    SMART error logging
           *    SMART self-test
           *    General Purpose Logging feature set
           *    SATA-I signaling speed (1.5Gb/s)
           *    SATA-II signaling speed (3.0Gb/s)
           *    Native Command Queueing (NCQ)
           *    Phy event counters
                Device-initiated interface power management
           *    Software settings preservation
Security: 
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
                frozen
        not     expired: security count
        not     supported: enhanced erase
Checksum: correct

fraga@tux ~/src$ cat /proc/ioports 
0000-001f : dma1
0020-0021 : pic1
002e-002e : w83627hf WDT
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : 0000:00:0d.0
  0170-0177 : libata
01f0-01f7 : 0000:00:0d.0
  01f0-01f7 : libata
0290-0297 : pnp 00:0a
  0295-0296 : w83627ehf
0376-0376 : 0000:00:0d.0
  0376-0376 : libata
03c0-03df : vga+
03f6-03f6 : 0000:00:0d.0
  03f6-03f6 : libata
0500-0503 : ACPI PM1a_EVT_BLK
0504-0505 : ACPI PM1a_CNT_BLK
0508-050b : ACPI PM_TMR
0520-0527 : ACPI GPE0_BLK
0600-063f : 0000:00:0a.1
0700-073f : 0000:00:0a.1
0cf8-0cff : PCI conf1
2000-207f : motherboard
2080-20ff : motherboard
5010-5015 : ACPI CPU throttle
d000-dfff : PCI Bus #04
  dc00-dc1f : 0000:04:08.0
    dc00-dc1f : ne2k-pci
e000-e00f : 0000:00:0e.0
  e000-e00f : sata_nv
e080-e083 : 0000:00:0e.0
  e080-e083 : sata_nv
e400-e407 : 0000:00:0e.0
  e400-e407 : sata_nv
e480-e483 : 0000:00:0e.0
  e480-e483 : sata_nv
e800-e807 : 0000:00:0e.0
  e800-e807 : sata_nv
ffa0-ffaf : 0000:00:0d.0
  ffa0-ffaf : libata

fraga@tux ~/src$ cat /proc/interrupts 
           CPU0       
  0:     166525   IO-APIC-edge      timer
  1:        603   IO-APIC-edge      i8042
  8:          2   IO-APIC-edge      rtc
  9:          0   IO-APIC-fasteoi   acpi
 12:          3   IO-APIC-edge      i8042
 14:          2   IO-APIC-edge      libata
 15:         19   IO-APIC-edge      libata
 18:      10852   IO-APIC-fasteoi   nvidia
 19:        561   IO-APIC-fasteoi   eth0
 20:        133   IO-APIC-fasteoi   HDA Intel
 21:          3   IO-APIC-fasteoi   ehci_hcd:usb2
 22:       3806   IO-APIC-fasteoi   ohci_hcd:usb1
 23:       5765   IO-APIC-fasteoi   libata
NMI:         80 
LOC:     166397 
ERR:          0

-- 
http://u-br.net
Linux 2.6.20: Homicidal Dwarf Hamster
gcc (GCC) 4.1.2

