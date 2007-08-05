From: Mikael Pettersson <mikpe@it.uu.se>
Subject: 2.6.23-rc2 regression: check_irq_resend() warning from cmd64x
Date: Sun, 5 Aug 2007 23:28:47 +0200 (MEST)
Message-ID: <200708052128.l75LSlN6009111@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:46310 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751815AbXHEV2w (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 5 Aug 2007 17:28:52 -0400
Received: from harpo.it.uu.se (daemon@harpo.it.uu.se [130.238.12.34])
	by aun.it.uu.se (8.13.6/8.13.6) with ESMTP id l75LSm77001756
	for <linux-ide@vger.kernel.org>; Sun, 5 Aug 2007 23:28:48 +0200 (MEST)
Received: (from mikpe@localhost)
	by harpo.it.uu.se (8.13.8+Sun/8.13.7) id l75LSlN6009111
	for linux-ide@vger.kernel.org; Sun, 5 Aug 2007 23:28:47 +0200 (MEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is on a sparc64 ultra5 with a rev 3 CMD646. Starting with kernel
2.6.23-rc2, each boot triggers a WARNING from kernel/irq/resend.c:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
CMD646: IDE controller at PCI slot 0000:01:03.0
CMD646: chipset revision 3
CMD646: MultiWord DMA force limited
CMD646: 100% native mode on irq 14
    ide0: BM-DMA at 0x1fe02c00020-0x1fe02c00027, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1fe02c00028-0x1fe02c0002f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: ST320420A, ATA DISK drive
hda: selected mode 0x22
ide0 at 0x1fe02c00000-0x1fe02c00007,0x1fe02c0000a on irq 14
Probing IDE interface ide1...
hdc: CRD-8483B, ATAPI CD/DVD-ROM drive
WARNING: at kernel/irq/resend.c:70 check_irq_resend()
Call Trace:
 [0000000000475a84] enable_irq+0x9c/0xc8
 [0000000000560438] probe_hwif+0x7bc/0x934
 [0000000000560dbc] probe_hwif_init_with_fixup+0x10/0xc4
 [0000000000563454] ide_setup_pci_device+0x94/0x9c
 [00000000005581f4] cmd64x_init_one+0x40/0x4c
 [0000000000680670] ide_scan_pcidev+0x48/0x84
 [00000000006806e0] ide_scan_pcibus+0x34/0x100
 [000000000068061c] ide_init+0x60/0x6c
 [0000000000670200] kernel_init+0xf0/0x270
 [0000000000427344] kernel_thread+0x38/0x48
 [00000000005c5fd8] rest_init+0x18/0x5c
hdc: selected mode 0x22
ide1 at 0x1fe02c00010-0x1fe02c00017,0x1fe02c0001a on irq 14 (shared with ide0)
hda: max request size: 128KiB
hda: 39851760 sectors (20404 MB) w/2048KiB Cache, CHS=39535/16/63, (U)DMA
hda: cache flushes not supported
 hda: hda1 hda2 hda3 hda4 hda5

/Mikael
