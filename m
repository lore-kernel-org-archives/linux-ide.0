From: Foli Ayivoh <it21@arcor.de>
Subject: [BUGREPORT 2/3] Kernel Oops with HPT372A IDE controller
Date: Sun, 14 May 2006 21:11:14 +0200
Message-ID: <200605142111.14695.it21@arcor.de>
Reply-To: 101551.753@compuserve.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:32949 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751578AbWENTKQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 14 May 2006 15:10:16 -0400
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net [151.189.8.20])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 805A81E9F5A
	for <linux-ide@vger.kernel.org>; Sun, 14 May 2006 21:10:14 +0200 (CEST)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id 6522A53378
	for <linux-ide@vger.kernel.org>; Sun, 14 May 2006 21:10:14 +0200 (CEST)
Received: from drx-3 (dslb-084-058-180-134.pools.arcor-ip.net [84.58.180.134])
	(Authenticated sender: it21@arcor.de)
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 06AE113E537
	for <linux-ide@vger.kernel.org>; Sun, 14 May 2006 21:10:14 +0200 (CEST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is part of dmesg from ubuntu 5 distro bootable CD-ROM with kernel 2.6.12-9-386

[4294690.705000] NFORCE2: IDE controller at PCI slot 0000:00:09.0
[4294690.705000] NFORCE2: chipset revision 162
[4294690.705000] NFORCE2: not 100% native mode: will probe irqs later
[4294690.705000] NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
[4294690.705000]     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
[4294690.705000]     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
[4294690.705000] Probing IDE interface ide0...
[4294691.377000] hda: TOSHIBA CD-ROM XM-6702B, ATAPI CD/DVD-ROM drive
[4294692.091000] hdb: YAMAHA CRW-F1E, ATAPI CD/DVD-ROM drive
[4294692.142000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[4294692.153000] Probing IDE interface ide1...
[4294692.825000] hdc: Pioneer DVD-ROM ATAPIModel DVD-106S 012, ATAPI CD/DVD-ROM drive
[4294693.131000] ide1 at 0x170-0x177,0x376 on irq 15
[4294693.131000] HPT372A: IDE controller at PCI slot 0000:01:0a.0
[4294693.131000] ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
[4294693.131000] ACPI: PCI Interrupt 0000:01:0a.0[A] -> Link [APC1] -> GSI 16 (level, high) -> IRQ 16
[4294693.131000] HPT372A: chipset revision 2
[4294693.131000] hpt: HPT372N detected, using 372N timing.
[4294693.131000] FREQ: 126 PLL: 45
[4294694.942000] HPT372A: 100% native mode on irq 16
[4294694.942000] hpt: no known IDE timings, disabling DMA.
[4294694.943000] hpt: no known IDE timings, disabling DMA.
[4294694.943000] Probing IDE interface ide2...
[4294695.206000] hde: WDC WD800BB-00CAA1, ATA DISK drive
[4294695.461000] hdf: WDC WD800BB-00BSA0, ATA DISK drive
[4294695.512000] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[4294695.512000]  printing eip:
[4294695.512000] f890f2fe
[4294695.512000] *pde = 00000000
[4294695.512000] Oops: 0000 [#1]
[4294695.512000] Modules linked in: ide_generic pdc202xx_new aec62xx alim15x3 atiixp cmd64x cs5520 cs5530 cy82c693 generic hpt34x ns87415 opti621 pdc202xx_old piix rz1000 sc1200 serverworks siimage sis5513 slc90e66 triflex trm290 via82cxxx floppy parport_pc parport fbcon tileblit font bitblit vga16fb vgastate vesafb cfbcopyarea cfbimgblt cfbfillrect softcursor usbserial usbkbd usb_storage thermal processor fan mousedev evdev usbhid sd_mod sata_sil hpt366 ohci1394 ieee1394 amd74xx ide_core sata_nv libata scsi_mod ehci_hcd ohci_hcd usbcore unix
[4294695.512000] CPU:    0
[4294695.512000] EIP:    0060:[<f890f2fe>]    Not tainted VLI
[4294695.512000] EFLAGS: 00010282   (2.6.12-9-386) 
[4294695.512000] EIP is at pci_bus_clock_list+0x9/0x1f [hpt366]
[4294695.512000] eax: 00000000   ebx: 00000051   ecx: 80015050   edx: 0000000c
[4294695.512000] esi: 30070000   edi: 00000040   ebp: dff76c00   esp: f7ef7ef8
[4294695.512000] ds: 007b   es: 007b   ss: 0068
[4294695.512000] Process modprobe (pid: 12446, threadinfo=f7ef6000 task=dfd47040)
[4294695.512000] Stack: f890f604 0000000c 00000000 0000000c 0cf76c00 00000000 00f76c00 f88c6bd8 
[4294695.512000]        f88ba9eb f75f9c3e f88c6b48 f88b427d f88c6bd8 0000000c 00000010 00000246 
[4294695.512000]        00000001 f7ef7f6c f88c6b48 00000000 c0000000 f7ef6000 f88b42da f88c6b48 
[4294695.512000] Call Trace:
[4294695.512000]  [<f890f604>] hpt372_tune_chipset+0xbd/0x112 [hpt366]
[4294695.512000]  [<f88b427d>] probe_hwif+0x33f/0x38c [ide_core]
[4294695.512000]  [<f88b42da>] probe_hwif_init_with_fixup+0x10/0x6c [ide_core]
[4294695.512000]  [<f88b709e>] ide_setup_pci_device+0x47/0x7d [ide_core]
[4294695.512000]  [<f891097a>] init_setup_hpt37x+0xd/0x10 [hpt366]
[4294695.512000]  [<f88b7205>] ide_scan_pcidev+0x34/0x4d [ide_core]
[4294695.512000]  [<f88b7245>] ide_scan_pcibus+0x27/0x8e [ide_core]
[4294695.512000]  [<f8a69005>] ide_generic_init+0x5/0x12 [ide_generic]
[4294695.512000]  [<c0129682>] sys_init_module+0xb5/0x172
[4294695.512000]  [<c0102ef9>] syscall_call+0x7/0xb
[4294695.512000] Code: 7d 36 83 c3 04 ac ae 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 74 d8 eb dd 31 c0 5b 5e 5f 5d c3 8b 44 24 08 0f b6 54 24 04 <80> 38 00 74 0d 38 10 75 04 8b 40 04 c3 83 c0 08 eb ee 8b 40 04 
