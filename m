From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [2.6.23-rc1] ata_piix: EH pending after completion, repeating EH (cnt=4)
Date: Mon, 30 Jul 2007 15:19:11 +0200 (MEST)
Message-ID: <200707301319.l6UDJBZi019272@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:50157 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935552AbXG3NTQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Jul 2007 09:19:16 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, mikpe@it.uu.se
Cc: linux-ide@vger.kernel.org

On Mon, 30 Jul 2007 16:52:01 +0900, Tejun Heo wrote:
> Mikael Pettersson wrote:
> > Sure, here are the boot messages with the newer debug patch:
> 
> Of course I missed again.  Here's yet another debug patch.  Sorry about
> the trouble.

No problem. Here's the kernel messages with the 3rd version of the patch:

pata_pdc2027x 0000:04:02.0: version 0.9
ACPI: PCI Interrupt 0000:04:02.0[A] -> GSI 23 (level, low) -> IRQ 18
pata_pdc2027x 0000:04:02.0: PLL input clock 16660 kHz
scsi0 : pata_pdc2027x
scsi1 : pata_pdc2027x
ata1: PATA max UDMA/133 cmd 0xf88297c0 ctl 0xf8829fda bmdma 0xf8829000 irq 18
ata2: PATA max UDMA/133 cmd 0xf88295c0 ctl 0xf8829dda bmdma 0xf8829008 irq 18
EH scheduled with LOADING set
 [<c022bd0e>] ata_host_register+0x1ee/0x2c0
 [<c022c780>] ata_interrupt+0x0/0x200
 [<c022be59>] ata_host_activate+0x79/0x90
 [<c023432a>] pdc2027x_init_one+0x23a/0x2d0
 [<c01cda96>] pci_device_probe+0x56/0x80
 [<c020e4a8>] driver_probe_device+0x88/0x190
 [<c02963c5>] klist_next+0x55/0xb0
 [<c020e6fa>] __driver_attach+0x7a/0x80
 [<c020d8ba>] bus_for_each_dev+0x3a/0x60
 [<c020e326>] driver_attach+0x16/0x20
 [<c020e680>] __driver_attach+0x0/0x80
 [<c020dc7a>] bus_add_driver+0x8a/0x1b0
 [<c01cdc46>] __pci_register_driver+0x56/0x90
 [<c032b830>] kernel_init+0x140/0x310
 [<c0102a12>] ret_from_fork+0x6/0x1c
 [<c032b6f0>] kernel_init+0x0/0x310
 [<c032b6f0>] kernel_init+0x0/0x310
 [<c0103717>] kernel_thread_helper+0x7/0x10
 =======================
ata1: soft resetting port
ata1.00: ATA-7: ST3320620A, 3.AAD, max UDMA/100
ata1.00: 625142448 sectors, multi 16: LBA48 
ata1.00: configured for UDMA/100
ata1: EH complete
EH scheduled with LOADING set
 [<c022bd0e>] ata_host_register+0x1ee/0x2c0
 [<c022c780>] ata_interrupt+0x0/0x200
 [<c022be59>] ata_host_activate+0x79/0x90
 [<c023432a>] pdc2027x_init_one+0x23a/0x2d0
 [<c01cda96>] pci_device_probe+0x56/0x80
 [<c020e4a8>] driver_probe_device+0x88/0x190
 [<c02963c5>] klist_next+0x55/0xb0
 [<c020e6fa>] __driver_attach+0x7a/0x80
 [<c020d8ba>] bus_for_each_dev+0x3a/0x60
 [<c020e326>] driver_attach+0x16/0x20
 [<c020e680>] __driver_attach+0x0/0x80
 [<c020dc7a>] bus_add_driver+0x8a/0x1b0
 [<c01cdc46>] __pci_register_driver+0x56/0x90
 [<c032b830>] kernel_init+0x140/0x310
 [<c0102a12>] ret_from_fork+0x6/0x1c
 [<c032b6f0>] kernel_init+0x0/0x310
 [<c032b6f0>] kernel_init+0x0/0x310
 [<c0103717>] kernel_thread_helper+0x7/0x10
 =======================
ata2: soft resetting port
ata2: EH complete
scsi 0:0:0:0: Direct-Access     ATA      ST3320620A       3.AA PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 625142448 512-byte hardware sectors (320073 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 625142448 512-byte hardware sectors (320073 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 >
sd 0:0:0:0: [sda] Attached SCSI disk
...
ata_piix 0000:00:1f.2: version 2.11
ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.2 to 64
scsi2 : ata_piix
scsi3 : ata_piix
ata3: SATA max UDMA/133 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001ff90 irq 14
ata4: SATA max UDMA/133 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001ff98 irq 15
EH scheduled with LOADING set
 [<c022bd0e>] ata_host_register+0x1ee/0x2c0
 [<c02308dd>] ata_pci_init_one+0x12d/0x250
 [<f8822580>] piix_init_one+0x1d0/0x540 [ata_piix]
 [<c01cda96>] pci_device_probe+0x56/0x80
 [<c020e4a8>] driver_probe_device+0x88/0x190
 [<c02963c5>] klist_next+0x55/0xb0
 [<c020e6fa>] __driver_attach+0x7a/0x80
 [<c020d8ba>] bus_for_each_dev+0x3a/0x60
 [<c020e326>] driver_attach+0x16/0x20
 [<c020e680>] __driver_attach+0x0/0x80
 [<c020dc7a>] bus_add_driver+0x8a/0x1b0
 [<c01cdc46>] __pci_register_driver+0x56/0x90
 [<f8834014>] piix_init+0x14/0x26 [ata_piix]
 [<c0139fc6>] sys_init_module+0x126/0x1860
 [<c0113f54>] do_page_fault+0x484/0x670
 [<c0227370>] ata_port_start+0x0/0x70
 [<c0102b2e>] syscall_call+0x7/0xb
 [<c0290000>] rtmsg_fib+0x40/0x180
 =======================
ata3: soft resetting port
ata3: EH complete
EH scheduled with LOADING set
 [<c022bd0e>] ata_host_register+0x1ee/0x2c0
 [<c02308dd>] ata_pci_init_one+0x12d/0x250
 [<f8822580>] piix_init_one+0x1d0/0x540 [ata_piix]
 [<c01cda96>] pci_device_probe+0x56/0x80
 [<c020e4a8>] driver_probe_device+0x88/0x190
 [<c02963c5>] klist_next+0x55/0xb0
 [<c020e6fa>] __driver_attach+0x7a/0x80
 [<c020d8ba>] bus_for_each_dev+0x3a/0x60
 [<c020e326>] driver_attach+0x16/0x20
 [<c020e680>] __driver_attach+0x0/0x80
 [<c020dc7a>] bus_add_driver+0x8a/0x1b0
 [<c01cdc46>] __pci_register_driver+0x56/0x90
 [<f8834014>] piix_init+0x14/0x26 [ata_piix]
 [<c0139fc6>] sys_init_module+0x126/0x1860
 [<c0113f54>] do_page_fault+0x484/0x670
 [<c0227370>] ata_port_start+0x0/0x70
 [<c0102b2e>] syscall_call+0x7/0xb
 [<c0290000>] rtmsg_fib+0x40/0x180
 =======================
ata4: soft resetting port
EH port aborted while LOADING set
 [<c02330d0>] ata_port_abort+0xb0/0xf0
 [<c023312e>] ata_port_freeze+0x1e/0x60
 [<c0227fb2>] ata_hsm_qc_complete+0x102/0x110
 [<c02283df>] ata_hsm_move+0x23f/0x7c0
 [<c0296dee>] schedule+0x1fe/0x700
 [<c022c6e9>] ata_pio_task+0x59/0xf0
 [<c022c690>] ata_pio_task+0x0/0xf0
 [<c012b00e>] run_workqueue+0xae/0x140
 [<c012b910>] worker_thread+0x0/0xe0
 [<c012b994>] worker_thread+0x84/0xe0
 [<c012e6d0>] autoremove_wake_function+0x0/0x40
 [<c012b910>] worker_thread+0x0/0xe0
 [<c012e442>] kthread+0x42/0x70
 [<c012e400>] kthread+0x0/0x70
 [<c0103717>] kernel_thread_helper+0x7/0x10
 =======================
ata4.00: ATAPI: TSSTcorpCD/DVDW SH-S183A, SB00, max UDMA/33
ata4.00: applying bridge limits
ata4.00: configured for UDMA/33
ata4: EH pending after completion, repeating EH (cnt=4)
ata4: EH complete
scsi 3:0:0:0: CD-ROM            TSSTcorp CD/DVDW SH-S183A SB00 PQ: 0 ANSI: 5
ata_piix 0000:00:1f.5: MAP [ P0 P2 P1 P3 ]
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.5 to 64
scsi4 : ata_piix
scsi5 : ata_piix
ata5: SATA max UDMA/133 cmd 0x0001e080 ctl 0x0001e002 bmdma 0x0001d800 irq 19
ata6: SATA max UDMA/133 cmd 0x0001dc00 ctl 0x0001d882 bmdma 0x0001d808 irq 19
EH scheduled with LOADING set
 [<c022bd0e>] ata_host_register+0x1ee/0x2c0
 [<c02308dd>] ata_pci_init_one+0x12d/0x250
 [<f8822580>] piix_init_one+0x1d0/0x540 [ata_piix]
 [<c01cda96>] pci_device_probe+0x56/0x80
 [<c020e4a8>] driver_probe_device+0x88/0x190
 [<c02963c5>] klist_next+0x55/0xb0
 [<c020e6fa>] __driver_attach+0x7a/0x80
 [<c020d8ba>] bus_for_each_dev+0x3a/0x60
 [<c020e326>] driver_attach+0x16/0x20
 [<c020e680>] __driver_attach+0x0/0x80
 [<c020dc7a>] bus_add_driver+0x8a/0x1b0
 [<c01cdc46>] __pci_register_driver+0x56/0x90
 [<f8834014>] piix_init+0x14/0x26 [ata_piix]
 [<c0139fc6>] sys_init_module+0x126/0x1860
 [<c0113f54>] do_page_fault+0x484/0x670
 [<c0227370>] ata_port_start+0x0/0x70
 [<c0102b2e>] syscall_call+0x7/0xb
 [<c0290000>] rtmsg_fib+0x40/0x180
 =======================
ata5: soft resetting port
ata5: EH complete
EH scheduled with LOADING set
 [<c022bd0e>] ata_host_register+0x1ee/0x2c0
 [<c02308dd>] ata_pci_init_one+0x12d/0x250
 [<f8822580>] piix_init_one+0x1d0/0x540 [ata_piix]
 [<c01cda96>] pci_device_probe+0x56/0x80
 [<c020e4a8>] driver_probe_device+0x88/0x190
 [<c02963c5>] klist_next+0x55/0xb0
 [<c020e6fa>] __driver_attach+0x7a/0x80
 [<c020d8ba>] bus_for_each_dev+0x3a/0x60
 [<c020e326>] driver_attach+0x16/0x20
 [<c020e680>] __driver_attach+0x0/0x80
 [<c020dc7a>] bus_add_driver+0x8a/0x1b0
 [<c01cdc46>] __pci_register_driver+0x56/0x90
 [<f8834014>] piix_init+0x14/0x26 [ata_piix]
 [<c0139fc6>] sys_init_module+0x126/0x1860
 [<c0113f54>] do_page_fault+0x484/0x670
 [<c0227370>] ata_port_start+0x0/0x70
 [<c0102b2e>] syscall_call+0x7/0xb
 [<c0290000>] rtmsg_fib+0x40/0x180
 =======================
ata6: soft resetting port
ata6: EH complete

/Mikael
