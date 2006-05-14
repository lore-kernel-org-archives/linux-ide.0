From: Foli Ayivoh <it21@arcor.de>
Subject: [BUGREPORT 1/3] Kernel Oops with HPT372A IDE controller
Date: Sun, 14 May 2006 21:10:53 +0200
Message-ID: <200605142110.53348.it21@arcor.de>
Reply-To: 101551.753@compuserve.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:49795 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751571AbWENTJy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 14 May 2006 15:09:54 -0400
Received: from mail-in-10-z2.arcor-so.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 7D92014C32C
	for <linux-ide@vger.kernel.org>; Sun, 14 May 2006 21:09:53 +0200 (CEST)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-10-z2.arcor-so.net (Postfix) with ESMTP id 716DA33A84B
	for <linux-ide@vger.kernel.org>; Sun, 14 May 2006 21:09:53 +0200 (CEST)
Received: from drx-3 (dslb-084-058-180-134.pools.arcor-ip.net [84.58.180.134])
	(Authenticated sender: it21@arcor.de)
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 2242013E517
	for <linux-ide@vger.kernel.org>; Sun, 14 May 2006 21:09:53 +0200 (CEST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Kernel Oops with HighPoint RocketRAID ATA133 aka HPT372A/N since kernel 2.6
Now tested with kernel 2.6.17-rc4

Kernel is on bootable CD-ROM
Modules are loaded from initrd

This is what I copied from screen:

Loading hpt366
[17179578.396000] HPT372A: IDE controller at PCI slot 0000:01:0a.0
[17179578.400000] ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
[17179578.404000] ACPI: PCI Interrupt 0000:01:0a.0[A] -> Link [APC1] -> GSI 16 (level, high) -> IRQ 18
[17179578.408000] HPT372A: chipset revision 2
[17179578.412000] HPT372A: 100% native mode on irq 18
[17179578.416000] hpt: HPT372N detected, using 372N timing.
[17179578.420000] FREQ: 125 PLL: 45
[17179579.536000] No Clock Stabilization!!!
[17179579.540000] hpt: no known IDE timings, disabling DMA
[17179579.544000] hpt: HPT372N detected, using 372N timing.
[17179579.548000] FREQ: 156 PLL: 66
[17179579.664000] No Clock Stabilization!!!
[17179579.668000] hpt: no known IDE timings, disabling DMA
[17179580.960000] hde: WDC WD800BB-00CAA1, ATA DISK drive
[17179581.240000] hdf: WDC WD800BB-00BSA0, ATA DISK drive
[17179581.296000] BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000
[17179581.296000]  printing eip:
[17179581.296000] f881b067
[17179581.300000] *pde = 00000000
[17179581.304000] Oops: 0000 [#1]
[17179582.308000] Modules linked in: hpt366 amd74xx
[17179582.308000] CPU:    0
[17179582.308000] EIP:    0060:[<f881b067>]    Not tainted VLI
[17179582.308000] EFLAGS: 00010246   (2.6.17-rc4 #1)
[17179582.308000] EIP is at pci_bus_clock_list+0xd/0x17 [hpt366]
[17179582.308000] eax: 0000000c   ebx: 30070000   ecx: dff10320   edx: 00000000
[17179582.308000] esi: dff92000   edi: c133f22c   ebp: 00000051   esp: c1d5ddec
[17179582.308000] ds: 007b   es: 007b   ss: 0068
[17179582.308000] Process modprobe (pid: 1473, threadinfo=c1d5c000 task=c1daaaf0)
[17179582.308000] Stack: <0>f881c1d3 00000000 c1d5de0f 0000000c dff10320 400ce6dc dffdda00 00000000
[17179582.308000]           001fe53d c133f198 00000002 c1d7743e c133f198 f881c25e c133f22c dff10320
[17179582.308000]           ff33f22c c133f22c 00000002 c1d7743e c133f22c 00000002 c1d7743e c133f198
[17179582.308000] Call Trace:
[17179582.308000]  <f881c1d3> hpt372_tune_chipset+0xb8/0x114 [hpt366]
[17179582.308000]  <f881c25e> hpt3xx_tune_chipset+0x2f/0x237 [hpt366]
[17179582.308000]  <c1156938> probe_hwif+0x631/0x6b9
[17179582.308000]  <c1134d8b> __driver_attach+0x0/0x67
[17179582.308000]  <c11573a8> probe_hwif_init_with_fixup+0xb/0x71
[17179582.308000]  <c1158ea3> ide_setup_pci_device+0x3a/0x6b
[17179582.308000]  <f881b175> hpt366_init_one+0xf/0x10 [hpt366]
[17179582.308000]  <c10bd966> pci_device_probe+0x36/0x55
[17179582.308000]  <c1134ce1> driver_probe_device+0x42/0x91
[17179582.308000]  <c1134dcd> __driver_attach+0x42/0x67
[17179582.308000]  <c1134465> bus_for_each_dev+0x37/0x59
[17179582.308000]  <c1134bd9> driver_attach+0x11/0x13
[17179582.308000]  <c1134d8b> __driver_attach+0x0/0x67
[17179582.308000]  <c11346d3> bus_add_driver+0x5a/0xd3
[17179582.308000]  <c10bd657> __pci_register_driver+0x34/0x4e
[17179582.308000]  <c1028f93> sys_init_module+0x1112/0x11e0
[17179582.308000]  <c1002977> syscall_call+0x7/0xb
[17179582.308000] Code: 19 c0 0c 01 85 c0 74 08 8b 33 85 f6 75 e0 eb 07 b8 01 00 00 00 eb 02 31 c0 5b
                        5e 5f 5d c3 eb 0b 38 c1 75 04 8b 42 04 c3 83 c2 08 <8a> 0a 84 c9 75 ef 8b 42
                        04 c3 ba 40 e1 81 f8 eb 88 80 b8 9d 00
[17179582.308000] EIP: [<f881b067>] pci_bus_clock_list+0xd/0x17 [hpt366] SS:ESP 0068:c1d5ddec
[17179582.308000]  [1]   Segment violation       modprobe hpt366 ...
