From: Stephen Clark <sclark46@earthlink.net>
Subject: Kernel 2.6.37 erroneously limiting to UDMA/33
Date: Wed, 05 Jan 2011 15:39:30 -0500
Message-ID: <4D24D702.9090908@earthlink.net>
Reply-To: sclark46@earthlink.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from elasmtp-dupuy.atl.sa.earthlink.net ([209.86.89.62]:55087 "EHLO
	elasmtp-dupuy.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752894Ab1AEUjc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2011 15:39:32 -0500
Received: from [69.22.83.66] (helo=joker.seclark.com)
	by elasmtp-dupuy.atl.sa.earthlink.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.67)
	(envelope-from <sclark46@earthlink.net>)
	id 1Paa8q-00071r-5d
	for linux-ide@vger.kernel.org; Wed, 05 Jan 2011 15:39:32 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

Why is the kernel limiting me to udma/33 when the device says it can do
ata2.01: CFA: TRANSCEND, 20070831, max UDMA/66

There is no cable the compact flash is a socket on the motherboard!

Loading sd_mod.ko module
Loading libata.ko module
Loading ata_generic.ko module
Loading pata_acpi.ko module
pata_acpi 0000:00:0f.0: PCI INT B -> GSI 21 (level, low) -> IRQ 21
pata_acpi 0000:00:0f.0: PCI INT B disabled
Loading pata_via.ko module
scsi0 : pata_via
scsi1 : pata_via
ata1: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xfa00 irq 14
ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xfa08 irq 15
ata2.01: CFA: TRANSCEND, 20070831, max UDMA/66
ata2.01: 7962192 sectors, multi 0: LBA
ata2.01: limited to UDMA/33 due to 40-wire cable
ata2.01: configured for UDMA/33
scsi 1:0:1:0: Direct-Access     ATA      TRANSCEND        2007 PQ: 0 ANSI: 5
sd 1:0:1:0: [sda] 7962192 512-byte logical blocks: (4.07 GB/3.79 GiB)
sd 1:0:1:0: [sda] Write Protect is off
sd 1:0:1:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DA
  sda: sda1 sda2 sda3
sd 1:0:1:0: [sda] Attached SCSI disk
Loading ata_piix.ko module

Thanks,
Steve

-- 

"They that give up essential liberty to obtain temporary safety,
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty
decreases."  (Thomas Jefferson)



