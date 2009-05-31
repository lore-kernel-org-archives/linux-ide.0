From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: VIA PATA IRQ-nobody-cared problems with CF
Date: Sun, 31 May 2009 23:37:15 +0200
Message-ID: <m3zlctrm2c.fsf@intrepid.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from khc.piap.pl ([195.187.100.11]:47729 "EHLO khc.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751685AbZEaVhR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 31 May 2009 17:37:17 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hi,

I'm trying to use VIA PATA with a compact flash. I'm consistently
getting "irq: nobody cared". Ideas?

It works fine with DMA-capable CF as master only.

Details:
IXP425 (ARM) little-endian
VT6421-based mini-PCI card
SATA ports (2) unconnected.

00:0d.0 RAID bus controller: VIA VT6421 IDE RAID Controller (rev 50)
00:0d.0 0104: 1106:3249 (rev 50)
        Subsystem: 1106:3249
        Flags: bus master, medium devsel, latency 32, IRQ 29
        I/O ports at 1420 [size=16]
        I/O ports at 1430 [size=16]
        I/O ports at 1440 [size=16]
        I/O ports at 1450 [size=16]
        I/O ports at 1400 [size=32]
        I/O ports at 1000 [size=256]
        Expansion ROM at 48000000 [disabled] [size=64K]
        Capabilities: [e0] Power Management version 2
        Kernel driver in use: sata_via

Linux-2.6.29.4 or latest .30 .git.

gcc-4.3.3 (recent SVN).

Is putting a CF card into on-card slot (wired as slave) with no master
present a valid option?
The cards seem to work fine in USB reader and in CS5536-based system
(including UDMA with the DMA-able card + IDE-CF adapter).

==========================================================
Working (no "nobody cared" message): CF in IDE-CF adapter, master,
CF is DMA-capable, Linux 2.6.29.4:

sata_via 0000:00:0d.0: routed to hard irq line 13
scsi0 : sata_via
scsi1 : sata_via
scsi2 : sata_via
ata1: SATA max UDMA/133 port i16@0x1420 bmdma 0x1400 irq 29
ata2: SATA max UDMA/133 port i16@0x1430 bmdma 0x1408 irq 29
ata3: PATA max UDMA/133 port i16@0x1440 bmdma 0x1410 irq 29
ata1: SATA link down (SStatus 0 SControl 310)
ata2: SATA link down (SStatus 0 SControl 310)
ata3.00: CFA: SanDisk SDCFX3-004G, HDX 4.32, max UDMA/66
ata3.00: 8027712 sectors, multi 0: LBA
ata3.00: limited to UDMA/33 due to 40-wire cable
ata3.00: configured for UDMA/33
isa bounce pool size: 16 pages
scsi 2:0:0:0: Direct-Access     ATA      SanDisk SDCFX3-0 HDX  PQ: 0 ANSI: 5
sd 2:0:0:0: [sda] 8027712 512-byte hardware sectors: (4.11 GB/3.82 GiB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA

==========================================================
"nobody cared": the same setup as above (master, IDE-CF) with
non-DMA-capable card, sort-of diff against working setup:

+irq 29: nobody cared (booted with the "irqpoll" option)
+[<c03bc850>] (dump_stack+0x0/0x14) from [<c0130bdc>] (__report_bad_irq+0x2c/0x9c)
+[<c0130bb0>] (__report_bad_irq+0x0/0x9c) from [<c0130ddc>] (note_interrupt+0x190/0x1fc)
+ r4:00000020
+[<c0130c4c>] (note_interrupt+0x0/0x1fc) from [<c013172c>] (handle_level_irq+0xc8/0xf0)
+[<c0131664>] (handle_level_irq+0x0/0xf0) from [<c00ef048>] (__exception_text_start+0x48/0x74)
+ r5:c04bc004 r4:0000001d
+[<c00ef000>] (__exception_text_start+0x0/0x74) from [<c00efad0>] (__irq_svc+0x30/0x80)
+Exception stack(0xc66b7bf8 to 0xc66b7c40)
+7be0:                                                       00000000 c66b6000
+7c00: 00000000 20000013 0000001d 00000002 00000000 ffff909b c66b6000 c04b7634
+7c20: 0000000a c66b7c74 c66b7c78 c66b7c40 c010de74 c010dd3c 20000013 ffffffff
+ r6:20000000 r5:0000001f r4:ffffffff
+[<c010dcf0>] (__do_softirq+0x0/0x104) from [<c010de74>] (irq_exit+0x80/0x90)
+[<c010ddf4>] (irq_exit+0x0/0x90) from [<c00ef04c>] (__exception_text_start+0x4c/0x74)
+[<c00ef000>] (__exception_text_start+0x0/0x74) from [<c00efad0>] (__irq_svc+0x30/0x80)
+Exception stack(0xc66b7ca8 to 0xc66b7cf0)
+7ca0:                   00000000 00300000 c66b7d0c 00000000 80000013 00000001
+7cc0: c6701380 ffff909b 00000001 c0256e04 c67014bc c66b7d04 ffbfffff c66b7cf4
+7ce0: c02526bc c00fa81c 40000013 ffffffff
+ r6:20000020 r5:0000001f r4:ffffffff
+[<c00fa7d0>] (ixp4xx_pci_read_no_errata+0x0/0x58) from [<c02526bc>] (ata_sff_sync+0x7c/0x84)
+ r4:c6700000
+[<c0252640>] (ata_sff_sync+0x0/0x84) from [<c0257064>] (ata_sff_pause+0x10/0x20)
+[<c0257054>] (ata_sff_pause+0x0/0x20) from [<c0257160>] (ata_sff_dev_select+0x78/0x7c)
+[<c02570e8>] (ata_sff_dev_select+0x0/0x7c) from [<c02530cc>] (ata_devchk+0x20/0x38c)
+ r4:c6700000
+[<c02530ac>] (ata_devchk+0x0/0x38c) from [<c0256f3c>] (ata_sff_softreset+0x138/0x168)
+ r5:00000001 r4:c6700000
+[<c0256e04>] (ata_sff_softreset+0x0/0x168) from [<c024d6b8>] (ata_do_reset+0x88/0x8c)
+[<c024d630>] (ata_do_reset+0x0/0x8c) from [<c024e2f4>] (ata_eh_reset+0x354/0xd84)
+ r8:00000000 r7:00002710 r6:c6701380 r5:00000008 r4:ffff909b
+[<c024dfa0>] (ata_eh_reset+0x0/0xd84) from [<c02508dc>] (ata_eh_recover+0x270/0xe00)
+[<c025066c>] (ata_eh_recover+0x0/0xe00) from [<c0251654>] (ata_do_eh+0x50/0x94)
+[<c0251604>] (ata_do_eh+0x0/0x94) from [<c02539c4>] (ata_sff_error_handler+0x118/0x1c4)
+ r7:a0000013 r6:00000000 r5:00000000 r4:c6700000
+[<c02538ac>] (ata_sff_error_handler+0x0/0x1c4) from [<c02520b8>] (ata_scsi_error+0x2e4/0x50c)
+[<c0251dd4>] (ata_scsi_error+0x0/0x50c) from [<c0236598>] (scsi_error_handler+0xd0/0x3c0)
+[<c02364c8>] (scsi_error_handler+0x0/0x3c0) from [<c011d134>] (kthread+0x58/0x94)
+[<c011d0dc>] (kthread+0x0/0x94) from [<c010bb40>] (do_exit+0x0/0x740)
+ r7:00000000 r6:00000000 r5:00000000 r4:00000000
+handlers:
+[<c0255e48>] (ata_sff_interrupt+0x0/0x2c4)
+Disabling IRQ #29
+ata3.00: CFA: SAMSUNG CF/ATA, CF031003, max PIO4
+ata3.00: 254976 sectors, multi 0: LBA
+ata3.00: configured for PIO4
+ata3.00: configured for PIO4
+ata3: EH complete
 isa bounce pool size: 16 pages
+scsi 2:0:0:0: Direct-Access     ATA      SAMSUNG CF/ATA   CF03 PQ: 0 ANSI: 5
+sd 2:0:0:0: [sda] 254976 512-byte hardware sectors: (130 MB/124 MiB)
 sd 2:0:0:0: [sda] Write Protect is off
+sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00

==========================================================
"nobody cared": CF DMA-capable (slave - in CF slot on the card):

+irq 29: nobody cared (booted with the "irqpoll" option)
+[<c03bc850>] (dump_stack+0x0/0x14) from [<c0130bdc>] (__report_bad_irq+0x2c/0x9c)
+[<c0130bb0>] (__report_bad_irq+0x0/0x9c) from [<c0130ddc>] (note_interrupt+0x190/0x1fc)
+ r4:00000020
+[<c0130c4c>] (note_interrupt+0x0/0x1fc) from [<c013172c>] (handle_level_irq+0xc8/0xf0)
+[<c0131664>] (handle_level_irq+0x0/0xf0) from [<c00ef048>] (__exception_text_start+0x48/0x74)
+ r5:c04bc004 r4:0000001d
+[<c00ef000>] (__exception_text_start+0x0/0x74) from [<c00efad0>] (__irq_svc+0x30/0x80)
+Exception stack(0xc671bbb8 to 0xc671bc00)
+bba0:                                                       00000000 c671a000
+bbc0: 00000000 20000013 0000001d 00000102 00000000 c6701380 c671a000 c04b7634
+bbe0: 0000000a c671bc34 c671bc38 c671bc00 c010de74 c010dd3c 20000013 ffffffff
+ r6:20000000 r5:0000001f r4:ffffffff
+[<c010dcf0>] (__do_softirq+0x0/0x104) from [<c010de74>] (irq_exit+0x80/0x90)
+[<c010ddf4>] (irq_exit+0x0/0x90) from [<c00ef04c>] (__exception_text_start+0x4c/0x74)
+[<c00ef000>] (__exception_text_start+0x0/0x74) from [<c00efad0>] (__irq_svc+0x30/0x80)
+Exception stack(0xc671bc68 to 0xc671bcb0)
+bc60:                   00000000 00200000 c671bccc 00000000 80000013 0000ffff
+bc80: c6700000 c6701380 00000000 ffff909a 00000002 c671bcc4 ffbfffff c671bcb4
+bca0: c02526bc c00fa81c 40000013 ffffffff
+ r6:20000020 r5:0000001f r4:ffffffff
+[<c00fa7d0>] (ixp4xx_pci_read_no_errata+0x0/0x58) from [<c02526bc>] (ata_sff_sync+0x7c/0x84)
+ r4:c6700000
+[<c0252640>] (ata_sff_sync+0x0/0x84) from [<c0257064>] (ata_sff_pause+0x10/0x20)
+[<c0257054>] (ata_sff_pause+0x0/0x20) from [<c0257160>] (ata_sff_dev_select+0x78/0x7c)
+[<c02570e8>] (ata_sff_dev_select+0x0/0x7c) from [<c02569b0>] (ata_sff_wait_after_reset+0x13c/0x224)
+ r4:00000000
+[<c0256874>] (ata_sff_wait_after_reset+0x0/0x224) from [<c0256b28>] (ata_bus_softreset+0x90/0x150)
+[<c0256a98>] (ata_bus_softreset+0x0/0x150) from [<c0256e6c>] (ata_sff_softreset+0x68/0x168)
+ r6:c6701380 r5:00000002 r4:c6700000
+[<c0256e04>] (ata_sff_softreset+0x0/0x168) from [<c024d6b8>] (ata_do_reset+0x88/0x8c)
+[<c024d630>] (ata_do_reset+0x0/0x8c) from [<c024e2f4>] (ata_eh_reset+0x354/0xd84)
+ r8:00000000 r7:00002710 r6:c6701380 r5:00000008 r4:ffff909a
+[<c024dfa0>] (ata_eh_reset+0x0/0xd84) from [<c02508dc>] (ata_eh_recover+0x270/0xe00)
+[<c025066c>] (ata_eh_recover+0x0/0xe00) from [<c0251654>] (ata_do_eh+0x50/0x94)
+[<c0251604>] (ata_do_eh+0x0/0x94) from [<c02539c4>] (ata_sff_error_handler+0x118/0x1c4)
+ r7:a0000013 r6:00000000 r5:00000000 r4:c6700000
+[<c02538ac>] (ata_sff_error_handler+0x0/0x1c4) from [<c02520b8>] (ata_scsi_error+0x2e4/0x50c)
+[<c0251dd4>] (ata_scsi_error+0x0/0x50c) from [<c0236598>] (scsi_error_handler+0xd0/0x3c0)
+[<c02364c8>] (scsi_error_handler+0x0/0x3c0) from [<c011d134>] (kthread+0x58/0x94)
+[<c011d0dc>] (kthread+0x0/0x94) from [<c010bb40>] (do_exit+0x0/0x740)
+ r7:00000000 r6:00000000 r5:00000000 r4:00000000
+handlers:
+[<c0255e48>] (ata_sff_interrupt+0x0/0x2c4)
+Disabling IRQ #29
+ata3.01: CFA: SanDisk SDCFX3-004G, HDX 4.32, max UDMA/66
+ata3.01: 8027712 sectors, multi 0: LBA
+ata3.01: limited to UDMA/33 due to 40-wire cable
+ata3.01: configured for UDMA/33
 isa bounce pool size: 16 pages
+scsi 2:0:1:0: Direct-Access     ATA      SanDisk SDCFX3-0 HDX  PQ: 0 ANSI: 5
+sd 2:0:1:0: [sda] 8027712 512-byte hardware sectors: (4.11 GB/3.82 GiB)
+sd 2:0:1:0: [sda] Write Protect is off
+sd 2:0:1:0: [sda] Mode Sense: 00 3a 00 00
+sd 2:0:1:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA

==========================================================
Linux 2.6.30-rc (latest git) seems to have some problems with the
backtrace:

ata1: SATA link down (SStatus 0 SControl 310)
ata2: SATA link down (SStatus 0 SControl 310)
irq 29: nobody cared (booted with the "irqpoll" option)
[<c00f8f5c>] (unwind_backtrace+0x0/0xe4) from [<c01324d4>] (__report_bad_irq+0x20/0x90)
[<c01324d4>] (__report_bad_irq+0x20/0x90) from [<c01326d4>] (note_interrupt+0x190/0x1fc)
[<c01326d4>] (note_interrupt+0x190/0x1fc) from [<c0132fd0>] (handle_level_irq+0xc4/0xec)
[<c0132fd0>] (handle_level_irq+0xc4/0xec) from [<c00f203c>] (_text+0x3c/0x68)
[<c00f203c>] (_text+0x3c/0x68) from [<c00f2a70>] (__irq_svc+0x30/0x80)
Exception stack(0xc6765cc0 to 0xc6765d08)
5cc0: 00000000 c6764000 00000102 20000013 0000001d 00000102 00000000 c6749380
5ce0: c6764000 c04b498c 0000000a c04b4960 c04a3d70 c6765d08 c0110700 c01105c4
5d00: 20000013 ffffffff
[<c00f2a70>] (__irq_svc+0x30/0x80) from [<c0110700>] (irq_exit+0x80/0x94)
[<c0110700>] (irq_exit+0x80/0x94) from [<c01325c0>] (note_interrupt+0x7c/0x1fc)
[<c01325c0>] (note_interrupt+0x7c/0x1fc) from [<00000002>] (0x2)
handlers:
[<c023d758>] (ata_sff_interrupt+0x0/0x120)
Disabling IRQ #29
ata3.01: CFA: SanDisk SDCFX3-004G, HDX 4.32, max UDMA/66
ata3.01: 8027712 sectors, multi 0: LBA
ata3.01: limited to UDMA/33 due to 40-wire cable
ata3.01: configured for UDMA/33
isa bounce pool size: 16 pages
scsi 2:0:1:0: Direct-Access     ATA      SanDisk SDCFX3-0 HDX  PQ: 0 ANSI: 5

-- 
Krzysztof Halasa
