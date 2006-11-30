From: Harold Lee <harold@hotelling.net>
Subject: sata_sil
Date: Wed, 29 Nov 2006 16:18:37 -0800
Message-ID: <456E235D.3090705@hotelling.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.228]:25173 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S967709AbWK3ASn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Nov 2006 19:18:43 -0500
Received: by wx-out-0506.google.com with SMTP id h27so2480544wxd
        for <linux-ide@vger.kernel.org>; Wed, 29 Nov 2006 16:18:42 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I just got a Cardbus / PCMCIA SATA controller using the Silicon Image 
3512 chipset. It is not working with my external SATA enclosure housing 
a WD 250 GB Caviar drive. The first error I see in dmesg is about the 
cache line size not being set. I tried unloading the sata_sil and libata 
modules, then "sudo setpci -s 03:00.0 CACHE_LINE_SIZE=08" then reloading 
them - but I still can't see the drive and I still get the "PIO error" / 
"failed to IDENTIFY (I/O error)" errors below in the dmesg output.

Any ideas?

 From lspci -v :

03:00.0 Mass storage controller: Silicon Image, Inc. SiI 3512 
[SATALink/SATARaid] Serial ATA Controller (rev 01)
        Subsystem: Silicon Image, Inc. SiI 3512 SATALink Controller
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 11
        I/O ports at 4010 [size=8]
        I/O ports at 4020 [size=4]
        I/O ports at 4018 [size=8]
        I/O ports at 4024 [size=4]
        I/O ports at 4000 [size=16]
        Memory at 50800000 (32-bit, non-prefetchable) [size=512]
        Expansion ROM at 50400000 [disabled] [size=512K]
        Capabilities: [60] Power Management version 2


 From dmesg:

libata version 1.20 loaded.
sata_sil 0000:03:00.0: version 0.9
PCI: Enabling device 0000:03:00.0 (0000 -> 0003)
ACPI: PCI interrupt 0000:03:00.0[A] -> GSI 11 (level, low) -> IRQ 11
sata_sil 0000:03:00.0: cache line size not set.  Driver may not function
sata_sil 0000:03:00.0: Applying R_ERR on DMA activate FIS errata fix
PCI: Setting latency timer of device 0000:03:00.0 to 64
ata1: SATA max UDMA/100 cmd 0xF8E48080 ctl 0xF8E4808A bmdma 0xF8E48000 
irq 11
ata2: SATA max UDMA/100 cmd 0xF8E480C0 ctl 0xF8E480CA bmdma 0xF8E48008 
irq 11
ata1: SATA link down (SStatus 0)
scsi9 : sata_sil
ata2: SATA link up 1.5 Gbps (SStatus 113)
ata2: PIO error
ata2: dev 0 failed to IDENTIFY (I/O error)
scsi10 : sata_sil

