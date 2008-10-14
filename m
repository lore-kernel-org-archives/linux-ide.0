From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11761] New: External BIOS-less VIA VT6410 card doesn't attach CD-ROM devices attached to the card
Date: Tue, 14 Oct 2008 14:12:35 -0700 (PDT)
Message-ID: <bug-11761-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56355 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751211AbYJNVNH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Oct 2008 17:13:07 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9ELCaGJ032064
	for <linux-ide@vger.kernel.org>; Tue, 14 Oct 2008 14:12:37 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11761

           Summary: External BIOS-less VIA VT6410 card doesn't attach CD-ROM
                    devices attached to the card
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.27
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: brefi@yandex.ru


Earliest failing kernel version: 2.6.26 is the first tried
Distribution: Debian-4 Etch
Hardware Environment: i946GZ+ICH7 (G31) + Core2Duo CPU
Software Environment: Xorg + IceWM

Problem Description: 

ATAPI CDROM (mwdma2) and DVD-RW (udma-4) attached to the add-in card VT6410
card aren't available after OS boot although the card itself is detected &
initialized normally by the OS. Having attached as slave devices to the HDD on
the only PATA ICH7 channel of the motherboard, they're detected normally and
work well.

In WinXP, the devices are detected & work well on the card ( so, the card
supports ATAPI CD/DVD as declared )
The card doesn't have any boot BIOS-ROM on the board thus isn't bootable
itself.
The LibATA's driver & SCSI-CDROM support are used.

The logs are as follows:
-------------------------
DEBUG.LOG

Oct 14 00:00:23 vano-linux kernel: Entering add_active_range(0, 0, 229376) 0
entries of 256 used
Oct 14 00:00:23 vano-linux kernel: On node 0 totalpages: 229376
Oct 14 00:00:23 vano-linux kernel:   DMA zone: 32 pages used for memmap
Oct 14 00:00:23 vano-linux kernel:   DMA zone: 0 pages reserved
Oct 14 00:00:23 vano-linux kernel:   DMA zone: 4064 pages, LIFO batch:0
Oct 14 00:00:23 vano-linux kernel:   Normal zone: 1760 pages used for memmap
Oct 14 00:00:23 vano-linux kernel:   Normal zone: 223520 pages, LIFO batch:31
Oct 14 00:00:23 vano-linux kernel:   Movable zone: 0 pages used for memmap
Oct 14 00:00:23 vano-linux kernel: ACPI: Local APIC address 0xfee00000
Oct 14 00:00:23 vano-linux kernel: mapped APIC to ffffb000 (fee00000)
Oct 14 00:00:23 vano-linux kernel: CPA: page pool initialized 1 of 1 pages
preallocated
Oct 14 00:00:23 vano-linux kernel: ACPI: EC: Look up EC in DSDT
Oct 14 00:00:23 vano-linux kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0._PRT]
Oct 14 00:00:23 vano-linux kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.P0P1._PRT]
Oct 14 00:00:23 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1e.0 to 64
Oct 14 00:00:23 vano-linux kernel: pci 0000:00:02.0: Boot video device
Oct 14 00:00:23 vano-linux kernel: Switched to high resolution mode on CPU 0
Oct 14 00:00:23 vano-linux kernel: Probing IDE interface ide0...
Oct 14 00:00:23 vano-linux kernel: Probing IDE interface ide1...
Oct 14 00:00:23 vano-linux kernel: PCI: setting IRQ 5 as level-triggered
Oct 14 00:00:23 vano-linux kernel: PCI: setting IRQ 10 as level-triggered
Oct 14 00:00:23 vano-linux kernel: eth0:  Identified 8139 chip type
'RTL-8100B/8139D'
Oct 14 00:00:23 vano-linux kernel: PCI: setting IRQ 11 as level-triggered
Oct 14 00:00:23 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.0 to 64
Oct 14 00:00:23 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.1 to 64
Oct 14 00:00:23 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.2 to 64
Oct 14 00:00:23 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.3 to 64
Oct 14 00:00:23 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1b.0 to 64
Oct 14 00:00:23 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.7 to 64
Oct 14 00:00:23 vano-linux kernel: PCI: cache line size of 32 is not supported
by device 0000:00:1d.7
Oct 14 00:00:23 vano-linux kernel: irda_init()
Oct 14 00:00:38 vano-linux NetworkManager: <debug info>^I[1223924438.020149]
nm_hal_device_added (): New device added (hal udi is
'/org/freedesktop/Hal/devices/platform_bluetooth'). 
Oct 14 00:01:52 vano-linux NetworkManager: <debug info>^I[1223924512.007949]
nm_print_open_socks (): Open Sockets List: 
Oct 14 00:01:52 vano-linux NetworkManager: <debug info>^I[1223924512.007967]
nm_print_open_socks (): Open Sockets List Done. 
Oct 14 00:59:26 vano-linux kernel: NR_CPUS: 8, nr_cpu_ids: 4
Oct 14 00:59:26 vano-linux kernel: mapped APIC to ffffb000 (fee00000)
Oct 14 00:59:26 vano-linux kernel: mapped IOAPIC to ffffa000 (fec00000)
Oct 14 00:59:26 vano-linux kernel: CPA: page pool initialized 1 of 1 pages
preallocated
Oct 14 00:59:26 vano-linux kernel: CPU0 attaching sched-domain:
Oct 14 00:59:26 vano-linux kernel:  domain 0: span 0-1
Oct 14 00:59:26 vano-linux kernel:   groups: 0 1
Oct 14 00:59:26 vano-linux kernel: CPU1 attaching sched-domain:
Oct 14 00:59:26 vano-linux kernel:  domain 0: span 0-1
Oct 14 00:59:26 vano-linux kernel:   groups: 1 0
Oct 14 00:59:26 vano-linux kernel: ACPI: EC: Look up EC in DSDT
Oct 14 00:59:26 vano-linux kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0._PRT]
Oct 14 00:59:26 vano-linux kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.P0P1._PRT]
Oct 14 00:59:26 vano-linux kernel: libata version 3.00 loaded.
Oct 14 00:59:26 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1e.0 to 64
Oct 14 00:59:26 vano-linux kernel: pci 0000:00:02.0: Boot video device
Oct 14 00:59:26 vano-linux kernel: Switched to high resolution mode on CPU 1
Oct 14 00:59:26 vano-linux kernel: Switched to high resolution mode on CPU 0
Oct 14 00:59:26 vano-linux kernel: ata_piix 0000:00:1f.2: version 2.12
Oct 14 00:59:26 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1f.2 to 64
Oct 14 00:59:26 vano-linux kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Oct 14 00:59:26 vano-linux kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Oct 14 00:59:26 vano-linux kernel: sr 0:0:1:0: Attached scsi CD-ROM sr0
Oct 14 00:59:26 vano-linux kernel: eth0:  Identified 8139 chip type
'RTL-8100B/8139D'
Oct 14 00:59:26 vano-linux kernel: pata_via 0000:01:01.0: version 0.3.3
Oct 14 00:59:26 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.0 to 64
Oct 14 00:59:26 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.1 to 64
Oct 14 00:59:26 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.2 to 64
Oct 14 00:59:26 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.3 to 64
Oct 14 00:59:26 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.7 to 64
Oct 14 00:59:26 vano-linux kernel: PCI: cache line size of 32 is not supported
by device 0000:00:1d.7
Oct 14 00:59:26 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1b.0 to 64
Oct 14 00:59:26 vano-linux kernel: irda_init()
Oct 14 01:28:15 vano-linux kernel: ACPI: IRQ0 used by override.
Oct 14 01:28:15 vano-linux kernel: ACPI: IRQ2 used by override.
Oct 14 01:28:15 vano-linux kernel: ACPI: IRQ9 used by override.
Oct 14 01:28:15 vano-linux kernel: NR_CPUS: 8, nr_cpu_ids: 4
Oct 14 01:28:15 vano-linux kernel: mapped APIC to ffffb000 (fee00000)
Oct 14 01:28:15 vano-linux kernel: mapped IOAPIC to ffffa000 (fec00000)
Oct 14 01:28:15 vano-linux kernel: CPA: page pool initialized 1 of 1 pages
preallocated
Oct 14 01:28:15 vano-linux kernel: CPU0 attaching sched-domain:
Oct 14 01:28:15 vano-linux kernel:  domain 0: span 0-1
Oct 14 01:28:15 vano-linux kernel:   groups: 0 1
Oct 14 01:28:15 vano-linux kernel: CPU1 attaching sched-domain:
Oct 14 01:28:15 vano-linux kernel:  domain 0: span 0-1
Oct 14 01:28:15 vano-linux kernel:   groups: 1 0
Oct 14 01:28:15 vano-linux kernel: ACPI: EC: Look up EC in DSDT
Oct 14 01:28:15 vano-linux kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0._PRT]
Oct 14 01:28:15 vano-linux kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.P0P1._PRT]
Oct 14 01:28:15 vano-linux kernel: libata version 3.00 loaded.
Oct 14 01:28:15 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1e.0 to 64
Oct 14 01:28:15 vano-linux kernel: pci 0000:00:02.0: Boot video device
Oct 14 01:28:15 vano-linux kernel: Switched to high resolution mode on CPU 1
Oct 14 01:28:15 vano-linux kernel: Switched to high resolution mode on CPU 0
Oct 14 01:28:15 vano-linux kernel: ata_piix 0000:00:1f.2: version 2.12
Oct 14 01:28:15 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1f.2 to 64
Oct 14 01:28:15 vano-linux kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Oct 14 01:28:15 vano-linux kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Oct 14 01:28:15 vano-linux kernel: eth0:  Identified 8139 chip type
'RTL-8100B/8139D'
Oct 14 01:28:15 vano-linux kernel: pata_via 0000:01:01.0: version 0.3.3
Oct 14 01:28:15 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.0 to 64
Oct 14 01:28:15 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.1 to 64
Oct 14 01:28:15 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.2 to 64
Oct 14 01:28:15 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.3 to 64
Oct 14 01:28:15 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.7 to 64
Oct 14 01:28:15 vano-linux kernel: PCI: cache line size of 32 is not supported
by device 0000:00:1d.7
Oct 14 01:28:15 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1b.0 to 64
Oct 14 01:28:15 vano-linux kernel: irda_init()
Oct 14 01:28:24 vano-linux NetworkManager: <debug info>^I[1223929704.952758]
nm_hal_device_added (): New device added (hal udi is
'/org/freedesktop/Hal/devices/platform_bluetooth'). 
Oct 14 01:30:44 vano-linux NetworkManager: <debug info>^I[1223929844.489467]
nm_print_open_socks (): Open Sockets List: 
Oct 14 01:30:44 vano-linux NetworkManager: <debug info>^I[1223929844.489487]
nm_print_open_socks (): Open Sockets List Done. 
Oct 14 01:33:24 vano-linux kernel: ACPI: IRQ0 used by override.
Oct 14 01:33:24 vano-linux kernel: ACPI: IRQ2 used by override.
Oct 14 01:33:24 vano-linux kernel: ACPI: IRQ9 used by override.
Oct 14 01:33:24 vano-linux kernel: NR_CPUS: 8, nr_cpu_ids: 4
Oct 14 01:33:24 vano-linux kernel: mapped APIC to ffffb000 (fee00000)
Oct 14 01:33:24 vano-linux kernel: mapped IOAPIC to ffffa000 (fec00000)
Oct 14 01:33:24 vano-linux kernel: CPA: page pool initialized 1 of 1 pages
preallocated
Oct 14 01:33:24 vano-linux kernel: CPU0 attaching sched-domain:
Oct 14 01:33:24 vano-linux kernel:  domain 0: span 0-1
Oct 14 01:33:24 vano-linux kernel:   groups: 0 1
Oct 14 01:33:24 vano-linux kernel: CPU1 attaching sched-domain:
Oct 14 01:33:24 vano-linux kernel:  domain 0: span 0-1
Oct 14 01:33:24 vano-linux kernel:   groups: 1 0
Oct 14 01:33:24 vano-linux kernel: ACPI: EC: Look up EC in DSDT
Oct 14 01:33:24 vano-linux kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0._PRT]
Oct 14 01:33:24 vano-linux kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.P0P1._PRT]
Oct 14 01:33:24 vano-linux kernel: libata version 3.00 loaded.
Oct 14 01:33:24 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1e.0 to 64
Oct 14 01:33:24 vano-linux kernel: pci 0000:00:02.0: Boot video device
Oct 14 01:33:24 vano-linux kernel: Switched to high resolution mode on CPU 1
Oct 14 01:33:24 vano-linux kernel: Switched to high resolution mode on CPU 0
Oct 14 01:33:24 vano-linux kernel: ata_piix 0000:00:1f.2: version 2.12
Oct 14 01:33:24 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1f.2 to 64
Oct 14 01:33:24 vano-linux kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Oct 14 01:33:24 vano-linux kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Oct 14 01:33:24 vano-linux kernel: eth0:  Identified 8139 chip type
'RTL-8100B/8139D'
Oct 14 01:33:24 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.7 to 64
Oct 14 01:33:24 vano-linux kernel: PCI: cache line size of 32 is not supported
by device 0000:00:1d.7
Oct 14 01:33:24 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.0 to 64
Oct 14 01:33:24 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.1 to 64
Oct 14 01:33:24 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.2 to 64
Oct 14 01:33:24 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.3 to 64
Oct 14 01:33:24 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1b.0 to 64
Oct 14 01:33:24 vano-linux kernel: pata_via 0000:01:01.0: version 0.3.3
Oct 14 01:33:24 vano-linux kernel: irda_init()
Oct 14 01:50:49 vano-linux kernel: ACPI: IRQ0 used by override.
Oct 14 01:50:49 vano-linux kernel: ACPI: IRQ2 used by override.
Oct 14 01:50:49 vano-linux kernel: ACPI: IRQ9 used by override.
Oct 14 01:50:49 vano-linux kernel: NR_CPUS: 8, nr_cpu_ids: 4
Oct 14 01:50:49 vano-linux kernel: mapped APIC to ffffb000 (fee00000)
Oct 14 01:50:49 vano-linux kernel: mapped IOAPIC to ffffa000 (fec00000)
Oct 14 01:50:49 vano-linux kernel: CPA: page pool initialized 1 of 1 pages
preallocated
Oct 14 01:50:49 vano-linux kernel: CPU0 attaching sched-domain:
Oct 14 01:50:49 vano-linux kernel:  domain 0: span 0-1
Oct 14 01:50:49 vano-linux kernel:   groups: 0 1
Oct 14 01:50:49 vano-linux kernel: CPU1 attaching sched-domain:
Oct 14 01:50:49 vano-linux kernel:  domain 0: span 0-1
Oct 14 01:50:49 vano-linux kernel:   groups: 1 0
Oct 14 01:50:49 vano-linux kernel: ACPI: EC: Look up EC in DSDT
Oct 14 01:50:49 vano-linux kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0._PRT]
Oct 14 01:50:49 vano-linux kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.P0P1._PRT]
Oct 14 01:50:49 vano-linux kernel: libata version 3.00 loaded.
Oct 14 01:50:49 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1e.0 to 64
Oct 14 01:50:49 vano-linux kernel: pci 0000:00:02.0: Boot video device
Oct 14 01:50:49 vano-linux kernel: Switched to high resolution mode on CPU 1
Oct 14 01:50:49 vano-linux kernel: Switched to high resolution mode on CPU 0
Oct 14 01:50:49 vano-linux kernel: ata_piix 0000:00:1f.2: version 2.12
Oct 14 01:50:49 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1f.2 to 64
Oct 14 01:50:49 vano-linux kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Oct 14 01:50:49 vano-linux kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Oct 14 01:50:49 vano-linux kernel: pata_via 0000:01:01.0: version 0.3.3
Oct 14 01:50:49 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.0 to 64
Oct 14 01:50:49 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.1 to 64
Oct 14 01:50:49 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.2 to 64
Oct 14 01:50:49 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.3 to 64
Oct 14 01:50:49 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.7 to 64
Oct 14 01:50:49 vano-linux kernel: PCI: cache line size of 32 is not supported
by device 0000:00:1d.7
Oct 14 01:50:49 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1b.0 to 64
Oct 14 01:50:49 vano-linux kernel: eth0:  Identified 8139 chip type
'RTL-8100B/8139D'
Oct 14 01:50:49 vano-linux kernel: irda_init()
Oct 14 01:50:58 vano-linux NetworkManager: <debug info>^I[1223931058.905585]
nm_hal_device_added (): New device added (hal udi is
'/org/freedesktop/Hal/devices/platform_bluetooth'). 
Oct 14 01:52:52 vano-linux pppd[3424]: using channel 1
Oct 14 01:52:54 vano-linux pppd[3424]: sent [LCP ConfReq id=0x1 <asyncmap 0x0>
<magic 0xbf1cb84d> <pcomp> <accomp>]
Oct 14 01:52:54 vano-linux pppd[3424]: rcvd [LCP ConfReq id=0x61 <asyncmap
0xa0000> <auth pap> <magic 0xbb5c3c4e> <pcomp> <accomp>]
Oct 14 01:52:54 vano-linux pppd[3424]: sent [LCP ConfAck id=0x61 <asyncmap
0xa0000> <auth pap> <magic 0xbb5c3c4e> <pcomp> <accomp>]
Oct 14 01:52:54 vano-linux pppd[3424]: rcvd [LCP ConfAck id=0x1 <asyncmap 0x0>
<magic 0xbf1cb84d> <pcomp> <accomp>]
Oct 14 01:52:54 vano-linux pppd[3424]: sent [LCP EchoReq id=0x0
magic=0xbf1cb84d]
Oct 14 01:52:54 vano-linux pppd[3424]: sent [PAP AuthReq id=0x1 user="userok"
password=<hidden>]
Oct 14 01:52:54 vano-linux pppd[3424]: rcvd [LCP EchoRep id=0x0
magic=0xbb5c3c4e]
Oct 14 01:52:54 vano-linux pppd[3424]: rcvd [PAP AuthAck id=0x1 ""]
Oct 14 01:52:54 vano-linux pppd[3424]: sent [CCP ConfReq id=0x1 <deflate 15>
<deflate(old#) 15> <bsd v1 15>]
Oct 14 01:52:54 vano-linux pppd[3424]: sent [IPCP ConfReq id=0x1 <compress VJ
0f 01> <addr 0.0.0.0> <ms-dns1 0.0.0.0> <ms-dns3 0.0.0.0>]
Oct 14 01:52:54 vano-linux pppd[3424]: rcvd [IPCP ConfReq id=0x1 <compress VJ
0f 00> <addr 172.16.234.12>]
Oct 14 01:52:54 vano-linux pppd[3424]: sent [IPCP ConfAck id=0x1 <compress VJ
0f 00> <addr 172.16.234.12>]
Oct 14 01:52:55 vano-linux pppd[3424]: rcvd [LCP ProtRej id=0x62 80 fd 01 01 00
0f 1a 04 78 00 18 04 78 00 15 03 2f]
Oct 14 01:52:55 vano-linux pppd[3424]: Protocol-Reject for 'Compression Control
Protocol' (0x80fd) received
Oct 14 01:52:55 vano-linux pppd[3424]: rcvd [IPCP ConfNak id=0x1 <addr
94.158.56.236> <ms-dns1 94.158.48.2> <ms-dns3 94.158.48.1>]
Oct 14 01:52:55 vano-linux pppd[3424]: sent [IPCP ConfReq id=0x2 <compress VJ
0f 01> <addr 94.158.56.236> <ms-dns1 94.158.48.2> <ms-dns3 94.158.48.1>]
Oct 14 01:52:55 vano-linux pppd[3424]: rcvd [IPCP ConfAck id=0x2 <compress VJ
0f 01> <addr 94.158.56.236> <ms-dns1 94.158.48.2> <ms-dns3 94.158.48.1>]
Oct 14 01:52:55 vano-linux pppd[3424]: Script /etc/ppp/ip-up started (pid 3448)
Oct 14 01:52:57 vano-linux pppd[3424]: Script /etc/ppp/ip-up finished (pid
3448), status = 0x0
Oct 14 02:05:55 vano-linux pppd[3424]: Script /etc/ppp/ip-down started (pid
3549)
Oct 14 02:05:55 vano-linux pppd[3424]: sent [LCP TermReq id=0x2 "User request"]
Oct 14 02:05:55 vano-linux pppd[3424]: Script /etc/ppp/ip-down finished (pid
3549), status = 0x0
Oct 14 02:05:55 vano-linux pppd[3424]: rcvd [LCP TermAck id=0x2]
Oct 14 02:19:22 vano-linux kernel: usb-storage: device found at 3
Oct 14 02:19:22 vano-linux kernel: usb-storage: waiting for device to settle
before scanning
Oct 14 02:19:27 vano-linux kernel: sd 4:0:0:0: [sdb] Mode Sense: 00 00 00 00
Oct 14 02:19:27 vano-linux kernel: sd 4:0:0:0: [sdb] Mode Sense: 00 00 00 00
Oct 14 02:19:28 vano-linux kernel: usb-storage: device scan complete
Oct 14 02:20:49 vano-linux kernel: usb-storage: device found at 4
Oct 14 02:20:49 vano-linux kernel: usb-storage: waiting for device to settle
before scanning
Oct 14 02:20:54 vano-linux kernel: sd 5:0:0:0: [sdb] Mode Sense: 00 00 00 00
Oct 14 02:20:54 vano-linux kernel: sd 5:0:0:0: [sdb] Mode Sense: 00 00 00 00
Oct 14 02:20:55 vano-linux kernel: usb-storage: device scan complete
Oct 14 02:24:14 vano-linux kernel: ACPI: IRQ0 used by override.
Oct 14 02:24:14 vano-linux kernel: ACPI: IRQ2 used by override.
Oct 14 02:24:14 vano-linux kernel: ACPI: IRQ9 used by override.
Oct 14 02:24:14 vano-linux kernel: NR_CPUS: 8, nr_cpu_ids: 4
Oct 14 02:24:14 vano-linux kernel: mapped APIC to ffffb000 (fee00000)
Oct 14 02:24:14 vano-linux kernel: mapped IOAPIC to ffffa000 (fec00000)
Oct 14 02:24:14 vano-linux kernel: CPA: page pool initialized 1 of 1 pages
preallocated
Oct 14 02:24:14 vano-linux kernel: CPU0 attaching sched-domain:
Oct 14 02:24:14 vano-linux kernel:  domain 0: span 0-1
Oct 14 02:24:14 vano-linux kernel:   groups: 0 1
Oct 14 02:24:14 vano-linux kernel: CPU1 attaching sched-domain:
Oct 14 02:24:14 vano-linux kernel:  domain 0: span 0-1
Oct 14 02:24:14 vano-linux kernel:   groups: 1 0
Oct 14 02:24:14 vano-linux kernel: ACPI: EC: Look up EC in DSDT
Oct 14 02:24:14 vano-linux kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0._PRT]
Oct 14 02:24:14 vano-linux kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.P0P1._PRT]
Oct 14 02:24:14 vano-linux kernel: libata version 3.00 loaded.
Oct 14 02:24:14 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1e.0 to 64
Oct 14 02:24:14 vano-linux kernel: pci 0000:00:02.0: Boot video device
Oct 14 02:24:14 vano-linux kernel: Switched to high resolution mode on CPU 1
Oct 14 02:24:14 vano-linux kernel: Switched to high resolution mode on CPU 0
Oct 14 02:24:14 vano-linux kernel: ata_piix 0000:00:1f.2: version 2.12
Oct 14 02:24:14 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1f.2 to 64
Oct 14 02:24:14 vano-linux kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Oct 14 02:24:14 vano-linux kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Oct 14 02:24:14 vano-linux kernel: eth0:  Identified 8139 chip type
'RTL-8100B/8139D'
Oct 14 02:24:14 vano-linux kernel: pata_via 0000:01:01.0: version 0.3.3
Oct 14 02:24:14 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.0 to 64
Oct 14 02:24:14 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.1 to 64
Oct 14 02:24:14 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.2 to 64
Oct 14 02:24:14 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.3 to 64
Oct 14 02:24:14 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.7 to 64
Oct 14 02:24:14 vano-linux kernel: PCI: cache line size of 32 is not supported
by device 0000:00:1d.7
Oct 14 02:24:14 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1b.0 to 64
Oct 14 02:24:14 vano-linux kernel: irda_init()
Oct 14 02:25:38 vano-linux kernel: pata_via 0000:01:01.0: version 0.3.3
Oct 14 02:25:38 vano-linux NetworkManager: <debug info>^I[1223933138.036312]
nm_hal_device_added (): New device added (hal udi is
'/org/freedesktop/Hal/devices/pci_1106_3164_scsi_host'). 
Oct 14 02:25:38 vano-linux NetworkManager: <debug info>^I[1223933138.047379]
nm_hal_device_added (): New device added (hal udi is
'/org/freedesktop/Hal/devices/pci_1106_3164_scsi_host_0'). 
Oct 14 02:28:46 vano-linux kernel: usb-storage: device found at 3
Oct 14 02:28:46 vano-linux kernel: usb-storage: waiting for device to settle
before scanning
Oct 14 02:28:51 vano-linux kernel: sd 6:0:0:0: [sdb] Mode Sense: 23 00 00 00
Oct 14 02:28:51 vano-linux kernel: sd 6:0:0:0: [sdb] Mode Sense: 23 00 00 00
Oct 14 02:28:51 vano-linux kernel: usb-storage: device scan complete
Oct 14 02:33:09 vano-linux pppd[5486]: using channel 1
Oct 14 02:33:11 vano-linux pppd[5486]: sent [LCP ConfReq id=0x1 <asyncmap 0x0>
<magic 0xeda4a6bb> <pcomp> <accomp>]
Oct 14 02:33:11 vano-linux pppd[5486]: rcvd [LCP ConfReq id=0xb2 <asyncmap
0xa0000> <auth pap> <magic 0xdb76219b> <pcomp> <accomp>]
Oct 14 02:33:11 vano-linux pppd[5486]: sent [LCP ConfAck id=0xb2 <asyncmap
0xa0000> <auth pap> <magic 0xdb76219b> <pcomp> <accomp>]
Oct 14 02:33:11 vano-linux pppd[5486]: rcvd [LCP ConfAck id=0x1 <asyncmap 0x0>
<magic 0xeda4a6bb> <pcomp> <accomp>]
Oct 14 02:33:11 vano-linux pppd[5486]: sent [LCP EchoReq id=0x0
magic=0xeda4a6bb]
Oct 14 02:33:11 vano-linux pppd[5486]: sent [PAP AuthReq id=0x1 user="userok"
password=<hidden>]
Oct 14 02:33:12 vano-linux pppd[5486]: rcvd [LCP EchoRep id=0x0
magic=0xdb76219b]
Oct 14 02:33:12 vano-linux pppd[5486]: rcvd [PAP AuthAck id=0x1 ""]
Oct 14 02:33:12 vano-linux pppd[5486]: sent [CCP ConfReq id=0x1 <deflate 15>
<deflate(old#) 15> <bsd v1 15>]
Oct 14 02:33:12 vano-linux pppd[5486]: sent [IPCP ConfReq id=0x1 <compress VJ
0f 01> <addr 0.0.0.0> <ms-dns1 0.0.0.0> <ms-dns3 0.0.0.0>]
Oct 14 02:33:12 vano-linux pppd[5486]: rcvd [IPCP ConfReq id=0x1 <compress VJ
0f 00> <addr 172.16.234.11>]
Oct 14 02:33:12 vano-linux pppd[5486]: sent [IPCP ConfAck id=0x1 <compress VJ
0f 00> <addr 172.16.234.11>]
Oct 14 02:33:12 vano-linux pppd[5486]: rcvd [LCP ProtRej id=0xb3 80 fd 01 01 00
0f 1a 04 78 00 18 04 78 00 15 03 2f]
Oct 14 02:33:12 vano-linux pppd[5486]: Protocol-Reject for 'Compression Control
Protocol' (0x80fd) received
Oct 14 02:33:12 vano-linux pppd[5486]: rcvd [IPCP ConfNak id=0x1 <addr
94.158.55.178> <ms-dns1 94.158.48.2> <ms-dns3 94.158.48.1>]
Oct 14 02:33:12 vano-linux pppd[5486]: sent [IPCP ConfReq id=0x2 <compress VJ
0f 01> <addr 94.158.55.178> <ms-dns1 94.158.48.2> <ms-dns3 94.158.48.1>]
Oct 14 02:33:12 vano-linux pppd[5486]: rcvd [IPCP ConfAck id=0x2 <compress VJ
0f 01> <addr 94.158.55.178> <ms-dns1 94.158.48.2> <ms-dns3 94.158.48.1>]
Oct 14 02:33:12 vano-linux pppd[5486]: Script /etc/ppp/ip-up started (pid 5529)
Oct 14 02:33:13 vano-linux pppd[5486]: Script /etc/ppp/ip-up finished (pid
5529), status = 0x0
Oct 14 03:03:48 vano-linux pppd[5486]: Script /etc/ppp/ip-down started (pid
5696)
Oct 14 03:03:48 vano-linux pppd[5486]: sent [LCP TermReq id=0x2 "User request"]
Oct 14 03:03:48 vano-linux pppd[5486]: Script /etc/ppp/ip-down finished (pid
5696), status = 0x0
Oct 14 03:03:48 vano-linux pppd[5486]: rcvd [LCP TermAck id=0x2]
Oct 14 03:48:20 vano-linux NetworkManager: <debug info>^I[1223938100.372020]
nm_print_open_socks (): Open Sockets List: 
Oct 14 03:48:20 vano-linux NetworkManager: <debug info>^I[1223938100.372039]
nm_print_open_socks (): Open Sockets List Done. 
Oct 14 03:48:54 vano-linux kernel: ACPI: IRQ0 used by override.
Oct 14 03:48:54 vano-linux kernel: ACPI: IRQ2 used by override.
Oct 14 03:48:54 vano-linux kernel: ACPI: IRQ9 used by override.
Oct 14 03:48:54 vano-linux kernel: NR_CPUS: 8, nr_cpu_ids: 4
Oct 14 03:48:54 vano-linux kernel: mapped APIC to ffffb000 (fee00000)
Oct 14 03:48:54 vano-linux kernel: mapped IOAPIC to ffffa000 (fec00000)
Oct 14 03:48:54 vano-linux kernel: CPA: page pool initialized 1 of 1 pages
preallocated
Oct 14 03:48:54 vano-linux kernel: CPU0 attaching sched-domain:
Oct 14 03:48:54 vano-linux kernel:  domain 0: span 0-1
Oct 14 03:48:54 vano-linux kernel:   groups: 0 1
Oct 14 03:48:54 vano-linux kernel: CPU1 attaching sched-domain:
Oct 14 03:48:54 vano-linux kernel:  domain 0: span 0-1
Oct 14 03:48:54 vano-linux kernel:   groups: 1 0
Oct 14 03:48:54 vano-linux kernel: ACPI: EC: Look up EC in DSDT
Oct 14 03:48:54 vano-linux kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0._PRT]
Oct 14 03:48:54 vano-linux kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.P0P1._PRT]
Oct 14 03:48:54 vano-linux kernel: libata version 3.00 loaded.
Oct 14 03:48:54 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1e.0 to 64
Oct 14 03:48:54 vano-linux kernel: pci 0000:00:02.0: Boot video device
Oct 14 03:48:54 vano-linux kernel: Switched to high resolution mode on CPU 1
Oct 14 03:48:54 vano-linux kernel: Switched to high resolution mode on CPU 0
Oct 14 03:48:54 vano-linux kernel: ata_piix 0000:00:1f.2: version 2.12
Oct 14 03:48:54 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1f.2 to 64
Oct 14 03:48:54 vano-linux kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Oct 14 03:48:54 vano-linux kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Oct 14 03:48:54 vano-linux kernel: pata_via 0000:01:01.0: version 0.3.3
Oct 14 03:48:54 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.0 to 64
Oct 14 03:48:54 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.1 to 64
Oct 14 03:48:54 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.2 to 64
Oct 14 03:48:54 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.3 to 64
Oct 14 03:48:54 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.7 to 64
Oct 14 03:48:54 vano-linux kernel: PCI: cache line size of 32 is not supported
by device 0000:00:1d.7
Oct 14 03:48:54 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1b.0 to 64
Oct 14 03:48:54 vano-linux kernel: eth0:  Identified 8139 chip type
'RTL-8100B/8139D'
Oct 14 03:48:54 vano-linux kernel: irda_init()
Oct 14 03:49:02 vano-linux NetworkManager: <debug info>^I[1223938142.848736]
nm_hal_device_added (): New device added (hal udi is
'/org/freedesktop/Hal/devices/platform_bluetooth'). 
Oct 14 03:52:16 vano-linux NetworkManager: <debug info>^I[1223938336.578030]
nm_print_open_socks (): Open Sockets List: 
Oct 14 03:52:16 vano-linux NetworkManager: <debug info>^I[1223938336.578050]
nm_print_open_socks (): Open Sockets List Done. 
Oct 14 08:12:26 vano-linux kernel: ACPI: IRQ0 used by override.
Oct 14 08:12:26 vano-linux kernel: ACPI: IRQ2 used by override.
Oct 14 08:12:26 vano-linux kernel: ACPI: IRQ9 used by override.
Oct 14 08:12:26 vano-linux kernel: NR_CPUS: 8, nr_cpu_ids: 4
Oct 14 08:12:26 vano-linux kernel: mapped APIC to ffffb000 (fee00000)
Oct 14 08:12:26 vano-linux kernel: mapped IOAPIC to ffffa000 (fec00000)
Oct 14 08:12:26 vano-linux kernel: CPA: page pool initialized 1 of 1 pages
preallocated
Oct 14 08:12:26 vano-linux kernel: CPU0 attaching sched-domain:
Oct 14 08:12:26 vano-linux kernel:  domain 0: span 0-1
Oct 14 08:12:26 vano-linux kernel:   groups: 0 1
Oct 14 08:12:26 vano-linux kernel: CPU1 attaching sched-domain:
Oct 14 08:12:26 vano-linux kernel:  domain 0: span 0-1
Oct 14 08:12:26 vano-linux kernel:   groups: 1 0
Oct 14 08:12:26 vano-linux kernel: ACPI: EC: Look up EC in DSDT
Oct 14 08:12:26 vano-linux kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0._PRT]
Oct 14 08:12:26 vano-linux kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.P0P1._PRT]
Oct 14 08:12:26 vano-linux kernel: libata version 3.00 loaded.
Oct 14 08:12:26 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1e.0 to 64
Oct 14 08:12:26 vano-linux kernel: pci 0000:00:02.0: Boot video device
Oct 14 08:12:26 vano-linux kernel: Switched to high resolution mode on CPU 1
Oct 14 08:12:26 vano-linux kernel: Switched to high resolution mode on CPU 0
Oct 14 08:12:26 vano-linux kernel: ata_piix 0000:00:1f.2: version 2.12
Oct 14 08:12:26 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1f.2 to 64
Oct 14 08:12:26 vano-linux kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Oct 14 08:12:26 vano-linux kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Oct 14 08:12:26 vano-linux kernel: pata_via 0000:01:01.0: version 0.3.3
Oct 14 08:12:26 vano-linux kernel: eth0:  Identified 8139 chip type
'RTL-8100B/8139D'
Oct 14 08:12:26 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.0 to 64
Oct 14 08:12:26 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.1 to 64
Oct 14 08:12:26 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.2 to 64
Oct 14 08:12:26 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.3 to 64
Oct 14 08:12:26 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.7 to 64
Oct 14 08:12:26 vano-linux kernel: PCI: cache line size of 32 is not supported
by device 0000:00:1d.7
Oct 14 08:12:26 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1b.0 to 64
Oct 14 08:12:26 vano-linux kernel: irda_init()
Oct 14 08:12:35 vano-linux NetworkManager: <debug info>^I[1223953955.815939]
nm_hal_device_added (): New device added (hal udi is
'/org/freedesktop/Hal/devices/platform_bluetooth'). 
Oct 14 08:18:04 vano-linux NetworkManager: <debug info>^I[1223954284.130193]
nm_print_open_socks (): Open Sockets List: 
Oct 14 08:18:04 vano-linux NetworkManager: <debug info>^I[1223954284.130213]
nm_print_open_socks (): Open Sockets List Done. 
Oct 14 22:52:50 vano-linux kernel: CPA: page pool initialized 1 of 1 pages
preallocated
Oct 14 22:52:50 vano-linux kernel: CPU0 attaching sched-domain:
Oct 14 22:52:50 vano-linux kernel:  domain 0: span 0-1
Oct 14 22:52:50 vano-linux kernel:   groups: 0 1
Oct 14 22:52:50 vano-linux kernel: CPU1 attaching sched-domain:
Oct 14 22:52:50 vano-linux kernel:  domain 0: span 0-1
Oct 14 22:52:50 vano-linux kernel:   groups: 1 0
Oct 14 22:52:50 vano-linux kernel: ACPI: EC: Look up EC in DSDT
Oct 14 22:52:50 vano-linux kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0._PRT]
Oct 14 22:52:50 vano-linux kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.P0P1._PRT]
Oct 14 22:52:50 vano-linux kernel: libata version 3.00 loaded.
Oct 14 22:52:50 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1e.0 to 64
Oct 14 22:52:50 vano-linux kernel: pci 0000:00:02.0: Boot video device
Oct 14 22:52:50 vano-linux kernel: Switched to high resolution mode on CPU 1
Oct 14 22:52:50 vano-linux kernel: Switched to high resolution mode on CPU 0
Oct 14 22:52:50 vano-linux kernel: ata_piix 0000:00:1f.2: version 2.12
Oct 14 22:52:50 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1f.2 to 64
Oct 14 22:52:50 vano-linux kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Oct 14 22:52:50 vano-linux kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Oct 14 22:52:50 vano-linux kernel: sr 0:0:1:0: Attached scsi CD-ROM sr0
Oct 14 22:52:50 vano-linux kernel: pata_via 0000:01:01.0: version 0.3.3
Oct 14 22:52:50 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.7 to 64
Oct 14 22:52:50 vano-linux kernel: PCI: cache line size of 32 is not supported
by device 0000:00:1d.7
Oct 14 22:52:50 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.0 to 64
Oct 14 22:52:50 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.1 to 64
Oct 14 22:52:50 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.2 to 64
Oct 14 22:52:50 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1d.3 to 64
Oct 14 22:52:50 vano-linux kernel: eth0:  Identified 8139 chip type
'RTL-8100B/8139D'
Oct 14 22:52:50 vano-linux kernel: PCI: Setting latency timer of device
0000:00:1b.0 to 64
Oct 14 22:52:50 vano-linux kernel: usb-storage: device found at 3
Oct 14 22:52:50 vano-linux kernel: usb-storage: waiting for device to settle
before scanning
Oct 14 22:52:50 vano-linux kernel: irda_init()
Oct 14 22:52:50 vano-linux kernel: sd 4:0:0:0: [sdb] Mode Sense: 23 00 80 00
Oct 14 22:52:50 vano-linux kernel: sd 4:0:0:0: [sdb] Mode Sense: 23 00 80 00
Oct 14 22:52:50 vano-linux kernel: usb-storage: device scan complete
Oct 14 22:52:59 vano-linux NetworkManager: <debug info>^I[1224006779.184846]
nm_hal_device_added (): New device added (hal udi is
'/org/freedesktop/Hal/devices/platform_bluetooth'). 
Oct 14 22:59:28 vano-linux pppd[4625]: using channel 1
Oct 14 22:59:29 vano-linux pppd[4625]: sent [LCP ConfReq id=0x1 <asyncmap 0x0>
<callback CBCP> <magic 0xbe5ff9af> <pcomp> <accomp>]
Oct 14 22:59:29 vano-linux pppd[4625]: rcvd [LCP ConfReq id=0xa4 <asyncmap
0xa0000> <auth pap> <magic 0xbfad0158> <pcomp> <accomp>]
Oct 14 22:59:29 vano-linux pppd[4625]: sent [LCP ConfAck id=0xa4 <asyncmap
0xa0000> <auth pap> <magic 0xbfad0158> <pcomp> <accomp>]
Oct 14 22:59:29 vano-linux pppd[4625]: rcvd [LCP ConfAck id=0x1 <asyncmap 0x0>
<callback CBCP> <magic 0xbe5ff9af> <pcomp> <accomp>]
Oct 14 22:59:29 vano-linux pppd[4625]: sent [LCP EchoReq id=0x0
magic=0xbe5ff9af]
Oct 14 22:59:29 vano-linux pppd[4625]: cbcp_lowerup
Oct 14 22:59:29 vano-linux pppd[4625]: want: 14
Oct 14 22:59:29 vano-linux pppd[4625]: sent [PAP AuthReq id=0x1
user="userok:callback" password=<hidden>]
Oct 14 22:59:29 vano-linux pppd[4625]: rcvd [LCP EchoRep id=0x0
magic=0xbfad0158]
Oct 14 22:59:30 vano-linux pppd[4625]: rcvd [PAP AuthAck id=0x1 ""]
Oct 14 22:59:30 vano-linux pppd[4625]: cbcp_open
Oct 14 22:59:30 vano-linux pppd[4625]: rcvd [CBCP Request id=0x32 < UserDefined
delay = 0 number = >] 00
Oct 14 22:59:30 vano-linux pppd[4625]: length: 5
Oct 14 22:59:30 vano-linux pppd[4625]: user callback allowed
Oct 14 22:59:30 vano-linux pppd[4625]: cbcp_resp cb_type=4
Oct 14 22:59:30 vano-linux pppd[4625]: cbcp_resp CONF_USER
Oct 14 22:59:30 vano-linux pppd[4625]: sent [CBCP Response id=0x32 <
UserDefined delay = 5 number = 2896574>] 32 38 39 36 35 37 34 00
Oct 14 22:59:30 vano-linux pppd[4625]: rcvd [IPCP ConfReq id=0x1 <compress VJ
0f 00> <addr 172.16.234.12>]
Oct 14 22:59:30 vano-linux pppd[4625]: sent [IPCP TermAck id=0x1]
Oct 14 22:59:30 vano-linux pppd[4625]: rcvd [CBCP Ack id=0x32 < UserDefined
delay = 5 number = 2896574>] 32 38 39 36 35 37 34 00
Oct 14 22:59:30 vano-linux pppd[4625]: peer will call: 2896574
Oct 14 22:59:30 vano-linux pppd[4625]: sent [LCP TermReq id=0x2 "Call me back,
please"]
Oct 14 22:59:30 vano-linux pppd[4625]: rcvd [LCP TermAck id=0x2]
Oct 14 23:00:03 vano-linux pppd[4635]: using channel 2
Oct 14 23:00:04 vano-linux pppd[4635]: sent [LCP ConfReq id=0x1 <asyncmap 0x0>
<magic 0xd58c23de> <pcomp> <accomp>]
Oct 14 23:00:04 vano-linux pppd[4635]: rcvd [LCP ConfReq id=0xa5 <asyncmap
0xa0000> <auth pap> <magic 0xbfad8ac0> <pcomp> <accomp>]
Oct 14 23:00:04 vano-linux pppd[4635]: sent [LCP ConfAck id=0xa5 <asyncmap
0xa0000> <auth pap> <magic 0xbfad8ac0> <pcomp> <accomp>]
Oct 14 23:00:04 vano-linux pppd[4635]: rcvd [LCP ConfAck id=0x1 <asyncmap 0x0>
<magic 0xd58c23de> <pcomp> <accomp>]
Oct 14 23:00:04 vano-linux pppd[4635]: sent [LCP EchoReq id=0x0
magic=0xd58c23de]
Oct 14 23:00:04 vano-linux pppd[4635]: sent [PAP AuthReq id=0x1
user="userok:callback" password=<hidden>]
Oct 14 23:00:05 vano-linux pppd[4635]: rcvd [LCP EchoRep id=0x0
magic=0xbfad8ac0]
Oct 14 23:00:05 vano-linux pppd[4635]: rcvd [PAP AuthAck id=0x1 ""]
Oct 14 23:00:05 vano-linux pppd[4635]: sent [CCP ConfReq id=0x1 <deflate 15>
<deflate(old#) 15>]
Oct 14 23:00:05 vano-linux pppd[4635]: sent [IPCP ConfReq id=0x1 <compress VJ
0f 01> <addr 0.0.0.0> <ms-dns1 0.0.0.0> <ms-dns3 0.0.0.0>]
Oct 14 23:00:05 vano-linux pppd[4635]: rcvd [IPCP ConfReq id=0x1 <compress VJ
0f 00> <addr 172.16.234.12>]
Oct 14 23:00:05 vano-linux pppd[4635]: sent [IPCP ConfAck id=0x1 <compress VJ
0f 00> <addr 172.16.234.12>]
Oct 14 23:00:05 vano-linux pppd[4635]: rcvd [LCP ProtRej id=0xa6 80 fd 01 01 00
0c 1a 04 78 00 18 04 78 00]
Oct 14 23:00:05 vano-linux pppd[4635]: Protocol-Reject for 'Compression Control
Protocol' (0x80fd) received
Oct 14 23:00:05 vano-linux pppd[4635]: rcvd [IPCP ConfNak id=0x1 <addr
94.158.56.149> <ms-dns1 94.158.48.2> <ms-dns3 94.158.48.1>]
Oct 14 23:00:05 vano-linux pppd[4635]: sent [IPCP ConfReq id=0x2 <compress VJ
0f 01> <addr 94.158.56.149> <ms-dns1 94.158.48.2> <ms-dns3 94.158.48.1>]
Oct 14 23:00:05 vano-linux pppd[4635]: rcvd [IPCP ConfAck id=0x2 <compress VJ
0f 01> <addr 94.158.56.149> <ms-dns1 94.158.48.2> <ms-dns3 94.158.48.1>]
Oct 14 23:00:05 vano-linux pppd[4635]: Script /etc/ppp/ip-up started (pid 4659)
Oct 14 23:00:06 vano-linux pppd[4635]: Script /etc/ppp/ip-up finished (pid
4659), status = 0x0
Oct 14 23:00:45 vano-linux kernel: usb-storage: device found at 4
Oct 14 23:00:45 vano-linux kernel: usb-storage: waiting for device to settle
before scanning
Oct 14 23:00:50 vano-linux kernel: sd 5:0:0:0: [sdb] Mode Sense: 23 00 00 00
Oct 14 23:00:50 vano-linux kernel: sd 5:0:0:0: [sdb] Mode Sense: 23 00 00 00
Oct 14 23:00:50 vano-linux kernel: usb-storage: device scan complete
Oct 14 23:05:07 vano-linux pppd[4635]: Script /etc/ppp/ip-down started (pid
4812)
Oct 14 23:05:07 vano-linux pppd[4635]: sent [LCP TermReq id=0x2 "User request"]
Oct 14 23:05:07 vano-linux pppd[4635]: Script /etc/ppp/ip-down finished (pid
4812), status = 0x0
Oct 14 23:05:07 vano-linux pppd[4635]: rcvd [LCP TermAck id=0x2]
Oct 14 23:27:56 vano-linux NetworkManager: <debug info>^I[1224008876.405652]
nm_print_open_socks (): Open Sockets List: 
Oct 14 23:27:56 vano-linux NetworkManager: <debug info>^I[1224008876.405672]
nm_print_open_socks (): Open Sockets List Done. 
Oct 14 23:28:32 vano-linux kernel: PCI: 0000:00:02.0 reg 10 32bit mmio:
[fea80000, feafffff]
Oct 14 23:28:32 vano-linux kernel: PCI: 0000:00:02.0 reg 14 io port: [dc00,
dc07]
Oct 14 23:28:32 vano-linux kernel: PCI: 0000:00:02.0 reg 18 32bit mmio:
[d0000000, dfffffff]
Oct 14 23:28:32 vano-linux kernel: PCI: 0000:00:02.0 reg 1c 32bit mmio:
[fe900000, fe9fffff]
Oct 14 23:28:32 vano-linux kernel: PCI: 0000:00:1b.0 reg 10 64bit mmio:
[fea78000, fea7bfff]
Oct 14 23:28:32 vano-linux kernel: PCI: 0000:00:1d.0 reg 20 io port: [d880,
d89f]
Oct 14 23:28:32 vano-linux kernel: PCI: 0000:00:1d.1 reg 20 io port: [d800,
d81f]
Oct 14 23:28:32 vano-linux kernel: PCI: 0000:00:1d.2 reg 20 io port: [d480,
d49f]
Oct 14 23:28:32 vano-linux kernel: PCI: 0000:00:1d.3 reg 20 io port: [d400,
d41f]
Oct 14 23:28:32 vano-linux kernel: PCI: 0000:00:1d.7 reg 10 32bit mmio:
[fea77c00, fea77fff]
Oct 14 23:28:32 vano-linux kernel: PCI: 0000:00:1f.2 reg 10 io port: [0, 7]
Oct 14 23:28:32 vano-linux kernel: PCI: 0000:00:1f.2 reg 14 io port: [0, 3]
Oct 14 23:28:32 vano-linux kernel: PCI: 0000:00:1f.2 reg 18 io port: [0, 7]
Oct 14 23:28:32 vano-linux kernel: PCI: 0000:00:1f.2 reg 1c io port: [0, 3]
Oct 14 23:28:32 vano-linux kernel: PCI: 0000:00:1f.2 reg 20 io port: [ffa0,
ffaf]
Oct 14 23:28:32 vano-linux kernel: PCI: 0000:00:1f.3 reg 20 io port: [400, 41f]
Oct 14 23:28:32 vano-linux kernel: PCI: 0000:01:00.0 reg 10 32bit mmio:
[febffc00, febfffff]
Oct 14 23:28:32 vano-linux kernel: pci 0000:01:00.0: supports D1
Oct 14 23:28:32 vano-linux kernel: pci 0000:01:00.0: supports D2
Oct 14 23:28:32 vano-linux kernel: PCI: 0000:01:01.0 reg 10 io port: [ec00,
ec07]
Oct 14 23:28:32 vano-linux kernel: PCI: 0000:01:01.0 reg 14 io port: [e880,
e883]
Oct 14 23:28:32 vano-linux kernel: PCI: 0000:01:01.0 reg 18 io port: [e800,
e807]
Oct 14 23:28:32 vano-linux kernel: PCI: 0000:01:01.0 reg 1c io port: [e480,
e483]
Oct 14 23:28:32 vano-linux kernel: PCI: 0000:01:01.0 reg 20 io port: [e400,
e40f]
Oct 14 23:28:32 vano-linux kernel: PCI: 0000:01:02.0 reg 10 io port: [e000,
e0ff]
Oct 14 23:28:32 vano-linux kernel: PCI: 0000:01:02.0 reg 14 32bit mmio:
[febff800, febff8ff]
Oct 14 23:28:32 vano-linux kernel: pci 0000:01:02.0: supports D1
Oct 14 23:28:32 vano-linux kernel: pci 0000:01:02.0: supports D2
Oct 14 23:28:32 vano-linux kernel: PCI: bridge 0000:00:1e.0 io port: [e000,
efff]
Oct 14 23:28:32 vano-linux kernel: PCI: bridge 0000:00:1e.0 32bit mmio:
[feb00000, febfffff]
Oct 14 23:28:32 vano-linux kernel: bus 00 -> node 0
Oct 14 23:28:32 vano-linux kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0._PRT]
Oct 14 23:28:32 vano-linux kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.P0P1._PRT]
Oct 14 23:28:32 vano-linux kernel: libata version 3.00 loaded.
Oct 14 23:28:32 vano-linux kernel: pci 0000:00:1e.0: setting latency timer to
64
Oct 14 23:28:32 vano-linux kernel: pci 0000:00:02.0: Boot video device
Oct 14 23:28:32 vano-linux kernel: Switched to high resolution mode on CPU 1
Oct 14 23:28:32 vano-linux kernel: Switched to high resolution mode on CPU 0
Oct 14 23:28:32 vano-linux kernel: ata_piix 0000:00:1f.2: version 2.12
Oct 14 23:28:32 vano-linux kernel: ata_piix 0000:00:1f.2: setting latency timer
to 64
Oct 14 23:28:32 vano-linux kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Oct 14 23:28:32 vano-linux kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Oct 14 23:28:32 vano-linux kernel: sr 0:0:1:0: Attached scsi CD-ROM sr0
Oct 14 23:28:32 vano-linux kernel: pata_via 0000:01:01.0: version 0.3.3
Oct 14 23:28:32 vano-linux kernel: uhci_hcd 0000:00:1d.0: setting latency timer
to 64
Oct 14 23:28:32 vano-linux kernel: uhci_hcd 0000:00:1d.1: setting latency timer
to 64
Oct 14 23:28:32 vano-linux kernel: uhci_hcd 0000:00:1d.2: setting latency timer
to 64
Oct 14 23:28:32 vano-linux kernel: uhci_hcd 0000:00:1d.3: setting latency timer
to 64
Oct 14 23:28:32 vano-linux kernel: HDA Intel 0000:00:1b.0: setting latency
timer to 64
Oct 14 23:28:32 vano-linux kernel: ehci_hcd 0000:00:1d.7: setting latency timer
to 64
Oct 14 23:28:32 vano-linux kernel: ehci_hcd 0000:00:1d.7: cache line size of 32
is not supported
Oct 14 23:28:32 vano-linux kernel: eth0:  Identified 8139 chip type
'RTL-8100B/8139D'
Oct 14 23:28:32 vano-linux kernel: usb-storage: device found at 3
Oct 14 23:28:32 vano-linux kernel: usb-storage: waiting for device to settle
before scanning
Oct 14 23:28:32 vano-linux kernel: irda_init()
Oct 14 23:28:32 vano-linux kernel: sd 4:0:0:0: [sdb] Mode Sense: 23 00 00 00
Oct 14 23:28:32 vano-linux kernel: sd 4:0:0:0: [sdb] Mode Sense: 23 00 00 00
Oct 14 23:28:32 vano-linux kernel: usb-storage: device scan complete
----------------------------------
lspci -vv output:

00:00.0 Host bridge: Intel Corporation Unknown device 29c0 (rev 10)
        Subsystem: Intel Corporation Unknown device 29c0
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
        Latency: 0
        Capabilities: [e0] Vendor Specific Information

00:02.0 VGA compatible controller: Intel Corporation Unknown device 29c2 (rev
10) (prog-if 00 [VGA])
        Subsystem: Intel Corporation Unknown device 29c2
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at fea80000 (32-bit, non-prefetchable) [size=512K]
        Region 1: I/O ports at dc00 [size=8]
        Region 2: Memory at d0000000 (32-bit, prefetchable) [size=256M]
        Region 3: Memory at fe900000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [90] Message Signalled Interrupts: Mask- 64bit- Queue=0/0
Enable-
                Address: 00000000  Data: 0000
        Capabilities: [d0] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition
Audio Controller (rev 01)
        Subsystem: Intel Corporation 82801G (ICH7 Family) High Definition Audio
Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at fea78000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0
Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] Express Unknown type IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
                Device: Latency L0s <64ns, L1 <1us
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed unknown, Width x0, ASPM unknown, Port 0
                Link: Latency L0s <64ns, L1 <1us
                Link: ASPM Disabled CommClk- ExtSynch-
                Link: Speed unknown, Width x0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)

00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1 (rev
01) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation 82801G (ICH7 Family) USB UHCI #1
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 23
        Region 4: I/O ports at d880 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2 (rev
01) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation 82801G (ICH7 Family) USB UHCI #2
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 4: I/O ports at d800 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3 (rev
01) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation 82801G (ICH7 Family) USB UHCI #3
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 18
        Region 4: I/O ports at d480 [size=32]

00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4 (rev
01) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation 82801G (ICH7 Family) USB UHCI #4
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 16
        Region 4: I/O ports at d400 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI
Controller (rev 01) (prog-if 20 [EHCI])
        Subsystem: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 23
        Region 0: Memory at fea77c00 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1) (prog-if 01
[Subtractive decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: feb00000-febfffff
        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [50] Subsystem: Intel Corporation 82801 PCI Bridge

00:1f.0 ISA bridge: Intel Corporation 82801GH (ICH7DH) LPC Interface Bridge
(rev 01)
        Subsystem: Intel Corporation 82801GH (ICH7DH) LPC Interface Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [e0] Vendor Specific Information

00:1f.2 IDE interface: Intel Corporation 82801GB/GR/GH (ICH7 Family) Serial ATA
Storage Controller IDE (rev 01) (prog-if 80 [Master])
        Subsystem: Intel Corporation 82801GB/GR/GH (ICH7 Family) Serial ATA
Storage Controller IDE
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 0: I/O ports at 01f0 [size=8]
        Region 1: I/O ports at 03f4 [size=1]
        Region 2: I/O ports at 0170 [size=8]
        Region 3: I/O ports at 0374 [size=1]
        Region 4: I/O ports at ffa0 [size=16]
        Capabilities: [70] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 01)
        Subsystem: Intel Corporation 82801G (ICH7 Family) SMBus Controller
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 19
        Region 4: I/O ports at 0400 [size=32]

01:00.0 Multimedia controller: Philips Semiconductors SAA7130 Video Broadcast
Decoder (rev 01)
        Subsystem: Philips Semiconductors Unknown device 0000
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (3750ns min, 9500ns max)
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at febffc00 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:01.0 RAID bus controller: VIA Technologies, Inc. VT6410 ATA133 RAID
controller (rev 06)
        Subsystem: VIA Technologies, Inc. VT6410 ATA133 RAID controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at ec00 [size=8]
        Region 1: I/O ports at e880 [size=4]
        Region 2: I/O ports at e800 [size=8]
        Region 3: I/O ports at e480 [size=4]
        Region 4: I/O ports at e400 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:02.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at e000 [size=256]
        Region 1: Memory at febff800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

----------------------


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
