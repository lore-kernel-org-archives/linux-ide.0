From: Chris Birkinshaw <chris@postbox.org.uk>
Subject: Strange VP_IDE problem
Date: Thu, 17 Feb 2005 10:07:40 +0000
Message-ID: <4b80642884915a76b00cfe44cdea5fec@postbox.org.uk>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Received: from i-195-137-80-122.freedom2surf.net ([195.137.80.122]:3801 "EHLO
	postbox.org.uk") by vger.kernel.org with ESMTP id S262289AbVBQKHl
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Feb 2005 05:07:41 -0500
Received: from [192.168.1.2] (powerbook.postbox.org.uk [192.168.1.2])
	by postbox.org.uk (Postfix) with ESMTP id 89E65520EA
	for <linux-ide@vger.kernel.org>; Thu, 17 Feb 2005 10:07:39 +0000 (GMT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


My 2.6.10 kernel is picking my on board controller up last, which is 
causing all sorts of problems! My kernel output is as follows:

Feb 15 21:24:49 postbox kernel: PDC20267: chipset revision 2
Feb 15 21:24:49 postbox kernel: PDC20267: 100%% native mode on irq 12
Feb 15 21:24:49 postbox kernel: PDC20267: (U)DMA Burst Bit ENABLED 
Primary PCI Mode Secondary PCI Mode.
Feb 15 21:24:49 postbox kernel:     ide2: BM-DMA at 0xb400-0xb407, BIOS 
settings: hde:pio, hdf:pio
Feb 15 21:24:49 postbox kernel:     ide3: BM-DMA at 0xb408-0xb40f, BIOS 
settings: hdg:pio, hdh:pio
Feb 15 21:24:49 postbox kernel: hde: IBM-IC35L060AVVA07-0, ATA DISK 
drive
Feb 15 21:24:49 postbox kernel: hdf: ST360014A, ATA DISK drive
Feb 15 21:24:49 postbox kernel: ide2 at 0xd800-0xd807,0xd402 on irq 12
Feb 15 21:24:49 postbox kernel: hdg: IC35L060AVV207-0, ATA DISK drive
Feb 15 21:24:49 postbox kernel: hdh: IC35L060AVV207-0, ATA DISK drive
Feb 15 21:24:49 postbox kernel: ide3 at 0xd000-0xd007,0xb802 on irq 12
Feb 15 21:24:49 postbox kernel: SiI680: IDE controller at PCI slot 
0000:00:0d.0
Feb 15 21:24:49 postbox kernel: ACPI: PCI Interrupt Link [LNKA] enabled 
at IRQ 11
Feb 15 21:24:49 postbox kernel: PCI: setting IRQ 11 as level-triggered
Feb 15 21:24:49 postbox kernel: ACPI: PCI interrupt 0000:00:0d.0[A] -> 
GSI 11 (level, low) -> IRQ 11
Feb 15 21:24:49 postbox kernel: SiI680: chipset revision 2
Feb 15 21:24:49 postbox kernel: SiI680: BASE CLOCK == 133
Feb 15 21:24:49 postbox kernel: SiI680: 100%% native mode on irq 11
Feb 15 21:24:49 postbox kernel:     ide0: MMIO-DMA , BIOS settings: 
hda:pio, hdb:pio
Feb 15 21:24:49 postbox kernel:     ide1: MMIO-DMA , BIOS settings: 
hdc:pio, hdd:pio
Feb 15 21:24:49 postbox kernel: hdc: IC35L060AVV207-0, ATA DISK drive
Feb 15 21:24:49 postbox kernel: hdd: Maxtor 6Y080L0, ATA DISK drive
Feb 15 21:24:49 postbox kernel: ide1 at 
0xe08160c0-0xe08160c7,0xe08160ca on irq 11
Feb 15 21:24:49 postbox kernel: VP_IDE: IDE controller at PCI slot 
0000:00:11.1
Feb 15 21:24:49 postbox kernel: ACPI: PCI interrupt 0000:00:11.1[A]: no 
GSI
Feb 15 21:24:49 postbox kernel: VP_IDE: chipset revision 6
Feb 15 21:24:49 postbox kernel: VP_IDE: not 100%% native mode: will 
probe irqs later
Feb 15 21:24:49 postbox kernel: VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 
controller on pci0000:00:11.1
Feb 15 21:24:49 postbox kernel:     ide4: BM-DMA at 0x8400-0x8407, BIOS 
settings: hdi:DMA, hdj:DMA
Feb 15 21:24:49 postbox kernel:     ide5: BM-DMA at 0x8408-0x840f, BIOS 
settings: hdk:DMA, hdl:pio


I have noticed this mentioned a few times on the web but no one seems 
to have found a solution. Is this a known bug?

Many thanks,

Chris Birkinshaw

