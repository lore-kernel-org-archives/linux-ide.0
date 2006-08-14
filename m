From: Andi Kleen <ak@suse.de>
Subject: via boot up hang during probing for no sata disks
Date: Mon, 14 Aug 2006 15:33:35 +0200
Message-ID: <200608141533.35448.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:9092 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751363AbWHNNdy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Aug 2006 09:33:54 -0400
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 42FE61FE8A
	for <linux-ide@vger.kernel.org>; Mon, 14 Aug 2006 15:33:53 +0200 (CEST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


One of my test machines hangs at boot when booting 2.6.18rc4.

It seems to busy loop somewhere because the CPU fans spin up.

The machine doesn't have any disks (just two PATAPI CD-ROMs) 
and boots over the network.

The SATA drivers are compiled into the kernel (x86-64 defconfig)

Strangely it seems to only hang with the 64bit kernel -- when
I boot a 32bit kernel it usually comes up. It is likely some timing
issue because booting with initcall_debug also seems to make 
the problem go away. I verified with a printk and without initcall_debug
that the hang still happens in svia_init.

I haven't seen that with earlier kernels.

libata version 2.00 loaded.
sata_via 0000:00:0f.0: version 2.0
GSI 17 sharing vector 0xB9 and IRQ 17
IOAPIC[0]: Set PCI routing entry (1-20 -> 0xb9 -> IRQ 17 Mode:1 Active:1)
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 185
sata_via 0000:00:0f.0: routed to hard irq line 9
ata1: SATA max UDMA/133 cmd 0x2C30 ctl 0x2C26 bmdma 0x2C00 irq 185
ata2: SATA max UDMA/133 cmd 0x2C28 ctl 0x2C22 bmdma 0x2C08 irq 185
scsi0 : sata_via
ata1: SATA link down (SStatus 0 SControl 310)
ATA: abnormal status 0x7F on port 0x2C37
scsi1 : sata_via
ata2: SATA link down (SStatus 0 SControl 310)
ATA: abnormal status 0x7F on port 0x2C2F
<hang>

Chipset is 
00:0f.0 IDE interface: VIA Technologies, Inc.: Unknown device 3149 (rev 80)
00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)

I will disable the driver for now because I don't need it
(after all the machine has no disks), but I wanted to let you now.

-Andi
