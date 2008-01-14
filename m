From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: sata_promise: Keeps saying SATA link down (SStatus 0 SControl 0)
Date: Mon, 14 Jan 2008 09:30:07 +0100
Message-ID: <18315.7567.747367.84127@harpo.it.uu.se>
References: <20080113234320.GA6225@roeckx.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:37282 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751465AbYANIa4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Jan 2008 03:30:56 -0500
In-Reply-To: <20080113234320.GA6225@roeckx.be>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kurt Roeckx <kurt@roeckx.be>
Cc: linux-ide@vger.kernel.org

Kurt Roeckx writes:
 > Hi,
 > 
 > I've just tried the 2.6.24-rc7 kernel (from Debian's experimental kernel
 > archive), running the x86_64 kernel.
 > 
 > 
 > I keep getting things like this in my log:
 > Jan 13 19:21:10 intrepid kernel: ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xa frozen
 > Jan 13 19:21:10 intrepid kernel: ata2: hotplug_status 0x20
 > Jan 13 19:21:11 intrepid kernel: ata2: soft resetting link
 > Jan 13 19:21:11 intrepid kernel: ata2: SATA link down (SStatus 0 SControl 0)
 > Jan 13 19:21:11 intrepid kernel: ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xb t4
 > Jan 13 19:21:11 intrepid kernel: ata2: hotplug_status 0x2
 > Jan 13 19:21:11 intrepid kernel: ata2: soft resetting link
 > Jan 13 19:21:11 intrepid kernel: ata2: SATA link down (SStatus 100 SControl 0)
 > Jan 13 19:21:11 intrepid kernel: ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xb t3
 > Jan 13 19:21:11 intrepid kernel: ata2: hotplug_status 0x20
 > Jan 13 19:21:13 intrepid kernel: ata2: soft resetting link
 > Jan 13 19:21:13 intrepid kernel: ata2: SATA link down (SStatus 100 SControl 0)
 > Jan 13 19:21:13 intrepid kernel: ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xb t2
 > Jan 13 19:21:13 intrepid kernel: ata2: hotplug_status 0x20
 > Jan 13 19:21:14 intrepid kernel: ata2: soft resetting link
 > Jan 13 19:21:14 intrepid kernel: ata2: SATA link down (SStatus 0 SControl 0)
 > Jan 13 19:21:14 intrepid kernel: ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xb t1
 > Jan 13 19:21:14 intrepid kernel: ata2: hotplug_status 0x2
 > Jan 13 19:21:15 intrepid kernel: ata2: soft resetting link
 > Jan 13 19:21:15 intrepid kernel: ata2: SATA link down (SStatus 100 SControl 0)
 > Jan 13 19:21:15 intrepid kernel: ata2: EH pending after 5 tries, giving up
 > Jan 13 19:21:15 intrepid kernel: ata2: EH complete
 > Jan 13 19:21:15 intrepid kernel: ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xa frozen
 > Jan 13 19:21:15 intrepid kernel: ata2: hotplug_status 0x2
 > Jan 13 19:21:16 intrepid kernel: ata2: soft resetting link
 > Jan 13 19:21:16 intrepid kernel: ata2: SATA link down (SStatus 100 SControl 0)
 > Jan 13 19:21:16 intrepid kernel: ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xb t4
 > Jan 13 19:21:16 intrepid kernel: ata2: hotplug_status 0x20
 > Jan 13 19:21:17 intrepid kernel: ata2: soft resetting link
 > Jan 13 19:21:17 intrepid kernel: ata2: SATA link down (SStatus 0 SControl 0)
 > Jan 13 19:21:17 intrepid kernel: ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xb t3
 > Jan 13 19:21:17 intrepid kernel: ata2: hotplug_status 0x2
 > [...]
 > 
 > 
 > ata2 is the second port of my promise controller in which nothing
 > is plugged in.
 > 
 > I also have an sata_via with 2 disks plugged in.
 > 
 > All 3 disks seem to come up properly as far as I can see from the log,
 > but I've just rebooted in an older kernel version.
 > 
 > With my current 2.6.22 kernel I just get 1 line saying that the link
 > is down and then it stops.
 > 
 > I think the important part of the log I get when booting is:
 > Jan 13 19:20:45 intrepid kernel: sata_promise 0000:00:08.0: version 2.11
 > Jan 13 19:20:45 intrepid kernel: ACPI: PCI Interrupt 0000:00:08.0[A] ->
 > GSI 18 (level, low) -> IRQ 18
 > Jan 13 19:20:45 intrepid kernel: scsi0 : sata_promise
 > Jan 13 19:20:45 intrepid kernel: scsi1 : sata_promise
 > Jan 13 19:20:45 intrepid kernel: scsi2 : sata_promise
 > Jan 13 19:20:45 intrepid kernel: ata1: SATA max UDMA/133 mmio m4096@0xfdf00000 port 0xfdf00200 irq 18
 > Jan 13 19:20:45 intrepid kernel: ata2: SATA max UDMA/133 mmio m4096@0xfdf00000 port 0xfdf00280 irq 18
 > Jan 13 19:20:45 intrepid kernel: ata3: PATA max UDMA/133 mmio m4096@0xfdf00000 port 0xfdf00300 irq 18
 > Jan 13 19:20:45 intrepid kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
 > Jan 13 19:20:45 intrepid kernel: ata1.00: ATA-7: WDC WD5000YS-01MPB1, 09.02E09, max UDMA/133
 > Jan 13 19:20:45 intrepid kernel: ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
 > Jan 13 19:20:45 intrepid kernel: ata1.00: configured for UDMA/133 
 > Jan 13 19:20:45 intrepid kernel: ata2: SATA link down (SStatus 0 SControl 0)
 > Jan 13 19:20:45 intrepid kernel: scsi 0:0:0:0: Direct-Access     ATA      WDC WD5000YS-01M 09.0 PQ: 0 ANSI: 5
 > Jan 13 19:20:45 intrepid kernel: sata_via 0000:00:0f.0: version 2.3
 > Jan 13 19:20:45 intrepid kernel: ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 20
 > Jan 13 19:20:45 intrepid kernel: sata_via 0000:00:0f.0: routed to hard irq line
 > 10
 > Jan 13 19:20:45 intrepid kernel: scsi3 : sata_via
 > Jan 13 19:20:45 intrepid kernel: scsi4 : sata_via
 > Jan 13 19:20:45 intrepid kernel: ata4: SATA max UDMA/133 cmd 0xe800 ctl 0xe400 bmdma 0xd400 irq 20
 > Jan 13 19:20:45 intrepid kernel: ata5: SATA max UDMA/133 cmd 0xe000 ctl 0xd800 bmdma 0xd408 irq 20
 > Jan 13 19:20:45 intrepid kernel: Driver 'sd' needs updating - please use bus_type methods
 > Jan 13 19:20:45 intrepid kernel: sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
 > Jan 13 19:20:45 intrepid kernel: sd 0:0:0:0: [sda] Write Protect is off
 > Jan 13 19:20:45 intrepid kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
 > Jan 13 19:20:45 intrepid kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 > Jan 13 19:20:45 intrepid kernel: sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
 > Jan 13 19:20:45 intrepid kernel: sd 0:0:0:0: [sda] Write Protect is off
 > Jan 13 19:20:45 intrepid kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
 > Jan 13 19:20:45 intrepid kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 > Jan 13 19:20:45 intrepid kernel:  sda: unknown partition table
 > Jan 13 19:20:45 intrepid kernel: sd 0:0:0:0: [sda] Attached SCSI disk
 > Jan 13 19:20:45 intrepid kernel: ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
 > Jan 13 19:20:45 intrepid kernel: ata4.00: ATA-7: Maxtor 6Y080M0, YAR51EW0, max UDMA/133
 > Jan 13 19:20:45 intrepid kernel: ata4.00: 160086528 sectors, multi 16: LBA
 > Jan 13 19:20:45 intrepid kernel: ata4.00: configured for UDMA/133
 > Jan 13 19:20:45 intrepid kernel: ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xa frozen
 > Jan 13 19:20:45 intrepid kernel: ata2: hotplug_status 0x20
 > Jan 13 19:20:45 intrepid kernel: ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
 > Jan 13 19:20:45 intrepid kernel: ata5.00: ATA-6: ST3200822AS, 3.01, max UDMA/133Jan 13 19:20:45 intrepid kernel: ata5.00: 390721968 sectors, multi 16: LBA48
 > Jan 13 19:20:45 intrepid kernel: ata5.00: configured for UDMA/133
 > Jan 13 19:20:45 intrepid kernel: scsi 3:0:0:0: Direct-Access     ATA      Maxtor 6Y080M0   YAR5 PQ: 0 ANSI: 5
 > Jan 13 19:20:45 intrepid kernel: sd 3:0:0:0: [sdb] 160086528 512-byte hardware sectors (81964 MB)
 > Jan 13 19:20:45 intrepid kernel: sd 3:0:0:0: [sdb] Write Protect is off
 > Jan 13 19:20:45 intrepid kernel: sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
 > Jan 13 19:20:45 intrepid kernel: sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 > Jan 13 19:20:45 intrepid kernel: sd 3:0:0:0: [sdb] 160086528 512-byte hardware sectors (81964 MB)
 > Jan 13 19:20:45 intrepid kernel: sd 3:0:0:0: [sdb] Write Protect is off
 > Jan 13 19:20:45 intrepid kernel: sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
 > Jan 13 19:20:45 intrepid kernel: sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 > Jan 13 19:20:45 intrepid kernel:  sdb: sdb1 sdb2 sdb3 sdb4
 > Jan 13 19:20:45 intrepid kernel: sd 3:0:0:0: [sdb] Attached SCSI disk
 > Jan 13 19:20:45 intrepid kernel: scsi 4:0:0:0: Direct-Access     ATA      ST3200822AS      3.01 PQ: 0 ANSI: 5
 > Jan 13 19:20:45 intrepid kernel: sd 4:0:0:0: [sdc] 390721968 512-byte hardware sectors (200050 MB)
 > Jan 13 19:20:45 intrepid kernel: sd 4:0:0:0: [sdc] Write Protect is off
 > Jan 13 19:20:45 intrepid kernel: sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
 > Jan 13 19:20:45 intrepid kernel: sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 > Jan 13 19:20:45 intrepid kernel: sd 4:0:0:0: [sdc] 390721968 512-byte hardware sectors (200050 MB)
 > Jan 13 19:20:45 intrepid kernel: sd 4:0:0:0: [sdc] Write Protect is off
 > Jan 13 19:20:45 intrepid kernel: sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
 > Jan 13 19:20:45 intrepid kernel: sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 > Jan 13 19:20:45 intrepid kernel:  sdc: unknown partition table
 > Jan 13 19:20:45 intrepid kernel: sd 4:0:0:0: [sdc] Attached SCSI disk
 > Jan 13 19:20:45 intrepid kernel: ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 21
 > Jan 13 19:20:45 intrepid kernel: ehci_hcd 0000:00:10.4: EHCI Host Controller
 > Jan 13 19:20:45 intrepid kernel: ehci_hcd 0000:00:10.4: new USB bus registered,
 > assigned bus number 5
 > Jan 13 19:20:45 intrepid kernel: ehci_hcd 0000:00:10.4: irq 21, io mem 0xfde00000
 > Jan 13 19:20:45 intrepid kernel: ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
 > Jan 13 19:20:45 intrepid kernel: usb usb5: configuration #1 chosen from 1 choiceJan 13 19:20:45 intrepid kernel: hub 5-0:1.0: USB hub found
 > Jan 13 19:20:45 intrepid kernel: hub 5-0:1.0: 8 ports detected
 > Jan 13 19:20:45 intrepid kernel: hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
 > Jan 13 19:20:45 intrepid kernel: Uniform CD-ROM driver Revision: 3.20
 > Jan 13 19:20:45 intrepid kernel: ata2: soft resetting link
 > Jan 13 19:20:45 intrepid kernel: ata2: SATA link down (SStatus 100 SControl 0)
 > Jan 13 19:20:45 intrepid kernel: ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xb t4
 > Jan 13 19:20:45 intrepid kernel: ata2: hotplug_status 0x20
 > Jan 13 19:20:45 intrepid kernel: ata2: soft resetting link
 > Jan 13 19:20:45 intrepid kernel: ata2: SATA link down (SStatus 0 SControl 0)
 > Jan 13 19:20:45 intrepid kernel: ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xb t3
 > Jan 13 19:20:45 intrepid kernel: ata2: hotplug_status 0x2

The chip repeatedly signals plug and unplug events on its second
ATA port. This is not a common error.

I need a lot more information to debug this:
- the output of /sbin/lspci
- for the Promise device only, the output of /sbin/lspci -n -vvxxx
- a complete kernel boot log from a boot with a vanilla www.kernel.org
  2.6.24-rc7 kernel

Since 2.6.22 works for you, it would help if you did a binary search
to identify when the problem was introduced. Like first try 2.6.23
(or current stable 2.6.23.n), and then either the 2.6.23-rc kernels
(if 2.6.23 is broken) or the 2.6.24-rc kernels (if 2.6.23 works).

/Mikael
